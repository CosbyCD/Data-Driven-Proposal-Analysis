/*
File: mode_day_seasonal.sql

This query performs a comprehensive analysis of ride data based on 
the seasons, providing insights into user behavior and preferences. By 
categorizing rides into Spring, Summer, Autumn, and Winter, and further 
segmenting by user type (Member or Casual), the query calculates the 
average ride length for each day of the week within each season and 
user type. The results highlight the mode day of the week for each 
season and user type combination, shedding light on patterns and 
preferences. The output is presented in a clear and organized manner,
allowing for easy identification of trends and variations in ride 
behaviors across different seasons and user types. This analysis 
contributes to a deeper understanding of user engagement and usage 
patterns, aiding decision-making for targeted marketing efforts 
and service improvements.
*/


WITH seasonal_mode AS (
SELECT
        CASE
            WHEN EXTRACT(MONTH FROM started_at) BETWEEN 3 AND 5 THEN 'Spring'
            WHEN EXTRACT(MONTH FROM started_at) BETWEEN 6 AND 8 THEN 'Summer'
            WHEN EXTRACT(MONTH FROM started_at) BETWEEN 9 AND 11 THEN 'Autumn'
            ELSE 'Winter'
        END AS season,
        name_of_day,
        CASE 
            WHEN member_casual = 'member' THEN 'Member'
            WHEN member_casual = 'casual' THEN 'Casual'
        END AS user_type,
        ROUND(AVG(EXTRACT(EPOCH FROM (ended_at - started_at)) / 60)::numeric, 2)
		AS seasonal_mean_ride_length_minutes,
        RANK() OVER (PARTITION BY CASE
                                    WHEN EXTRACT(MONTH FROM started_at) BETWEEN 3 AND 5 THEN 'Spring'
                                    WHEN EXTRACT(MONTH FROM started_at) BETWEEN 6 AND 8 THEN 'Summer'
                                    WHEN EXTRACT(MONTH FROM started_at) BETWEEN 9 AND 11 THEN 'Autumn'
                                    ELSE 'Winter'
                                END, 
                                CASE 
                                    WHEN member_casual = 'member' THEN 'Member'
                                    WHEN member_casual = 'casual' THEN 'Casual'
                                END
                     ORDER BY COUNT(*) DESC) AS rank
    FROM
        combined_data
    GROUP BY
        season, name_of_day, user_type
)
SELECT
    season,
    name_of_day,
    user_type,
    seasonal_mean_ride_length_minutes
FROM
    seasonal_mode
WHERE
    rank = 1
ORDER BY
    CASE
        WHEN season = 'Spring' THEN 1
        WHEN season = 'Summer' THEN 2
        WHEN season = 'Autumn' THEN 3
        WHEN season = 'Winter' THEN 4
    END,
    user_type;
