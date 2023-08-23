/*
File: "total_records_by_season.sql"

Synopsis:
"total_records_by_season.sql" plays a crucial role in 
categorizing records within the "combined_data" table 
into distinct seasons based on the month extracted from 
the "started_at" date. By employing a CASE statement, 
the query attributes each record to a specific season: 
'Winter,' 'Spring,' 'Summer,' or 'Autumn.' Subsequently, 
the query calculates and presents the total number of
records for each season, arranged chronologically.

Query Objective:
The primary objective of this query is to deliver a 
comprehensive overview of record distribution across 
various seasons. By furnishing the total record count 
for each season, stakeholders can discern patterns and 
trends that occur over distinct timeframes within the year.

Methodology:
Utilizing the CASE statement, the query intelligently 
labels each record with a corresponding season based 
on its month. Months 12, 1, and 2 are designated as 
'Winter,' months 3, 4, and 5 as 'Spring,' months 6, 
7, and 8 as 'Summer,' and months 9, 10, and 11 as 
'Autumn.' The COUNT(*) function calculates the total 
number of records for each season, drawing data from 
the "combined_data" table. Meaningful grouping is 
achieved through the GROUP BY clause, utilizing the 
'season' column derived from the CASE statement. 
Results are presented in chronological order based 
on the minimum month value via the ORDER BY clause.

Practical Significance:

"TotalRecordsBySeason.sql" delivers insights by 
presenting data patterns and trends over different 
seasons throughout the year. This information empowers 
stakeholders with a structured understanding of how 
data varies across distinct temporal contexts. Such 
insights support informed decision-making and strategic 
assessments that consider seasonal influences.

Incorporating this query emphasizes the project's 
commitment to rigorous data analysis, facilitating 
nuanced insights and effective communication of 
findings. The straightforward output of this query 
enhances accessibility to valuable information, 
enabling stakeholders to discern cyclic patterns 
and influences impacting the dataset's seasonal 
distribution.
*/

SELECT
  CASE
    WHEN EXTRACT(MONTH FROM started_at) IN (12, 1, 2) THEN 'Winter'
    WHEN EXTRACT(MONTH FROM started_at) IN (3, 4, 5) THEN 'Spring'
    WHEN EXTRACT(MONTH FROM started_at) IN (6, 7, 8) THEN 'Summer'
    WHEN EXTRACT(MONTH FROM started_at) IN (9, 10, 11) THEN 'Autumn'
  END AS season,
  TO_CHAR(COUNT(*), '999,999,999') AS total_records_by_season
FROM
  combined_data
GROUP BY
  season
ORDER BY
  MIN(EXTRACT(MONTH FROM started_at));