/*
File: count_riders_per_week_yearly.sql

This SQL query employs the crosstab function to transform ride
count data from the combined_data table. The query calculates 
and categorizes the number of rides undertaken by both member 
and casual riders for each week of the year. The pivot table 
generated from this query offers a concise summary, allowing 
analysis of weekly ride patterns and a comparison of ride counts
between member and casual riders. This information can be 
valuable for understanding rider engagement trends and making
informed decisions related to resource allocation and service 
enhancements.
*/


SELECT *
FROM crosstab(
    'SELECT
        EXTRACT(WEEK FROM started_at) AS week_number,
        member_casual,
        TO_CHAR(COUNT(*), ''9,999,999'') AS ride_count
    FROM
        combined_data
    GROUP BY
        week_number, member_casual
    ORDER BY
        week_number',
    'VALUES (''member''), (''casual'')'
) AS pivot_table(week_number int, member text, casual text);
