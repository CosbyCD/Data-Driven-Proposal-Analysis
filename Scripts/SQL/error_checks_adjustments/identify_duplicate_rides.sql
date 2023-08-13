/*
File:
File Name: "identify_duplicate_rides.sql"

Description:
The query "identify_duplicate_rides.sql," facilitates 
an insightful analysis of the "combined_data" dataset 
to pinpoint occurrences of duplicate rides. By employing 
a meticulous grouping mechanism based on ride_id and 
started_at, the script effectively isolates instances 
where these identifiers recur, indicating potential 
duplicate ride entries within the dataset.

Objective:
The script's purpose is to assist in data quality 
assurance by highlighting rides that share identical 
ride IDs and start times. Through the application of 
the GROUP BY clause and the inclusion of a HAVING 
condition to identify counts greater than one, the 
script systematically extracts information about 
duplicate rides, ultimately contributing to the 
enhancement of data accuracy and integrity.

This script serves as an essential tool for refining 
the dataset, reinforcing the reliability of subsequent 
analyses, and fostering a robust foundation for 
evidence-based decision-making. Incorporating 
"identify_duplicate_rides.sql" underscores the 
commitment to meticulous data scrutiny and the 
promotion of data-driven insights within the 
project framework.

Results should be column headers with no records
*/


SELECT ride_id, started_at, COUNT(*) AS duplicate_count
FROM combined_data
GROUP BY ride_id, started_at
HAVING COUNT(*) > 1;