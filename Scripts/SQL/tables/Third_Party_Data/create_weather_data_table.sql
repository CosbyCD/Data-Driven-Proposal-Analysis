/*
File: create_weather_data_table.sql

The "weather_data" table serves as the repository for a 
comprehensive weather dataset dedicated to Chicago, 
Illinois. Spanning from January 1, 2022, to December 31, 2022,
the dataset is composed of daily temperature records and an 
array of meteorological variables. These variables include 
temperature metrics, humidity levels, detailed precipitation
data, atmospheric pressure readings, solar indexes, cloud 
information, visibility metrics, and wind statistics. 
Additionally, the dataset captures significant timestamps
such as sunrise and sunset times, moon phases, weather 
conditions, their descriptions, and the data collection 
location along with distance measurements in miles. Through 
this comprehensive dataset, valuable insights into Chicago's 
climatic trends and conditions during the specified timeframe
are made available for analysis.
*/

CREATE TABLE weather_data (
    name TEXT,
    datetime TIMESTAMP,
    tempmax NUMERIC,
    tempmin NUMERIC,
    temp NUMERIC,
    feelslikemax NUMERIC,
    feelslikemin NUMERIC,
    feelslike NUMERIC,
    dew NUMERIC,
    humidity NUMERIC,
    precip NUMERIC,
    precipprob NUMERIC,
    precipcover NUMERIC,
    preciptype TEXT,
    snow NUMERIC,
    snowdepth NUMERIC,
    windgust NUMERIC,
    windspeed NUMERIC,
    winddir NUMERIC,
    sealevelpressure NUMERIC,
    cloudcover NUMERIC,
    visibility NUMERIC,
    solarradiation NUMERIC,
    solarenergy NUMERIC,
    uvindex NUMERIC,
    severerisk NUMERIC,
    sunrise TIMESTAMP,
    sunset TIMESTAMP,
    moonphase NUMERIC,
    conditions TEXT,
    description TEXT,
    icon TEXT,
    stations TEXT
);
