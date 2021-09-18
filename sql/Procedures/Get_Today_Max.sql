CREATE DEFINER=`dev`@`%` PROCEDURE `Get_Today_Max`(
	IN `my_date` DATE,
	IN `loc` INT
)
BEGIN
	SELECT 
		id_location, 
		Locations.name,
		ROUND(MAX(pressure),2) AS MAXPress,
		ROUND(MAX(temp - 273.15),2) AS MAXTemp,
		ROUND(MAX(humidity),2) AS MAXHumidity
	FROM RawRecords
	INNER JOIN Locations on id_location = Locations.id
    WHERE  id_location = loc AND (date_timestamp = CURDATE())
	GROUP BY id_location;
END