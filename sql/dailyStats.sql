-- Daily stats query template
SELECT id FROM WeatherDB.records WHERE (temp = (SELECT MIN(temp) FROM WeatherDB.records WHERE (id_location = 36 AND (date_timestamp BETWEEN "2020-04-19 00:00:00" AND "2020-04-19 23:59:59")))) LIMIT 0,1;
SELECT id FROM WeatherDB.records WHERE (temp = (SELECT MAX(temp) FROM WeatherDB.records WHERE (id_location = 36 AND (date_timestamp BETWEEN "2020-04-19 00:00:00" AND "2020-04-19 23:59:59")))) LIMIT 0,1;
SELECT id FROM WeatherDB.records WHERE (pressure = (SELECT MIN(pressure) FROM WeatherDB.records WHERE (id_location = 36 AND (date_timestamp BETWEEN "2020-04-19 00:00:00" AND "2020-04-19 23:59:59")))) LIMIT 0,1;
SELECT id FROM WeatherDB.records WHERE (pressure = (SELECT MAX(pressure) FROM WeatherDB.records WHERE (id_location = 36 AND (date_timestamp BETWEEN "2020-04-19 00:00:00" AND "2020-04-19 23:59:59")))) LIMIT 0,1;
SELECT id FROM WeatherDB.records WHERE (humidity = (SELECT MIN(humidity) FROM WeatherDB.records WHERE(id_location = 36 AND (date_timestamp BETWEEN "2020-04-19 00:00:00" AND "2020-04-19 23:59:59")))) LIMIT 0,1;
SELECT id FROM WeatherDB.records WHERE (humidity = (SELECT MAX(humidity) FROM WeatherDB.records WHERE (id_location = 36 AND (date_timestamp BETWEEN "2020-04-19 00:00:00" AND "2020-04-19 23:59:59")))) LIMIT 0,1;
SELECT id FROM WeatherDB.records WHERE (wind_speed = (SELECT MIN(wind_speed) FROM WeatherDB.records WHERE (id_location = 36 AND (date_timestamp BETWEEN "2020-04-19 00:00:00" AND "2020-04-19 23:59:59")))) LIMIT 0,1;
SELECT id FROM WeatherDB.records WHERE (wind_speed = (SELECT MAX(wind_speed) FROM WeatherDB.records WHERE (id_location = 36 AND (date_timestamp BETWEEN "2020-04-19 00:00:00" AND "2020-04-19 23:59:59")))) LIMIT 0,1;
