'''
Created on 9 avr. 2020
Update 31.05.2021
@author: dns


'''

# imports
#------------------------------------------------------------------------------------------------------
import mysql.connector
import requests
import json
import time

# getWeatherMessage()
#------------------------------------------------------------------------------------------------------
def getWeatherMessage(location,apiKey):
    url="https://api.openweathermap.org/data/2.5/weather?q={},ch&appid={}".format(location,apiKey)    
    
    try:
        r = requests.get(url, params={'q': location,'appid': apiKey})
    except requests.exceptions.RequestException as err:
        print ("Connection error : ",err)
        return False
   
    r.text
    data = json.loads(r.text)
    return data

# dbconnect()
#------------------------------------------------------------------------------------------------------
def dbconnect(srv, usr, pwd):
   
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
            print("SQLSTATE value : {}".format(e.sqlstate)) # SQLSTATE value
            print("Error message  : {}".format(e.msg))       # error message
            print("Error          : {}".format(e))                   # errno, sqlstate, msg values
            
        else:
            print("Db server is unreachable or down... Hint : Check network configuration endpoints.")
    return False


'''
-----------------------------------------------------------------------------------------------------
Main application
-----------------------------------------------------------------------------------------------------
'''
host = "192.168.1.10"
user = "dev"
pwd  = "password"

msg = getWeatherMessage("Heremence","7fe4b94a6895956f0cfe6c083016f804")
if msg:
    print(f"Message retrieved from OpenWeather.")
else:
    print("Server unavailable or wrong URL. No HTTP query answer received!")

dbx = dbconnect(host,user,pwd)
if dbx:
    print(f"{dbx}")
else:
    print(f"DB connection failed!")


