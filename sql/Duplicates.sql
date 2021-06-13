SELECT 
	id, 
    date_timestamp,
    id_location, 
    ROW_NUMBER() OVER ( 
		PARTITION BY date_timestamp 
        ORDER BY date_timestamp
	) AS row_num 
FROM Records;

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
FROM Records) td
WHERE row_num > 1;

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
FROM Records) td
WHERE row_num > 1;

SET SQL_SAFE_UPDATES=0;
DELETE FROM Records 
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
		FROM Records) td
		WHERE row_num > 1
    )
);