/*
File: total_records_by_month

This SQL query focuses on quantifying the monthly ride volume within 
the ride-sharing dataset. By extracting the month component from the 
"started_at" timestamp and grouping the data accordingly, the query 
calculates the total number of records (rides) for each month. The 
results provide a comprehensive overview of ride activity distribution
across the months.

The query's systematic approach facilitates the identification of 
patterns and trends in ride usage over time. By ordering the results 
in chronological order, the analysis highlights monthly fluctuations 
in ride volume, allowing for the detection of peak months and potential 
seasonality effects. This information serves as a foundational step for
further in-depth investigations into user engagement, operational 
planning, and targeted marketing strategies within the ride-sharing platform.
*/
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  TO_CHAR(COUNT(*), '999,999,999') AS total_records_by_month
FROM
  combined_data
GROUP BY
  EXTRACT(MONTH FROM started_at)
ORDER BY
  EXTRACT(MONTH FROM started_at);
