#----------------------------------------------------------------------------------
# Table : RawRecords
# List records created by locations and creation dates
#----------------------------------------------------------------------------------
SELECT date(date_timestamp) AS dte, Locations.name, count(date_timestamp) AS nb_records
FROM RawRecords
INNER JOIN Locations ON Locations.id = RawRecords.id_location
WHERE id_location IN (SELECT id FROM Locations)
GROUP BY id_location, date(date_timestamp) 
ORDER BY date(date_timestamp);

#----------------------------------------------------------------------------------
# Table : RawRecords
# List records created by locations and creation dates grouped by locations + month
#----------------------------------------------------------------------------------
SELECT date(date_timestamp) AS dte, Locations.name AS LName, count(date_timestamp) AS nb_records
FROM RawRecords
INNER JOIN Locations ON Locations.id = RawRecords.id_location
WHERE MONTH(DATE(date_timestamp)) in (SELECT MONTH(DATE(date_timestamp)) FROM RawRecords GROUP BY MONTH(DATE(date_timestamp)))
AND ( id_location IN (SELECT id FROM Locations) ) 
GROUP BY id_location, month(date_timestamp) 
ORDER BY id_location, month(date_timestamp);

SELECT COUNT(*) as totalRecs 
from RawRecords;

#----------------------------------------------------------------------------------
# Table : RawRecords
# Select MIN,MAX,AVG by locations and creation dates grouped by locations + day
#----------------------------------------------------------------------------------
SELECT date(date_timestamp) AS date, Locations.name AS LName, 
(round(min(temp),2) - 273.15) as minTemp, (round(max(temp),2) - 273.15) as maxTemp, (round(avg(temp), 2) - 273.15) as avgTemp,
round(min(humidity),2) as minHumidity, round(max(humidity),2) as maxHumidity, round(avg(humidity), 2) as avgHumidity,
round(min(pressure),2) as minPressure, round(max(pressure),2) as maxPressure, round(avg(pressure), 2) as avgPressure,
round(sum(rain_1h))
FROM RawRecords
INNER JOIN Locations ON Locations.id = RawRecords.id_location
WHERE id_location IN (SELECT id FROM Locations)
GROUP BY id_location, month(date_timestamp),day(date_timestamp)
ORDER BY id_location, date_timestamp;

#----------------------------------------------------------------------------------
# Table : RawRecords
# Select MIN,MAX,AVG by locations and creation dates grouped by locations + month
#----------------------------------------------------------------------------------
SELECT date(date_timestamp) AS dte, Locations.name AS LName, 
(round(min(temp),2) - 273.15) as minTemp, (round(max(temp),2) - 273.15) as maxTemp, (round(avg(temp), 2) - 273.15) as avgTemp,
round(min(humidity),2) as minHumidity, round(max(humidity),2) as maxHumidity, round(avg(humidity), 2) as avgHumidity,
round(min(pressure),2) as minPressure, round(max(pressure),2) as maxPressure, round(avg(pressure), 2) as avgPressure
FROM RawRecords
INNER JOIN Locations ON Locations.id = RawRecords.id_location
WHERE MONTH(DATE(date_timestamp)) in (SELECT MONTH(DATE(date_timestamp)) FROM RawRecords GROUP BY MONTH(DATE(date_timestamp)))
AND ( id_location IN (SELECT id FROM Locations) ) 
GROUP BY id_location, month(date_timestamp) 
ORDER BY id_location, month(date_timestamp);



SELECT LocationName, count(date)
FROM (
		SELECT date(date_timestamp) AS date, Locations.name AS LocationName
		FROM RawRecords
		INNER JOIN Locations ON Locations.id = RawRecords.id_location
		WHERE (id_location = 6) 
		GROUP BY id_location, MONTH(date_timestamp), DAY(date_timestamp)
		HAVING ( (round(max(temp), 2) - 273.15) < 0)
) tmpTable;



SELECT date(date_timestamp) AS date, Locations.name AS LocationName, round(sum(rain_1h / 4),2) as totalSnow, round((temp - 273.15),2) as t
FROM RawRecords
INNER JOIN Locations ON Locations.id = RawRecords.id_location
WHERE ((id_location = 6) AND (rain_1h > 0 )) 
GROUP BY id_location, MONTH(date_timestamp), DAY(date_timestamp)
HAVING ( t <= 2)
                
