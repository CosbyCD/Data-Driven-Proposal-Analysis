/*
File: "count_records_with_nulls.sql"

This SQL query facilitates a comprehensive assessment of 
data quality issues within the "combined_data" dataset. 
It calculates the error percentage by identifying records 
with NULL values across specific columns and measuring 
their proportion relative to the entire dataset.

Query Details:
The query is structured around a Common Table Expression 
(CTE) named "total_null_counts," designed to count 
records with NULL values in targeted columns. By evaluating 
columns such as "ride_id," "rideable_type," "started_at," 
and others, the query identifies records with potential 
data quality anomalies.

To compute the error percentage, the CTE calculates the 
total number of records with errors. The main query then 
calculates the overall number of records in the dataset. 
By dividing the count of records with errors by the total 
count and expressing it as a percentage, the query 
quantifies the extent of data quality challenges.

Benefits and Implications:
This data quality analysis offers a pragmatic perspective 
on the impact of NULL values on dataset integrity. By 
quantifying the proportion of records affected by NULLs, 
data professionals gain insights into potential data gaps 
and anomalies. This, in turn, empowers informed decision-making 
to enhance data reliability and accuracy.
*/

-- Calculate the Percentage of Records with NULLs

-- This SQL query calculates the error percentage in the "combined_data" table by
-- determining the total number of records with errors and the overall total number
-- of records in the table. It achieves this by employing a Common Table Expression (CTE)
-- called "total_null_counts" to count records with NULL values in specific columns.

WITH total_null_counts AS (
    SELECT
        COUNT(*) AS total_records_with_errors
    FROM
        combined_data
    WHERE
        ride_id IS NULL OR
        rideable_type IS NULL OR
        started_at IS NULL OR
        ended_at IS NULL OR
        start_station_name IS NULL OR
        start_station_id IS NULL OR
        end_station_name IS NULL OR
        end_station_id IS NULL OR
        start_lat IS NULL OR
        start_lng IS NULL OR
        end_lat IS NULL OR
        end_lng IS NULL OR
        member_casual IS NULL OR
        ride_length IS NULL OR
        day_of_week IS NULL OR
        name_of_day IS NULL
)
SELECT
    TO_CHAR(total_records, '999,999,999') AS total_records,
    TO_CHAR(total_records_with_errors, '999,999,999') AS total_records_with_errors,
    TO_CHAR((total_records_with_errors::float / total_records * 100), '999.99') AS error_percentage
FROM
    (SELECT COUNT(*) AS total_records FROM combined_data) AS total_records,
    total_null_counts;
