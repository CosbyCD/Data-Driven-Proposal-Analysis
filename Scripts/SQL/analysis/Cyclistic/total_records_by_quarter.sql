/*
File: "total_records_by_quarter.sql"

The SQL query, labeled "total_records_by_quarter.sql," 
serves a practical analytical purpose by calculating and 
presenting the total count of records per quarter from the 
"combined_data" table. By extracting the quarter number 
(1, 2, 3, or 4) from the "started_at" date and organizing 
the results in ascending order, the query delivers a 
concise overview of data distribution across quarterly timeframes.

Query Objective:
The primary aim of the query is to provide a clear and 
organized view of record counts for each quarter. By 
displaying the quarterly record count, stakeholders can 
gain insights into data patterns, enabling them to make 
informed decisions and strategic assessments based on 
quarterly intervals.

Methodology:
Utilizing the EXTRACT function, the query accurately 
isolates the quarter from the "started_at" date, 
effectively segmenting data for analysis. Employing the 
COUNT(*) function, it performs a straightforward 
calculation of record totals for each quarter. The 
query sources data from the "combined_data" table 
and employs a logical grouping based on the extracted 
quarter. The output is sensibly sorted in ascending 
order by quarter number.

Practical Significance:
The "TotalRecordsByQuarter.sql" query offers actionable 
insights by presenting an organized perspective of data 
behavior throughout distinct quarters. This information 
aids stakeholders in recognizing trends, patterns, and 
potential seasonality within the dataset. The query's 
output supports well-informed decision-making and 
strategic planning.

Inclusion of this query reflects a commitment to analytical 
rigor, fostering data-driven exploration and facilitating 
effective communication of results. The query's 
straightforward output encourages easy interpretation, 
empowering stakeholders to extract valuable insights 
from the dataset's quarterly dimensions. */

SELECT
  EXTRACT(QUARTER FROM started_at) AS quarter,
  COUNT(*) AS total_records_by_quarter
FROM
  combined_data
GROUP BY
  EXTRACT(QUARTER FROM started_at)
  ORDER BY
  EXTRACT(QUARTER FROM started_at);