'''
Created on 01 august 2021
Updated 
@author: dns
'''

# ------------------------------------------------------------------------------------------------------
# Imports
# ------------------------------------------------------------------------------------------------------
import sys
import getopt
import numpy as np
import pandas as pd
import hashlib

# ------------------------------------------------------------------------------------------------------
# Global Variables
# ------------------------------------------------------------------------------------------------------
mydb = ''
cursorDB = ''
host = "192.168.33.100"
user = "dev"
pwd = "1234qwerASD!"
apiKey = "7fe4b94a6895956f0cfe6c083016f804"

#source = 'D:/dev/60_Python/WeatherDB/data/MeteoBlue_LowRes_dataexport_20210718T094329_final.csv'
source = 'D:/dev/60_Python/WeatherDB/data/sample.csv'
target = 'D:/dev/60_Python/WeatherDB/data/sample_norm.csv'

def getMd5(msg):
    msg =  hashlib.md5(msg.to_string().encode('utf-8'))
    return msg.hexdigest()

def location():
    return 6

# ------------------------------------------------------------------------------------------------------
# MAIN
# ------------------------------------------------------------------------------------------------------
def main(argv):
   print('------------------------------------------------------------------------------------------------------')
   print('ImportArcMeteoBlue.py')
   print('------------------------------------------------------------------------------------------------------')

   raw_data = pd.read_csv(source,sep=';')

   raw_data['LocationId'] = raw_data.apply(lambda x: location(), axis=1)
   raw_data['hashMsg']    = raw_data.apply(lambda x: getMd5(x), axis=1)
   raw_data['TimeStamp']  = raw_data['TimeStamp'].str.replace('T',' ')

   raw_data.to_csv(target,sep=';',index=True)
