CREATE DEFINER=`dev`@`%` PROCEDURE `Get_Monthly_Stats`(IN `my_date` DATE, IN `loc` INT)
BEGIN 
# Monthly stats from Records table
#-------------------------------------------------------------------------------------------------------
SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));	
SELECT 
    date_timestamp,
    MONTH(DATE(date_timestamp)) AS `month`,
    COUNT(*) AS nbRec,
    ROUND(MIN(temp), 2) - 271.5 AS minTemp,
    ROUND(MAX(temp), 2) - 271.5 AS maxTemp,
    ROUND(AVG(temp), 2) - 271.5 AS avgTemp,
    ROUND(MIN(feels_like), 2) - 271.5 AS minFeelsLike,
    ROUND(MAX(feels_like), 2) - 271.5 AS maxFeelsLike,
    ROUND(AVG(feels_like), 2) - 271.5 AS avgFeelsLike,
    ROUND(MIN(pressure), 2) AS minPressure,
    ROUND(MAX(pressure), 2) AS maxPressure,
    ROUND(AVG(pressure), 2) AS avgPressure,
    ROUND(MIN(humidity), 2) AS minHumidity,
    ROUND(MAX(humidity), 2) AS maxHumidity,
    ROUND(AVG(humidity), 2) AS avgHumidity,
    ROUND(AVG(wind_speed), 2) AS avgWindSpeed,
    ROUND(MAX(wind_speed), 2) AS maxWindSpeed,
    ROUND(AVG(wind_dir), 2) AS avgWindDir,
    ROUND(AVG(clouds_cover), 2) AS avgCloudsCover,
    ROUND(SUM(rain_1h), 2) AS sumRain,
    ROUND(SUM(snow_1h), 2) AS sumSnow
FROM
    RawRecords
WHERE
    (MONTH(DATE(date_timestamp)) = MONTH(my_date)
        AND (YEAR(DATE(date_timestamp)) = YEAR(my_date))
        AND id_location = loc)
GROUP BY MONTH(DATE(date_timestamp));
END