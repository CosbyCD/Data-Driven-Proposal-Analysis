/*
File: max_ride_length_analysis_seasonal.sql

This SQL query offers a comprehensive analysis of ride length
statistics for "Member" and "Casual" users, segregated by 
distinct seasons throughout the year. By categorizing rides
into Spring, Summer, Autumn, and Winter, the query presents
total and maximum ride lengths in hours, minutes, and seconds.
The values are normalized by user counts, ensuring equitable 
comparisons and eliminating bias from varying user populations. 
This approach provides impartial insights into ride length 
behaviors, enabling a nuanced understanding of user segments
and their interactions with the platform. The query's output
provides a holistic evaluation of ride experiences across 
seasons, contributing to a comprehensive overview of user
engagement patterns.
*/

WITH MaxRideLengths AS (
    SELECT 
        CASE 
            WHEN member_casual = 'member' THEN 'Member'
            WHEN member_casual = 'casual' THEN 'Casual'
        END AS user_type,
        CASE
            WHEN EXTRACT(MONTH FROM started_at) BETWEEN 3 AND 5 THEN 'Spring'
            WHEN EXTRACT(MONTH FROM started_at) BETWEEN 6 AND 8 THEN 'Summer'
            WHEN EXTRACT(MONTH FROM started_at) BETWEEN 9 AND 11 THEN 'Autumn'
            ELSE 'Winter'
        END AS season,
        SUM(EXTRACT(EPOCH FROM (ended_at - started_at))) AS sum_ride_length_seconds,
        COUNT(*) AS user_count
    FROM combined_data
    GROUP BY user_type, season
)
SELECT 
    season,
    user_type,
    CONCAT(
        TO_CHAR(FLOOR(sum_ride_length_seconds / 3600), 'FM999,999,999'), ' hours, ',
        TO_CHAR(FLOOR((sum_ride_length_seconds % 3600) / 60), 'FM999,999,999'), ' minutes, ',
        TO_CHAR(FLOOR(sum_ride_length_seconds % 60), 'FM999,999,999'), ' seconds'
    ) AS total_max_ride_length_for_the_season,
    CONCAT(
        TO_CHAR(FLOOR((sum_ride_length_seconds / 3600 / user_count) / 60), 'FM999,999,999'), ' hours, ',
        TO_CHAR(FLOOR((sum_ride_length_seconds / user_count % 3600) / 60), 'FM999,999,999'), ' minutes, ',
        TO_CHAR(FLOOR((sum_ride_length_seconds / user_count) % 60), 'FM999,999,999'), ' seconds'
    ) AS normalized_max_ride_length_for_the_season
FROM MaxRideLengths
ORDER BY
    CASE 
        WHEN season = 'Spring' THEN 1
        WHEN season = 'Summer' THEN 2
        WHEN season = 'Autumn' THEN 3
        ELSE 4
    END,
    user_type;