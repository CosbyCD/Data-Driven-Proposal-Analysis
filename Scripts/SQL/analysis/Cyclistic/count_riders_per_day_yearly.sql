/*
File: count_riders_per_day_yearly.sql

The provided SQL query generates a concise and insightful summary of 
yearly ride data trends based on the day of the week. It presents the 
distribution of total ride counts between "Member" and "Casual" users, highlighting 
the percentage difference in ride counts for each day. The analysis aims to 
reveal patterns in user engagement and preferences throughout the week.
*/

SELECT
    TO_CHAR(started_at, 'Day') AS day_of_week,
    REPLACE(TO_CHAR(SUM(CASE WHEN member_casual = 'member' 
						THEN 1 ELSE 0 END), '999,999'), ',', ',') AS member_ride_count,
    REPLACE(TO_CHAR(SUM(CASE WHEN member_casual = 'casual' 
						THEN 1 ELSE 0 END), '999,999'), ',', ',') AS casual_ride_count,
    REPLACE(TO_CHAR(ROUND(((SUM(CASE WHEN member_casual = 'member' 
								THEN 1 ELSE 0 END) - SUM(CASE WHEN member_casual = 'casual' 
								THEN 1 ELSE 0 END))::numeric / SUM(CASE WHEN member_casual = 'member' 
								THEN 1 ELSE 0 END)) * 100, 2), '999,999.99'), ',', ',') AS percent_difference
FROM
    error_free_records
GROUP BY
    TO_CHAR(started_at, 'Day')
ORDER BY
    EXTRACT(DOW FROM MIN(started_at));