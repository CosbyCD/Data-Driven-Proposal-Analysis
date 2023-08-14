/*
File: weekday_peak_ride_analysis_yearly.sql

This SQL query offers a detailed exploration of ride length
trends for "Member" and "Casual" users throughout the year.
By analyzing the "combined_data" dataset, it identifies the 
day of the week with the highest ride activity and computes 
the average ride duration in minutes for each user type on 
that particular day. The results are accompanied by the 
respective weekday, enabling a precise comparison of ride 
behaviors between user categories. This inquiry into the 
annual peak ridership day enhances the understanding of 
user engagement patterns and provides valuable insights 
for strategic planning and optimizing the overall user 
experience.
*/

SELECT
    mfd.name_of_day,
    mfd.day_of_week,
    cd.user_type,
    ROUND(AVG(EXTRACT(EPOCH FROM (cd.ended_at - cd.started_at)) / 60)::numeric, 2) AS yearly_mean_ride_length_minutes
FROM (
    SELECT
        name_of_day,
        started_at,
        ended_at,
        CASE
            WHEN member_casual = 'member' THEN 'Member'
            WHEN member_casual = 'casual' THEN 'Casual'
        END AS user_type
    FROM
        combined_data
) AS cd
JOIN (
    SELECT
        name_of_day,
        EXTRACT(DOW FROM started_at) AS day_of_week
    FROM
        combined_data
    GROUP BY
        name_of_day, EXTRACT(DOW FROM started_at)
    ORDER BY
        COUNT(*) DESC
    LIMIT 1
) AS mfd ON EXTRACT(DOW FROM cd.started_at) = mfd.day_of_week
GROUP BY
    mfd.name_of_day, mfd.day_of_week, cd.user_type
ORDER BY
    mfd.day_of_week, cd.user_type;
