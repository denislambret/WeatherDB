-- --------------------------------------------------------
-- Hôte:                         192.168.33.100
-- Version du serveur:           8.0.26 - MySQL Community Server - GPL
-- SE du serveur:                Linux
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour WeatherDB
CREATE DATABASE IF NOT EXISTS `WeatherDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `WeatherDB`;

-- Listage de la structure de la procédure WeatherDB. Get_Daily_Stats
DROP PROCEDURE IF EXISTS `Get_Daily_Stats`;
DELIMITER //
CREATE PROCEDURE `Get_Daily_Stats`(my_date DATE, loc INT)
BEGIN
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
	WHERE (
		day(date(date_timestamp)) = day(curdate())
        AND (month(date(date_timestamp)) = month(curdate()))
		AND (year(date(date_timestamp)) = year(curdate()))
        AND (id_location = loc)
	)
	GROUP BY day(date(date_timestamp));
END//
DELIMITER ;

-- Listage de la structure de la procédure WeatherDB. Get_Hourly_Stats
DROP PROCEDURE IF EXISTS `Get_Hourly_Stats`;
DELIMITER //
CREATE PROCEDURE `Get_Hourly_Stats`(my_date DATE, loc INT)
BEGIN
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
	#WHERE (DATE(date_timestamp) = '2021-08-10') AND id_location = loc
	WHERE (DATE(date_timestamp) = my_date) AND id_location = loc
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
END//
DELIMITER ;

-- Listage de la structure de la procédure WeatherDB. Get_Monthly_Stats
DROP PROCEDURE IF EXISTS `Get_Monthly_Stats`;
DELIMITER //
CREATE PROCEDURE `Get_Monthly_Stats`(my_date DATE, loc INT)
BEGIN
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
	WHERE (
		month(date(date_timestamp)) = month(curdate()) 
        AND (year(date(date_timestamp)) = year(curdate()))
        AND id_location = loc
	)
	GROUP BY month(date(date_timestamp));
END//
DELIMITER ;

-- Listage de la structure de la table WeatherDB. Idx_Daily
DROP TABLE IF EXISTS `Idx_Daily`;
CREATE TABLE IF NOT EXISTS `Idx_Daily` (
  `id` int NOT NULL,
  `id_record` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Daily stats record indexes reference table';

-- Listage des données de la table WeatherDB.Idx_Daily : ~2 rows (environ)
/*!40000 ALTER TABLE `Idx_Daily` DISABLE KEYS */;
INSERT IGNORE INTO `Idx_Daily` (`id`, `id_record`) VALUES
	(3, 2052),
	(3, 2052);
/*!40000 ALTER TABLE `Idx_Daily` ENABLE KEYS */;

-- Listage de la structure de la table WeatherDB. Idx_Hourly
DROP TABLE IF EXISTS `Idx_Hourly`;
CREATE TABLE IF NOT EXISTS `Idx_Hourly` (
  `id` int NOT NULL,
  `id_record` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table WeatherDB.Idx_Hourly : ~0 rows (environ)
/*!40000 ALTER TABLE `Idx_Hourly` DISABLE KEYS */;
/*!40000 ALTER TABLE `Idx_Hourly` ENABLE KEYS */;

-- Listage de la structure de la table WeatherDB. Idx_Monthly
DROP TABLE IF EXISTS `Idx_Monthly`;
CREATE TABLE IF NOT EXISTS `Idx_Monthly` (
  `id` int NOT NULL,
  `id_record` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table WeatherDB.Idx_Monthly : ~0 rows (environ)
/*!40000 ALTER TABLE `Idx_Monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `Idx_Monthly` ENABLE KEYS */;

-- Listage de la structure de la table WeatherDB. Locations
DROP TABLE IF EXISTS `Locations`;
CREATE TABLE IF NOT EXISTS `Locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(140) DEFAULT NULL,
  `timezone` float DEFAULT NULL,
  `altitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table WeatherDB.Locations : ~6 rows (environ)
