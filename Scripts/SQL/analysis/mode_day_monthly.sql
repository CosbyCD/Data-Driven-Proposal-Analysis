/*
File: mode_day_monthly.sql

This query analyzes ride data for "Member" and "Casual" users, 
presenting the mode (most frequent) day of the week, total ride 
count, and average ride length in minutes for each month of the 
year. The query enables a comprehensive evaluation of user behavior
based on day-to-day patterns, allowing for meaningful insights into 
user preferences and engagement trends. By segmenting data by user 
type and highlighting mode days, the analysis contributes to a 
well-informed understanding of ride utilization patterns, aiding 
in data-driven decision-making and strategic planning for 
ride-sharing services. The output provides a clear breakdown of 
mode days across user types, fostering a better grasp of user 
engagement dynamics on a monthly basis.
*/


WITH DayOfWeekCounts AS (
    SELECT
        TO_CHAR(started_at, 'Month') AS month,
        CASE 
            WHEN member_casual = 'member' THEN 'Member'
            WHEN member_casual = 'casual' THEN 'Casual'
        END AS user_type,
        EXTRACT(DOW FROM started_at) AS day_of_week,
        COUNT(*) AS ride_count,
        ROUND(AVG(EXTRACT(EPOCH FROM (ended_at - started_at)) / 60)::numeric, 2) AS avg_ride_length_minutes
    FROM combined_data
    GROUP BY month, user_type, EXTRACT(DOW FROM started_at)
),
RankedDays AS (
    SELECT
        month,
        user_type,
        day_of_week,
        ride_count,
        avg_ride_length_minutes,
        ROW_NUMBER() OVER (PARTITION BY month, user_type ORDER BY ride_count DESC) AS rank
    FROM DayOfWeekCounts
)
SELECT
    month,
    user_type,
    CASE
        WHEN day_of_week = 0 THEN 'Sunday'
        WHEN day_of_week = 1 THEN 'Monday'
        WHEN day_of_week = 2 THEN 'Tuesday'
        WHEN day_of_week = 3 THEN 'Wednesday'
        WHEN day_of_week = 4 THEN 'Thursday'
        WHEN day_of_week = 5 THEN 'Friday'
        WHEN day_of_week = 6 THEN 'Saturday'
    END AS mode_day_of_week,
    MAX(ride_count) AS max_count,
    avg_ride_length_minutes
FROM RankedDays
WHERE rank = 1
GROUP BY month, user_type, day_of_week, avg_ride_length_minutes
ORDER BY 
    to_timestamp(month, 'Month')::DATE,
    user_type;
