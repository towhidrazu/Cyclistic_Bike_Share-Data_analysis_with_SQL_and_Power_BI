![CyclisticLogo](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/Cyclistic.jpg)

# Cyclistic_Bike_Share
Cyclistic Bike_Share- Data analysis with SQL &amp; Power BI


## INTRODUCTION
This is the final project in my Google Data Analytics Professional Certificate course. In this case study I will be analyzing a public dataset for a fictional company provided by the course. I will be using SQL & Power BI for this analysis. This is because SQL can handle large amount of data (5+ million rows of data in this project) very easily and Power BI is a very useful data visualization tool.

Data set for case study can be found here [Cyclistic Trip Data Download](https://divvy-tripdata.s3.amazonaws.com/index.html).

The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).

## BACKGROUND INFORMATION

### Scenario

fictitiously I am wirkign as data analyst in the marketing analyst team at Cyclistic, a bike-share compnay in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

### About the company

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of more than 600 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.

The company's marketing strategy relied on creating general awareness and appealing to broad consumer segments. The flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships help the company to attract more consumers and achieve its goal.

Cyclistic refers to its customers as 'casual' rides who purchase single-ride or full-day passes and as 'members' who purchase an annual subscription.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Moreno believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members.


### Characters and teams

* Cyclistic:  A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.

* Lily Moreno: The director of marketing and manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.

* Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.

* Cyclistic executive team: The notoriously detail-oriented executive team will decide whether to approve the recommended marketing program.
Consumers can purchase access to Cylictic bikes using three options: classic_bike, docked_bike & electric_bike

### Limitations of study

Data-privacy issues prohibit us from using riders’ personally identifiable information. For this reason we won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

For casual riders there are approximately 331K record where start_station_id and start_station_name are missing. For member riders this number is approximately 538K. This is also the case for end_station_id and end_station_name. Due to this at time determining top used station we will exclude those null valued record.


### The case study follows the six step data analysis process:

### ❓ [Ask](#step-1-ask)
### 💻 [Prepare](#step-2-prepare)
### 🛠 [Process](#step-3-process)
### 📊 [Analyze](#step-4-analyze)
### 📋 [Share](#step-5-share)
### 🧗‍♀️ [Act](#step-6-act)

## Step 1: Ask

