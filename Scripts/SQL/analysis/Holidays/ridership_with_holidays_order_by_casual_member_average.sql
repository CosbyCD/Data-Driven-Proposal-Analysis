/*
File: ridership_with_holidays_order_by_casual_member_average.sql

This query provides insights into ride patterns and preferences for
"Member" and "Casual" users, allowing a comprehensive understanding
of user behavior throughout the year. By leveraging data from the 
"combined_data" dataset and optional holiday information, the query
calculates counts and average counts of rides for both user types. 
User population sizes are considered, ensuring fair comparisons 
between segments. The analysis is organized by date, day of the 
year, day name, and potential holiday name, and ordered by average
casual riders in decending order.
*/

SELECT
    date_start AS date,
    combined_data.day_of_year,
    combined_data.name_of_day,
    COALESCE(h.holiday_name, '') AS holiday_name,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'casual' THEN 1 END), '999,999,999') AS casual_riders_count,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'member' THEN 1 END), '999,999,999') AS member_riders_count,
    ROUND(AVG(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END), 2) AS average_casual_riders,
    ROUND(AVG(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END), 2) AS average_member_riders
FROM
    combined_data
LEFT JOIN holidays h ON combined_data.date_start = h.holiday_start_date
GROUP BY
    date_start, combined_data.day_of_year, combined_data.name_of_day, h.holiday_name
ORDER BY
    average_casual_riders DESC;
