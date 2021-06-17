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

# ------------------------------------------------------------------------------------------------------
# Global Variables
# ------------------------------------------------------------------------------------------------------
mydb = ''
cursorDB = ''
host = "192.168.33.10"
user = "root"
pwd = "1234qwerASD"
cities = ["Hérémence","Geneva","Lausanne","Sion","Evolène"]
apiKey = "7fe4b94a6895956f0cfe6c083016f804"
retryPeriod = 30

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
            print("Error code     : {}".format(e.errno))        # error number
            print("SQLSTATE value : {}".format(e.sqlstate))     # SQLSTATE value
            print("Error message  : {}".format(e.msg))          # Error message
            print("Error          : {}".format(e))              # Errno, sqlstate, msg values
            print("Db server is unreachable or down... Hint : Check network configuration endpoints.")
    return False


# getCity(cityId)
#------------------------------------------------------------------------------------------------------
def getCityByName(cityName):
            # Connect to Weather DB and return a cursor object
        dbx = dbconnect(host, user, pwd)
        if not dbx:
            print(f"DB connection failed!")
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
            print("Location does not exists - Updating location table...")
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
        print(f"DB connection failed!")
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

while (1):
    for city in cities:
        print("------------------------------------------------------------------------------------------------------")
        print("Get weather message for {}".format(city))
        print("------------------------------------------------------------------------------------------------------")
        
        # Get current Open Weather message for location
        fMsg = False
        while (fMsg == False):
            msg = getWeatherMessage(city, apiKey)
            if msg:
                print("Message retrieved from OpenWeather.")
                fMsg = True
            else:
                print("Server unavailable or wrong URL. No HTTP query answer received!")
                print("Retry query in {}".format(retryPeriod))
                time.sleep(retryPeriod)
            

        # Connect to Weather DB and return a cursor object
        dbx = dbconnect(host, user, pwd)
        if not dbx:
            print(f"DB connection failed!")
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
            print("Location does not exists - Updating location table...")
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
            print("Record already exists in WeatherDB! Bypass insertion.")
        else:
            # Connect to Weather DB and return a cursor object
            dbx = dbconnect(host, user, pwd)
            if not dbx:
                print(f"DB connection failed!")
                exit

            # Now we create record in weather_records table
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

            print("Inject message with fingerprint: {} ".format(hashMsg))
            dbx.execute(query)
            mydb.commit()
            dbx.close()
            print("New weather message injected in Weather DB.")
    time.sleep(300)    
