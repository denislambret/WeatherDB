CREATE PROCEDURE `Count_Duplicates_RawRecords` ()
BEGIN
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
END