[Back to top](#introduction)

Three questions will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

**Moreno** (the director of marketing and my manager) has assigned me the first question to answer:

**How do annual members and casual riders use Cyclistic bikes differently?**

**Key tasks**

1. Identify the business task
   
* Finding out the difference in bike use between annual members and casual riders.

2. Consider key stakeholders
- Director of Marketing & my manager (Lily Moreno), Marketing Analytics team (The team where I belong to)

**Deliverable**

**A clear statement of the business task**

For completion of the business task our effort should be answering the following questions:

- What is the total numbers of rides of the both types of users?
- What is the total and average ride duration of the both types of users?
- What is the total numbers of rides, total and average ride duration of both types of users based on the day of the week and based of the month of the year?
- What is the numbers of riders per hour for both types of users?
- What are the peak hours for both types of users?
- What are the mostly used starting and ending stations for both types of users?
- Which bikes are preferred  by the users?


## Step 2: Prepare

[Back to top](#introduction)

I will use Cyclistic’s historical trip data to analyze and identify trends. Link for Cyclistic trip data and information about license is given above.

**Key tasks**

1. Download data and store it appropriately.
* Data has been downloaded and stored on my computer. A copy of the data has been produced to work with.

2. Identify how it’s organized.
* The data is organized in CSV (comma-separated values) format under zip file.

3. Sort and filter the data.
* For the purpose of my analysis I have downloaded most recent 12 months file (October 2022 to September 2023). Unzip those and organize those in a separate folder.

4. Determine the credibility of the data
* For the purpose of this case study, the datasets are appropriate and will enable me to answer the business questions. But data-privacy issues will prohibit me from using rider's personally identifiable information and this will prevent me from determining if casual riders live in the
Cyclistic service area or if riders have purchased multiple single passes.


**Deliverable**

**A description of all data sources used**


* Source of data: [Cyclistic Trip Data Download](https://divvy-tripdata.s3.amazonaws.com/index.html)

***For the purpose of this case study we will use PostgreSQL. Installation procesure of PostgreSQL & pgAdmin can be found in my [this youtube video.](https://youtu.be/bk1XawUBQ-U)***


**CREATING TABLE OF 13 COLUMNS TO IMPORT DATA FROM CSV FILES TO POSTGRE SQL**

```
# CODES for creating table with ride_id as Primary Key:

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
```


**COPY data from CSV FILE TO newly created table**

It is mentionable that in the table named 'october' we have loaded only data of october. In next step we will add rest 11 months data in this 'october' table. Then we will rename the 'october' table as 'fullyear'.

```
COPY october(ride_id, rideable_type, started_at, ended_at, start_station_name,  

start_station_id, end_station_name, end_station_id, start_lat,  start_lng, end_lat, end_lng, member_casual)  

FROM 'E:\cyclistic\202210-divvy-tripdata.csv'  # location of CSV file in computer

DELIMITER ','  

CSV HEADER  # As CSV file containes header row
```

**To view first few rows of the whole table**

Now that I have imported october 2022 data to my newly created SQL table I will be using, I will take a look at at a glance to familiarize myself with the data and to check for errors.

```
SELECT *  

FROM october  

LIMIT 10
```

**Add November & subsequest months (11 months) data to existing table named october (This way we bring all 12 months (October 2022 to September 2023) data under 1 table)**

```
From PGadmin right click on table named October -> import/export data -> Under General from File Name,

select the CSV file -> From Options, turn on Header -> Press Ok  

# Note: This can also be done using Union All command after creating & importing data for each month's table.
```


**Renaming 'october' table as 'fullyear' table**

```
ALTER TABLE october RENAME TO fullyear
```


**Make a duplicate table named 'fullyear_backup' from existing table 'fullyear' in case we need in future**

```
CREATE TABLE fullyear_backup AS TABLE fullyear
```

## Step 3: Process

[Back to top](#introduction)

For this analysis I will be using SQL (PostgreSQL) and Power BI.

The whole 12 months of data contains 5+ millions of rows making it a huge dataset. To work with such a hugh dataset efficiently SQL is one of the best options as it can handle massive amount of data in good pace.

For visualization part I will be using MS Power BI which is a very widely used and powerful business intelligence tool and can produce effective visualizations.

**Deliverable**

**Documentation of any cleaning or manipulation of data**

Checking no. of rows in full year table

```
SELECT COUNT(*)
FROM fullyear

Ans: 5674399
```

Now I will check whether this dataset contains any duplicate entry based on column 'ride_id'

```
SELECT ride_id, COUNT(*)
FROM fullyear1
GROUP BY ride_id
HAVING COUNT(*) > 1

Result: null

# Thus, this dataset doesn't contain any duplicate value.
```

Now I will check whether this dataset contains any negative, zero or extremely large ride length (more than 24 hours) value

```
SELECT ride_id, (ended_at - started_at) AS ride_length
FROM fullyear
WHERE (ended_at - started_at) < '00:00:01' OR (ended_at - started_at) > '24:00:00'
ORDER BY ride_length

# From 17640 resulted values I can see this dataset containes 11695 negative and zero value.
And rest 5945 row contains ride length more than 24 hours.
These might happen due to testing or checking pupose.
Or this could happen due to any error.

For the purpose of our study we will discard those 17640 values from analysis. These are 0.31% of the total data.
```

**Creating a new table named fullyear1 for analysis with 5 new columns (ride_length, day_of_week, day_name, month_of_year, month_name) in addition to original columns filtering out ride length from 1 second to 24 hours.**

```
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
```

*** Let's have a quick look on first 10 rows of data**

```
SELECT *
FROM fullyear1
LIMIT 10
```
![TopTenRows](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/TopTenRows.png)

**Now our dataset fullyear1 is ready to analyze. Thus we proceed to ANALYZE section.**


## Step 4: Analyze

[Back to top](#introduction)

**All the required data are now in one SQL table 'fullyear1' and ready for exploration.**

Our Analyze section comprises of answering all the questions we framed in Ask (step 1) phase to attain business task.

**What is the total numbers of rides of the both types of users?**

```
SELECT member_casual AS member_type, count(*)
FROM fullyear1
GROUP BY member_casual

RESULT:

Casual: 2077387
Member: 3579372
```

**What is the total ride duration of the both types of users?**

```
SELECT member_casual AS member_type, sum(ride_length)
FROM fullyear1
GROUP BY member_casual

RESULT:

Casual: 1 day 713964:46:09
Member:	720377:57:18
```

**What is the average ride duration of the both types of users?**

```
SELECT member_casual AS member_type, avg(ride_length)
FROM fullyear1
GROUP BY member_casual

RESULT:

Casual: 00:20:37.304156
Member: 00:12:04.529509

```

***From the following queries, we will generate query data in tabular format. As we are using PostgreSQL, so To do that we have to execute follwing code chunk to enable crosstab function.***

```
create extension tablefunc

```


**What is the total numbers of rides of both types of users based on the day of the week?**

```
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


RESULT:
 day_name       casual  member
"Sunday"	337183	400790
"Monday"	236159	485185
"Tuesday"	239686	552590
"Wednesday"	248298	569899
"Thursday"	272968	573983
"Friday"	315502	519058
"Saturday"	427591	477867
```

**What is the total rides duration of both types of users based on the day of the week?**

```
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
	END                                      # Custom Sorting
	, member_casual'
	, 'values (''casual''), (''member'')')
	AS (day_name text, casual interval, member interval)

RESULT:
day_name             casual        member
"Sunday"	"134524:21:02"	"89840:23:48"
"Monday"	"79698:37:26"	"92734:24:58"
"Tuesday"	"73127:25:28"	"106528:27:55"
"Wednesday"	"1 day 72180:13:29"	"109195:33:43"
"Thursday"	"82291:27:18"	"110587:35:58"
"Friday"	"105656:17:24"	"104268:03:13"
"Saturday"	"166486:24:02"	"107223:27:43"
```

**What is the average rides duration of both types of users based on the day of the week?**

```
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

RESULT:

day_name             casual                  member
"Sunday"	"00:23:56.275441"	"00:13:26.969805"
"Monday"	"00:20:14.923192"	"00:11:28.075472"
"Tuesday"	"00:18:18.348372"	"00:11:34.009075"
"Wednesday"	"00:17:26.867913"	"00:11:29.778405"
"Thursday"	"00:18:05.289257"	"00:11:33.601305"
"Friday"	"00:20:05.579185"	"00:12:03.165798"
"Saturday"	"00:23:21.69237"	"00:13:27.765472"
```

**What is the total numbers of rides of both types of users based on the months of the year?**

```
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

RESULT:
month_name      casual  member
"January"	39917	150258
"February"	42930	147397
"March"	        62067	196432
"April"	        146974	279241
"May"	        229785	363718
"June"	        300517	418249
"July"	        330334	436039
"August"	310040	460240
"September"	260819	404473
"October"	208639	349559
"November"	100570	236891
"December"	44795	136875
```

**What is the total rides duration of both types of users based on the months of the year?**

```
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

RESULT:
month_name        casual            member
"January"	"9114:32:16"	"25206:25:17"
"February"	"11462:24:48"	"25703:08:17"
"March"	        "15883:58:37"	"33368:30:08"
"April"	        "50729:45:38"	"53335:36:30"
"May"	    "1 day 86287:37:00"	"77575:42:00"
"June"   	"109023:39:31"	"89597:47:01"
"July"	        "125904:07:32"	"95906:48:44"
"August"	"113316:33:56"	"100967:35:47"
"September"	"91951:29:36"	"85070:57:35"
"October"	"64229:43:31"	"67200:03:20"
"November"	"26056:23:38"	"42863:03:55"
"December"	"10004:30:06"	"23582:18:44"

```

**What is the average rides duration of both types of users based on the months of the year?**

```
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


RESULT:

month_name           casual                  member
"January"	"00:13:42.014079"	"00:10:03.915379"
"February"	"00:16:01.208665"	"00:10:27.769202"
"March"	        "00:15:21.299837"	"00:10:11.542967"
"April"	        "00:20:42.581259"	"00:11:27.607443"
"May"	        "00:22:32.228475"	"00:12:47.827053"
"June"	        "00:21:46.033173"	"00:12:51.196156"
"July"	        "00:22:52.110809"	"00:13:11.820282"
"August"	"00:21:55.764534"	"00:13:09.769136"
"September"	"00:21:09.176617"	"00:12:37.171566"
"October"	"00:18:28.263608"	"00:11:32.072583"
"November"	"00:15:32.713712"	"00:10:51.384118"
"December"	"00:13:24.022904"	"00:10:20.247116"

```

**What is the numbers of riders in each hour throughout the year for both types of users?**

```
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
	

RESULT:
      hour_start       casual member
"2022-10-01 00:00:00"	303	235
"2022-10-01 01:00:00"	261	157
"2022-10-01 02:00:00"	151	100
"2022-10-01 03:00:00"	79	75
"2022-10-01 04:00:00"	40	25
"2022-10-01 05:00:00"	39	64
"2022-10-01 06:00:00"	80	155
"2022-10-01 07:00:00"	133	260
"2022-10-01 08:00:00"	233	428
"2022-10-01 09:00:00"	435	590
.....                   ...     ...

# Total rows: 10 of 8758

Note: Here as we are seeing the riders count based of hour for full year so no. of rows are higher. In next step we will
use data visualization section to see a trand of no. of riders based on hour for both casual and member.
```

**What are the peak hours for casual riders?**

```
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



RESULT:
     start_time         user_type     No._of_rides
"2023-06-10 16:00:00"	"casual"	1706
"2023-06-10 15:00:00"	"casual"	1626
"2023-08-19 15:00:00"	"casual"	1610
"2023-06-24 13:00:00"	"casual"	1554
"2023-06-10 13:00:00"	"casual"	1540
"2023-08-12 14:00:00"	"casual"	1535
"2023-08-12 15:00:00"	"casual"	1534
"2023-08-12 13:00:00"	"casual"	1533
"2023-08-19 16:00:00"	"casual"	1523
"2023-06-24 14:00:00"	"casual"	1513
"2023-07-29 16:00:00"	"casual"	1506
"2023-06-24 16:00:00"	"casual"	1504

NOTE: For casual riders there are 12 incidents wehere total ride per hour is above 1500. And the popular hours are
mostly afternoon time ranging from 1:00pm to 4:00pm
```

**What are the peak hours for member riders?**

```
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



RESULT:
     start_time         user_type     No._of_rides
"2023-08-29 17:00:00"	"member"	2188
"2023-08-01 17:00:00"	"member"	2142
"2023-08-02 17:00:00"	"member"	2141
"2023-08-08 17:00:00"	"member"	2129
"2023-07-19 17:00:00"	"member"	2126
"2023-09-20 17:00:00"	"member"	2101
"2023-08-16 17:00:00"	"member"	2097
"2023-07-18 17:00:00"	"member"	2070
"2023-08-09 17:00:00"	"member"	2042
"2023-08-30 17:00:00"	"member"	2035
....                     ....           ...
Total rows: 10 of 158

NOTE: For member riders there are 158 incidents wehere total ride per hour is above 1500. And the popular hours are
mostly 5:00pm which is office closing time. Also No._of_riders are far higher then casual member. It can be
inferred that cyclistic's bike are widely used by members for going back to homr from work.
```

**What are the mostly used starting stations for casual users?**

```
SELECT start_station_name, member_casual as types_of_rides, COUNT(*) AS no_of_rides
FROM fullyear1
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name, member_casual
HAVING member_casual = 'casual' AND COUNT(*) > '10000'
ORDER BY COUNT(*) DESC


RESULT:

      start_station_name               types_of_rides  no_of_rides
"Streeter Dr & Grand Ave"	        "casual"	47227
"DuSable Lake Shore Dr & Monroe St"	"casual"	30709
"Michigan Ave & Oak St"	                "casual"	22873
"Millennium Park"	                "casual"	20701
"DuSable Lake Shore Dr & North Blvd"	"casual"	20439
"Shedd Aquarium"			"casual"	17923
"Theater on the Lake"			"casual"	16467
"Dusable Harbor"			"casual"	14805
"Wells St & Concord Ln"			"casual"	12727
"Montrose Harbor"			"casual"	11903
"Adler Planetarium"			"casual"	11728
"Indiana Ave & Roosevelt Rd"		"casual"	11602
"Clark St & Armitage Ave"		"casual"	11316
"Clark St & Lincoln Ave"		"casual"	11061
"Clark St & Elm St"			"casual"	10999
"Wilton Ave & Belmont Ave"		"casual"	10716
"Michigan Ave & 8th St"			"casual"	10508
"Clark St & Newport St"			"casual"	10028
"Wells St & Elm St"			"casual"	10007
```

**What are the mostly used starting stations for member riders?**

```
SELECT start_station_name, member_casual as types_of_rides, COUNT(*) AS no_of_rides
FROM fullyear1
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name, member_casual
HAVING member_casual = 'member' AND COUNT(*) > '10000'
ORDER BY COUNT(*) DESC

RESULT:

  start_station_name          types_of_rides  no_of_rides
"Kingsbury St & Kinzie St"	"member"	25075
"Clark St & Elm St"	     	"member"	24466
"Clinton St & Washington Blvd"	"member"	24234
"Wells St & Concord Ln"		"member"	21048
"University Ave & 57th St"	"member"	20747
"Wells St & Elm St"		"member"	19849
"Ellis Ave & 60th St"		"member"	19756
"Clinton St & Madison St"	"member"	19189
"Loomis St & Lexington St"	"member"	19166
"Broadway & Barry Ave"		"member"	18659
"State St & Chicago Ave"	"member"	17986
"Streeter Dr & Grand Ave"	"member"	17222
...                                ...           ...
Total rows: 12 of 106

```


**What are the mostly used ending stations for casual users?**

```
SELECT end_station_name, member_casual as types_of_rides, COUNT(*) AS no_of_rides
FROM fullyear1
WHERE end_station_name IS NOT NULL
GROUP BY end_station_name, member_casual
HAVING member_casual = 'casual' AND COUNT(*) > '10000'
ORDER BY COUNT(*) DESC

RESULT:

  end_station_name                  types_of_rides  no_of_rides
"Streeter Dr & Grand Ave"		"casual"	50727
"DuSable Lake Shore Dr & Monroe St"	"casual"	27896
"Michigan Ave & Oak St"	 		"casual"	24094
"DuSable Lake Shore Dr & North Blvd"	"casual"	23388
"Millennium Park"			"casual"	22731
"Theater on the Lake"			"casual"	17825
"Shedd Aquarium"			"casual"	15867
"Dusable Harbor"			"casual"	13401
"Wells St & Concord Ln"			"casual"	12397
"Montrose Harbor"			"casual"	11663
"Clark St & Lincoln Ave"		"casual"	11641
"Clark St & Armitage Ave"		"casual"	11609
"Indiana Ave & Roosevelt Rd"		"casual"	10742
"Clark St & Elm St"			"casual"	10501
"Sheffield Ave & Waveland Ave"		"casual"	10430
"Broadway & Barry Ave"			"casual"	10244
"Wabash Ave & Grand Ave"		"casual"	10231
"Adler Planetarium"			"casual"	10201
"Clark St & Newport St"			"casual"	10159
"Michigan Ave & Washington St"		"casual"	10054
"Wells St & Elm St"			"casual"	10035
```


**What are the mostly used ending stations for member riders?**

```
SELECT end_station_name, member_casual as types_of_rides, COUNT(*) AS no_of_rides
FROM fullyear1
WHERE end_station_name IS NOT NULL
GROUP BY end_station_name, member_casual
HAVING member_casual = 'member' AND COUNT(*) > '10000'
ORDER BY COUNT(*) DESC

RESULT:

 end_station_name                  types_of_rides  no_of_rides
"Kingsbury St & Kinzie St"	"member"	25520
"Clinton St & Washington Blvd"	"member"	25396
"Clark St & Elm St"		"member"	24186
"Wells St & Concord Ln"		"member"	22000
"University Ave & 57th St"	"member"	20863
"Clinton St & Madison St"	"member"	20602
"Wells St & Elm St"		"member"	19836
"Ellis Ave & 60th St"		"member"	19489
"Loomis St & Lexington St"	"member"	19207
"Broadway & Barry Ave"		"member"	18987
"State St & Chicago Ave"	"member"	18528
"Canal St & Adams St"		"member"	17621
 ....                            ...              ...
Total rows: 12 of 107
```

**Which bikes are preferred by the users?**

```
SELECT *
FROM CROSSTAB('
	SELECT rideable_type, member_casual AS type_of_rider, COUNT(*) AS no_of_rides
	FROM fullyear1
	GROUP BY rideable_type, member_casual
	ORDER BY rideable_type, member_casual'
	, 'values (''casual''), (''member'')')
	AS (rideable_type text, casual bigint, member bigint)

RESULT:

 rideable_type   casual  member
"classic_bike"	833923	1737635
"docked_bike"	96905	 null
"electric_bike"	1146559	1841737
```



## Step 5: Share

[Back to top](#introduction)

In analyze phase we tried to answer business questions through SQL queries using PostgresSQL.

Now in share phase we will try to share those insights through sophisticated and polished in order to effectively communicate to the executive team. 

For the purpose of creating impactful visualization we will use MS PowerBI, which is a very useful business intelligence tool used for data visualization and other related purpose around the world.

**We will load table name fullyear1.csv (created from table 'fullyear1'created in process phase) into powerBI to prepare our visualization.**

***Alternatively we could directly connect our PostgreSQL server wih powerBI to create a direct quesry connection. Procedure to do that is described in my [this youtube video](https://youtu.be/dIIyoteMr5w).***




**What is the total numbers of rides of the both types of users?**

![v1](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v1.png)

Comment: From the above pie chart it is clearly visible that our target customer 'Casual' riders took 37% (2.08 million ) of total rides between October 2022 to September 2023.


***As ride_duration is given in the table as time value we will convert timevalue into decimal hourvalue using DAX function:***
```
hour_value = HOUR(fullyear1[ride_length]) + MINUTE(fullyear1[ride_length])/60 + SECOND(fullyear1[ride_length])/3600
```


**What is the total ride duration of the both types of users?**
![v2](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v2.png)

Comment: In case of total hour of bike using we found that both casual riders and memebers passed around same time which is a bit more that 700 hours.


**What is the average ride duration of the both types of users?**
![v3](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v3.png)


Comment: The average ride duration for casual riders is 20.62 minutes, whereas the average ride duration for members is 12.08 minutes. So this can clearly understood that the average trip duration for casual rider is lengthier than that of members. 

***From next visual we have to show information sorted by specific order of days of a week or months of a year. Power BI won't sort the day or months as per their original order. Rather it srots those alphabetically. So we have to follow custom column set rule in Power BI. Procedure to do that is described in my [this youtube video](https://youtu.be/Ds4b5taeFw8).***


**What is the total numbers of rides of both types of users based on the day of the week?**
![v4](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v4.png)


Comment: From the chart above we can see overall members riders took more rides compare to their casual counterpart. But members riders tend to use cyclistic bukes on weekday most wehereas casul riders prefered to ride more on weekend.



**What is the total rides duration of both types of users based on the day of the week?**
![v5](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v5.png)


Comment: This chart also depicts the almost same scenario as previous one except the weekends. On weekend we can see on basis of total ride hours, casual riders surpassed member riders.



**What is the average rides duration of both types of users based on the day of the week?**
![v6](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v6.png)


Comment: From chart above we can see average minutes of ride for casual riders are always high compare to member riders. Also tend to go for longer ride for both of users are higher in weekend compare to weekdays.




**What is the total numbers of rides of both types of users based on the months of the year?**
![v7](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v7.png)


Comment: From the chart above we can see there's a huge impact of winter season in using cyclistic bike. As November to March see very less rides compare to summer months. As the weather gets warmer, riders take more rides.

Though usages of members are always high compare to the casual. It seems members use cyclisyics bikes to commute to their work.




**What is the total rides duration of both types of users based on the months of the year?**
![v8](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v8.png)



Comment: In case of total ride duration it can be seen that casual riders ride more in summer time that indicates using of bikes by casual riders for recreation in summer time. Whereas in winter months total ride hours for members are larger than that of casual riders.




**What is the average rides duration of both types of users based on the months of the year?**
![v9](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v9.png)


Comment: In considering the average ride duration casual riders are always clearly ahead of member riders.

***Using following DAX formual we will extract time value from started_at column and convert this value to text to generate our desired visulas***
```
TimeColumnText = FORMAT('fullyear1'[started_at], "HH:mm:ss")
```

**What are the peak hours for casual riders?**
![v11](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v11.png)

Comment: Chart above depicts that casual riders enjoy their rides most during afternoon time. That emphasises their use of bikes for recreational purposes.


**What are the peak hours for member riders?**
![v12](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v12.png)

Commnet: On the other hand usage patter of bikes by members throughout the day shows 2 peaks where one is around 8:00 o' clocl in the morning and other one is around 6:00 o' clock in the afternoon. Thus it can be inferred with confidence that most of the cyclistic's member use bikes for commuting to office & back to home.



**What are the mostly used starting stations for casual users?**
![v13](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v13.png)




**What are the mostly used starting stations for member riders?**
![v14](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v14.png)



**What are the mostly used ending stations for casual users?**
![v15](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v15.png)




**What are the mostly used ending stations for member riders?**
![v16](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v16.png)

**Note:**
For casual riders there are approximately 331K record where start_station_id and start_station_name are missing. For member riders this number is approximately 538K. This is also the case for end_station_id and end_station_name. To determine top station uses accurately, these data are needed.


**Which bikes are preferred by the users?**
![v17](https://github.com/towhidrazu/Cyclistic_Bike_Share/blob/main/v17.png)

Comment:Classic bikes are mostly used bikes followed by electric bikes. Docked bikes are least popular among users where very few are used by casula riders and there's no member user for docked bikes.

### Key findings:

* Casual riders comprises 37% (2.08 million) of the total ride.
* On average casual riders take longer ride (20.62 minutes) than member (12.08 minutes) riders.
* Members are more active on weekdays (Monday to Friday) and less active on weekend. Whereas casual riders are more active on weekends.
* Seasons have a huge impact on overall ride taking. Where as the temperature drops less riders are seen and vice versa. Thoug members are seen mentionably in winter season.
* Summer months are very popular to casual riders.
* Starting from midday peak hour of using cyclistic's bikes by casual riders are around 6:00pm.
* Members have 2 significant spikes of using bikes. Around 8:00an in morning and around 6:00pm in afternoon. Those says they use bikes more for commuting to office & back to home.
* Most popular startings and ending stations for casual riders are Streeter Dr & Grand Ave, DuSable Lake Shore Dr and Michigan Ave & Oak St.
* Most popular startings and ending stations for members are Kingsbury St & Kinzie St, Clark St & Elm St and Clinton St & Washington Blvd.
* Top used bikes are classic bikes followed by electric bikes. Docked bikes are least popular with mearly no use by members riders.


## Step 6: Act

[Back to top](#introduction)

This step will be carried out by the Cyclistic's executive team, Director of Marketing Lily Moreno based on the analysis of me and Marketing Analytics team.

### My recommendations based on my analysis:

1. Customized ads can be made targeting casual rides stating the benefits of being a member. Place to post those ads can be top starting and ending stations used by casual riders.
2. Special discount can be offered 
3. c
4. d