/*!40000 ALTER TABLE `Locations` DISABLE KEYS */;
INSERT IGNORE INTO `Locations` (`id`, `name`, `timezone`, `altitude`, `longitude`, `latitude`, `active`) VALUES
	(2, 'Sion', 7200, 0, 46.2291, 7.3594, NULL),
	(3, 'Evolène', 7200, 0, 46.1135, 7.4944, NULL),
	(4, 'Geneva', 7200, 0, 46.2022, 6.1457, NULL),
	(5, 'Lausanne', 7200, 0, 46.516, 6.6328, NULL),
	(6, 'Hérémence', 7200, 400, 7.4049, 46.1815, NULL),
	(7, 'Geneva', 7200, 400, 6.1457, 46.2022, NULL);
/*!40000 ALTER TABLE `Locations` ENABLE KEYS */;

-- Listage de la structure de la table WeatherDB. RawData1h
DROP TABLE IF EXISTS `RawData1h`;
CREATE TABLE IF NOT EXISTS `RawData1h` (
  `IdRecordsByHour` int NOT NULL AUTO_INCREMENT,
  `LocationId` int DEFAULT NULL,
  `hashMsg` varchar(32) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `Temp2m` float DEFAULT NULL,
  `GrowDeg2m` float DEFAULT NULL,
  `Temp1000mb` float DEFAULT NULL,
  `Temp850mb` float DEFAULT NULL,
  `Temp700mb` float DEFAULT NULL,
  `Rain` float DEFAULT NULL,
  `Snow` float DEFAULT NULL,
  `RHumidity` float DEFAULT NULL,
  `WindSpeed` float DEFAULT NULL,
  `WindDir10m` float DEFAULT NULL,
  `WindSpeed80m` float DEFAULT NULL,
  `WindDir80m` float DEFAULT NULL,
  `WindGust` float DEFAULT NULL,
  `WindSpeed900mb` float DEFAULT NULL,
  `WindDir900mb` float DEFAULT NULL,
  `WindSpeed850mb` float DEFAULT NULL,
  `WindDir850m` float DEFAULT NULL,
  `WindSpeed700m` float DEFAULT NULL,
  `WindDir700m` float DEFAULT NULL,
  `WindDir500m` float DEFAULT NULL,
  `WindSpeed500m` float DEFAULT NULL,
  `Dew point` float DEFAULT NULL,
  `CoverHigh` float DEFAULT NULL,
  `CoverMedium` float DEFAULT NULL,
  `CoverLow` float DEFAULT NULL,
  `CAPE` float DEFAULT NULL,
  `SunshineDuration` float DEFAULT NULL,
  `SWRadiation` float DEFAULT NULL,
  `SWRDirect` float DEFAULT NULL,
  `SWRDiffuse` float DEFAULT NULL,
  `PressureMSL` float DEFAULT NULL,
  `Pressure850mb` float DEFAULT NULL,
  `Pressure700mb` float DEFAULT NULL,
  `Pressure500mb` float DEFAULT NULL,
  `Evap` float DEFAULT NULL,
  `EvapFAO` float DEFAULT NULL,
  `TempSurf` float DEFAULT NULL,
  `SoilTemp` float DEFAULT NULL,
  `SoilMoisture` float DEFAULT NULL,
  `VapoPressureDelta` float DEFAULT NULL,
  PRIMARY KEY (`IdRecordsByHour`)
) ENGINE=InnoDB AUTO_INCREMENT=320352 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Listage de la structure de la table WeatherDB. Records
DROP TABLE IF EXISTS `Records`;
CREATE TABLE IF NOT EXISTS `Records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_timestamp` datetime DEFAULT NULL,
  `temp` float DEFAULT NULL,
  `feels_like` float DEFAULT NULL,
  `pressure` float DEFAULT NULL,
  `humidity` float DEFAULT NULL,
  `wind_speed` float DEFAULT NULL,
  `wind_dir` int DEFAULT NULL,
  `clouds_cover` int DEFAULT NULL,
  `rain_1h` float DEFAULT NULL,
  `snow_1h` float DEFAULT NULL,
  `id_location` int DEFAULT NULL,
  `hashmsg` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `idx_list` (`hashmsg`)
) ENGINE=InnoDB AUTO_INCREMENT=12291 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table WeatherDB.Records : ~8'042 rows (environ)

