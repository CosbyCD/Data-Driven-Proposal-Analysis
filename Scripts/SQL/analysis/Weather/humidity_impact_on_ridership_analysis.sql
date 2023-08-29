/*
File: humidity_impact_on_ridership_analysis.sql

This query investigates the relationship between humidity
levels and ridership preferences. By grouping ridership 
counts based on humidity ranges, it offers insights into 
how humidity might impact the preferences of casual and 
member riders. The analysis helps to identify any potential
correlations between humidity levels and ridership behavior. 
*/

SELECT
    humidity_range,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'casual' THEN 1 END), '999,999') AS casual_riders_count,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'member' THEN 1 END), '999,999') AS member_riders_count
FROM (
    SELECT
        CASE
            WHEN hwm.humidity < 30 THEN 'Less than 30%'
            WHEN hwm.humidity >= 30 AND hwm.humidity < 50 THEN '30-49%'
            WHEN hwm.humidity >= 50 AND hwm.humidity < 70 THEN '50-69%'
            WHEN hwm.humidity >= 70 THEN '70% and above'
        END AS humidity_range,
        ef.member_casual
    FROM
        holidays_weather_merged hwm
    LEFT JOIN error_free_records ef ON hwm.date_w = ef.date_start
    WHERE
        hwm.holiday_name IS NOT NULL
) AS humidity_data
GROUP BY
    humidity_range
ORDER BY
    humidity_range;
