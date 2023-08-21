/*
File: alter_align_temporal_granularity_between_datasets.sql

These alteration queries are needed because the 'combined_data'
and 'weather_data' tables both have timestamp columns, but 
their temporal granularity differs. To address this, a new 
column named 'date_start' will be added to the 'combined_data'
table. This column will reference the 'started_at' column and
extract the date portion from the timestamp. The extracted 
date will be stored in 'YYYY-MM-DD' format in the 'date_start'
column, aligning the temporal granularity between the two tables.
*/

/* RUN THESE INDIVIDUALLY - ADD THE COLUMN FIRST, THEN UPDATE THE DATA */


-- Add the 'date_start' column to the 'combined_data' table
ALTER TABLE combined_data
ADD COLUMN date_start DATE;

-- Update the 'date_start' column with extracted date from 'started_at'
UPDATE combined_data
SET date_start = DATE(started_at);