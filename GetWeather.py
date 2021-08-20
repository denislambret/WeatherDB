'''
Created on 9 avr. 2020
Updated 31.05.2021 - Minor change
@author: dns
'''

# ------------------------------------------------------------------------------------------------------
# Icleamports
# ------------------------------------------------------------------------------------------------------
import mysql.connector
import requests
import json
import time
import logging
import hashlib
import time
from datetime import datetime

# ------------------------------------------------------------------------------------------------------
# Global Variables
# ------------------------------------------------------------------------------------------------------
mydb = ''
cursorDB = ''
host = "192.168.33.100"
user = "dev"
pwd = "1234qwerASD!"
cities = ["Hérémence","Geneva","Lausanne","Sion","Evolène"]
apiKey = "7fe4b94a6895956f0cfe6c083016f804"
retryPeriod = 30
logfile = 'D:/dev/60_Python/WeatherDB/logs/GetWeather.log'

# ------------------------------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------------------------------

# getWeatherMessage(location, apiKey)
# ------------------------------------------------------------------------------------------------------
def getWeatherMessage(location, apiKey):
    url = "https://api.openweathermap.org/data/2.5/weather?q={},ch&appid={}".format(
        location, apiKey)

    try:
        r = requests.get(url, params={'q': location, 'appid': apiKey})
    except requests.exceptions.RequestException as err:
        print("Connection error : ", err)
        return False
    r.text
    data = json.loads(r.text)
    return data

# dbconnect(srv, usr, pwd):
#------------------------------------------------------------------------------------------------------
def dbconnect(srv, usr, pwd):
    global mydb
    global cursorDB

    try:
        mydb = mysql.connector.connect(
            host=srv,
            user=usr,
            passwd=pwd,
            database="WeatherDB")
        cursorDB = mydb.cursor()
        return cursorDB

    except mysql.connector.Error as e:
        if e.errno:
            s = str(e)
            logger.error("Error code     : {}".format(e.errno))        # error number
            logger.error("SQLSTATE value : {}".format(e.sqlstate))     # SQLSTATE value
            logger.error("Error message  : {}".format(e.msg))          # Error message
            logger.error("Error          : {}".format(e))              # Errno, sqlstate, msg values
            logger.error("Db server is unreachable or down... Hint : Check network configuration endpoints.")
    return False


# getCity(cityId)
#------------------------------------------------------------------------------------------------------
def getCityByName(cityName):
            # Connect to Weather DB and return a cursor object
        dbx = dbconnect(host, user, pwd)
        if not dbx:
            logger.error(f"DB connection failed!")
        exit
        query = "SELECT id, name FROM WeatherDB.Locations WHERE name='{}' LIMIT 1".format(cityName)
        dbx.execute(query)
        result = dbx.fetchone()
        dbx.close()
        if result:
        # If yes then we simply insert the record after retrieving location ID
            idLocation = result[0]
        else:
        # Else we create the new location, gather associated ID and then create the record
            logger.error("Location does not exists - Updating location table...")
            query = "INSERT INTO WeatherDB.Locations (name, timezone, altitude, longitude, latitude) VALUES ('{}', '{}', '400', '{}', '{}')".format(msg['name'], msg['timezone'], msg['coord']['lon'], msg['coord']['lat'])
            dbx.execute(query)
            mydb.commit()    
            dbx.close()

# setHash(msg)
#------------------------------------------------------------------------------------------------------
def computeHash(msg):
    hash_obj = hashlib.md5(msg)
    return hash_obj.hexdigest()

# existsMsg(hashmsg)
#------------------------------------------------------------------------------------------------------
def existsMsg(hashmsg):
    dbx = dbconnect(host, user, pwd)
    if not dbx:
        logger.error(f"DB connection failed!")
    exit
    query = "SELECT  * FROM WeatherDB.Records WHERE hashmsg='{}' LIMIT 1".format(hashmsg)
    dbx.execute(query)
    result = dbx.fetchone()
    dbx.close()
    if result: 
        return True
    else: 
        return False

'''
-----------------------------------------------------------------------------------------------------
Main application
-----------------------------------------------------------------------------------------------------
'''
logger = logging.getLogger('GetWeather.py')
logger.setLevel(logging.DEBUG)
ch = logging.FileHandler(logfile)
ch.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
logger.addHandler(ch)

