 /*
File: member_casual_user_stats_season.sql

This query organizes ride data into four distinct seasons—Winter, 
Spring, Summer, and Autumn—for the year 2022. It calculates and 
presents the counts of member and casual users, along with the 
percentage difference between them, shedding light on user 
preferences and behaviors across different seasons.
*/

WITH seasonal_counts AS (
    SELECT
        CASE
            WHEN EXTRACT(MONTH FROM started_at) IN (12, 1, 2) THEN 'Winter'
            WHEN EXTRACT(MONTH FROM started_at) IN (3, 4, 5) THEN 'Spring'
            WHEN EXTRACT(MONTH FROM started_at) IN (6, 7, 8) THEN 'Summer'
            WHEN EXTRACT(MONTH FROM started_at) IN (9, 10, 11) THEN 'Autumn'
            ELSE 'Unknown'
        END AS season,
        COUNT(*) FILTER (WHERE member_casual = 'member') AS member_count,
        COUNT(*) FILTER (WHERE member_casual = 'casual') AS casual_count
    FROM
        error_free_records
    WHERE
        EXTRACT(YEAR FROM started_at) = 2022
    GROUP BY
        season
)
SELECT
    season,
    TO_CHAR(member_count, '9,999,999') AS membership,
    TO_CHAR(casual_count, '9,999,999') AS casual,
    ROUND(((member_count - casual_count)::numeric / NULLIF(member_count, 0)) * 100, 2) AS percentage_difference
FROM
    seasonal_counts
ORDER BY
    casual DESC;