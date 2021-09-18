-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 192.168.33.100    Database: WeatherDB
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Idx_Daily`
--

DROP TABLE IF EXISTS `Idx_Daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Idx_Daily` (
  `id` int NOT NULL,
  `id_record` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Daily stats record indexes reference table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Idx_Hourly`
--

DROP TABLE IF EXISTS `Idx_Hourly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Idx_Hourly` (
  `id` int NOT NULL,
  `id_record` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Idx_Monthly`
--

DROP TABLE IF EXISTS `Idx_Monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Idx_Monthly` (
  `id` int NOT NULL,
  `id_record` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Locations`
--

DROP TABLE IF EXISTS `Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Locations` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RawData1h`
--

DROP TABLE IF EXISTS `RawData1h`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RawData1h` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RawRecords`
--

DROP TABLE IF EXISTS `RawRecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RawRecords` (
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
) ENGINE=InnoDB AUTO_INCREMENT=13225 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RecordsByDay`
--

DROP TABLE IF EXISTS `RecordsByDay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RecordsByDay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timeStamp` datetime DEFAULT NULL,
  `nbRec` int DEFAULT NULL,
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
  `avgWindDir` float DEFAULT NULL,
  `avgCloudsCover` float DEFAULT NULL,
  `sumRain` float DEFAULT NULL,
  `sumSnow` float DEFAULT NULL,
  `idLocation` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RecordsByHour`
--

DROP TABLE IF EXISTS `RecordsByHour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RecordsByHour` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idLocation` int DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
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
  `avgWindSpeed` float DEFAULT NULL,
  `gust` float DEFAULT NULL,
  `avgWindDir` float DEFAULT NULL,
  `avgCloudsCover` float DEFAULT NULL,
  `sumRain` float DEFAULT NULL,
  `sumSnow` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RecordsByMonth`
--

DROP TABLE IF EXISTS `RecordsByMonth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RecordsByMonth` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idLocation` int DEFAULT NULL,
  `timeStamp` datetime DEFAULT NULL,
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
  `avgCloudsCover` float DEFAULT NULL,
  `sumRain` float DEFAULT NULL,
  `sumSnow` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RecordsByQuarter`
--

DROP TABLE IF EXISTS `RecordsByQuarter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RecordsByQuarter` (
  `id` int NOT NULL,
  `idLocation` int DEFAULT NULL,
  `timeStamp` datetime DEFAULT NULL,
  `quarter` int DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RecordsByYear`
--

DROP TABLE IF EXISTS `RecordsByYear`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RecordsByYear` (
  `id` int NOT NULL,
  `timeStamp` datetime DEFAULT NULL,
  `year` int DEFAULT NULL,
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Stats_Daily`
--

DROP TABLE IF EXISTS `Stats_Daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stats_Daily` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Stats_Hourly`
--

DROP TABLE IF EXISTS `Stats_Hourly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stats_Hourly` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Stats_Monthly`
--

DROP TABLE IF EXISTS `Stats_Monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stats_Monthly` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WeatherDB.RecordsByHour`
--

DROP TABLE IF EXISTS `WeatherDB.RecordsByHour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WeatherDB.RecordsByHour` (
  `id` bigint DEFAULT NULL,
  `date_timestamp` datetime DEFAULT NULL,
  `Hour` bigint DEFAULT NULL,
  `nbRec` bigint DEFAULT NULL,
  `minTemp` double DEFAULT NULL,
  `maxTemp` double DEFAULT NULL,
  `avgTemp` double DEFAULT NULL,
  `minFeelsLike` double DEFAULT NULL,
  `maxFeelsLike` double DEFAULT NULL,
  `avgFeelsLike` double DEFAULT NULL,
  `minPressure` double DEFAULT NULL,
  `maxPressure` double DEFAULT NULL,
  `avgPressure` double DEFAULT NULL,
  `minHumidity` double DEFAULT NULL,
  `maxHumidity` double DEFAULT NULL,
  `avgHumidity` double DEFAULT NULL,
  `avgWindSpeed` double DEFAULT NULL,
  `gust` double DEFAULT NULL,
  `avgWindDir` double DEFAULT NULL,
  `avgCloudsCover` double DEFAULT NULL,
  `sumRain` double DEFAULT NULL,
  `sumSnow` double DEFAULT NULL,
  KEY `ix_WeatherDB.RecordsByHour_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'WeatherDB'
--
/*!50003 DROP PROCEDURE IF EXISTS `Get_Daily_Stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `Get_Daily_Stats`(
	IN `my_date` DATE,
	IN `loc` INT
)
BEGIN
	# Daily stats from Records table
	#-------------------------------------------------------------------------------------------------------
	select
        loc as idLocation,
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
		day(date(date_timestamp)) = day(curdate())
        AND (month(date(date_timestamp)) = month(curdate()))
		AND (year(date(date_timestamp)) = year(curdate()))
        AND (id_location = loc)
	)
	GROUP BY day(date(date_timestamp));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Get_Hourly_Stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `Get_Hourly_Stats`(
	IN `my_date` DATE,
	IN `loc` INT
)
BEGIN
# Hourly stats from Records table
#-------------------------------------------------------------------------------------------------------
	SELECT 
	loc AS idLocation, 
	date_timestamp,
#	CASE 
#	  WHEN HOUR(date_timestamp) BETWEEN 0 AND 1 THEN '00:00 - 01:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 1 AND 2 THEN '01:00 - 02:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 2 AND 3 THEN '02:00 - 03:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 3 AND 4 THEN '03:00 - 04:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 4 AND 5 THEN '04:00 - 05:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 5 AND 6 THEN '05:00 - 06:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 6 AND 7 THEN '06:00 - 07:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 7 AND 8 THEN '07:00 - 08:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 8 AND 9 THEN '08:00 - 09:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 9 AND 10 THEN '09:00 - 10:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 10 AND 11 THEN '10:00 - 11:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 11 AND 12 THEN '11:00 - 12:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 12 AND 13 THEN '12:00 - 13:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 13 AND 14 THEN '13:00 - 14:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 14 AND 15 THEN '14:00 - 15:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 15 AND 16 THEN '15:00 - 16:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 16 AND 17 THEN '16:00 - 17:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 17 AND 18 THEN '17:00 - 18:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 18 AND 19 THEN '18:00 - 19:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 19 AND 20 THEN '19:00 - 20:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 20 AND 21 THEN '20:00 - 21:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 21 AND 22 THEN '21:00 - 22:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 22 AND 23 THEN '22:00 - 23:00'
#	  WHEN HOUR(date_timestamp) BETWEEN 23 AND 24 THEN '23:00 - 00:00'
#	END AS `Hours`, 

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
		ROUND(max(wind_speed),2) as gust,
		ROUND(avg(wind_dir),2) as avgWindDir,
		ROUND(avg(clouds_cover),2) as avgCloudsCover,
		ROUND(sum(rain_1h),2) as sumRain,
		ROUND(sum(snow_1h),2) as sumSnow
	FROM RawRecords
	#WHERE (DATE(date_timestamp) = '2021-08-10') AND id_location = loc
	WHERE (DATE(date_timestamp) = my_date) AND id_location = loc
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Get_Monthly_Stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `Get_Monthly_Stats`(
	IN `my_date` DATE,
	IN `loc` INT
)
BEGIN
# Monthly stats from Records table
#-------------------------------------------------------------------------------------------------------
	select
		loc AS idLocation, 
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Set_Daily_Stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `Set_Daily_Stats`(my_date DATE, loc INT)
BEGIN
	select
		null,
        my_date,
		loc AS idLocation, 
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Set_Hourly_Stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `Set_Hourly_Stats`(my_date DATE, loc INT)
BEGIN
	INSERT INTO Stats_Hourly
	SELECT 
		null,
	    loc AS idLocation, 
        my_date,
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-06 22:20:49
