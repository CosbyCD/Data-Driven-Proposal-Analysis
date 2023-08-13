/*

File: "migration_validation_record_counts.sql"

Synopsis:
This query, labeled "migration_validation_record_counts.sql," 
serves a pragmatic purpose in the context of data migration to 
a new platform. It performs a straightforward analysis of data 
within the "combined_data" table, aiming to validate the accuracy 
and completeness of the migration process through a monthly 
record count aggregation.

Query Objective:

The query's objective is to determine the total count of records 
for each month, organized chronologically based on the "started_at" 
column. By generating this aggregation, the query facilitates an 
effective means of confirming that data migration to the new 
platform has transpired without errors or omissions.

Methodology:

Utilizing the TO_CHAR function, the query converts "started_at" 
dates into full month names, enabling clear month identification. 
The COUNT(*) function computes record totals, considering data 
from the "combined_data" table. Records are grouped by both full 
month names and numeric month values extracted from "started_at" 
using the date_part function. The query concludes by presenting 
the aggregated results in chronological order via the ORDER BY 
clause.

Importance:

"MonthlyRecordCountsValidation.sql" provides a utilitarian 
mechanism to verify the successful transition of data to the 
new platform. By presenting a concise summary of record counts 
over time, the query offers a pragmatic means of validating 
the data migration process, assuring stakeholders of data 
accuracy and completeness.

Inclusion of this query within the project underscores a 
commitment to meticulous data management and validation. 
The query's output aids stakeholders in confidently 
utilizing migrated data for informed decision-making, 
devoid of embellishment.
*/


SELECT
  TO_CHAR(started_at, 'Month') AS month,
  COUNT(*) AS total_records_by_month
FROM
  combined_data
GROUP BY
  TO_CHAR(started_at, 'Month'),
  date_part('month', started_at)
ORDER BY
  date_part('month', started_at);
