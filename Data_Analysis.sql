-- Analysis

-- 1.1 To get a better idea of difference between causal and anuual members, I would like to know how many rides contributed by annual riders and casual riders, respectively

SELECT member_casual,
              COUNT(ride_id) AS num_rides
FROM formatted_bike_data
GROUP BY 1

-- 2.1 Is there any seasonality in bike share? I would like to see the monthly trend of rides.

SELECT member_casual,
              COUNT(CASE month WHEN '01' THEN 1 ELSE NULL END) AS Jan_rides,
              COUNT(CASE month WHEN '02' THEN 1 ELSE NULL END) AS Feb_rides,
              COUNT(CASE month WHEN '03' THEN 1 ELSE NULL END) AS Mar_rides,
              COUNT(CASE month WHEN '04' THEN 1 ELSE NULL END) AS Apr_rides,
              COUNT(CASE month WHEN '05' THEN 1 ELSE NULL END) AS May_rides,
              COUNT(CASE month WHEN '06' THEN 1 ELSE NULL END) AS Jun_rides
FROM
(
    SELECT DISTINCT id,
                   ride_id,
                   strftime('%m', started_at) as month, -- Hint: return TEXT
                   member_casual
    FROM formatted_bike_data
) monthly_rides
GROUP BY 1

-- Finding:  For the first half of the year, the peak month of rides for  both casual and member is June
-- Probably because the weather is getting better, num of rides is growing up

-- 2.2 Rides trend by day of week analysis
SELECT member_casual,
               COUNT(CASE day_of_week WHEN 'Mon'  THEN 1 ELSE NULL END) AS Mon_rides,
               COUNT(CASE day_of_week WHEN 'Tues'  THEN 1 ELSE NULL END) AS Tues_rides,
               COUNT(CASE day_of_week WHEN 'Wed'  THEN 1 ELSE NULL END) AS Wed_rides,
               COUNT(CASE day_of_week WHEN 'Thur'  THEN 1 ELSE NULL END) AS Thur_rides,
               COUNT(CASE day_of_week WHEN 'Fri'  THEN 1 ELSE NULL END) AS Fri_rides,
               COUNT(CASE day_of_week WHEN 'Sat'  THEN 1 ELSE NULL END) AS Sat_rides,
               COUNT(CASE day_of_week WHEN 'Sun'  THEN 1 ELSE NULL END) AS Sun_rides
FROM 
           (SELECT id, 
                           ride_id,
                           started_at,
                           CASE cast(STRFTIME('%w',started_at) as interger) 
                           WHEN 0 THEN 'Sun'
                           WHEN 1 THEN 'Mon'
                           WHEN 2 THEN 'Tues'
                           WHEN 3 THEN 'Wed'
                           WHEN 4 THEN 'Thur'
                           WHEN 5 THEN 'Fri'
                           ELSE 'Sat' END AS Day_of_Week,  -- new column
                           member_casual
           FROM formatted_bike_data) ride_on_day_of_week
GROUP BY 1

/*Finding: 
 Annual members tends to ride more on Tues, Wed, and Thur, and it could because majority companies have a hybrid work schedule, usually 3 days work from the office and 2 days wfh.
 While, casual members have more rides on weekends than weekdays.*/

-- 2.3 Rides trend by hour
SELECT DISTINCT STRFTIME('%H', started_at) AS Hour,
               COUNT(CASE member_casual WHEN 'casual'     THEN 1 ELSE NULL END) AS casual,
               COUNT(CASE member_casual WHEN 'member'  THEN 1 ELSE NULL END) AS member
FROM formatted_bike_data
GROUP BY 1
ORDER BY 1

/*Peak hours of annual member to use bikes are from 8am-9am in the morning , and 17pm-19pm in the afternoon
Peak hours of casual member to use bikes are from 11am-12pm in the morning, and 17pm-18pm in the afternoon*/


--  3. Then, I wanna know the mean of duration, max duration, and the mode of  day_of_week

SELECT  member_casual,
                ROUND(avg(duration_mins),2) as mean_duration_mins
FROM 
            (
            SELECT  id,
                             ride_id,
                            (STRFTIME('%s',ended_at)-STRFTIME('%s',started_at))/60 as duration_mins,
                            member_casual
            FROM formatted_bike_data
            ) ride_length
GROUP BY 1

/*Finding: We can see that casual riders' average trip length is more than  annual member rides.
Casual riders' avg ride length is around 18.49 mins, while members' avg ride  length is about 10.95 mins*/


-- 4.  What's the difference  in terms of bike types between casual riders and members?
SELECT rideable_type,
               COUNT(CASE member_casual WHEN 'casual'  THEN 1 ELSE NULL END) AS Casual,
               COUNT(CASE member_casual WHEN 'member' THEN 1 ELSE NULL END) AS Member
FROM formatted_bike_data
GROUP BY 1

-- Finding: The electric_bike is the preferred bike by both annual and casual riders, followed by classic_bike
-- Surprisingly,  docked_bikes are exclusively used by casual riders, and no annual member used it for the 1st half year
