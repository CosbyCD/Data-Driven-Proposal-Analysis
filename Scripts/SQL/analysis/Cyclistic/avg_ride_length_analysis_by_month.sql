/*
File: avg_ride_length_analysis_by_month.sql

This SQL query analyzes ride length data based on user membership types,
broken down by month. It calculates average ride lengths for "member" and
"casual" users, highlighting potential differences. Additionally, the 
query computes the percentage difference between these averages, providing
insights into user behavior. The results offer valuable information for
optimizing bike-sharing services.
*/

SELECT
    TO_CHAR(started_at, 'Month') AS month,
    ROUND(
        AVG(CASE WHEN member_casual = 'member'
                 THEN EXTRACT(EPOCH FROM (ended_at - started_at)) / 60 END)::numeric, 2
    ) AS member_mean_ride_length_minutes,
    ROUND(
        AVG(CASE WHEN member_casual = 'casual'
                 THEN EXTRACT(EPOCH FROM (ended_at - started_at)) / 60 END)::numeric, 2
    ) AS casual_mean_ride_length_minutes,
    ROUND(
        (
            (
                AVG(CASE WHEN member_casual = 'casual'
                         THEN EXTRACT(EPOCH FROM (ended_at - started_at)) / 60 END)::numeric
            ) - (
                AVG(CASE WHEN member_casual = 'member'
                         THEN EXTRACT(EPOCH FROM (ended_at - started_at)) / 60 END)::numeric
            )
        ) / AVG(CASE WHEN member_casual = 'casual'
                   THEN EXTRACT(EPOCH FROM (ended_at - started_at)) / 60 END)::numeric * 100, 2
    ) AS percentage_difference
FROM
    error_free_records
GROUP BY
    month
ORDER BY
    ROUND(AVG(CASE WHEN member_casual = 'casual'
                 THEN EXTRACT(EPOCH FROM (ended_at - started_at)) / 60 END)::numeric, 2) DESC;
