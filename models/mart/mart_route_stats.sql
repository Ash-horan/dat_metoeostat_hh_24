SELECT 
    origin.airport_code AS origin_airport_code,
    origin.name AS origin_airport_name,
    origin.city AS origin_city,
    origin.country AS origin_country,
    destination.airport_code AS destination_airport_code,
    destination.name AS destination_airport_name,
    destination.city AS destination_city,
    destination.country AS destination_country,
    COUNT(*) AS total_flights,
    COUNT(DISTINCT r.tail_number) AS unique_airplanes,
    COUNT(DISTINCT r.airline) AS unique_airlines,
    ROUND(AVG(r.actual_elapsed_time), 2) AS avg_actual_elapsed_time,
    ROUND(AVG(r.arr_delay), 2) AS avg_arrival_delay,
    MAX(r.arr_delay) AS max_delay,
    MIN(r.arr_delay) AS min_delay,
    SUM(CASE WHEN r.cancelled = 1 THEN 1 ELSE 0 END) AS total_cancelled,
    SUM(CASE WHEN r.diverted = 1 THEN 1 ELSE 0 END) AS total_diverted
FROM 
    mart_route_stats r
JOIN 
    airports origin ON r.origin = origin.airport_code
JOIN 
    airports destination ON r.destination = destination.airport_code
GROUP BY 
    origin.airport_code, origin.name, origin.city, origin.country,
    destination.airport_code, destination.name, destination.city, destination.country
ORDER BY 
    origin.airport_code, destination.airport_code;
