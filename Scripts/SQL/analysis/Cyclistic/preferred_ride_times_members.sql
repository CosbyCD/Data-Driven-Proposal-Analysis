/*
File: preferred_ride_times_members.sql

The provided query analyzes the usage trends of members in a
bike-sharing program according to the time of day they start
their rides. The query categorizes the ride times into various
periods and calculates the count of rides within each period. 
The results are presented in descending order of ride counts, 
offering insights into the most popular ride times among members. 
*/

SELECT CASE
           WHEN EXTRACT(HOUR FROM started_at) = 0 THEN '12am'
           WHEN EXTRACT(HOUR FROM started_at) = 12 THEN '12pm'
           WHEN EXTRACT(HOUR FROM started_at) < 12 THEN TO_CHAR(started_at, 'HHam')
           ELSE TO_CHAR(started_at, 'HHpm')
       END AS member_ride_times,
       TO_CHAR(COUNT(*), '9,999,999') AS member_ride_counts
FROM combined_data
WHERE member_casual = 'member'
GROUP BY member_ride_times
ORDER BY member_ride_counts DESC;

