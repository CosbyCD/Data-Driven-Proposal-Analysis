/*
File: ride_length_analysis_by_year

This query focuses on the average ride durations of "member"
and "casual" riders within a single-year timeframe. 
It calculates and presents the rounded mean ride lengths 
for each user category and the corresponding percentage 
difference. By examining ride patterns within this specific 
year, the analysis offers valuable insights into the typical
ride durations of different user types.
*/


SELECT
    year,
    ROUND(member_mean_ride_length_minutes, 2) AS rounded_member_mean_ride_length_minutes,
    ROUND(casual_mean_ride_length_minutes, 2) AS rounded_casual_mean_ride_length_minutes,
    ROUND(
        (
            (casual_mean_ride_length_minutes - member_mean_ride_length_minutes)
            / NULLIF(casual_mean_ride_length_minutes, 0)
        ) * 100,
        2
    ) AS percentage_difference
FROM (
    SELECT
        EXTRACT(YEAR FROM started_at) AS year,
        AVG(
            CASE WHEN member_casual = 'member'
                 THEN EXTRACT(EPOCH FROM (ended_at - started_at)) / 60 END
        )::numeric AS member_mean_ride_length_minutes,
        AVG(
            CASE WHEN member_casual = 'casual'
                 THEN EXTRACT(EPOCH FROM (ended_at - started_at)) / 60 END
        )::numeric AS casual_mean_ride_length_minutes
    FROM
        combined_data
    GROUP BY
        year
) AS subquery;

