CREATE DEFINER=`dev`@`%` PROCEDURE `Get_Monthly_Stats`(
	IN `my_date` DATE,
	IN `loc` INT
)
BEGIN
# Monthly stats from Records table
#-------------------------------------------------------------------------------------------------------
	select
		id_location, 
        date_timestamp,
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
		round(max(wind_speed),2) as maxWindSpeed,
		round(avg(wind_dir),2) as avgWindDir,
		round(avg(clouds_cover),2) as avgCloudsCover,
		round(sum(rain_1h),2) as sumRain,
		round(sum(snow_1h),2) as sumSnow
	FROM RawRecords
	WHERE (
		month(date(date_timestamp)) = month(my_date) 
        AND (year(date(date_timestamp)) = year(my_date))
        AND id_location = loc
	)
	GROUP BY month(date(date_timestamp));
END