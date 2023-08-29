/*
File: origin_ride_counts_by_start_station_all.sql

This query will give you a list of start stations along with 
the corresponding count of rides that originated from each 
station. The list will be ordered in descending order of ride counts.
*/

SELECT start_station_name, TO_CHAR(COUNT(start_station_name), '9,999,999') AS origin_ride_count
FROM error_free_records
GROUP BY start_station_name
ORDER BY origin_ride_count DESC;
