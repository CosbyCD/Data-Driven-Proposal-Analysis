/*
File: max_ride_length_analysis_yearly.sql

This SQL query analyzes ride length statistics for "Member" 
and "Casual" users over a year, presenting total and maximum 
ride lengths in hours, minutes, and seconds. The maximum ride 
length is adjusted by user count, ensuring fair comparisons 
between user types. "Normalized by the user count" equalizes 
differences in user population sizes, providing unbiased insights
into ride length behaviors. This query offers a comprehensive 
and equitable assessment of ride experiences for different user segments.
*/


WITH MaxRideLengths AS (
    SELECT 
        CASE 
            WHEN member_casual = 'member' THEN 'Member'
            WHEN member_casual = 'casual' THEN 'Casual'
        END AS user_type,
        SUM(EXTRACT(EPOCH FROM (ended_at - started_at))) AS sum_ride_length_seconds,
        COUNT(*) AS user_count
    FROM combined_data
    GROUP BY member_casual
)
SELECT 
    user_type,
    CONCAT(
        TO_CHAR(FLOOR(sum_ride_length_seconds / 3600), 'FM999,999,999'), ' hours, ',
        FLOOR((sum_ride_length_seconds % 3600) / 60), ' minutes, ',
        FLOOR(sum_ride_length_seconds % 60), ' seconds'
    ) AS total_max_ride_length_for_the_year,
    CONCAT(
        TO_CHAR(FLOOR((sum_ride_length_seconds / 3600 / user_count) / 60), 'FM999,999,999'), ' hours, ',
        FLOOR((sum_ride_length_seconds / user_count % 3600) / 60), ' minutes, ',
        FLOOR((sum_ride_length_seconds / user_count) % 60), ' seconds'
    ) AS max_ride_length_for_the_year
FROM MaxRideLengths;
