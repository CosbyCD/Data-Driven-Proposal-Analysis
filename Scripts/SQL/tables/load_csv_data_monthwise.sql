/*
File: load_csv_data_monthwise.sql

Description:
This code snippet orchestrates a dynamic data transfer 
process, facilitating the ingestion of information from 
CSV files into respective database tables. The procedure 
iterates through each month of the year and efficiently 
populates the designated "cyclistic_data_" tables with 
data extracted from corresponding CSV files.

Procedure:

The procedure commences by traversing the months, from 
January (1) to December (12), extracting data for each 
specific month. Within the loop, the procedure constructs 
the target table name and CSV file path dynamically based 
on the current month number. Utilizing the "EXECUTE" 
command, the code executes a formatted SQL query to 
efficiently copy data from the CSV file into the 
designated table. The "COPY" operation is adeptly 
customized with the table name, CSV file path, and 
relevant formatting specifications.

Key Elements:

month_num: Integer variable representing the current 
month's numerical value.
table_name: Text variable that holds the name of the 
target table, formed using the month number.
csv_path: Text variable containing the file path of 
the CSV file for the current month.
Objective:

This script is an essential component of the data 
transformation process. By dynamically copying data 
from corresponding CSV files into distinct tables 
for each month, the code streamlines the organization 
and storage of cycling trip data. This systematic 
approach facilitates subsequent data analysis and 
exploration, contributing to the comprehensive 
evaluation of ridership patterns and trends.
*/

-- Loop through the months and copy data from CSV files
DO $$ 
DECLARE
    month_num INTEGER;
    table_name TEXT;
    csv_path TEXT;
BEGIN
    FOR month_num IN 1..12 LOOP
        table_name := 'cyclistic_data_' || month_num;
        csv_path := 'D:/phase_one_transform/2022' || LPAD(month_num::TEXT, 2, '0') || '-divvy-tripdata.csv';
        
        EXECUTE format('
            COPY %I FROM %L DELIMITER %L CSV HEADER;',
            table_name, csv_path, ',');
    END LOOP;
END $$;