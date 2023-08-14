/*
File: monthly_error_statistics_query.sql

The "monthly_error_statistics_query.sql" script calculates
and summarizes error statistics on a monthly basis from 
the "combined_data" table. It retrieves counts of records
with errors, where specific columns contain NULL values,
empty strings (''), or whitespace (' '), and calculates 
the corresponding percentage against total records for 
each month. The results include columns for the month, 
counts of errors in various columns, error percentages 
rounded to two decimal points, and are ordered 
chronologically. By executing this query, you can gain 
insights into the prevalence of errors within different 
months, aiding data quality assessment and pattern recognition.
*/


WITH total_counts AS (
    SELECT COUNT(*) AS total_records FROM combined_data
)

SELECT 
    EXTRACT(MONTH FROM started_at) AS month,
    LPAD(
        TO_CHAR(
            COUNT(*) FILTER (
                WHERE start_station_name IS NULL OR 
                      start_station_name = '' OR 
                      start_station_name = ' '
            ),
            '999,999,999'
        ),
        12
    ) AS error_count_start_station_name,
    LPAD(
        TO_CHAR(
            ROUND(
                (COUNT(*) FILTER (
                    WHERE start_station_name IS NULL OR 
                          start_station_name = '' OR 
                          start_station_name = ' '
                ) * 100.0 / total_records),
                2
            ),
            '999.99'
        ),
        8
    ) AS error_percentage_ssn_by_month,
    LPAD(
        TO_CHAR(
            COUNT(*) FILTER (
                WHERE start_station_id IS NULL OR 
                      start_station_id = '' OR 
                      start_station_id = ' '
            ),
            '999,999,999'
        ),
        12
    ) AS error_count_start_station_id,
    LPAD(
        TO_CHAR(
            ROUND(
                (COUNT(*) FILTER (
                    WHERE start_station_id IS NULL OR 
                          start_station_id = '' OR 
                          start_station_id = ' '
                ) * 100.0 / total_records),
                2
            ),
            '999.99'
        ),
        8
    ) AS error_percentage_ssi_by_month,
    LPAD(
        TO_CHAR(
            COUNT(*) FILTER (
                WHERE end_station_name IS NULL OR 
                      end_station_name = '' OR 
                      end_station_name = ' '
            ),
            '999,999,999'
        ),
        12
    ) AS error_count_end_station_name,
    LPAD(
        TO_CHAR(
            ROUND(
                (COUNT(*) FILTER (
                    WHERE end_station_name IS NULL OR 
                          end_station_name = '' OR 
                          end_station_name = ' '
                ) * 100.0 / total_records),
                2
            ),
            '999.99'
        ),
        8
    ) AS error_percentage_esn_by_month,
    LPAD(
        TO_CHAR(
            COUNT(*) FILTER (
                WHERE end_station_id IS NULL OR 
                      end_station_id = '' OR 
                      end_station_id = ' '
            ),
            '999,999,999'
        ),
        12
    ) AS error_count_end_station_id,
    LPAD(
        TO_CHAR(
            ROUND(
                (COUNT(*) FILTER (
                    WHERE end_station_id IS NULL OR 
                          end_station_id = '' OR 
                          end_station_id = ' '
                ) * 100.0 / total_records),
                2
            ),
            '999.99'
        ),
        8
    ) AS error_percentage_esi_by_month,
    LPAD(
        TO_CHAR(
            COUNT(*) FILTER (WHERE end_lat IS NULL),
            '999,999,999'
        ),
        12
    ) AS error_count_end_lat,
    LPAD(
        TO_CHAR(
            ROUND(
                (COUNT(*) FILTER (WHERE end_lat IS NULL) * 100.0 / total_records),
                2
            ),
            '999.99'
        ),
        8
    ) AS error_percentage_end_lat_by_month,
    LPAD(
        TO_CHAR(
            COUNT(*) FILTER (WHERE end_lng IS NULL),
            '999,999,999'
        ),
        12
    ) AS error_count_end_lng,
    LPAD(
        TO_CHAR(
            ROUND(
                (COUNT(*) FILTER (WHERE end_lng IS NULL) * 100.0 / total_records),
                2
            ),
            '999.99'
        ),
        8
    ) AS error_percentage_end_lng_by_month

FROM 
    combined_data,
    total_counts

WHERE
    start_station_name IS NULL OR start_station_name = '' OR start_station_name = ' '
    OR start_station_id IS NULL OR start_station_id = '' OR start_station_id = ' '
    OR end_station_name IS NULL OR end_station_name = '' OR end_station_name = ' '
    OR end_station_id IS NULL OR end_station_id = '' OR end_station_id = ' '
    OR end_lat IS NULL
    OR end_lng IS NULL

GROUP BY 
    EXTRACT(MONTH FROM started_at),
    total_records

ORDER BY month;