while (1):
    for city in cities:
        now = datetime.now()
        logger.info("------------------------------------------------------------------------------------------------------")
        logger.info("{} Get weather message for {} - ".format(now.strftime("%d/%m/%Y %H:%M:%S"),city))
        logger.info("------------------------------------------------------------------------------------------------------")
        
        # Get current Open Weather message for location
        fMsg = False
        while (fMsg == False):
            msg = getWeatherMessage(city, apiKey)
            if msg:
                logger.info("Message retrieved from OpenWeather.")
                fMsg = True
            else:
                logger.error("Server unavailable or wrong URL. No HTTP query answer received!")
                logger.warning("Retry query in {}".format(retryPeriod))
                time.sleep(retryPeriod)
            

        # Connect to Weather DB and return a cursor object
        dbx = dbconnect(host, user, pwd)
        if not dbx:
            logger.error(f"DB connection failed!")
        exit

        # Test if location exist
        # If yes, we just keep the location id, else we create the location and keep the id
        query = "SELECT id, name FROM WeatherDB.Locations WHERE name='{}' LIMIT 1".format(city)
        dbx.execute(query)
        result = dbx.fetchone()
        
        if result:
        # If yes then we simply insert record after retrieving location ID
            idLocation = result[0]
        else:
        # Else we create the new location, gather associated ID and then create the record
            logger.info("Location does not exists - Updating location table...")
            query = "INSERT INTO WeatherDB.Locations (name, timezone, altitude, longitude, latitude) VALUES ('{}', '{}', '400', '{}', '{}')".format(msg['name'], msg['timezone'], msg['coord']['lon'], msg['coord']['lat'])
            dbx.execute(query)
            mydb.commit()
        
        query = "SELECT id, name FROM WeatherDB.Locations WHERE name='{}' LIMIT 1".format(city)
        dbx.execute(query)
        result = dbx.fetchone()
        idLocation = result[0]
        dbx.close()


        # Control message values before insertion
        if ('speed' not in msg['wind']):
            msg['wind']['speed'] = '0'
        if ('deg' not in msg['wind']):
            msg['wind']['deg'] = '0'
        if ('rain' not in msg):
            msg['rain'] = {'1h': 0}
        if ('snow' not in msg):
            msg['snow'] = {'1h': 0}
        hashMsg = computeHash(json.dumps(msg).encode())
        if existsMsg(hashMsg):
            logger.warning("Record already exists in WeatherDB! Bypass insertion.")
        else:
            # Connect to Weather DB and return a cursor object
            dbx = dbconnect(host, user, pwd)
            if not dbx:
                logger.error(f"DB connection failed!")
                exit

            # Now we create record in weather_records table
            logger.debug("date_timestamp : {}".format(time.localtime(msg['dt']))) 
            logger.debug("temp           : {}".format(msg['main']['temp']))
            logger.debug("feels_like     : {}".format(msg['main']['feels_like']))
            logger.debug("pressure       : {}".format(msg['main']['pressure']))
            logger.debug("humidity       : {}".format(msg['main']['humidity']))
            logger.debug("wind_speed     : {}".format(msg['wind']['speed']))
            logger.debug("wind_dir       : {}".format(msg['wind']['deg'])) 
            logger.debug("clouds_cover   : {}".format(msg['clouds']['all']))
            logger.debug("rain_1h        : {}".format(msg['rain']['1h']))
            logger.debug("snow_1h        : {}".format(msg['snow']['1h']))
            logger.debug("id_location    : {}".format(idLocation))
            logger.debug("hashmsg        : {}".format(hashMsg))
            query = "INSERT INTO WeatherDB.Records ( date_timestamp, temp, feels_like, pressure, humidity, " \
            "wind_speed, wind_dir, clouds_cover, rain_1h, snow_1h, id_location, hashmsg) " \
            "VALUES ('{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}','{}')".format(
                time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(msg['dt'])),
                msg['main']['temp'],
                msg['main']['feels_like'],
                msg['main']['pressure'],
                msg['main']['humidity'],
                msg['wind']['speed'],
                msg['wind']['deg'],
                msg['clouds']['all'],
                msg['rain']['1h'],
                msg['snow']['1h'],
                idLocation,
                hashMsg
                )

            logger.info("Inject message with fingerprint: {} ".format(hashMsg))
            dbx.execute(query)
            mydb.commit()
            dbx.close()
            logger.info("New weather message injected in Weather DB.")
    time.sleep(300)    



