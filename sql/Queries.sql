# Count total records stored in table Records
SELECT COUNT(*) as nbRecords
FROM Records;

# Count records by locations
SELECT Locations.name as name, COUNT(*) as nbRecords
FROM Records
INNER JOIN Locations ON Records.id_location = Locations.id
GROUP BY id_location;

# Get average per locations
select 
	id_location, 
    Locations.name,
	ROUND(AVG(pressure),2) AS avgPress,
	ROUND(AVG(temp - 271.15),2) AS avgTemp,
	ROUND(AVG(humidity),2) AS avgHumidity
FROM Records
Inner join Locations on id_location = Locations.id
group by id_location;

# Get min per locations
select 
	id_location, 
    Locations.name,
	ROUND(MIN(pressure),2) AS MINPress,
	ROUND(MIN(temp - 271.15),2) AS MINTemp,
	ROUND(MIN(humidity),2) AS MINHumidity
FROM Records
Inner join Locations on id_location = Locations.id
group by id_location;

# Get max per locations
SELECT 
    id_location,
    Locations.name,
    ROUND(MAX(pressure), 2) AS MAXPress,
    ROUND(MAX(temp - 271.15), 2) AS MAXTemp,
    ROUND(MAX(humidity), 2) AS MAXHumidity
FROM
    Records
        INNER JOIN
    Locations ON id_location = Locations.id
GROUP BY id_location;

SELECT *
FROM Records
WHERE length(hashmsg) <= 1;

set sql_safe_updates=0;
UPDATE Records SET hashmsg=NULL WHERE length(hashmsg) <= 1;

SELECT MD5(date_timestamp) FROM Records WHERE hashmsg IS NULL;
UPDATE Records SET hashmsg=MD5(date_timestamp) WHERE hashmsg IS NULL; 

EXPLAIN SELECT * 
FROM Records 
WHERE hashmsg = "83b3e1ef78781a28f43a73af0c72a7d3";

