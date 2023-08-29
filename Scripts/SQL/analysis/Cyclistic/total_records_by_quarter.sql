/*
File: "total_records_by_quarter.sql"

This query calculates the total count of records per 
quarter from the "error_free_records" table. By extracting
the quarter number (1, 2, 3, or 4) from the "started_at"
date and organizing the results in ascending order, the 
query delivers a concise overview of data distribution 
across quarterly timeframes.
*/

SELECT
  TO_CHAR(EXTRACT(QUARTER FROM started_at), '9') AS quarter,
  TO_CHAR(COUNT(*), '9,999,999') AS total_records_by_quarter
FROM
  error_free_records
GROUP BY
  EXTRACT(QUARTER FROM started_at)
ORDER BY
  EXTRACT(QUARTER FROM started_at);
