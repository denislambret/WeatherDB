CREATE DEFINER=`dev`@`%` PROCEDURE `Count_Duplicates_RecordsByHour`()
BEGIN
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
END