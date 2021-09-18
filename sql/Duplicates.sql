#----------------------------------------------------------------------------------
# Table : RawRecords
# List all occurences of every records
#----------------------------------------------------------------------------------
SELECT 
	 id, 
    date_timestamp,
    id_location, 
    ROW_NUMBER() OVER ( 
		PARTITION BY date_timestamp 
        ORDER BY date_timestamp
	) AS row_num 
FROM RawRecords;

# List duplicates
#----------------------------------------------------------------------------------
SELECT id,id_location, date_timestamp,row_num
FROM (
SELECT 
	id, 
    date_timestamp,
    id_location, 
    ROW_NUMBER() OVER ( 
		PARTITION BY date_timestamp 
        ORDER BY date_timestamp
	) AS row_num 
FROM RawRecords) td
WHERE row_num > 1;

# Count all duplicates found in table 
#----------------------------------------------------------------------------------
SELECT COUNT(id) AS totalDuplicates
FROM (
SELECT 
	id, 
    date_timestamp,
    id_location, 
    ROW_NUMBER() OVER ( 
		PARTITION BY date_timestamp 
        ORDER BY date_timestamp
	) AS row_num 
FROM RawRecords) td
WHERE row_num > 1;

# Delete all duplicates found in table
#----------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES=0;
DELETE FROM RawRecords 
WHERE (
	id IN (
    SELECT id
	FROM (
		SELECT 
			id, 
			date_timestamp,
			id_location, 
			ROW_NUMBER() OVER ( 
				PARTITION BY date_timestamp 
				ORDER BY date_timestamp
			) AS row_num 
		FROM RawRecords) td
		WHERE row_num > 1
    )
);

#----------------------------------------------------------------------------------
# Table : RecordsByDay
# List all occurences of every records
#----------------------------------------------------------------------------------
SELECT 
	 id, 
    timestamp,
    idLocation, 
    ROW_NUMBER() OVER ( 
		PARTITION BY timestamp 
        ORDER BY timestamp
	) AS row_num 
FROM RecordsByDay;

# List duplicates
#----------------------------------------------------------------------------------
SELECT id,idLocation, timestamp,row_num
FROM (
SELECT 
	 id, 
    timestamp,
    idLocation, 
    ROW_NUMBER() OVER ( 
		PARTITION BY timestamp 
        ORDER BY timestamp
	) AS row_num 
FROM RecordsByDay) td
WHERE row_num > 1;

# Count all duplicates found in table 
#----------------------------------------------------------------------------------
SELECT COUNT(id) AS totalDuplicates
FROM (
SELECT 
	id, 
    timestamp,
    idLocation, 
    ROW_NUMBER() OVER ( 
		PARTITION BY timestamp 
        ORDER BY timestamp
	) AS row_num 
FROM RecordsByDay) td
WHERE row_num > 1;

# Delete all duplicates found in table
#----------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES=0;
DELETE FROM RecordsByDay 
WHERE (
	id IN (
    SELECT id
	FROM (
		SELECT 
			id, 
			timestamp,
			idLocation, 
			ROW_NUMBER() OVER ( 
				PARTITION BY timestamp 
				ORDER BY timestamp
			) AS row_num 
		FROM RecordsByDay) td
		WHERE row_num > 1
    )
);

#----------------------------------------------------------------------------------
# Table : RecordsByHour
# List all occurences of every records
#----------------------------------------------------------------------------------
SELECT 
	 id, 
    timestamp,
    idLocation, 
    ROW_NUMBER() OVER ( 
		PARTITION BY timestamp 
        ORDER BY timestamp
	) AS row_num 
FROM RecordsByHour;

# List duplicates
#----------------------------------------------------------------------------------
SELECT id,idLocation, timestamp,row_num
FROM (
SELECT 
	 id, 
    timestamp,
    idLocation, 
    ROW_NUMBER() OVER ( 
		PARTITION BY timestamp 
        ORDER BY timestamp
	) AS row_num 
FROM RecordsByHour) td
WHERE row_num > 1;

# Count all duplicates found in table 
#----------------------------------------------------------------------------------
SELECT COUNT(id) AS totalDuplicates
FROM (
SELECT 
	id, 
    timestamp,
    idLocation, 
    ROW_NUMBER() OVER ( 
		PARTITION BY timestamp 
        ORDER BY timestamp
	) AS row_num 
FROM RecordsByHour) td
WHERE row_num > 1;

# Delete all duplicates found in table RecordsByHour
#----------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES=0;
DELETE FROM RecordsByHour 
WHERE (
	id IN (
    SELECT id
	FROM (
		SELECT 
			id, 
			timestamp,
			idLocation, 
			ROW_NUMBER() OVER ( 
				PARTITION BY timestamp 
				ORDER BY timestamp
			) AS row_num 
		FROM RecordsByHour) td
		WHERE row_num > 1
    )
);

#----------------------------------------------------------------------------------
# Table : RecordsByMonth
# List all occurences of every records
#----------------------------------------------------------------------------------
SELECT 
	 id, 
    timestamp,
    idLocation, 
    ROW_NUMBER() OVER ( 
		PARTITION BY timestamp 
        ORDER BY timestamp
	) AS row_num 
FROM RecordsByMonth;

# List duplicates
#----------------------------------------------------------------------------------
SELECT id,idLocation, timestamp,row_num
FROM (
SELECT 
	 id, 
    timestamp,
    idLocation, 
    ROW_NUMBER() OVER ( 
		PARTITION BY timestamp 
        ORDER BY timestamp
	) AS row_num 
FROM RecordsByMonth) td
WHERE row_num > 1;

# Count all duplicates found in table 
#----------------------------------------------------------------------------------
SELECT COUNT(id) AS totalDuplicates
FROM (
SELECT 
	id, 
    timestamp,
    idLocation, 
    ROW_NUMBER() OVER ( 
		PARTITION BY timestamp 
        ORDER BY timestamp
	) AS row_num 
FROM RecordsByMonth) td
WHERE row_num > 1;

# Delete all duplicates found in table
#----------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES=0;
DELETE FROM RecordsByMonth 
WHERE (
	id IN (
    SELECT id
	FROM (
		SELECT 
			id, 
			timestamp,
			idLocation, 
			ROW_NUMBER() OVER ( 
				PARTITION BY timestamp 
				ORDER BY timestamp
			) AS row_num 
		FROM RecordsByMonth) td
		WHERE row_num > 1
    )
);