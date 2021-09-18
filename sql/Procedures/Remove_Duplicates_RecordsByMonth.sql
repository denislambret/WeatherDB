CREATE PROCEDURE `Remove_Duplicates_RecordsByMonth` ()
BEGIN
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
END
