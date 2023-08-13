/*
File: data_enhancement_doy.sql

Enhancing Data Understanding and Analysis with 'Day of Year'
As the project advanced through the stages of table creation, 
data loading, and migration validation, a thorough evaluation 
of the resulting dataset revealed avenues for data refinement. 
Notably, an opportunity emerged to amplify the dataset's 
temporal context.

Recognizing the potential for enriched insights, the project 
strategically incorporated the "day_of_year" column. This 
addition introduces a succinct representation of each day's 
position within the year, expressed numerically on a scale 
from 1 to 365. By providing this valuable temporal perspective, 
the project enhances data interpretability and fosters more 
sophisticated temporal analyses.

These enhancements underscore a steadfast commitment to robust 
and comprehensive data practices. Introducing meaningful 
attributes, the dataset is now primed to deliver heightened 
insights, fostering informed decision-making and establishing 
a resilient cornerstone for analytical pursuits.
*/ 

-- Assuming 'combined_data' is the name of your table
ALTER TABLE combined_data
ADD COLUMN day_of_year INTEGER;

-- Update the 'day_of_year' column for each record in 'combined_data'
UPDATE combined_data
SET day_of_year = DATE_PART('doy', started_at::date);

