/*
File: count_fields_with_nulls.sql

This query conducts a thorough investigation into the data 
integrity of the "combined_data" database by meticulously 
analyzing the presence of NULL values across its records. 
The analysis focuses on evaluating the percentage of 
errors within the dataset as a whole.

The query systematically evaluates each record, calculating
the total count of fields (columns), the count of fields 
with NULL values, and the corresponding percentage of NULLs
relative to the entire dataset. Precision is maintained 
through careful use of conditional expressions and accurate
mathematical computations.

The results are presented in a concise and structured format,
providing stakeholders with a clear overview of the data 
quality assessment. By executing this query, valuable insights
are gained into the extent of data completeness and the 
proportion of errors within the database.

This analysis facilitates informed decision-making, guides 
targeted data refinement strategies, and supports ongoing 
data quality monitoring. It underscores the commitment to 
maintaining a dependable and reliable dataset, crucial for 
effective analysis and decision support.
*/

SELECT
    TO_CHAR(COUNT(*) * 17, '999,999,999') AS total_fields,
    TO_CHAR(SUM(
        CASE WHEN ride_id IS NULL OR ride_id = '' OR ride_id = ' ' THEN 1 ELSE 0 END +
        CASE WHEN rideable_type IS NULL OR rideable_type = '' OR rideable_type = ' ' THEN 1 ELSE 0 END +
        CASE WHEN started_at IS NULL THEN 1 ELSE 0 END +
        CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END +
        CASE WHEN start_station_name IS NULL OR start_station_name = '' OR start_station_name = ' ' THEN 1 ELSE 0 END +
        CASE WHEN start_station_id IS NULL OR start_station_id = '' OR start_station_id = ' ' THEN 1 ELSE 0 END +
        CASE WHEN end_station_name IS NULL OR end_station_name = '' OR end_station_name = ' ' THEN 1 ELSE 0 END +
        CASE WHEN end_station_id IS NULL OR end_station_id = '' OR end_station_id = ' ' THEN 1 ELSE 0 END +
        CASE WHEN start_lat IS NULL THEN 1 ELSE 0 END +
        CASE WHEN start_lng IS NULL THEN 1 ELSE 0 END +
        CASE WHEN end_lat IS NULL THEN 1 ELSE 0 END +
        CASE WHEN end_lng IS NULL THEN 1 ELSE 0 END +
        CASE WHEN member_casual IS NULL OR member_casual = '' OR member_casual = ' ' THEN 1 ELSE 0 END +
        CASE WHEN ride_length IS NULL THEN 1 ELSE 0 END +
        CASE WHEN day_of_week IS NULL THEN 1 ELSE 0 END +
        CASE WHEN name_of_day IS NULL THEN 1 ELSE 0 END
    ), '999,999,999') AS total_nulls,
    TO_CHAR((SUM(
        CASE WHEN ride_id IS NULL OR ride_id = '' OR ride_id = ' ' THEN 1 ELSE 0 END +
        CASE WHEN rideable_type IS NULL OR rideable_type = '' OR rideable_type = ' ' THEN 1 ELSE 0 END +
        CASE WHEN started_at IS NULL THEN 1 ELSE 0 END +
        CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END +
        CASE WHEN start_station_name IS NULL OR start_station_name = '' OR start_station_name = ' ' THEN 1 ELSE 0 END +
        CASE WHEN start_station_id IS NULL OR start_station_id = '' OR start_station_id = ' ' THEN 1 ELSE 0 END +
        CASE WHEN end_station_name IS NULL OR end_station_name = '' OR end_station_name = ' ' THEN 1 ELSE 0 END +
        CASE WHEN end_station_id IS NULL OR end_station_id = '' OR end_station_id = ' ' THEN 1 ELSE 0 END +
        CASE WHEN start_lat IS NULL THEN 1 ELSE 0 END +
        CASE WHEN start_lng IS NULL THEN 1 ELSE 0 END +
        CASE WHEN end_lat IS NULL THEN 1 ELSE 0 END +
        CASE WHEN end_lng IS NULL THEN 1 ELSE 0 END +
        CASE WHEN member_casual IS NULL OR member_casual = '' OR member_casual = ' ' THEN 1 ELSE 0 END +
        CASE WHEN ride_length IS NULL THEN 1 ELSE 0 END +
        CASE WHEN day_of_week IS NULL THEN 1 ELSE 0 END +
        CASE WHEN name_of_day IS NULL THEN 1 ELSE 0 END
    )::float / (COUNT(*) * 17) * 100), '999.99') AS error_percentage
FROM
    combined_data;
