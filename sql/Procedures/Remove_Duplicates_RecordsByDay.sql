CREATE DEFINER=`dev`@`%` PROCEDURE `Remove_Duplicates_RecordsByDay`()
BEGIN
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
END