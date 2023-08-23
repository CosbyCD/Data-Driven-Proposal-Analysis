/*
File: weather_impact_on_ridership_analysis.sql

The provided query analyzes the impact of temperature and 
precipitation on ridership patterns by categorizing the data
into temperature ranges and precipitation statuses. The query
calculates the count of casual and member riders for each 
combination of temperature range, precipitation status, 
and precipitation type. The output offers insights into 
how different weather conditions influence ridership, 
considering factors such as temperature and the presence 
of precipitation, including rain, snow, and ice. The results
allow for a comprehensive understanding of how these weather
variables affect rider behavior.
*/

SELECT
    temperature_range,
    precipitation_status,
    CASE
        WHEN precipitation_type IS NULL THEN ''
        WHEN precipitation_type LIKE '%rain%' AND precipitation_type LIKE '%snow%' THEN 'Rain and Snow'
        WHEN precipitation_type LIKE '%rain%' THEN 'Rain'
        WHEN precipitation_type LIKE '%snow%' THEN 'Snow'
        WHEN precipitation_type LIKE '%ice%' THEN 'Ice'
        ELSE 'Other Precipitation'
    END AS precipitation_type,
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
        CASE
            WHEN wd.precip IS NULL THEN NULL
            WHEN wd.precip > 0 THEN COALESCE(wd.preciptype, 'Other')
        END AS precipitation_type,
        member_casual
    FROM
        combined_data cd
    LEFT JOIN holidays h ON cd.date_start = h.holiday_start_date
    LEFT JOIN weather_data wd ON cd.date_start = wd.datetime::date
    WHERE
        h.holiday_name IS NOT NULL
) AS temp_precip_data
GROUP BY
    temperature_range, precipitation_status, precipitation_type
ORDER BY
    temperature_range, precipitation_status, precipitation_type;
