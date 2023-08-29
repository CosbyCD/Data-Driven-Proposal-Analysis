/*
File: rider_behavior_holiday_non-holiday_comparison.sql

The query analyzes rider behavior by calculating the average
counts of casual and member riders on both holidays and 
non-holidays. It achieves this by categorizing each day based
on the presence of a holiday and then computing the respective
averages. The results provide insights into how rider patterns
differ between these two day types.
*/

SELECT
    CASE WHEN h.holiday_name IS NOT NULL THEN 'Holiday' ELSE 'Non-Holiday' END AS day_type,
    ROUND(AVG(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END), 4) AS avg_casual_riders,
    ROUND(AVG(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END), 4) AS avg_member_riders
FROM
    error_free_records ef
LEFT JOIN holidays h ON ef.date_start = h.holiday_start_date
GROUP BY
    day_type
ORDER BY
    day_type;
