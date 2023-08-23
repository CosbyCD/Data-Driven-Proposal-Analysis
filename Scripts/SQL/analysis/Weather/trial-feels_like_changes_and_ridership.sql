/*
File: feels_like_changes_and_ridership.sql

This query analyzes ridership fluctuations during days with 
significant weather changes. It categorizes days based on 
temperature drops greater than 10°F, temperature rises greater
than 10°F, or no significant change in temperature. The query
calculates the count of casual and member riders for each 
weather change category, providing insights into how abrupt 
weather shifts influence rider behavior.
*/

SELECT
    CASE
        WHEN temp_diff = 'Temperature Rise > 10°F' THEN 'Temperature Rise > 10°F'
        WHEN temp_diff = 'Temperature Drop > 10°F' THEN 'Temperature Drop > 10°F'
        ELSE 'No Significant Change'
    END AS weather_change_category,
    TO_CHAR(SUM(CASE WHEN member_casual = 'casual' THEN casual_riders_count ELSE 0 END), '999,999,999') AS casual_riders_count,
    TO_CHAR(SUM(CASE WHEN member_casual = 'member' THEN member_riders_count ELSE 0 END), '999,999,999') AS member_riders_count
FROM (
    SELECT
        cd.date_start,
        wd.feelslike,
        cd.member_casual,
        COUNT(CASE WHEN cd.member_casual = 'casual' THEN 1 END) AS casual_riders_count,
        COUNT(CASE WHEN cd.member_casual = 'member' THEN 1 END) AS member_riders_count,
        CASE
            WHEN wd.feelslike::integer > 10 THEN 'Temperature Rise > 10°F'
            WHEN wd.feelslike::integer < -10 THEN 'Temperature Drop > 10°F'
            ELSE 'No Significant Change'
        END AS temp_diff
    FROM
        combined_data cd
    JOIN
        weather_data wd ON cd.date_start = wd.datetime
    WHERE
        cd.date_start BETWEEN '2022-01-01' AND '2022-12-31'
    GROUP BY
        cd.date_start, wd.feelslike, cd.member_casual
) AS temp_diff_data
GROUP BY
    temp_diff
ORDER BY
    CASE
        WHEN temp_diff = 'No Significant Change' THEN 1
        WHEN temp_diff = 'Temperature Drop > 10°F' THEN 2
        WHEN temp_diff = 'Temperature Rise > 10°F' THEN 3
    END;
