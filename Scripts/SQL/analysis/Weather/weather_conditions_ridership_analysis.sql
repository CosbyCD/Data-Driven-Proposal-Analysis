/*
File: weather_conditions_ridership_analysis.sql

This query analyzes the impact of specific weather conditions on ridership patterns.
It categorizes the data based on different weather conditions and calculates the count
of casual and member riders for each weather condition category.
The output provides insights into how different weather conditions influence rider behavior.
*/

SELECT
    conditions,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'casual' THEN 1 END), '999,999') AS casual_riders_count,
    TO_CHAR(COUNT(CASE WHEN member_casual = 'member' THEN 1 END), '999,999') AS member_riders_count
FROM (
    SELECT
        CASE
            WHEN wd.conditions IS NULL THEN 'Unknown'
            ELSE wd.conditions
        END AS conditions,
        member_casual
    FROM
        combined_data cd
    LEFT JOIN holidays h ON cd.date_start = h.holiday_start_date
    LEFT JOIN weather_data wd ON cd.date_start = wd.datetime::date
    WHERE
        h.holiday_name IS NOT NULL
) AS weather_conditions_data
GROUP BY
    conditions
ORDER BY
    conditions;
