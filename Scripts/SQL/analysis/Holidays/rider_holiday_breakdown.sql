/*
File: rider_holiday_breakdown.sql

The provided query conducts an analysis of ridership behavior 
in relation to holidays. By employing the data from the 
"error_free_records" dataset and incorporating the "holidays" 
table through a left join, the query calculates the count 
of both casual and member riders for each holiday. The 
grouped results offer insights into the distribution of 
rider types during various holidays. The outcomes, ordered
by holiday name, facilitate a comprehensive view of how 
rider engagement varies across different holidays, aiding
in understanding the preferences and behaviors of riders 
during these occasions.
*/

SELECT
    hwm.holiday_name,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'casual' THEN 1 END), '9,999,999') AS casual_riders_count,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'member' THEN 1 END), '9,999,999') AS member_riders_count
FROM
    error_free_records ef
LEFT JOIN holidays_weather_merged hwm ON ef.date_start = hwm.holiday_start_date
WHERE
    hwm.holiday_name IS NOT NULL
GROUP BY
    hwm.holiday_name
ORDER BY
    hwm.holiday_name;
