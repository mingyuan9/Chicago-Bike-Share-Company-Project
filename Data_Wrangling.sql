--  1. First of all, I select total count of records in each month to double check if it's consistent with the count number in the excel sheet.
SELECT STRFTIME('%m', started_at) as Month,
                COUNT(*) as Total_count
FROM bike_data
GROUP BY 1

-- Perfect! The result was exactly what we want and matched with our data in the excel.

/*2. I'm checking the validity  of data
For example, if for some ride_ids, started_at time is greater than or equal to ended_at time, 
it could happen because people changed their mind and don't want to bike any more, or could be the
bike is not working so that people change to another bike, and then the data entry doesn't make sense and it's not valid.
And we want to exclude these entries when analyzing data*/

SELECT COUNT(*) as invalid_entries
FROM
(     
    SELECT *
    FROM bike_data
    WHERE started_at >= ended_at
) invalid_data

-- So, we have 216 data entries that are invalid and should be exclude from our dataset.

/*3. Other factors make data invalid could be ride length is abnormaly long.
Usually the duration of a bike marathon range from 3 to 7 hours, so we exclude data if ride lenth is over 7 hours (420 mins), 
 which could be someone forgot to lock the bike or could be system issues*/
SELECT COUNT(*) AS ride_overtime_count
FROM  
(
    SELECT 
           DISTINCT ride_id,
           (STRFTIME('%s',ended_at)-STRFTIME('%s',started_at))/60 as duration_mins
           FROM bike_data
           WHERE duration_mins >= 420
) ride_overtime   --We found 4208 rides are invalid because it's barely possible that an ordinary person could ride over 7 hours without professional training.


--4. I wanna explore more about data. How many types of bike? Any Null values there?
SELECT DISTINCT rideable_type
FROM bike_data

-- So we have 3 types: electric, classic, and docked bikes

--5. How many types of membership?
SELECT DISTINCT member_casual
FROM bike_data

-- Cool, we only have 2 types of users: member, and casual

-- 6. So here, I wanna create a new view that exclude invalid data (abnormal ride length and invalid started_at time)
SELECT COUNT(*) as invalid_count  -- 4424 invalid data, which is consistent with previous result (4208 + 216)
FROM
        (
SELECT id,
               ride_id,
               rideable_type,
               started_at,
               ended_at,
               start_station_name,
               start_station_id,
               end_station_name,
               end_station_id,
               start_lat,
               start_lng,
               end_lat,
               end_lng,
               member_casual
FROM bike_data
WHERE started_at >= ended_at
              OR (STRFTIME('%s',ended_at)-STRFTIME('%s',started_at))/60 >= 420
              ) invalid_data

-- Create a view: formatted_bike_data       
CREATE VIEW formatted_bike_data AS
SELECT *
FROM
        (
SELECT id,
               ride_id,
               rideable_type,
               started_at,
               ended_at,
               start_station_name,
               start_station_id,
               end_station_name,
               end_station_id,
               start_lat,
               start_lng,
               end_lat,
               end_lng,
               member_casual
FROM bike_data
WHERE started_at < ended_at 
                AND (STRFTIME('%s',ended_at)-STRFTIME('%s',started_at))/60 < 420
              ) valid_data

-- Our later on analysis would based on formatted  dataset.
