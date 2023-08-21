/*
File: "create_cyclistic_tables.sql"

Context and Purpose: The SQL script, "create_cyclistic_tables.sql," 
is used to establish a robust framework for data storage, laying the 
groundwork for the subsequent stages of my ETL process. Through this 
script, a series of individual tables are created, to house specific 
ride data from distinct months. The genesis of "cyclistic_data_1" 
serves as the template from which the ensuing "cyclistic_data_2" 
through "cyclistic_data_12" tables derive their structure. The 
script's function is paramount in preparing a structured environment 
for aggregation and analysis.

Data Modeling and Type Specification: The script methodically assigns 
appropriate data types to each column, ensuring accurate and efficient 
data storage and retrieval. Utilizing "text" for textual data, 
"timestamp" for temporal records, and "decimal" for precise geographic 
coordinates guarantees data integrity and alignment with the intended 
data schema. Furthermore, the "integer" type aptly captures the day 
of the week, adding to the script's meticulous data modeling.

Advantages of the Query: The creation of distinct tables for individual 
months underscores my adeptness in database design and SQL proficiency. 
This segmented approach not only enhances data organization but also 
streamlines query execution and facilitates subsequent analysis. By 
deploying standardized table structures across the complete set, 
the script fosters a cohesive ecosystem conducive to seamless data 
aggregation and comprehensive insights.

Incorporating the "create_cyclistic_tables.sql" script within my 
project portfolio underscores my ability to architect and implement 
scalable data solutions. This skill is pivotal in addressing the 
complex challenges of database management and design. The script serves 
as tangible proof of my commitment to providing structured, reliable, 
and meticulously designed solutions for data-driven initiatives, 
showcasing my capacity to contribute effectively to future data-centric 
projects.
*/

DO $$ 
BEGIN
    FOR i IN 1..12 LOOP
        EXECUTE format('
            CREATE TABLE cyclistic_data_%s (
                ride_id text,
                rideable_type text,
                started_at timestamp,
                ended_at timestamp,
                start_station_name text,
                start_station_id text,
                end_station_name text,
                end_station_id text,
                start_lat decimal,
                start_lng decimal,
                end_lat decimal,
                end_lng decimal,
                member_casual text,
                ride_length text,
                day_of_week integer,
                name_of_day text
            );', i);
    END LOOP;
END $$;