--CREATING TABLE OF 13 COLUMNS TO IMPORT DATA FROM CSV FILES TO POSTGRE SQL

CREATE TABLE october (  

ride_id VARCHAR(50),  

rideable_type TEXT,  

started_at TIMESTAMP,  

ended_at TIMESTAMP,  

start_station_name VARCHAR(100),  

start_station_id VARCHAR(100),  

end_station_name VARCHAR (100),  

end_station_id VARCHAR (100),  

start_lat DECIMAL,  

start_lng DECIMAL,  

end_lat DECIMAL,  

end_lng DECIMAL,  

member_casual TEXT,  

PRIMARY KEY (ride_id))


--COPY data from CSV FILE TO newly created table
COPY october(ride_id, rideable_type, started_at, ended_at, start_station_name,  

start_station_id, end_station_name, end_station_id, start_lat,  start_lng, end_lat, end_lng, member_casual)  

FROM 'E:\cyclistic\202210-divvy-tripdata.csv'  --location of CSV file in computer

DELIMITER ','  

CSV HEADER  --As CSV file containes header row

--To view first few rows of the whole table
SELECT *  

FROM october  

LIMIT 10


--Renaming 'october' table as 'fullyear' table
ALTER TABLE october RENAME TO fullyear


--Make a duplicate table named 'fullyear_backup' from existing table 'fullyear' in case we need in future
CREATE TABLE fullyear_backup AS TABLE fullyear


--Checking no. of rows in full year table
SELECT COUNT(*)
FROM fullyear

--check whether this dataset contains any duplicate entry based on column 'ride_id'
SELECT ride_id, COUNT(*)
FROM fullyear1
GROUP BY ride_id
HAVING COUNT(*) > 1

--check whether this dataset contains any negative, zero or extremely large ride length (more than 24 hours) value
SELECT ride_id, (ended_at - started_at) AS ride_length
FROM fullyear
WHERE (ended_at - started_at) < '00:00:01' OR (ended_at - started_at) > '24:00:00'
ORDER BY ride_length

--Creating a new table named fullyear1 for analysis with 5 new columns (ride_length, day_of_week, day_name, month_of_year, month_name) in addition to original columns filtering out ride length from 1 second to 24 hours.
CREATE TABLE fullyear1 AS ( 

SELECT *, (ended_at - started_at) AS ride_length, EXTRACT('DOW' FROM started_at) AS day_of_week,  

CASE WHEN EXTRACT('DOW' FROM started_at) = '0' THEN 'Sunday' 

     WHEN EXTRACT('DOW' FROM started_at) = '1' THEN 'Monday' 

 WHEN EXTRACT('DOW' FROM started_at) = '2' THEN 'Tuesday' 

 WHEN EXTRACT('DOW' FROM started_at) = '3' THEN 'Wednesday' 

 WHEN EXTRACT('DOW' FROM started_at) = '4' THEN 'Thursday' 

 WHEN EXTRACT('DOW' FROM started_at) = '5' THEN 'Friday' 

 WHEN EXTRACT('DOW' FROM started_at) = '6' THEN 'Saturday' 

 END AS day_name,  

 EXTRACT('MON' FROM started_at) AS month_of_year, 

CASE WHEN EXTRACT('MON' FROM started_at) = '1' THEN 'January' 

 WHEN EXTRACT('MON' FROM started_at) = '2' THEN 'February' 

 WHEN EXTRACT('MON' FROM started_at) = '3' THEN 'March' 

 WHEN EXTRACT('MON' FROM started_at) = '4' THEN 'April' 

 WHEN EXTRACT('MON' FROM started_at) = '5' THEN 'May' 

 WHEN EXTRACT('MON' FROM started_at) = '6' THEN 'June' 

 WHEN EXTRACT('MON' FROM started_at) = '7' THEN 'July' 

 WHEN EXTRACT('MON' FROM started_at) = '8' THEN 'August' 

 WHEN EXTRACT('MON' FROM started_at) = '9' THEN 'September' 

 WHEN EXTRACT('MON' FROM started_at) = '10' THEN 'October' 

 WHEN EXTRACT('MON' FROM started_at) = '11' THEN 'November' 

 WHEN EXTRACT('MON' FROM started_at) = '12' THEN 'December' 

END AS month_name 

FROM fullyear 

WHERE (ended_at - started_at) BETWEEN '00:00:01' AND '24:00:00' 

ORDER BY started_at)


