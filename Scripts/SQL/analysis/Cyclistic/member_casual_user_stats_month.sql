/*
File: member_casual_user_stats_month.sql

This SQL query calculates and presents a breakdown of member 
and casual user counts, along with the percentage difference,
for each month of the year. Utilizing data from the "error_free_records" 
table, the query summarizes the counts of members and casual 
users and computes the percentage difference between these two 
groups. The results are presented in a formatted and organized 
manner, allowing for easy comparison and analysis of user patterns
over the months.
*/

WITH counts AS (
    SELECT
        EXTRACT(MONTH FROM started_at) AS month,
        COUNT(*) FILTER (WHERE member_casual = 'member') AS member_count,
        COUNT(*) FILTER (WHERE member_casual = 'casual') AS casual_count
    FROM
        error_free_records
    GROUP BY
        EXTRACT(MONTH FROM started_at)
)
SELECT
    TO_CHAR(TO_DATE(EXTRACT(YEAR FROM CURRENT_DATE) || '-' || month || '-01', 'YYYY-MM-DD'), 'Month') AS months,
    TO_CHAR(member_count, 'FM999,999,999') AS membership_count,
    TO_CHAR(casual_count, 'FM999,999,999') AS casual_use_count,
    ROUND(
        ((member_count - casual_count)::numeric / NULLIF(member_count, 0)) * 100,
        2
    ) AS percentage_difference
FROM
    counts
ORDER BY
    EXTRACT(MONTH FROM TO_DATE(month::text, 'MM'));
