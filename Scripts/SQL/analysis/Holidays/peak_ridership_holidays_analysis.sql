/*
File: peak_ridership_holidays_analysis.sql

The provided query analyzes peak ridership during holidays by 
calculating the total ridership (combined casual and member 
riders) for each holiday. It excludes rows with NULL holiday 
names, ensuring only valid holiday data is considered. The 
results offer insights into which holidays attract the highest
overall ridership, aiding in understanding the popularity of 
specific holidays among riders.
*/

SELECT
    hwm.holiday_name,
    TO_CHAR(COUNT(CASE WHEN ef.member_casual = 'casual' THEN 1 END) + COUNT(CASE WHEN ef.member_casual = 'member' THEN 1 END), '999,999') AS total_ridership
FROM
    error_free_records ef
LEFT JOIN holidays_weather_merged hwm ON ef.date_start = hwm.holiday_start_date
WHERE
    hwm.holiday_name IS NOT NULL
GROUP BY
    hwm.holiday_name
ORDER BY
    total_ridership DESC;
