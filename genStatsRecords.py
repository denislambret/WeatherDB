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
import calendar
from datetime import date, timedelta
from dateutil.relativedelta import relativedelta
from configparser import ConfigParser
from numpy import NaN
from sqlalchemy import create_engine
import pandas as pd
from os.path import exists


# ------------------------------------------------------------------------------------------------------
# Global Variables
# ------------------------------------------------------------------------------------------------------
cities = ["Hérémence","Geneva","Lausanne","Sion","Evolène"]
params_config = {
        'deamon':     {'must': False,  'data': False,    'short': 'd',    'long': 'daemon'},
        'config':     {'must': False,  'data': True,     'short': 'c',    'long': 'conf'}
    }
configfilename  = "./conf/GenStatsRecords.ini"
localstation    = 6

# Get config parameters
#-----------------------------------------------------------------------------------------------------
def loadConfig(config_filename):
    print("Load {} config file...".format(cmd['config_file']))
    if not exists(config_filename):
        print("Config file {} is missing".format(config_filename))
        return NaN
    config_object = ConfigParser()
    config_object.read(config_filename)
    if not config_object:
        print("Error while loading configuration !!!")
        exit(1)
    print("Config obj : {}".format(config_object))  
    print("config  sections {} ".format(config_object.sections())) 
    return config_object['INFO']

# Logger setup
#-----------------------------------------------------------------------------------------------------
def loadLogger():
    logger = logging.getLogger(os.path.basename(__file__))
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

# Get date previous month
#-----------------------------------------------------------------------------------------------------
def getPrevMonth(current):
    _first_day = current.replace(day=1)
    prev_month_lastday = _first_day - datetime.timedelta(days=1)
    return prev_month_lastday.replace(day=1)


def getLastDayOfMonth(date):
    first_day_of_month = datetime.datetime(date.year, date.month, 1)
    next_month_date = first_day_of_month + datetime.timedelta(days=32)
    new_dt = datetime.datetime(next_month_date.year, next_month_date.month, 1)
    Last_day= new_dt - datetime.timedelta(days=1)+datetime.timedelta(hours=23,minutes=59,seconds=59)
    return Last_day

# Generate dates range by months or days
#-----------------------------------------------------------------------------------------------------
def dayDateRange(start_date, end_date):
    for n in range(int((end_date - start_date).days)):
        yield start_date + timedelta(n)

def monthDateRange(start_date, end_date):
    for n in range(int((end_date.year - start_date.year) * 12 + (end_date.month - start_date.month))):
        yield start_date + relativedelta(months =+ n)

# Parse command line
#-----------------------------------------------------------------------------------------------------
def getCmdLineOptions():
    cmd = {}
    try:
        opts, args = getopt.getopt(sys.argv[1:],'c:s:e:l:t:n',['config=','startDate=','endDate=','location=','prevMonth', 'yesterday','now','statsType='])
    except getopt.error as msg:
            sys.stdout = sys.stderr
            print(msg)
            print("""usage: %s 
            -c --config     : script specific configuration file
            -s --startDate  : yyyy-mm-dd as start date
            -e --end_date   : yyyy-mm-dd as end date
            -l --location   : location_id
            -t --statsType  : stats Type (hourly,daily,monthly)
            -n --now        : now
            --now           : set date to now
            --yesterday     : set date to yesterday
            --prevMonth     : set date to previous month
            
            """%sys.argv[0])
            sys.exit(1)
    
    
    #print("opts : {} - args : {}".format(opts,args))
    for opt, arg in opts:
        if opt in ('-l', '--location'):
            cmd['localstation'] = arg
        elif opt in ('-s', '--startDate'):
            cmd['start_date'] = arg
            if cmd['start_date']:
                cmd['start_date'] = datetime.datetime.strptime(cmd['start_date'],"%Y-%m-%d")
        elif opt in ('-e', '--endDate'):
            cmd['end_date'] = arg
            cmd['end_date'] = datetime.datetime.strptime( cmd['end_date'],"%Y-%m-%d")
        elif opt in ('-n', '--now'):
            cmd['start_date'] = date.today()
            cmd['end_date'] = cmd['start_date'] + timedelta(days=1) 
        elif opt in ('-c','--config'):
            cmd['config_file'] = arg
        elif opt in ('-t','--statsType'):
            cmd['type_stats'] = arg
        elif opt in ('--prevMonth'):
            cmd['start_date'] = getPrevMonth(date.today())
            cmd['end_date'] = cmd['start_date'] + timedelta(days=31)
            cmd['end_date'] = cmd['end_date'].replace(day=1)
        elif opt in ('--yesterday'):
            cmd['start_date'] = date.today() - timedelta(days=1)
            cmd['end_date'] = cmd['start_date'] + timedelta(days=1)
    
    return cmd        

# Switch stats
#-----------------------------------------------------------------------------------------------------
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

# Script initialization
#-----------------------------------------------------------------------------------------------------

# Get command line options
cmd={}
cmd = getCmdLineOptions()

# Load connexion configuration file
if 'config_file'  not in cmd:
    cmd['config_file'] = 'd:/Dev/60_Python/WeatherDB/conf/genStatRecords.ini'
cfg = loadConfig(cmd['config_file'])

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
        query = switch_stats(cmd['type_stats'],my_date,localstation)
        raw_data = pd.read_sql(query, con=db_connection)
        if raw_data.size > 0:
            logger.info("{} - retrieved {} record(s)".format(my_date,raw_data.shape))
            pass
        raw_data.rename(columns = {'date_timestamp':'timestamp'}, inplace = True)
        raw_data.rename(columns = {'id_location':'idLocation'}, inplace = True)
        raw_data.insert(0,'id',0)
        #raw_data.insert(1,'idLocation',localstation)
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
        query = switch_stats(cmd['type_stats'],my_date,localstation)
        raw_data = pd.read_sql(query, con=db_connection)
        if raw_data.size > 0:
            logger.info("{} - retrieved {} record(s)".format(my_date,raw_data.shape))
            pass
        raw_data.rename(columns = {'date_timestamp':'timestamp'}, inplace = True)
        raw_data.rename(columns = {'id_location':'idLocation'}, inplace = True)
        raw_data.insert(0,'id',0)
        #raw_data.insert(1,'idLocation',localstation)
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
        pdata.to_sql('RecordsByHour', con=db_connection, if_exists='append', index=False)    





          