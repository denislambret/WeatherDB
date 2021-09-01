# ------------------------------------------------------------------------------------------------------
# Imports
# ------------------------------------------------------------------------------------------------------
import getopt
import sys
import logging
from logging.handlers import RotatingFileHandler
from logging.handlers import TimedRotatingFileHandler
import datetime
from datetime import date, timedelta
from dateutil.relativedelta import relativedelta
from configparser import ConfigParser
from sqlalchemy import create_engine
import pandas as pd

# ------------------------------------------------------------------------------------------------------
# Global Variables
# ------------------------------------------------------------------------------------------------------
mydb = ''
cursorDB = ''
cities = ["Hérémence","Geneva","Lausanne","Sion","Evolène"]
params_config = {
        'deamon':     {'must': False,  'data': False,    'short': 'd',    'long': 'daemon'},
        'config':     {'must': False,  'data': True,     'short': 'c',    'long': 'conf'}
    }
daemonFlag = False
config_filename = ""
localstation = 6

# Get hourly stats for a given range of day(s) and a single location
#-----------------------------------------------------------------------------------------------------
def daterange(start_date, end_date):
    for n in range(int((end_date.year - start_date.year) * 12 + (end_date.month - start_date.month))):
        yield start_date + relativedelta(months =+ n)
        

#-----------------------------------------------------------------------------------------------------
# Main application
#-----------------------------------------------------------------------------------------------------


# Load connexion configuration file
#-----------------------------------------------------------------------------------------------------
config_filename = "./GetStats.ini"

# Read config.ini file
config_object = ConfigParser()
config_object.read(config_filename)
if  not config_object:
    print("Error while loading configuration !!!")

# Config initialization
cfg = config_object['INFO']
try:
    opts, args = getopt.getopt(sys.argv[1:],'s:e:l:n')
except getopt.error as msg:
        sys.stdout = sys.stderr
        print(msg)
        print("""usage: %s [-s:v|-e:v|-l:v|-n] 
        -s: start date
        -e: end date
        -l: location
        -n: now
        """%sys.argv[0])
        sys.exit(2)

# Get option command line
for opt, arg in opts:
    if opt in ('-l', '--loc'):
        localstation = arg
    elif opt in ('-s', '--startdate'):
        start_date = arg
        start_date=datetime.datetime.strptime(start_date,"%d-%m-%Y")
    elif opt in ('-e', '--enddate'):
        end_date = arg
        end_date=datetime.datetime.strptime(end_date,"%d-%m-%Y")
    elif opt in ('-n', '--now'):
        start_date = date.today()
        end_date = start_date + timedelta(days=1) 

    
# Set loggers
#-----------------------------------------------------------------------------------------------------
# Logger 
logger = logging.getLogger('GetMonthlyStats.py')
logger.setLevel(int(cfg['loglevel']))

# Logger for Rotating files
ch = TimedRotatingFileHandler(cfg['logfile'],
                                       when="midnight",
                                       interval=1,
                                       backupCount=5)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
logger.addHandler(ch)

# Logger for STDOUT
cs = logging.StreamHandler()
cs.setLevel(int(cfg['loglevel']))
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
cs.setFormatter(formatter)
logging.getLogger('').addHandler(cs)

logger.info("getMonthlyStat.py")
logger.info("-----------------------------------------------------------------------------------------------------")

# Establish connection with DB (using sqlalchemy)
#-----------------------------------------------------------------------------------------------------
db_connection_str = "mysql+pymysql://{}:{}@{}/WeatherDB".format(cfg['user'],cfg['password'],cfg['host'])
db_connection = create_engine(db_connection_str)

# Connect to Weather DB and return a cursor object
query = "SELECT id, name FROM WeatherDB.Locations WHERE id='{}' LIMIT 1".format(localstation)
stations= db_connection.execute(query)
logger.info("Local station is : {}".format(stations.fetchone()))

# work variables for aggregation
pdata = pd.DataFrame([])
flagFirstRec = True
iter = 0

# Build hourly stats with store procedure Get_Hourly_Stats. Append results day by day to pandas table
logger.info("Build monthly stats from {} until {}".format(start_date,end_date))
for my_date in daterange(start_date, end_date):
    iter += 1
    query = "call Get_Monthly_Stats('{}',{});".format(str(my_date), localstation)
    logger.debug("Query : {}".format(query))
    raw_data = pd.read_sql(query, con=db_connection)
    raw_data.rename(columns = {'date_timestamp':'timestamp'}, inplace = True)
    raw_data.insert(0,'id',0)
    if flagFirstRec:
        pdata = pd.DataFrame(raw_data)
        flagFirstRec = False
    else:
        pdata = pdata.append(pd.DataFrame(raw_data))
    
logger.info("Found {} aggregate(s) created for a period of {} day(s).".format(pdata.shape,iter))
logger.info("Dump aggregate(s) to WeatherDB")

# Dump aggregates in RecordsByHour
pdata.to_sql('RecordsByMonth', con=db_connection, if_exists='append',
           index=False)