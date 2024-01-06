-- 1. first, I'm wondering is there any invalid data, for example, bike started_at is greater than or equal ended_date,
-- which means the user didn't even ride a bike or there's a system issue with datetime.

SELECT COUNT(*)
FROM
(     
    SELECT *
    FROM bike_data
    WHERE started_at >= ended_at
) invalid_data

-- 2. We've got 382 invalid records from our dataset, which we could delete those records
DELETE FROM bike_data
WHERE started_at >= ended_at

-- 3. To check if we successfully delete invalid data, we could run the first step query again
SELECT COUNT(*)
FROM
(     
    SELECT *
    FROM bike_data
    WHERE started_at >= ended_at
) invalid_data

-- The result above is 0, it seems we deleted invalid data successfully.

-- 4. Some other factors that I think is not useful for the analysis are bike duration too short or too long
-- for example, if bike duration is greater than 12 hour, it's probably because the user forgets to lock the bike 
SELECT member_casual,
       COUNT(*) AS users_w_unusual_ride
FROM
(SELECT id,
       ride_id,
       rideable_type,
       started_at,
       ended_at, 
      (STRFTIME('%s',ended_at)-STRFTIME('%s',started_at))/60 as duration_mins,
       member_casual
FROM bike_data
WHERE duration_mins >= 720) unusual_ride -- greater than 12 hour ride
GROUP BY 1

-- I found that 1911 casual users have unusual rides that more than 12 hrs, while only 499 users have abnormal rides.
-- I believe we should do data analysis exclude the data above. 

-- 5. As for start_lat, start_lng, end_lat, end,lng are float data, I wanna make sure they don't have whitespace at the beginning or at the end
SELECT start_lat,
       TRIM(ROUND(start_lat,6)),
       start_lng,
       TRIM(ROUND(start_lng,6)),
       end_lat,
       TRIM(ROUND(end_lat,6)),
       end_lng,
       TRIM(ROUND(end_lng,6))
FROM bike_data
LIMIT 10

-- 6.Updata dataset: update data of existing rows
UPDATE bike_data
SET start_lat = TRIM(ROUND(start_lat,6)),
    start_lng = TRIM(ROUND(start_lng,6)),
    end_lat = TRIM(ROUND(end_lat,6)),
    end_lng = TRIM(ROUND(end_lng,6))
    

-- 7. Create a data views that we could use for later analysis, only include rides under
CREATE VIEW formatted_bike_data AS
SELECT id,
       ride_id,
       rideable_type,
       started_at,
       ended_at,
       CASE cast(STRFTIME('%w',started_at) as interger) 
            WHEN 0 THEN 'Sun'
            WHEN 1 THEN 'Mon'
            WHEN 2 THEN 'Tues'
            WHEN 3 THEN 'Wed'
            WHEN 4 THEN 'Thur'
            WHEN 5 THEN 'Fri'
            ELSE 'Saturday' END AS Day_of_Week,  -- new column
       (STRFTIME('%s',ended_at)-STRFTIME('%s',started_at))/60 as duration_mins,
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
WHERE duration_mins < 720

