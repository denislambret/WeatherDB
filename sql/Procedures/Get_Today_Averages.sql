CREATE DEFINER=`dev`@`%` PROCEDURE `Get_Today_Avg`(
	IN `my_date` DATE,
	IN `loc` INT
)
BEGIN
	SELECT 
		id_location, 
		Locations.name,
		ROUND(AVG(pressure),2) AS avgPress,
		ROUND(AVG(temp - 273.15),2) AS avgTemp,
		ROUND(AVG(humidity),2) AS avgHumidity
	FROM RawRecords
	INNER JOIN Locations on id_location = Locations.id
	WHERE  id_location = loc AND (date_timestamp = CURDATE())
    GROUP BY id_location;
END