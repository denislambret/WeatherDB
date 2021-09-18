# Remove duplicates on all tables
#-------------------------------------------------------------------------------------
call Remove_Duplicates_RawRecords;
call Remove_Duplicates_RecordsByHour;
call Remove_Duplicates_RecordsByDay;
call Remove_Duplicates_RecordsByMonth;