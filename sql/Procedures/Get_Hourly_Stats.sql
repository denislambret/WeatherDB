CREATE DEFINER=`dev`@`%` PROCEDURE `Get_Hourly_Stats`(IN `my_date` DATE, IN `loc` INT)
BEGIN 

# Hourly stats from Records table
#-------------------------------------------------------------------------------------------------------
SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SELECT 
    date_timestamp,
    HOUR(date_timestamp) AS `Hour`,
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
    ROUND(MAX(wind_speed), 2) AS gust,
    ROUND(AVG(wind_dir), 2) AS avgWindDir,
    ROUND(AVG(clouds_cover), 2) AS avgCloudsCover,
    ROUND(SUM(rain_1h), 2) AS sumRain,
    ROUND(SUM(snow_1h), 2) AS sumSnow
FROM
    RawRecords
WHERE
    (DATE(date_timestamp) = my_date)
        AND id_location = loc
GROUP BY CASE
    WHEN HOUR(date_timestamp) BETWEEN 0 AND 1 THEN 0
    WHEN HOUR(date_timestamp) BETWEEN 1 AND 2 THEN 1
    WHEN HOUR(date_timestamp) BETWEEN 2 AND 3 THEN 2
    WHEN HOUR(date_timestamp) BETWEEN 3 AND 4 THEN 3
    WHEN HOUR(date_timestamp) BETWEEN 4 AND 5 THEN 4
    WHEN HOUR(date_timestamp) BETWEEN 5 AND 6 THEN 5
    WHEN HOUR(date_timestamp) BETWEEN 6 AND 7 THEN 6
    WHEN HOUR(date_timestamp) BETWEEN 7 AND 8 THEN 7
    WHEN HOUR(date_timestamp) BETWEEN 8 AND 9 THEN 8
    WHEN HOUR(date_timestamp) BETWEEN 9 AND 10 THEN 9
    WHEN HOUR(date_timestamp) BETWEEN 10 AND 11 THEN 10
    WHEN HOUR(date_timestamp) BETWEEN 11 AND 12 THEN 11
    WHEN HOUR(date_timestamp) BETWEEN 12 AND 13 THEN 12
    WHEN HOUR(date_timestamp) BETWEEN 13 AND 14 THEN 13
    WHEN HOUR(date_timestamp) BETWEEN 14 AND 15 THEN 14
    WHEN HOUR(date_timestamp) BETWEEN 15 AND 16 THEN 15
    WHEN HOUR(date_timestamp) BETWEEN 16 AND 17 THEN 16
    WHEN HOUR(date_timestamp) BETWEEN 17 AND 18 THEN 17
    WHEN HOUR(date_timestamp) BETWEEN 18 AND 19 THEN 18
    WHEN HOUR(date_timestamp) BETWEEN 19 AND 20 THEN 19
    WHEN HOUR(date_timestamp) BETWEEN 20 AND 21 THEN 20
    WHEN HOUR(date_timestamp) BETWEEN 21 AND 22 THEN 21
    WHEN HOUR(date_timestamp) BETWEEN 22 AND 23 THEN 22
    WHEN HOUR(date_timestamp) BETWEEN 23 AND 24 THEN 23
END;
END