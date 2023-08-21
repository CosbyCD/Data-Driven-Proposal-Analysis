/*
Context and Purpose:
The "holidays" table is a fundamental component of my
project portfolio, focused on evaluating ridership data
and cycling patterns in Chicago during the year 2022.
The data for this table was sourced using calendars and
Google to identify 34 holidays that span 55 days in Chicago.
Each holiday's name, start date, and end date are stored 
in the "holidays" table.

Data Source and Assumptions:
The holiday data was collected through extensive research
using official calendars and online sources to ensure accuracy.
Any assumptions made during data collection are clearly
documented, and the table's structure reflects the most 
relevant attributes for further analysis.

Integration with the Project:
The "holidays" table will be used in conjunction with the
previously created "combined_data" table, which consolidates
cycling ride data from various sources. By leveraging the
"holidays" table, I aim to identify and analyze ridership
patterns during specific holidays. This will provide 
valuable insights into how holidays impact cycling trends
in Chicago, contributing to a comprehensive assessment of
cycling behavior in the city throughout the year.

The "holidays" table, alongside other components of my
project, demonstrates my SQL skills in data modeling,
table creation, and data analysis. It showcases my ability
to collect and structure relevant data, making it an
essential element in illustrating my capabilities as 
a SQL developer.
*/

-- Create the 'holidays' table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.holidays (
    holiday_name text COLLATE pg_catalog."default",
    holiday_start_date date,
    holiday_end_date date
);

-- Set the table to use the default tablespace
ALTER TABLE public.holidays SET TABLESPACE pg_default;

-- Set the table's owner to 'postgres'
ALTER TABLE public.holidays OWNER TO postgres;
