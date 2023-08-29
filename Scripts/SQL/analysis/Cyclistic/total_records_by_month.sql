/*
File: total_records_by_month

This query focuses on calculating the monthly rides within 
the ride-sharing dataset.
*/
SELECT
  EXTRACT(MONTH FROM started_at) AS month,
  TO_CHAR(COUNT(*), '999,999,999') AS total_records_by_month
FROM
  error_free_records
GROUP BY
  EXTRACT(MONTH FROM started_at)
ORDER BY
  EXTRACT(MONTH FROM started_at);