--Let's have a quick look on first 10 rows of data
SELECT *
FROM fullyear1
LIMIT 10


--What is the total numbers of rides of the both types of users?
SELECT member_casual AS member_type, count(*)
FROM fullyear1
GROUP BY member_casual


--What is the total ride duration of the both types of users?
SELECT member_casual AS member_type, sum(ride_length)
FROM fullyear1
GROUP BY member_casual


--What is the average ride duration of the both types of users?
SELECT member_casual AS member_type, avg(ride_length)
FROM fullyear1
GROUP BY member_casual

--From the following queries, we will generate query data in tabular format. As we are using PostgreSQL, so To do that we have to execute follwing code chunk to enable crosstab function.
create extension tablefunc


--What is the total numbers of rides of both types of users based on the day of the week?
SELECT *
FROM crosstab('SELECT day_name, member_casual AS rider_type, COUNT(*) AS rides
FROM fullyear1
GROUP BY day_name, member_casual
ORDER BY CASE
	WHEN day_name = ''Sunday'' THEN 1
	WHEN day_name = ''Monday'' THEN 2
	WHEN day_name = ''Tuesday'' THEN 3
	WHEN day_name = ''Wednesday'' THEN 4
	WHEN day_name = ''Thursday'' THEN 5
	WHEN day_name = ''Friday'' THEN 6
	WHEN day_name = ''Saturday'' THEN 7
	END                                  # Custom Sorting
	, member_casual'
	, 'values (''casual''), (''member'')')
	AS (day_name text, casual bigint, member bigint)
	
	
--What is the total rides duration of both types of users based on the day of the week?
SELECT *
FROM crosstab('SELECT day_name, member_casual AS rider_type, SUM(ride_length) AS rides
FROM fullyear1
GROUP BY day_name, member_casual
ORDER BY CASE
	WHEN day_name = ''Sunday'' THEN 1
	WHEN day_name = ''Monday'' THEN 2
	WHEN day_name = ''Tuesday'' THEN 3
	WHEN day_name = ''Wednesday'' THEN 4
	WHEN day_name = ''Thursday'' THEN 5
	WHEN day_name = ''Friday'' THEN 6
	WHEN day_name = ''Saturday'' THEN 7
	END                          --Custom Sorting
	, member_casual'
	, 'values (''casual''), (''member'')')
	AS (day_name text, casual interval, member interval)
	

--What is the average rides duration of both types of users based on the day of the week?
SELECT *
FROM crosstab('SELECT day_name, member_casual AS rider_type, AVG(ride_length) AS rides
FROM fullyear1
GROUP BY day_name, member_casual
ORDER BY CASE
	WHEN day_name = ''Sunday'' THEN 1
	WHEN day_name = ''Monday'' THEN 2
	WHEN day_name = ''Tuesday'' THEN 3
	WHEN day_name = ''Wednesday'' THEN 4
	WHEN day_name = ''Thursday'' THEN 5
	WHEN day_name = ''Friday'' THEN 6
	WHEN day_name = ''Saturday'' THEN 7
	END                                   # Custom Sorting
	, member_casual'
	, 'values (''casual''), (''member'')')
	AS (day_name text, casual interval, member interval)
	
	
--What is the total numbers of rides of both types of users based on the months of the year?
SELECT *
FROM crosstab('SELECT month_name, member_casual, COUNT(*) AS rides
FROM fullyear1
GROUP BY month_name, member_casual
ORDER BY array_position(array[''January'',''February'',''March'',''April'',
			  ''May'',''June'', ''July'',''August'',''September'',''October''
			  ,''November'',''December''],month_name)                             #Custom sorting
			   , member_casual'
	, 'values (''casual''), (''member'')')
	AS (month_name text, casual bigint, member bigint)
	
