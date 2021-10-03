# Libraries Imports
#-----------------------------------------------------------------------------------------------------
import os
from configparser import ConfigParser
from sqlalchemy import create_engine
from datetime import datetime
import logging
from logging.handlers import RotatingFileHandler
from logging.handlers import TimedRotatingFileHandler

# Logger setup
#-----------------------------------------------------------------------------------------------------
def loadLogger():
    logger = logging.getLogger(os.path.basename(__file__))
    logger.setLevel(int(cfg['loglevel']))

    # Set loggers channels (TimeRotatingFile + STDOUT)
    ch = TimedRotatingFileHandler(cfg['logfile'],
                                        when="midnight",
                                        interval=1,
                                        backupCount=7)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    ch.setFormatter(formatter)
    logger.addHandler(ch)

    cs = logging.StreamHandler()
    cs.setLevel(int(cfg['loglevel']))
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    cs.setFormatter(formatter)
    logging.getLogger('').addHandler(cs)
    return logger


# Load connexion configuration file
#-----------------------------------------------------------------------------------------------------
config_filename = "./conf/GetWeather.ini"

# Read config.ini file
config_object = ConfigParser()
config_object.read(config_filename)
if  not config_object:
    print("Error while loading configuration !!!")

# Log initialization
cfg = config_object['INFO']


# Initialize logger
logger = loadLogger()
logger.info("-----------------------------------------------------------------------------------------------------")
logger.info(os.path.basename(__file__))
logger.info("-----------------------------------------------------------------------------------------------------")


# Establish connection with DB (using sqlalchemy)
#-----------------------------------------------------------------------------------------------------
db_connection_str = "mysql+pymysql://{}:{}@{}/WeatherDB".format(cfg['user'],cfg['password'],cfg['host'])
db_connection = create_engine(db_connection_str)

# Query duplicates in DB
queries = [ 'CALL Count_Duplicates_RawRecords();',
            'CALL Count_Duplicates_RecordsByHour();',
            'CALL Count_Duplicates_RecordsByDay();',
            'CALL Count_Duplicates_RecordsByMonth();'
        ]
for query in queries:
    try:   
        rc = db_connection.execute(query)
        #print("Query : {} - RC : {}".format(query,rc))
    except:   
        logger.error("Count duplicates query failed") 


# Remove duplicates in DB
logger.info("Remove duplicates from WeatherDB")
queries = [ 'CALL Remove_Duplicates_RawRecords();',
            'CALL Remove_Duplicates_RecordsByHour();',
            'CALL Remove_Duplicates_RecordsByDay();',
            'CALL Remove_Duplicates_RecordsByMonth();'
        ]
for query in queries:
    try:   
        rc = db_connection.execute(query)
        #print("Query : {} - RC : {}".format(query,rc.count()))
    except:   
        logger.error("Remove duplicates query failed") 
