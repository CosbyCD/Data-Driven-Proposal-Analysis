/*
File: temperature_precipitation_ridership_analysis.sql

The provided SQL query analyzes ridership behavior based on 
temperature and precipitation conditions during holidays. It
categorizes temperature ranges and precipitation status, 
calculating the count of casual and member riders for each
combination. The query aims to uncover patterns in ridership
preferences across various weather conditions.
*/

SELECT
    temperature_range,
    precipitation_status,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'casual' THEN 1 END), '999,999') AS casual_riders_count,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'member' THEN 1 END), '999,999') AS member_riders_count
FROM (
    SELECT
        CASE
            WHEN hwm.temp < 50 THEN 'Less than 50°F'
            WHEN hwm.temp >= 50 AND hwm.temp < 60 THEN '50-59°F'
            WHEN hwm.temp >= 60 AND hwm.temp < 70 THEN '60-69°F'
            WHEN hwm.temp >= 70 AND hwm.temp < 80 THEN '70-79°F'
            ELSE '80°F and above'
        END AS temperature_range,
        CASE
            WHEN hwm.precip > 0 THEN 'Precipitation'
            ELSE 'No Precipitation'
        END AS precipitation_status,
        cd.member_casual
    FROM
        combined_data cd
    LEFT JOIN holidays_weather_merged hwm ON cd.date_start = hwm.date_w
    WHERE
        hwm.holiday_name IS NOT NULL
) AS temp_precip_data
GROUP BY
    temperature_range, precipitation_status
ORDER BY
    temperature_range, precipitation_status;
