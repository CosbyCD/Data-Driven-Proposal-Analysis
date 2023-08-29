/*
File: member_casual_user_stats_year.sql

"This  query conducts an analysis of bike-sharing data
from the 'error_free_records' table, specifically focusing on 
the total counts of members and casual riders for the year,
along with the percentage difference between these counts.
The query employs conditional aggregation techniques to 
achieve accurate calculations and utilizes rounding for 
result clarity. The analysis provides insights into rider 
distribution and trends for the specified year."
*/

SELECT
    EXTRACT(YEAR FROM started_at) AS year,
    TO_CHAR(SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END), '999,999,999') AS member_count,
    TO_CHAR(SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END), '999,999,999') AS casual_count,
    ROUND(
        (
            (
                SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) - 
                SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END)
            )::numeric /
            SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END)
        ) * 100,
        2
    ) AS percentage_difference
FROM error_free_records
GROUP BY EXTRACT(YEAR FROM started_at)
ORDER BY year;
