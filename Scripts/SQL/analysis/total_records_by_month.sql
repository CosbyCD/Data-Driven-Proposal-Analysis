/*
File: total_records_by_month

Although I had previously obtained the records categorized
by month during the 'phase_one_transformation' process, 
I opted to present this information here to ensure a 
seamless flow in the data analysis.
*/

SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  COUNT(*) AS total_records_by_month
FROM
  combined_data
GROUP BY
  EXTRACT(MONTH FROM started_at)
  ORDER BY
  EXTRACT(MONTH FROM started_at);