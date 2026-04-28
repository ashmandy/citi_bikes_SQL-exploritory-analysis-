-- Project: Citi Bike NYC Trip Analysis
-- Dataset: Citi Bike public trip data (self collected)
-- Objective: Analyze demand patterns, rider behavior, and station pressure
-- Tool: MySQL
-- Author: Mandy Langlois

USE Citi_Bikes;

-- Creating table 
CREATE TABLE citibike_trips (
ride_id VARCHAR(50),
rideable_type VARCHAR(50),
started_at DATETIME,
ended_at DATETIME,
start_station_name VARCHAR(255),
start_station_id VARCHAR(50),
start_lat DOUBLE,
start_lng DOUBLE,
end_station_name VARCHAR(255),
end_station_id VARCHAR(50),
end_lat DOUBLE,
end_lng DOUBLE,
member_casual VARCHAR(20),
PRIMARY KEY (ride_id)
);

-- Duplicate file verification  
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ride_id) AS distinct_rows,
    COUNT(*) - COUNT(DISTINCT ride_id) AS duplicates
FROM citibike_trips;

-- What is the typical hourly demand pattern across all days?
SELECT
	EXTRACT(HOUR FROM started_at) AS hour_of_day,
	COUNT(*) AS trips
    FROM citibike_trips
    GROUP BY hour_of_day
    ORDER BY hour_of_day;
    
-- When does the bike share system experience its highest and lowest demand? 
WITH hourly AS ( 
SELECT EXTRACT(HOUR FROM started_at) AS hour_of_day,
COUNT(*) trips
FROM citibike_trips
GROUP BY hour_of_day
),
ranked AS(
SELECT 
hour_of_day,
trips,
DENSE_RANK() OVER (ORDER BY trips DESC) AS high_demand,
DENSE_RANK() OVER(ORDER BY trips ASC) AS low_demand
FROM hourly 
)
SELECT 
hour_of_day,
trips,
CASE 
WHEN high_demand = 1 THEN 'high'
WHEN low_demand =1 THEN 'low'
END AS label
FROM ranked
WHERE high_demand= 1 OR low_demand= 1
ORDER BY trips DESC;

-- How does demand differ between weedays and weekends?
WITH hourly AS (
SELECT 
EXTRACT(HOUR FROM started_at) AS hour_of_day,
CASE 
WHEN DAYOFWEEK(started_at) IN (1,7) THEN 'Weekend'
ELSE 'Weekday'
END AS day_type,
COUNT(*) AS Trips
FROM citibike_trips
GROUP BY hour_of_day, day_type
)
SELECT * 
FROM hourly 
ORDER BY day_type, hour_of_day;

-- How do casual riders and members differ in:
-- AVG trip duration(min) during the weekday. 2-Monday and 6-Friday.
SELECT 
member_casual,
COUNT(*) AS trips, 
AVG(TIMESTAMPDIFF(MINUTE,started_at,ended_at)) AS avg_trip_dur
FROM citibike_trips
WHERE ended_at > started_at 
AND DAYOFWEEK(started_at) BETWEEN 2 AND 6 
GROUP BY member_casual;

-- How does this time (min) differ weekend vs weekday?
-- 	Note: The durations seem very long, about 5 to 7 hours, this could be due to a small number of long rides influencing the avg.
SELECT 
member_casual,
CASE 
WHEN DAYOFWEEK(started_at) IN (1,7) THEN 'Weekend'
ELSE 'Weekday'
END AS day_type,
COUNT(*) AS trips,
ROUND(AVG(TIMESTAMPDIFF(MINUTE,started_at,ended_at)),0) AS avg_trip_dur
FROM citibike_trips
WHERE ended_at > started_at
GROUP BY member_casual, day_type;

-- What routes are most frequently used by each rider type?
WITH route_count AS( 
SELECT 
member_casual,
start_station_name,
end_station_name,
COUNT(*) AS trips
FROM citibike_trips
WHERE start_station_name IS NOT NULL
AND end_station_name IS NOT NULL
GROUP BY member_casual, start_station_name, end_station_name
),
route_rankings AS(
SELECT*,
RANK() OVER(PARTITION BY member_casual ORDER BY trips DESC) AS route_ranks
FROM route_count
)
SELECT
member_casual,
start_station_name,
end_station_name,
trips
FROM route_rankings
WHERE route_ranks <= 5
ORDER BY member_casual,trips DESC;

-- Are round trips more common for members or casual riders?
-- Computes trip duration and only keeps the trips longer than 60 seconds. 
WITH trips_type AS (
SELECT 
member_casual,
CASE 
WHEN start_station_id = end_station_id THEN 1 
ELSE 0 
END AS is_round_trip
FROM citibike_trips
WHERE start_station_id IS NOT NULL
AND end_station_id IS NOT NULL 
AND TIMESTAMPDIFF(SECOND, started_at, ended_at) > 60 
)
SELECT 
member_casual,
COUNT(*) AS trips,
SUM(is_round_trip) AS round_trips, 
ROUND(SUM(is_round_trip) * 100.0 / COUNT(*), 2) AS round_trip_pct
FROM trips_type
GROUP BY member_casual;

-- Which station has the most departures?
SELECT 
start_station_name,
COUNT(*) AS departures
FROM citibike_trips
WHERE start_station_name IS NOT NULL 
GROUP BY start_station_name
ORDER BY departures DESC
LIMIT 1;

-- Which station has the most arrivals?
SELECT 
end_station_name,
COUNT(*) AS arrivals 
FROM citibike_trips
WHERE end_station_name IS NOT NULL 
GROUP BY end_station_name
ORDER BY arrivals DESC
LIMIT 1;




