/*
File: ridership_temperature_analysis.sql

This query performs an insightful analysis of ridership behavior
in relation to temperature variations during holidays. It 
leverages data from the 'combined_data' and 'weather_data' 
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
        WHEN temp < 50 THEN 'Less than 50°F'
        WHEN temp >= 50 AND temp < 60 THEN '50-59°F'
        WHEN temp >= 60 AND temp < 70 THEN '60-69°F'
        WHEN temp >= 70 AND temp < 80 THEN '70-79°F'
        ELSE '80°F and above'
    END AS temperature_range,
    COUNT(CASE WHEN member_casual = 'casual' THEN 1 END) AS casual_riders_count,
    COUNT(CASE WHEN member_casual = 'member' THEN 1 END) AS member_riders_count
FROM
    combined_data cd
LEFT JOIN holidays h ON cd.date_start = h.holiday_start_date
LEFT JOIN weather_data wd ON cd.date_start = wd.datetime::date
WHERE
    h.holiday_name IS NOT NULL
GROUP BY
    temperature_range
ORDER BY
    temperature_range;
