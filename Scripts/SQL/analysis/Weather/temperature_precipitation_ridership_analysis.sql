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
            WHEN temp < 50 THEN 'Less than 50°F'
            WHEN temp >= 50 AND temp < 60 THEN '50-59°F'
            WHEN temp >= 60 AND temp < 70 THEN '60-69°F'
            WHEN temp >= 70 AND temp < 80 THEN '70-79°F'
            ELSE '80°F and above'
        END AS temperature_range,
        CASE
            WHEN wd.precip > 0 THEN 'Precipitation'
            ELSE 'No Precipitation'
        END AS precipitation_status,
        member_casual
    FROM
        error_free_records ef
    LEFT JOIN holidays h ON ef.date_start = h.holiday_start_date
    LEFT JOIN weather_data wd ON ef.date_start = wd.datetime::date
    WHERE
        h.holiday_name IS NOT NULL
) AS temp_precip_data
GROUP BY
    temperature_range, precipitation_status
ORDER BY
    temperature_range, precipitation_status;
