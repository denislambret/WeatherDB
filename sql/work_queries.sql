SELECT COUNT(*) FROM RawData1h;
SELECT MAX(TIMESTAMP)  FROM RawData1h;
SELECT MAX(date_timestamp)  FROM Records;

CALL Get_Hourly_Stats('2021-08-30', 2)

INSERT INTO RecordsByHour 
	SELECT 
		0,
		date_timestamp,
		0,
		COUNT(*) AS nbRec,
		ROUND(min(temp),2) - 271.5 as minTemp,
		ROUND(max(temp),2) - 271.5 as maxTemp,
		ROUND(avg(temp),2) - 271.5 as avgTemp,
		ROUND(min(feels_like),2) - 271.5 as minFeelsLike,
		ROUND(max(feels_like),2) - 271.5 as maxFeelsLike,
		ROUND(avg(feels_like),2) - 271.5 as avgFeelsLike,
		ROUND(min(pressure),2) as minPressure,
		ROUND(max(pressure),2) as maxPressure,
		ROUND(avg(pressure),2) as avgPressure,
		ROUND(min(humidity),2) as minHumidity,
		ROUND(max(humidity),2) as maxHumidity,
		ROUND(avg(humidity),2) as avgHumidity,
		ROUND(avg(wind_speed),2) as avgWindSpeed,
		ROUND(max(wind_speed),2) as maxWindSpeed,
		ROUND(avg(wind_dir),2) as avgWindDir,
		ROUND(avg(clouds_cover),2) as avgCloudsCover,
		ROUND(avg(rain_1h),2) as avgRain,
		ROUND(avg(snow_1h),2) as avgSnow
		FROM RawRecords
		WHERE (DATE(date_timestamp) = '2021-08-30') AND id_location = 6
		GROUP BY 
		  CASE 
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

	
	
	SELECT 
		0,
		date_timestamp,
		HOUR(date_timestamp) AS hour, 
		COUNT(*) AS nbRec,
		ROUND(min(temp),2) - 271.5 as minTemp,
		ROUND(max(temp),2) - 271.5 as maxTemp,
		ROUND(avg(temp),2) - 271.5 as avgTemp,
		ROUND(min(feels_like),2) - 271.5 as minFeelsLike,
		ROUND(max(feels_like),2) - 271.5 as maxFeelsLike,
		ROUND(avg(feels_like),2) - 271.5 as avgFeelsLike,
		ROUND(min(pressure),2) as minPressure,
		ROUND(max(pressure),2) as maxPressure,
		ROUND(avg(pressure),2) as avgPressure,
		ROUND(min(humidity),2) as minHumidity,
		ROUND(max(humidity),2) as maxHumidity,
		ROUND(avg(humidity),2) as avgHumidity,
		ROUND(avg(wind_speed),2) as avgWindSpeed,
		ROUND(max(wind_speed),2) as maxWindSpeed,
		ROUND(avg(wind_dir),2) as avgWindDir,
		ROUND(avg(clouds_cover),2) as avgCloudsCover,
		ROUND(avg(rain_1h),2) as avgRain,
		ROUND(avg(snow_1h),2) as avgSnow
		FROM RawRecords
		WHERE (DATE(date_timestamp) = '2021-08-30') AND id_location = 6
		GROUP BY 
		  CASE 
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
		
		