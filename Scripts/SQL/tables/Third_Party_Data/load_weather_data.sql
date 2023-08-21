/*
File: load_weather_data.sql

The query efficiently loads data from a CSV file into the 
"weather_data" table using the PostgreSQL COPY command. 
This action facilitates the transfer of weather data from
the specified file to the database table, enabling subsequent
analysis and processing.
*/


COPY weather_data 
FROM 'D:\GAC_Cyclistic_project\Weather\Chicago_Illinois_2022-01-01_to_2022-12-31.csv'
DELIMITER ',' CSV HEADER;
