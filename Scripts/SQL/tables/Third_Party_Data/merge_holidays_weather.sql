/*
File merge_holidays_weather.sql

The "holidays_weather_merged" table combines information from 
the "holidays" and "weather_data" tables in to one cohesive 
table, to simplify workflow and optimizes the ability to 
draw meaningful conclusions from the data.
*/


-- Create a new table to store the query results
CREATE TABLE holidays_weather_merged AS
SELECT *
FROM holidays
FULL OUTER JOIN (
    SELECT *,
           CAST(datetime AS DATE) AS date_w
    FROM weather_data
) AS weather_date_only
ON holidays.holiday_start_date = weather_date_only.date_w;