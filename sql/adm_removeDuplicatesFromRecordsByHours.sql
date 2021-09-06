# Count duplicates in table RecordsByHours
#------------------------------------------------------------------------------------
SELECT COUNT(id) AS totalDuplicates
FROM (
SELECT 
	id, 
    timeStamp,
    idLocation, 
    ROW_NUMBER() OVER ( 
		PARTITION BY timeStamp 
        ORDER BY timeStamp
	) AS row_num 
FROM RecordsByHours) td
WHERE row_num > 1;

# Delete duplicates in table RecordsByHours
#------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES=0;
DELETE FROM RecordsByDay 
WHERE (
	id IN (
    SELECT id
	FROM (
		SELECT 
			id, 
			timeStamp,
			idLocation, 
			ROW_NUMBER() OVER ( 
				PARTITION BY timeStamp 
				ORDER BY timeStamp
			) AS row_num 
		FROM RecordsByHours) td
		WHERE row_num > 1
    )
);