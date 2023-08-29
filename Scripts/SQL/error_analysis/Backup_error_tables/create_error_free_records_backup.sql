/*
File: create_error_free_records_backup.sql

To safeguard data integrity and provide a safety net for
potential changes, I will be generating a backup table.
This involves duplicating the structure and content 
to preserve its original state.

The process includes utilizing the "CREATE TABLE" command to
establish a new backup table, followed by the "SELECT * FROM"
statement to copy the data from the respective source table.
By executing these commands, I will create a backup table 
ensuring that the table is securely preserved for 
reference and restoration purposes.
*/


CREATE TABLE error_free_records_backup AS
SELECT * FROM error_free_records;