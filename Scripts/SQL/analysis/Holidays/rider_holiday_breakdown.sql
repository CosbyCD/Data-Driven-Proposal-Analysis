/*
File: rider_holiday_breakdown.sql

The provided query conducts an analysis of ridership behavior 
in relation to holidays. By employing the data from the 
"combined_data" dataset and incorporating the "holidays" 
table through a left join, the query calculates the count 
of both casual and member riders for each holiday. The 
grouped results offer insights into the distribution of 
rider types during various holidays. The outcomes, ordered
by holiday name, facilitate a comprehensive view of how 
rider engagement varies across different holidays, aiding
in understanding the preferences and behaviors of riders 
during these occasions.
*/

SELECT
    h.holiday_name,
    COUNT(CASE WHEN member_casual = 'casual' THEN 1 END) AS casual_riders_count,
    COUNT(CASE WHEN member_casual = 'member' THEN 1 END) AS member_riders_count
FROM
    combined_data cd
LEFT JOIN holidays h ON cd.date_start = h.holiday_start_date
WHERE
    h.holiday_name IS NOT NULL
GROUP BY
    h.holiday_name
ORDER BY
    h.holiday_name;
