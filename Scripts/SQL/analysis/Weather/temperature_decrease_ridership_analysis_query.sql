/*
File: temperature_decrease_ridership_analysis_query.sql

This SQL query combines weather data and ridership counts to 
analyze temperature shifts affecting casual and member ridership.
This analysis is using the 'feels like' temperatures instead of the 
actual recorded temperatures as the 'feels like' is what riders experience.
It calculates the counts of riders and their temperature 
preferences before and after temperature shifts where the decrease 
is greater than 10 degrees Fahrenheit. The query efficiently retrieves segmented 
ridership data and provides valuable insights into how 
temperature changes impact ridership patterns.
*/
WITH TemperatureShifts AS (
    SELECT
        wd.datetime AS shift_date,
        wd.feelslike AS shift_temp,
        LAG(wd.feelslike) OVER (ORDER BY wd.datetime) AS prev_temp,
        LAG(wd.datetime) OVER (ORDER BY wd.datetime) AS prev_date
    FROM weather_data wd
),
RidershipCounts AS (
    SELECT
        ts.shift_date,
        ts.shift_temp AS shifted_temperature,
        ts.prev_temp AS previous_temperature,
        rc_shift.casual_riders_count AS current_casual_riders_count,
        rc_prev.casual_riders_count AS previous_casual_riders_count,
        rc_shift.member_riders_count AS current_member_riders_count,
        rc_prev.member_riders_count AS previous_member_rider_count
    FROM TemperatureShifts ts
    LEFT JOIN (
        SELECT date_start,
               COUNT(CASE WHEN member_casual = 'casual' THEN 1 END) AS casual_riders_count,
               COUNT(CASE WHEN member_casual = 'member' THEN 1 END) AS member_riders_count
        FROM combined_data
        GROUP BY date_start
    ) rc_shift ON ts.shift_date = rc_shift.date_start
    LEFT JOIN (
        SELECT date_start,
               COUNT(CASE WHEN member_casual = 'casual' THEN 1 END) AS casual_riders_count,
               COUNT(CASE WHEN member_casual = 'member' THEN 1 END) AS member_riders_count
        FROM combined_data
        GROUP BY date_start
    ) rc_prev ON ts.prev_date = rc_prev.date_start
    WHERE ts.prev_temp - ts.shift_temp > 10
)
SELECT
    rc.shift_date,
    rc.shifted_temperature,
    rc.previous_temperature,
    rc.current_casual_riders_count,
    rc.previous_casual_riders_count,
    rc.current_member_riders_count,
    rc.previous_member_rider_count
FROM RidershipCounts rc
ORDER BY rc.shifted_temperature DESC;
