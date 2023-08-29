/*
File: ridership_temperature_analysis.sql

This query performs an insightful analysis of ridership behavior
in relation to temperature variations during holidays. It 
leverages data from the 'error_free_records' and 'weather_data' 
tables to categorize temperatures into ranges, such as "Less
than 50°F," "50-59°F," and so on. The results reveal the 
distribution of casual and member riders across these 
temperature intervals, providing valuable insights into how 
temperature influences rider engagement. The query is designed 
to assist in understanding the riders' preferences and behavior 
under different weather conditions, aiding in data-driven 
decision-making for optimizing ridership strategies.
*/
SELECT
    CASE
        WHEN hwm.temp < 50 THEN 'Less than 50°F'
        WHEN hwm.temp >= 50 AND hwm.temp < 60 THEN '50-59°F'
        WHEN hwm.temp >= 60 AND hwm.temp < 70 THEN '60-69°F'
        WHEN hwm.temp >= 70 AND hwm.temp < 80 THEN '70-79°F'
        ELSE '80°F and above'
    END AS temperature_range,
    TO_CHAR(COUNT(CASE WHEN ef.member_casual = 'casual' THEN 1 END), '9,999,999') AS casual_riders_count,
    TO_CHAR(COUNT(CASE WHEN ef.member_casual = 'member' THEN 1 END), '9,999,999') AS member_riders_count
FROM
    holidays_weather_merged hwm
LEFT JOIN error_free_records ef ON hwm.date_w = ef.date_start
WHERE
    hwm.holiday_name IS NOT NULL
GROUP BY
    temperature_range
ORDER BY
    temperature_range;
