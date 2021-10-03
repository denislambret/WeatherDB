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