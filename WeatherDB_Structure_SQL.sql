-- Partial structure
CREATE DATABASE `WeatherDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `WeatherDB`;
CREATE TABLE `Locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(120) DEFAULT NULL,
  `timezone` varchar(45) DEFAULT NULL,
  `altitude` varchar(45) DEFAULT NULL,
  `longitude` varchar(45) DEFAULT NULL,
  `latitude` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_timestamp` datetime DEFAULT NULL,
  `temp` decimal(5,2) DEFAULT NULL,
  `feels_like` decimal(5,2) DEFAULT NULL,
  `pressure` decimal(6,2) DEFAULT NULL,
  `humidity` decimal(5,2) DEFAULT NULL,
  `wind_speed` decimal(5,2) DEFAULT NULL,
  `wind_dir` int DEFAULT NULL,
  `clouds_cover` int DEFAULT NULL,
  `rain_1h` decimal(5,2) DEFAULT NULL,
  `snow_1h` decimal(5,2) DEFAULT NULL,
  `id_location` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COMMENT='WeatherDB -  Raw weather records';

