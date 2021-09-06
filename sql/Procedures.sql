# getTodayMax - Get todays's maximums
#---------------------------------------------------------------------------------
DELIMITER $$
DROP PROCEDURE IF EXISTS GetTodayMax;
CREATE PROCEDURE GetTodayMax()
BEGIN
	select 
		id_location, 
		Locations.name,
		ROUND(MAX(pressure),2) AS MAXPress,
		ROUND(MAX(temp - 273.15),2) AS MAXTemp,
		ROUND(MAX(humidity),2) AS MAXHumidity
	FROM RawRecords
	INNER JOIN Locations on id_location = Locations.id
	GROUP BY id_location;
END$$

# getTodayMax - Get todays's minimums
#---------------------------------------------------------------------------------
DELIMITER $$
DROP PROCEDURE IF EXISTS GetTodayMin;
CREATE PROCEDURE GetTodayMin()
BEGIN
    select 
		id_location, 
		Locations.name,
		ROUND(MIN(pressure),2) AS MINPress,
		ROUND(MIN(temp - 273.15),2) AS MINTemp,
		ROUND(MIN(humidity),2) AS MINHumidity
	FROM RawRecords
	INNER JOIN Locations on id_location = Locations.id
	GROUP BY id_location;
END$$

# getTodayMax - Get todays's averages
#---------------------------------------------------------------------------------
DELIMITER $$
DROP PROCEDURE IF EXISTS GetTodayAvg;
CREATE PROCEDURE GetTodayAvg()
BEGIN
	select 
		id_location, 
		Locations.name,
		ROUND(AVG(pressure),2) AS avgPress,
		ROUND(AVG(temp - 273.15),2) AS avgTemp,
		ROUND(AVG(humidity),2) AS avgHumidity
	FROM RawRecords
	INNER JOIN Locations on id_location = Locations.id
	GROUP BY id_location;
END$$

DELIMITER ;

call GetTodayAvg();
call GetTodayMin();
call GetTodayMax();
 