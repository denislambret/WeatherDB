# ------------------------------------------------------------------------------------------------------
# Imports
# ------------------------------------------------------------------------------------------------------
import os
import getopt
import sys
import logging
from logging.handlers import RotatingFileHandler
from logging.handlers import TimedRotatingFileHandler
import datetime
from datetime import date, timedelta
from dateutil.relativedelta import relativedelta
from configparser import ConfigParser
from numpy import NaN
from sqlalchemy import create_engine
import pandas as pd

# ------------------------------------------------------------------------------------------------------
# Global Variables
# ------------------------------------------------------------------------------------------------------
cities = ["Hérémence","Geneva","Lausanne","Sion","Evolène"]
params_config = {
        'deamon':     {'must': False,  'data': False,    'short': 'd',    'long': 'daemon'},
        'config':     {'must': False,  'data': True,     'short': 'c',    'long': 'conf'}
    }
configFilename  = "./GetWeather.ini"
localstation    = 6

# Get config parameters
#-----------------------------------------------------------------------------------------------------
def loadConfig(config_filename):
    config_object = ConfigParser()
    config_object.read(config_filename)
    if  not config_object:
        print("Error while loading configuration !!!")
    return config_object['INFO']

# Logger setup
#-----------------------------------------------------------------------------------------------------
def loadLogger():
    logger = logging.getLogger('GetWeather.py')
    logger.setLevel(int(cfg['loglevel']))

    # Set loggers channels (TimeRotatingFile + STDOUT)
    ch = TimedRotatingFileHandler(cfg['logfile'],
                                        when="midnight",
                                        interval=1,
                                        backupCount=5)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    ch.setFormatter(formatter)
    logger.addHandler(ch)

    cs = logging.StreamHandler()
    cs.setLevel(int(cfg['loglevel']))
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    cs.setFormatter(formatter)
    logging.getLogger('').addHandler(cs)
    return logger

# Parse command line
#-----------------------------------------------------------------------------------------------------
def getCmdLineOptions():
    cmd = {}
    try:
        opts, args = getopt.getopt(sys.argv[1:],'s:e:l:t:n')
    except getopt.error as msg:
            sys.stdout = sys.stderr
            print(msg)
            print("""usage: %s [-s:v|-e:v|-l:v|t:v|-n] 
            -s: start date
            -e: end date
            -l: location
            -t: Stats Type (hourly,daily,monthly)
            -n: now
            """%sys.argv[0])
            sys.exit(2)

    for opt, arg in opts:
        if opt in ('-l', '--loc'):
            cmd['localstation'] = arg
        elif opt in ('-s', '--startdate'):
            cmd['start_date'] = arg
            cmd['start_date']= datetime.datetime.strptime(cmd['start_date'],"%Y-%m-%d")
        elif opt in ('-e', '--enddate'):
            cmd['end_date'] = arg
            cmd['end_date'] = datetime.datetime.strptime( cmd['end_date'],"%Y-%m-%d")
        elif opt in ('-n', '--now'):
            cmd['start_date'] = date.today()
            cmd['end_date'] = cmd['start_date'] + timedelta(days=1) 
        elif opt in ('-t','--type'):
            cmd['type_stats'] = arg

    return cmd        

# Generate dates range by months or days
#-----------------------------------------------------------------------------------------------------
def dayDateRange(start_date, end_date):
    for n in range(int((end_date - start_date).days)):
        yield start_date + timedelta(n)

def monthDateRange(start_date, end_date):
    for n in range(int((end_date.year - start_date.year) * 12 + (end_date.month - start_date.month))):
        yield start_date + relativedelta(months =+ n)

# Switch stats
def switch_stats(name,my_date,localstation):
  switcher = { 
      'hourly' : "call Get_Hourly_Stats('{}',{});".format(str(my_date), localstation),
      'daily'  : "call Get_Daily_Stats('{}',{});".format(str(my_date), localstation),
      'monthly': "call Get_Monthly_Stats('{}',{});".format(str(my_date), localstation)
  }
  return switcher.get(name, NaN)

#-----------------------------------------------------------------------------------------------------
# Main application
#-----------------------------------------------------------------------------------------------------
# Load connexion configuration file
cfg = loadConfig('./GetStat.ini')

# Get option command line
cmd = getCmdLineOptions()

# Initialize logger
logger = loadLogger()
logger.info(os.path.basename(__file__))
logger.info("-----------------------------------------------------------------------------------------------------")

# Establish connection with DB (using sqlalchemy)
#-----------------------------------------------------------------------------------------------------
db_connection_str = "mysql+pymysql://{}:{}@{}/WeatherDB".format(cfg['user'],cfg['password'],cfg['host'])
db_connection = create_engine(db_connection_str)

# Connect to Weather DB and return a cursor object
query = "SELECT id, name FROM WeatherDB.Locations WHERE id='{}' LIMIT 1".format(localstation)
stations = db_connection.execute(query)
logger.info("Local station is : {}".format(stations.fetchone()))

# work variables for aggregation
pdata = pd.DataFrame([])
flagFirstRec = True
iter = 0

# Build hourly/daily/monthly stats with store procedures call. 
# Append results day by day to pandas table
#-----------------------------------------------------------------------------------------------------
logger.info("Build {} stats from {} until {}".format(cmd['type_stats'],cmd['start_date'],cmd['end_date']))
if cmd['type_stats'] == 'monthly':
    for my_date in monthDateRange(cmd['start_date'],cmd['end_date']):
        iter += 1
        query = switch_stats(cmd['type_stats'],my_date,cmd['localstation'])
        raw_data = pd.read_sql(query, con=db_connection)
        if raw_data.size > 0:
            logger.info("{} - retrieved {} record(s)".format(my_date,raw_data.shape))
            pass
        raw_data.rename(columns = {'date_timestamp':'timestamp'}, inplace = True)
        raw_data.insert(0,'id',0)
        if flagFirstRec:
            pdata = pd.DataFrame(raw_data)
            flagFirstRec = False
        else:
            pdata = pdata.append(pd.DataFrame(raw_data))
    # Dump aggregates in RecordsByMonth
    logger.info("Found {} aggregate(s) created for a period of {} month(s).".format(pdata.shape,iter))
    logger.info("Dump aggregate(s) to WeatherDB")
    pdata.to_sql('RecordsByMonth', con=db_connection, if_exists='append', index=False)
else:
    for my_date in dayDateRange(cmd['start_date'],cmd['end_date']):
        iter += 1
        query = switch_stats(cmd['type_stats'],my_date,cmd['localstation'])
        raw_data = pd.read_sql(query, con=db_connection)
        if raw_data.size > 0:
            logger.info("{} - retrieved {} record(s)".format(my_date,raw_data.shape))
            pass
        raw_data.rename(columns = {'date_timestamp':'timestamp'}, inplace = True)
        raw_data.insert(0,'id',0)
        if flagFirstRec:
            pdata = pd.DataFrame(raw_data)
            flagFirstRec = False
        else:
            pdata = pdata.append(pd.DataFrame(raw_data))
    logger.info("Found {} aggregate(s) created for a period of {} day(s).".format(pdata.shape,iter))
    logger.info("Dump aggregate(s) to WeatherDB")
    if cmd['type_stats'] == 'daily':
        pdata.to_sql('RecordsByDay', con=db_connection, if_exists='append', index=False)    
    elif cmd['type_stats'] == 'hourly':
        pdata.to_sql('RecordsByHOur', con=db_connection, if_exists='append', index=False)    





          