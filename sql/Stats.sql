# Hourly stats from Records table
#-------------------------------------------------------------------------------------------------------
SELECT 
CASE 
  WHEN HOUR(date_timestamp) BETWEEN 0 AND 1 THEN '00:00 - 01:00'
  WHEN HOUR(date_timestamp) BETWEEN 1 AND 2 THEN '01:00 - 02:00'
  WHEN HOUR(date_timestamp) BETWEEN 2 AND 3 THEN '02:00 - 03:00'
  WHEN HOUR(date_timestamp) BETWEEN 3 AND 4 THEN '03:00 - 04:00'
  WHEN HOUR(date_timestamp) BETWEEN 4 AND 5 THEN '04:00 - 05:00'
  WHEN HOUR(date_timestamp) BETWEEN 5 AND 6 THEN '05:00 - 06:00'
  WHEN HOUR(date_timestamp) BETWEEN 6 AND 7 THEN '06:00 - 07:00'
  WHEN HOUR(date_timestamp) BETWEEN 7 AND 8 THEN '07:00 - 08:00'
  WHEN HOUR(date_timestamp) BETWEEN 8 AND 9 THEN '08:00 - 09:00'
  WHEN HOUR(date_timestamp) BETWEEN 9 AND 10 THEN '09:00 - 10:00'
  WHEN HOUR(date_timestamp) BETWEEN 10 AND 11 THEN '10:00 - 11:00'
  WHEN HOUR(date_timestamp) BETWEEN 11 AND 12 THEN '11:00 - 12:00'
  WHEN HOUR(date_timestamp) BETWEEN 12 AND 13 THEN '12:00 - 13:00'
  WHEN HOUR(date_timestamp) BETWEEN 13 AND 14 THEN '13:00 - 14:00'
  WHEN HOUR(date_timestamp) BETWEEN 14 AND 15 THEN '14:00 - 15:00'
  WHEN HOUR(date_timestamp) BETWEEN 15 AND 16 THEN '15:00 - 16:00'
  WHEN HOUR(date_timestamp) BETWEEN 16 AND 17 THEN '16:00 - 17:00'
  WHEN HOUR(date_timestamp) BETWEEN 17 AND 18 THEN '17:00 - 18:00'
  WHEN HOUR(date_timestamp) BETWEEN 18 AND 19 THEN '18:00 - 19:00'
  WHEN HOUR(date_timestamp) BETWEEN 19 AND 20 THEN '19:00 - 20:00'
  WHEN HOUR(date_timestamp) BETWEEN 20 AND 21 THEN '20:00 - 21:00'
  WHEN HOUR(date_timestamp) BETWEEN 21 AND 22 THEN '21:00 - 22:00'
  WHEN HOUR(date_timestamp) BETWEEN 22 AND 23 THEN '22:00 - 23:00'
  WHEN HOUR(date_timestamp) BETWEEN 23 AND 24 THEN '23:00 - 00:00'
END AS `Hours`, COUNT(*) AS nbRec,
	hour(date(date_timestamp)) AS `Hour`, 
	round(min(temp),2) - 271.5 as minTemp,
	round(max(temp),2) - 271.5 as maxTemp,
	round(avg(temp),2) - 271.5 as avgTemp,
	round(min(feels_like),2) - 271.5 as minFeelsLike,
    round(max(feels_like),2) - 271.5 as maxFeelsLike,
    round(avg(feels_like),2) - 271.5 as avgFeelsLike,
	round(min(pressure),2) as minPressure,
    round(max(pressure),2) as maxPressure,
    round(avg(pressure),2) as avgPressure,
	round(min(humidity),2) as minHumidity,
    round(max(humidity),2) as maxHumidity,
    round(avg(humidity),2) as avgHumidity,
	round(avg(wind_speed),2) as avgWindSpeed,
	round(max(wind_speed),2) as gust,
	round(avg(wind_dir),2) as avgWindDir,
	round(avg(clouds_cover),2) as avgCloudsCover,
	round(sum(rain_1h),2) as sumRain,
	round(sum(snow_1h),2) as sumSnow
