/*
File: combine_monthly_data.sql

Description:

The "combine_monthly_data.sql" script plays a pivotal role 
in consolidating cycling trip data for a comprehensive 
analysis. By utilizing the UNION ALL operation, the script 
seamlessly merges individual monthly datasets from 
"cyclistic_data_1" to "cyclistic_data_12" tables into a 
single entity named "combined_data." This efficient 
process ensures a unified repository containing diverse 
attributes such as ride details, timestamps, geographical 
coordinates, and rider types. The resulting dataset 
serves as a foundation for in-depth ridership pattern 
analyses and insights into Chicago's cycling trends 
throughout the year.

Objective:

The script underscores my adeptness in data integration 
and structured database operations. Its execution 
showcases my capability to seamlessly merge disparate 
datasets, fostering a coherent data environment for 
future analysis. By unifying data from different months, 
the script facilitates advanced exploration, enabling 
the extraction of meaningful patterns and correlations 
to inform data-driven decisions.

Incorporating the "Combine_Monthly_Data.sql" script into 
the project narrative highlights my practical skills in 
database management and reinforces my commitment to 
delivering streamlined, efficient, and insightful data 
solutions.
*/

CREATE TABLE combined_data AS
SELECT * FROM cyclistic_data_1
UNION ALL SELECT * FROM cyclistic_data_2
UNION ALL SELECT * FROM cyclistic_data_3
UNION ALL SELECT * FROM cyclistic_data_4
UNION ALL SELECT * FROM cyclistic_data_5
UNION ALL SELECT * FROM cyclistic_data_6
UNION ALL SELECT * FROM cyclistic_data_7
UNION ALL SELECT * FROM cyclistic_data_8
UNION ALL SELECT * FROM cyclistic_data_9
UNION ALL SELECT * FROM cyclistic_data_10
UNION ALL SELECT * FROM cyclistic_data_11
UNION ALL SELECT * FROM cyclistic_data_12;
