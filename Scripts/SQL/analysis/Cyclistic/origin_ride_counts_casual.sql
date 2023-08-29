/*
File: origin_ride_counts_casual.sql

The provided SQL query calculates origin ride counts by start
station, categorizing them into member and casual riders. It
uses conditional aggregation to tally the number of rides for
each category separately. The query groups the results by 
start_station_name and orders them in descending order based
on the count of casual rides.
*/

SELECT
    start_station_name,
    TO_CHAR(SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END), '9,999,999') AS member_ride_count,
    TO_CHAR(SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END), '9,999,999') AS casual_ride_count
FROM error_free_records
GROUP BY start_station_name
ORDER BY casual_ride_count DESC;
