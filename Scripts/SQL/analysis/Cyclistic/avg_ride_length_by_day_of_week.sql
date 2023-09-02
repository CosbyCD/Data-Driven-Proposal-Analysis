/*
File: avg_ride_length_by_day_of_week.sql

This query performs an insightful analysis of ride-sharing data, 
specifically focusing on the average ride lengths for different 
user categories (i.e., "Member" and "Casual") across different 
days of the week. The query employs a crosstab approach to 
present the results in a structured pivot table format.

The analysis begins by categorizing ride data into "Member" and 
"Casual" categories and extracting the day of the week from the 
timestamp of each ride. It then calculates the average ride length
for each combination of user category and day of the week, rounding 
the results to four decimal places. The data is grouped and ordered
to ensure meaningful presentation.

The resulting pivot table offers a comprehensive overview of how
ride lengths vary based on user category and day of the week. 
This analysis provides valuable insights into user behavior 
patterns and preferences, which can inform strategic decisions aimed 
at optimizing ride-sharing services. For instance, the presented data
could aid in tailoring marketing campaigns, service offerings, and 
resource allocation to enhance user satisfaction and engagement 
across different user segments and days of the week.
*/


SELECT *
FROM crosstab(
    'SELECT
        CASE WHEN member_casual = ''member'' THEN ''Member'' ELSE ''Casual'' END AS category,
        EXTRACT(DOW FROM started_at) AS day_of_week,
        ROUND(AVG(CAST(ride_length AS numeric)), 4) AS average_ride_length
    FROM
        combined_data
    GROUP BY
        1, 2
    ORDER BY
        1, 2',
    'VALUES (0), (1), (2), (3), (4), (5), (6)'
) AS pivot_table(category text, "Sunday" numeric, "Monday" numeric, "Tuesday" numeric,
				 "Wednesday" numeric, "Thursday" numeric, "Friday" numeric, "Saturday" numeric);
