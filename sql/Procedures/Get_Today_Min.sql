CREATE DEFINER=`dev`@`%` PROCEDURE `Get_Today_Min`(
	IN `my_date` DATE,
	IN `loc` INT
)
BEGIN
    SELECT
		id_location, 
		Locations.name,
		ROUND(MIN(pressure),2) AS MINPress,
		ROUND(MIN(temp - 273.15),2) AS MINTemp,
		ROUND(MIN(humidity),2) AS MINHumidity
	FROM RawRecords
	INNER JOIN Locations on id_location = Locations.id
    WHERE  id_location = loc AND (date_timestamp = CURDATE())
	GROUP BY id_location;
END