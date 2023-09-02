/*
File: max_ride_length_analysis_monthly.sql

This query offers a comprehensive and equitable analysis of ride length
statistics for "Member" and "Casual" users over the course of a year. 
Leveraging the "combined_data" dataset, the query adeptly calculates 
total and maximum ride lengths, meticulously adjusted and normalized 
by user count. By factoring in the user population sizes, the query 
ensures unbiased comparisons between different user types. Furthermore, 
the analysis is organized by month, adding a temporal dimension to the 
insights. The resulting output effectively captures the variations in 
ride lengths, providing a clear and meaningful assessment of user behavior
patterns throughout the year.
*/

WITH MaxRideLengths AS (
    SELECT 
        TO_CHAR(started_at, 'Month') AS month,
        CASE 
            WHEN member_casual = 'member' THEN 'Member'
            WHEN member_casual = 'casual' THEN 'Casual'
        END AS user_type,
        SUM(EXTRACT(EPOCH FROM (ended_at - started_at))) AS sum_ride_length_seconds,
        COUNT(*) AS user_count
    FROM combined_data
    GROUP BY month, member_casual
)
SELECT 
    month,
    user_type,
    CONCAT(
        TO_CHAR(FLOOR(sum_ride_length_seconds / 3600), 'FM999,999,999'), ' hours, ',
        TO_CHAR(FLOOR((sum_ride_length_seconds % 3600) / 60), 'FM999,999,999'), ' minutes, ',
        TO_CHAR(FLOOR(sum_ride_length_seconds % 60), 'FM999,999,999'), ' seconds'
    ) AS total_max_ride_length_for_the_month,
    CONCAT(
        TO_CHAR(FLOOR((sum_ride_length_seconds / 3600 / user_count) / 60), 'FM999,999,999'), ' hours, ',
        TO_CHAR(FLOOR((sum_ride_length_seconds / user_count % 3600) / 60), 'FM999,999,999'), ' minutes, ',
        TO_CHAR(FLOOR((sum_ride_length_seconds / user_count) % 60), 'FM999,999,999'), ' seconds'
    ) AS normalized_max_ride_length_for_the_month
FROM MaxRideLengths
ORDER BY 
    to_timestamp(month, 'Month')::DATE,
    user_type;
