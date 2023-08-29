/*
File: negative_ride_length.sql

This query calculates the count of records within a designated
table where a specified column holds negative numerical values.
The resulting count provides insight into the quantity of 
records containing negative numbers within the dataset. */


SELECT COUNT(ride_length) AS negative_ride_length
FROM combined_data
WHERE ride_length < 0;