FROM Records
#WHERE (DATE(date_timestamp) = '2021-08-10') AND id_location = 6
WHERE (DATE(date_timestamp) = curdate()) AND id_location = 6
GROUP BY 
  CASE 
    WHEN HOUR(date_timestamp) BETWEEN 0 AND 1 THEN 1
    WHEN HOUR(date_timestamp) BETWEEN 1 AND 2 THEN 2
    WHEN HOUR(date_timestamp) BETWEEN 2 AND 3 THEN 3
    WHEN HOUR(date_timestamp) BETWEEN 3 AND 4 THEN 4
    WHEN HOUR(date_timestamp) BETWEEN 4 AND 5 THEN 5
    WHEN HOUR(date_timestamp) BETWEEN 5 AND 6 THEN 6
    WHEN HOUR(date_timestamp) BETWEEN 6 AND 7 THEN 7
    WHEN HOUR(date_timestamp) BETWEEN 7 AND 8 THEN 8
    WHEN HOUR(date_timestamp) BETWEEN 8 AND 9 THEN 9
    WHEN HOUR(date_timestamp) BETWEEN 9 AND 10 THEN 10
    WHEN HOUR(date_timestamp) BETWEEN 10 AND 11 THEN 11
    WHEN HOUR(date_timestamp) BETWEEN 11 AND 12 THEN 12
    WHEN HOUR(date_timestamp) BETWEEN 12 AND 13 THEN 13
    WHEN HOUR(date_timestamp) BETWEEN 13 AND 14 THEN 14
    WHEN HOUR(date_timestamp) BETWEEN 14 AND 15 THEN 15
    WHEN HOUR(date_timestamp) BETWEEN 15 AND 16 THEN 16
    WHEN HOUR(date_timestamp) BETWEEN 16 AND 17 THEN 17
    WHEN HOUR(date_timestamp) BETWEEN 17 AND 18 THEN 18
    WHEN HOUR(date_timestamp) BETWEEN 18 AND 19 THEN 19
    WHEN HOUR(date_timestamp) BETWEEN 19 AND 20 THEN 20
    WHEN HOUR(date_timestamp) BETWEEN 20 AND 21 THEN 21
    WHEN HOUR(date_timestamp) BETWEEN 21 AND 22 THEN 22
    WHEN HOUR(date_timestamp) BETWEEN 22 AND 23 THEN 23
    WHEN HOUR(date_timestamp) BETWEEN 23 AND 24 THEN 24
END;

# Daily stats from Records table
#-------------------------------------------------------------------------------------------------------
select
	day(date(date_timestamp)) AS `Day`, 
	count(*) AS nbRec,
	round(min(temp),2) - 271.5 as minTemp,
	round(max(temp),2) - 271.5 as maxTemp,
	round(avg(temp),2) - 271.5 as avgTemp,
	round(min(feels_like),2) - 271.5 as minFeelsLike,
	round(max(feels_like),2) - 271.5 as maxFeelsLike,
	round(avg(feels_like),2) - 271.5 as avgFeelsLike,
	round(min(pressure),2) as minPressure,
	round(max(pressure),2) as maxPressure,
	round(avg(pressure),2) as avgPressure,
	round(min(humidity),2) as minHumidity,
	round(max(humidity),2) as maxHumidity,
	round(avg(humidity),2) as avgHumidity,
	round(avg(wind_speed),2) as avgWindSpeed,
	round(max(wind_speed),2) as maxWind,
	round(avg(wind_dir),2) as avgWindDir,
	round(avg(clouds_cover),2) as avgCloudsCover,
	round(sum(rain_1h),2) as sumRain,
	round(sum(snow_1h),2) as sumSnow
FROM Records
WHERE (day(date(date_timestamp)) = day(curdate())) AND id_location = 6
GROUP BY day(date(date_timestamp));
  
# Monthly stats from Records table
#-------------------------------------------------------------------------------------------------------
select
	month(date(date_timestamp)) AS `month`, 
	count(*) AS nbRec,
	round(min(temp),2) - 271.5 as minTemp,
	round(max(temp),2) - 271.5 as maxTemp,
	round(avg(temp),2) - 271.5 as avgTemp,
	round(min(feels_like),2) - 271.5 as minFeelsLike,
	round(max(feels_like),2) - 271.5 as maxFeelsLike,
	round(avg(feels_like),2) - 271.5 as avgFeelsLike,
	round(min(pressure),2) as minPressure,
	round(max(pressure),2) as maxPressure,
	round(avg(pressure),2) as avgPressure,
	round(min(humidity),2) as minHumidity,
	round(max(humidity),2) as maxHumidity,
	round(avg(humidity),2) as avgHumidity,
	round(avg(wind_speed),2) as avgWindSpeed,
	round(max(wind_speed),2) as maxWind,
	round(avg(wind_dir),2) as avgWindDir,
	round(avg(clouds_cover),2) as avgCloudsCover,
	round(sum(rain_1h),2) as sumRain,
	round(sum(snow_1h),2) as sumSnow
FROM Records
WHERE (month(date(date_timestamp)) = month(curdate())) AND id_location = 6
GROUP BY month(date(date_timestamp));

