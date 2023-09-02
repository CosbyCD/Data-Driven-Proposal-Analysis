/*
FILE: outlier_ridelength_identification.sql

The following series of queries is used to identify those rides
where the ride length is negative, as well as those that are 
longer than a day.
*/

-- How many records with negative ride_length?
SELECT COUNT(*) AS total_records_with_negative_ride_length
FROM combined_data
WHERE ride_length < 0;

-- View the records
SELECT ride_length AS negative_ride_length, COUNT(ride_length) AS total
FROM combined_data
GROUP BY ride_length
HAVING ride_length < 0;

-- remove the records
DELETE FROM combined_data
WHERE ride_length < 0;



-- How many records with ridelengths over a day
SELECT ride_length AS over_a_day_ride_length, COUNT(ride_length) AS total
FROM combined_data
WHERE ride_length > 24
GROUP BY ride_length;

--view the records
SELECT *
FROM combined_data
WHERE ride_length > 24

-- remove the records
DELETE FROM combined_data
WHERE ride_length > 24;


