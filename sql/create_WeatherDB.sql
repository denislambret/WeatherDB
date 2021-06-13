-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: 192.168.10.33    Database: WeatherDB
-- ------------------------------------------------------
-- Server version	5.7.29 ---

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(140) DEFAULT NULL,
  `timezone` float DEFAULT NULL,
  `altitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `Locations` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `records`
--

DROP TABLE IF EXISTS `Records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_timestamp` datetime DEFAULT NULL,
  `temp` float DEFAULT NULL,
  `feels_like` float DEFAULT NULL,
  `pressure` float DEFAULT NULL,
  `humidity` float DEFAULT NULL,
  `wind_speed` float DEFAULT NULL,
  `wind_dir` int(11) DEFAULT NULL,
  `clouds_cover` int(11) DEFAULT NULL,
  `rain_1h` float DEFAULT NULL,
  `snow_1h` float DEFAULT NULL,
  `id_location` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `id_idx` (`id_location`),
  CONSTRAINT `id` FOREIGN KEY (`id_location`) REFERENCES `location` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `records`
--

LOCK TABLES `Records` WRITE;
/*!40000 ALTER TABLE `records` DISABLE KEYS */;
/*!40000 ALTER TABLE `records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stat_records`
--

DROP TABLE IF EXISTS `Stat_Records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stat_Records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `min_value` float DEFAULT NULL,
  `min_time` timestamp NULL DEFAULT NULL,
  `max_value` float DEFAULT NULL,
  `max_time` timestamp NULL DEFAULT NULL,
  `average_value` varchar(100) DEFAULT NULL,
  `min_1hdelta_value` float DEFAULT NULL,
  `min_1hdelta_time` timestamp NULL DEFAULT NULL,
  `max_1hdelta_value` float DEFAULT NULL,
  `max_1hdelta_time` timestamp NULL DEFAULT NULL,
  `min_3hdelta_value` float DEFAULT NULL,
  `min_3hdelta_time` timestamp NULL DEFAULT NULL,
  `max_3hdelta_value` float DEFAULT NULL,
  `max_3hdelta_time` timestamp NULL DEFAULT NULL,
  `message` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stat_records`
--

LOCK TABLES `Stat_Records` WRITE;
/*!40000 ALTER TABLE `stat_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `stat_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stat_reports`
--

DROP TABLE IF EXISTS `Stat_Reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stat_Reports` (
  `id` int(11) NOT NULL,
  `id_location` int(11) DEFAULT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `date_period` int(11) DEFAULT NULL,
  `sunrise` time DEFAULT NULL,
  `sunset` time DEFAULT NULL,
  `summary` varchar(120) DEFAULT NULL,
  `message` varchar(256) DEFAULT NULL,
  `id_day_type` int(11) DEFAULT NULL,
  `id_stat_temp` int(11) DEFAULT NULL,
  `id_stat_pressure` int(11) DEFAULT NULL,
  `id_stat_humidity` int(11) DEFAULT NULL,
  `id_stat_rain` int(11) DEFAULT NULL,
  `id_stat_snow` int(11) DEFAULT NULL,
  `id_stat_wind` int(11) DEFAULT NULL,
  `id_stat_clouds` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idstat_daily_UNIQUE` (`id`),
  KEY `id_stat_temp_idx` (`id_stat_temp`),
  KEY `id_stat_pressure_idx` (`id_stat_pressure`),
  KEY `id_stat_wind_idx` (`id_stat_wind`),
  KEY `id_stat_humidity_idx` (`id_stat_humidity`),
  KEY `id_stat_rain_idx` (`id_stat_rain`),
  KEY `id_stat_snow_idx` (`id_stat_snow`),
  KEY `id_location_idx` (`id_location`),
  KEY `id_stat_clouds_idx` (`id_stat_clouds`),
  CONSTRAINT `id_location` FOREIGN KEY (`id_location`) REFERENCES `location` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_stat_clouds` FOREIGN KEY (`id_stat_clouds`) REFERENCES `stat_records` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_stat_humidity` FOREIGN KEY (`id_stat_humidity`) REFERENCES `stat_records` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_stat_pressure` FOREIGN KEY (`id_stat_pressure`) REFERENCES `stat_records` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_stat_rain` FOREIGN KEY (`id_stat_rain`) REFERENCES `stat_records` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_stat_snow` FOREIGN KEY (`id_stat_snow`) REFERENCES `stat_records` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_stat_temp` FOREIGN KEY (`id_stat_temp`) REFERENCES `stat_records` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_stat_wind` FOREIGN KEY (`id_stat_wind`) REFERENCES `stat_records` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Daily statistics based on record of the day.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stat_reports`
--

LOCK TABLES `Stat_Reports` WRITE;
/*!40000 ALTER TABLE `stat_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `stat_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'WeatherDB'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-09 10:23:33
