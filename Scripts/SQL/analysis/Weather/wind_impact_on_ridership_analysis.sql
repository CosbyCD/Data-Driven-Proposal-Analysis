/*
File: wind_impact_on_ridership_analysis.sql

This query examines the relationship between wind speed and ridership behavior
by categorizing wind speed into ranges. It calculates the count of casual and
 member riders for each wind speed range. The output provides insights into how
different wind speed levels influence ridership engagement.
*/

SELECT
    wind_speed_range,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'casual' THEN 1 END), '999,999') AS casual_riders_count,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'member' THEN 1 END), '999,999') AS member_riders_count
FROM (
    SELECT
        CASE
            WHEN windspeed < 5 THEN '0-4 mph'
            WHEN windspeed >= 5 AND windspeed < 10 THEN '5-9 mph'
            WHEN windspeed >= 10 AND windspeed < 15 THEN '10-14 mph'
            WHEN windspeed >= 15 AND windspeed < 20 THEN '15-19 mph'
            ELSE '20 mph and above'
        END AS wind_speed_range,
        cd.member_casual
    FROM
        combined_data cd
    LEFT JOIN holidays_weather_merged hwm ON cd.date_start = hwm.date_w
    WHERE
        hwm.holiday_name IS NOT NULL
) AS wind_data
GROUP BY
    wind_speed_range
ORDER BY
    CASE
        WHEN wind_speed_range = '5-9 mph' THEN 1
        WHEN wind_speed_range = '10-14 mph' THEN 2
        WHEN wind_speed_range = '15-19 mph' THEN 3
        WHEN wind_speed_range = '20 mph and above' THEN 4
        ELSE 5
    END;
