/*
File: extreme_weather_impact_on_ridership_analysis.sql

This query delves into the impact of extreme weather conditions 
on ridership behavior by examining patterns during exceptionally 
hot, cold, or stormy days. By categorizing data based on temperature
and precipitation, the query calculates the average percentage of 
casual and member riders for each extreme weather type. 
*/

SELECT
    extreme_weather_type,
    TO_CHAR(AVG(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) * 100, '999.99') || '%' AS avg_casual_riders_percentage,
    TO_CHAR(AVG(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) * 100, '999.99') || '%' AS avg_member_riders_percentage
FROM (
    SELECT
        CASE
            WHEN wd.temp >= 80 THEN 'Hot'
            WHEN wd.temp < 50 THEN 'Cold'
            WHEN wd.precip > 0 THEN 'Stormy'
            ELSE 'Normal'
        END AS extreme_weather_type,
        member_casual
    FROM
        error_free_records ef
    LEFT JOIN holidays h ON ef.date_start = h.holiday_start_date
    LEFT JOIN weather_data wd ON ef.date_start = wd.datetime::date
    WHERE
        h.holiday_name IS NOT NULL
) AS extreme_weather_data
GROUP BY
    extreme_weather_type
ORDER BY
    avg_casual_riders_percentage DESC;