--What is the total rides duration of both types of users based on the months of the year?
SELECT *
FROM crosstab('SELECT month_name, member_casual, SUM(ride_length) AS rides
FROM fullyear1
GROUP BY month_name, member_casual
ORDER BY array_position(array[''January'',''February'',''March'',''April'',
			  ''May'',''June'', ''July'',''August'',''September'',''October''
			  ,''November'',''December''],month_name)                       #Custom sorting
			  , member_casual'
	, 'values (''casual''), (''member'')')
	AS (month_name text, casual interval, member interval)
	

--What is the average rides duration of both types of users based on the months of the year?
SELECT *
FROM crosstab('SELECT month_name, member_casual, AVG(ride_length) AS rides
FROM fullyear1
GROUP BY month_name, member_casual
ORDER BY array_position(array[''January'',''February'',''March'',''April'',
			  ''May'',''June'', ''July'',''August'',''September'',''October''
			  ,''November'',''December''],month_name)      #Custom sorting
			  , member_casual'
	, 'values (''casual''), (''member'')')        
	AS (month_name text, casual interval, member interval)
	
	
--What is the numbers of riders in each hour throughout the year for both types of users?
SELECT *
FROM CROSSTAB(
	'SELECT
	  DATE_TRUNC(''hour'', started_at) AS hour_start, member_casual,
	  COUNT(*) AS "No._of_rides"
	FROM
	  fullyear1
	GROUP BY
	  member_casual, hour_start
	ORDER BY
	  hour_start, member_casual'
	, 'values(''casual''),(''member'')')
	AS (hour_start timestamp without time zone, casual bigint, member bigint)
	
	
--What are the peak hours for casual riders?
SELECT
  DATE_TRUNC('hour', started_at) AS hour_start, member_casual as user_type,
  COUNT(*) AS "No._of_rides"
FROM
  fullyear1
GROUP BY
  member_casual, hour_start
HAVING
	COUNT(*)> '1500' AND member_casual = 'casual'
ORDER BY
  member_casual,COUNT(*) DESC, hour_start
  
  
--What are the peak hours for member riders?
SELECT
  DATE_TRUNC('hour', started_at) AS hour_start, member_casual as user_type,
  COUNT(*) AS "No._of_rides"
FROM
  fullyear1
GROUP BY
  member_casual, hour_start
HAVING
	COUNT(*)> '1500' AND member_casual = 'member'
ORDER BY
  member_casual, COUNT(*) DESC, hour_start
  
  
--What are the mostly used starting stations for casual users?
SELECT start_station_name, member_casual as types_of_rides, COUNT(*) AS no_of_rides
FROM fullyear1
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name, member_casual
HAVING member_casual = 'casual' AND COUNT(*) > '10000'
ORDER BY COUNT(*) DESC


--What are the mostly used starting stations for member riders?
SELECT start_station_name, member_casual as types_of_rides, COUNT(*) AS no_of_rides
FROM fullyear1
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name, member_casual
HAVING member_casual = 'member' AND COUNT(*) > '10000'
ORDER BY COUNT(*) DESC


--What are the mostly used ending stations for casual users?
SELECT end_station_name, member_casual as types_of_rides, COUNT(*) AS no_of_rides
FROM fullyear1
WHERE end_station_name IS NOT NULL
GROUP BY end_station_name, member_casual
HAVING member_casual = 'casual' AND COUNT(*) > '10000'
ORDER BY COUNT(*) DESC


--What are the mostly used ending stations for member riders?
SELECT end_station_name, member_casual as types_of_rides, COUNT(*) AS no_of_rides
FROM fullyear1
WHERE end_station_name IS NOT NULL
GROUP BY end_station_name, member_casual
HAVING member_casual = 'member' AND COUNT(*) > '10000'
ORDER BY COUNT(*) DESC


--Which bikes are preferred by the users?
SELECT *
FROM CROSSTAB('
	SELECT rideable_type, member_casual AS type_of_rider, COUNT(*) AS no_of_rides
	FROM fullyear1
	GROUP BY rideable_type, member_casual
	ORDER BY rideable_type, member_casual'
	, 'values (''casual''), (''member'')')
	AS (rideable_type text, casual bigint, member bigint)