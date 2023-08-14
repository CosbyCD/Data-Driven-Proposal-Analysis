/*
File: count_riders_per_month_yearly.sql

This SQL query employs the crosstab function to transform ride
count data from the combined_data table. The query calculates 
and categorizes the number of rides undertaken by both member 
and casual riders for each month of the year. The pivot table 
generated from this query offers a concise summary, allowing 
analysis of monthly ride patterns and a comparison of ride counts
between member and casual riders. This information can be 
valuable for understanding rider engagement trends and making
informed decisions related to resource allocation and service 
enhancements.
*/


SELECT *
FROM crosstab(
    'SELECT
        EXTRACT(MONTH FROM started_at) AS month_number,
        member_casual,
        COUNT(*) AS ride_count
    FROM
        combined_data
    GROUP BY
        month_number, member_casual
    ORDER BY
        month_number',
    'VALUES (''member''), (''casual'')'
) AS pivot_table(month_number int, member numeric, casual numeric);