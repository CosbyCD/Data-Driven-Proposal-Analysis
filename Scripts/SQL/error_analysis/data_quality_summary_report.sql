/*
File: data_quality_summary_report.sql

This SQL query generates a comprehensive summary report 
for the "combined_data" table, focusing on data quality 
assessment. The query calculates the count of NULL and 
empty values for each column, along with the total record 
count, and presents the results in a structured format. 
By utilizing conditional expressions and filters, the 
query provides valuable insights into the presence of 
missing or inconsistent data across multiple columns. 
The report aids in identifying potential data quality 
issues, enabling effective data cleansing and enhancement 
efforts.
*/

WITH total_counts AS (
  SELECT COUNT(*) AS total_records FROM combined_data
)
SELECT column_name, null_count
FROM (
  SELECT 'total_records' AS column_name, TO_CHAR(total_records, '999,999,999') AS null_count, 0 AS sort_order FROM total_counts
  UNION ALL
  SELECT 'ride_id', TO_CHAR(COUNT(*) FILTER (WHERE ride_id IS NULL OR ride_id = '' OR ride_id = ' '), '999,999,999') AS null_count, 1 FROM combined_data
  UNION ALL
  SELECT 'rideable_type', TO_CHAR(COUNT(*) FILTER (WHERE rideable_type IS NULL OR rideable_type = '' OR rideable_type = ' '), '999,999,999') AS null_count, 2 FROM combined_data
  UNION ALL
  SELECT 'started_at', TO_CHAR(COUNT(*) FILTER (WHERE started_at IS NULL), '999,999,999') AS null_count, 3 FROM combined_data
  UNION ALL
  SELECT 'ended_at', TO_CHAR(COUNT(*) FILTER (WHERE ended_at IS NULL), '999,999,999') AS null_count, 4 FROM combined_data
  UNION ALL
  SELECT 'start_station_name', TO_CHAR(COUNT(*) FILTER (WHERE start_station_name IS NULL OR start_station_name = '' OR start_station_name = ' '), '999,999,999') AS null_count, 5 FROM combined_data
  UNION ALL
  SELECT 'start_station_id', TO_CHAR(COUNT(*) FILTER (WHERE start_station_id IS NULL OR start_station_id = '' OR start_station_id = ' '), '999,999,999') AS null_count, 6 FROM combined_data
  UNION ALL
  SELECT 'end_station_name', TO_CHAR(COUNT(*) FILTER (WHERE end_station_name IS NULL OR end_station_name = '' OR end_station_name = ' '), '999,999,999') AS null_count, 7 FROM combined_data
  UNION ALL
  SELECT 'end_station_id', TO_CHAR(COUNT(*) FILTER (WHERE end_station_id IS NULL OR end_station_id = '' OR end_station_id = ' '), '999,999,999') AS null_count, 8 FROM combined_data
  UNION ALL
  SELECT 'start_lat', TO_CHAR(COUNT(*) FILTER (WHERE start_lat IS NULL), '999,999,999') AS null_count, 9 FROM combined_data
  UNION ALL
  SELECT 'start_lng', TO_CHAR(COUNT(*) FILTER (WHERE start_lng IS NULL), '999,999,999') AS null_count, 10 FROM combined_data
  UNION ALL
  SELECT 'end_lat', TO_CHAR(COUNT(*) FILTER (WHERE end_lat IS NULL), '999,999,999') AS null_count, 11 FROM combined_data
  UNION ALL
  SELECT 'end_lng', TO_CHAR(COUNT(*) FILTER (WHERE end_lng IS NULL), '999,999,999') AS null_count, 12 FROM combined_data
  UNION ALL
  SELECT 'member_casual', TO_CHAR(COUNT(*) FILTER (WHERE member_casual IS NULL OR member_casual = '' OR member_casual = ' '), '999,999,999') AS null_count, 13 FROM combined_data
  UNION ALL
  SELECT 'ride_length', TO_CHAR(COUNT(*) FILTER (WHERE ride_length IS NULL), '999,999,999') AS null_count, 14 FROM combined_data
  UNION ALL
  SELECT 'day_of_week', TO_CHAR(COUNT(*) FILTER (WHERE day_of_week IS NULL), '999,999,999') AS null_count, 15 FROM combined_data
  UNION ALL
  SELECT 'name_of_day', TO_CHAR(COUNT(*) FILTER (WHERE name_of_day IS NULL), '999,999,999') AS null_count, 16 FROM combined_data
  UNION ALL
  SELECT 'day_of_year', TO_CHAR(COUNT(*) FILTER (WHERE day_of_year IS NULL), '999,999,999') AS null_count, 17 FROM combined_data
) AS results
ORDER BY sort_order, column_name;