-- Listage de la structure de la procédure WeatherDB. Set_Daily_Stats
DROP PROCEDURE IF EXISTS `Set_Daily_Stats`;
DELIMITER //
CREATE PROCEDURE `Set_Daily_Stats`(my_date DATE, loc INT)
BEGIN
	select
		null,
        my_date,
        day(date(my_date)) AS `Day`, 
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
END//
DELIMITER ;

-- Listage de la structure de la procédure WeatherDB. Set_Hourly_Stats
DROP PROCEDURE IF EXISTS `Set_Hourly_Stats`;
DELIMITER //
CREATE PROCEDURE `Set_Hourly_Stats`(my_date DATE, loc INT)
BEGIN
	INSERT INTO Stats_Hourly
	SELECT 
		null,
	   '2021-08-10',
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
		END AS `timeRange`, 
			hour(date(date_timestamp)) AS `Hour`, 
			COUNT(*) AS nbRec,
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
		WHERE (DATE(date_timestamp) = my_date) AND id_location = loc
		#WHERE (DATE(date_timestamp) = my_date) AND id_location = loc
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
END//
DELIMITER ;

-- Listage de la structure de la table WeatherDB. Stats_Daily
DROP TABLE IF EXISTS `Stats_Daily`;
CREATE TABLE IF NOT EXISTS `Stats_Daily` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timeStamp` date DEFAULT NULL,
  `nbRec` int DEFAULT NULL,
  `minTemp` float DEFAULT NULL,
  `maxTemp` float DEFAULT NULL,
  `avgTemp` float DEFAULT NULL,
  `minFeelsLike` float DEFAULT NULL,
  `maxFeelsLike` float DEFAULT NULL,
  `avgFeelsLike` float DEFAULT NULL,
  `minPressure` float DEFAULT NULL,
  `maxPressure` float DEFAULT NULL,
  `avgPressure` float DEFAULT NULL,
  `minHumidity` float DEFAULT NULL,
  `maxHumidity` float DEFAULT NULL,
  `avgHumidity` float DEFAULT NULL,
  `maxWindSpeed` float DEFAULT NULL,
  `avgWindSpeed` float DEFAULT NULL,
  `avgWindDir` float DEFAULT NULL,
  `avgCloudCover` float DEFAULT NULL,
  `sumRain` float DEFAULT NULL,
  `sumSnow` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PRIMARY_IDX` (`id`,`timeStamp`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Daily measures report';

-- Listage des données de la table WeatherDB.Stats_Daily : ~2 rows (environ)
/*!40000 ALTER TABLE `Stats_Daily` DISABLE KEYS */;
INSERT IGNORE INTO `Stats_Daily` (`id`, `timeStamp`, `nbRec`, `minTemp`, `maxTemp`, `avgTemp`, `minFeelsLike`, `maxFeelsLike`, `avgFeelsLike`, `minPressure`, `maxPressure`, `avgPressure`, `minHumidity`, `maxHumidity`, `avgHumidity`, `maxWindSpeed`, `avgWindSpeed`, `avgWindDir`, `avgCloudCover`, `sumRain`, `sumSnow`) VALUES
	(1, '2021-06-11', NULL, 12.12, 27.53, 19.24, 11.21, 27.27, 18.56, 1016, 1022, 1019.62, 32, 82, 57.66, 1.89, 7.2, 88.84, 28.65, 8.78, 0),
	(2, '2021-06-11', NULL, 12.12, 27.53, 19.24, 11.21, 27.27, 18.56, 1016, 1022, 1019.62, 32, 82, 57.66, 1.89, 7.2, 88.84, 28.65, 8.78, 0);
/*!40000 ALTER TABLE `Stats_Daily` ENABLE KEYS */;

-- Listage de la structure de la table WeatherDB. Stats_Hourly
DROP TABLE IF EXISTS `Stats_Hourly`;
CREATE TABLE IF NOT EXISTS `Stats_Hourly` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timeStamp` datetime DEFAULT NULL,
  `timeRange` varchar(45) DEFAULT NULL,
  `hour` int DEFAULT NULL,
  `nbRec` int DEFAULT NULL,
  `minTemp` float DEFAULT NULL,
  `maxTemp` float DEFAULT NULL,
  `avgTemp` float DEFAULT NULL,
  `minFeelsLike` float DEFAULT NULL,
  `maxFeelsLike` float DEFAULT NULL,
  `avgFeelsLike` float DEFAULT NULL,
  `minPressure` float DEFAULT NULL,
  `maxPressure` float DEFAULT NULL,
  `avgPressure` float DEFAULT NULL,
  `minHumidity` float DEFAULT NULL,
  `maxHumidity` float DEFAULT NULL,
  `avgHumidity` float DEFAULT NULL,
  `maxWindSpeed` float DEFAULT NULL,
  `avgWindSpeed` float DEFAULT NULL,
  `avgDir` float DEFAULT NULL,
  `avgCloudCover` float DEFAULT NULL,
  `sumRain` float DEFAULT NULL,
  `sumSnow` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table WeatherDB.Stats_Hourly : ~2 rows (environ)
/*!40000 ALTER TABLE `Stats_Hourly` DISABLE KEYS */;
INSERT IGNORE INTO `Stats_Hourly` (`id`, `timeStamp`, `timeRange`, `hour`, `nbRec`, `minTemp`, `maxTemp`, `avgTemp`, `minFeelsLike`, `maxFeelsLike`, `avgFeelsLike`, `minPressure`, `maxPressure`, `avgPressure`, `minHumidity`, `maxHumidity`, `avgHumidity`, `maxWindSpeed`, `avgWindSpeed`, `avgDir`, `avgCloudCover`, `sumRain`, `sumSnow`) VALUES
	(159, '2021-08-10 00:00:00', '21:00 - 22:00', 0, 2, 13.74, 13.74, 13.74, 12.62, 12.62, 12.62, 1018, 1018, 1018, 62, 62, 62, 1.03, 1.03, 50, 0, 0, 0),
	(160, '2021-08-10 00:00:00', '22:00 - 23:00', 0, 9, 11.8, 13.37, 12.32, 10.75, 12.27, 11.22, 1019, 1019, 1019, 63, 72, 68.11, 1.77, 2.06, 31.11, 0, 0, 0);
/*!40000 ALTER TABLE `Stats_Hourly` ENABLE KEYS */;

-- Listage de la structure de la table WeatherDB. Stats_Monthly
DROP TABLE IF EXISTS `Stats_Monthly`;
CREATE TABLE IF NOT EXISTS `Stats_Monthly` (
  `id` int NOT NULL,
  `timeStamp` datetime DEFAULT NULL,
  `minTemp` int DEFAULT NULL,
  `maxTemp` float DEFAULT NULL,
  `avgTemp` float DEFAULT NULL,
  `minFeelsLike` float DEFAULT NULL,
  `maxFeelsLike` float DEFAULT NULL,
  `avgFeelsLike` float DEFAULT NULL,
  `minPressure` float DEFAULT NULL,
  `maxPressure` float DEFAULT NULL,
  `avgPressure` float DEFAULT NULL,
  `minHumidity` float DEFAULT NULL,
  `maxHumidity` float DEFAULT NULL,
  `avgHumidity` float DEFAULT NULL,
  `maxWindSpeed` float DEFAULT NULL,
  `avgWindSpeed` float DEFAULT NULL,
  `avgDir` float DEFAULT NULL,
  `avgCloudCover` float DEFAULT NULL,
  `sumRain` float DEFAULT NULL,
  `sumSnow` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table WeatherDB.Stats_Monthly : ~0 rows (environ)
/*!40000 ALTER TABLE `Stats_Monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `Stats_Monthly` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
