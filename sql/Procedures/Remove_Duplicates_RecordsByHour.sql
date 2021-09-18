CREATE DEFINER=`dev`@`%` PROCEDURE `Remove_Duplicates_RecordsByHour`()
BEGIN
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
END