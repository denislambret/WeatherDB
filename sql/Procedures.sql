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
	FROM Records
	Inner join Locations on id_location = Locations.id
	group by id_location;
END$$

DROP PROCEDURE IF EXISTS GetTodayMin;
CREATE PROCEDURE GetTodayMin()
BEGIN
    select 
		id_location, 
		Locations.name,
		ROUND(MIN(pressure),2) AS MINPress,
		ROUND(MIN(temp - 273.15),2) AS MINTemp,
		ROUND(MIN(humidity),2) AS MINHumidity
	FROM Records
	Inner join Locations on id_location = Locations.id
	group by id_location;
END$$

DROP PROCEDURE IF EXISTS GetTodayAvg;
CREATE PROCEDURE GetTodayAvg()
BEGIN
	select 
		id_location, 
		Locations.name,
		ROUND(AVG(pressure),2) AS avgPress,
		ROUND(AVG(temp - 273.15),2) AS avgTemp,
		ROUND(AVG(humidity),2) AS avgHumidity
	FROM Records
	Inner join Locations on id_location = Locations.id
	group by id_location;
END$$

DELIMITER ;

call GetTodayAvg();
call GetTodayMin();
call GetTodayMax();
 