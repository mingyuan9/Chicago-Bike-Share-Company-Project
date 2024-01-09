# Chicago-Bike-Share-Company-Project

## Introduction ##
This project is a part of Google Data Analytics case study, and the data keeps updated periodically by the provider.
Cyclistic is a bike-share company in Chicago. In 2016, the company launched a successful bike-share offering with 
5,824 bicycles and 692 docking stations. They primarily provides 3 types of bikes: classic, electric and docked bikes. 
The director of the marketing team wants to maximize company's profit by converting more casual riders to members. 

## Goal ##
My goal is to design a new marketing campaign to convert riders into annual subscription by providing actionable recommendations,
backed up with compelling data and data visualizations.
Casual riders are defined as customers who purchased a single-ride or a full-day pass
Annual members are defined as customers who purchased annual memberships

In order to design a marketing strategy to convert more casual users, it's important to ask:
1. How does user behavior differentiate between casual riders and members?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become annual members?

## Data Source ##
Motivate International Inc. provides with the data and is available under this [license](https://divvybikes.com/data-license-agreement).
The data used for analysis is sourced from Cyclistic's bike trip records and I selected data from Jan 2023 until Jun 2023 (6 Months) for my analysis
to better understand trend and user difference. 
Each dataset includes the following 13 fields:
ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual

## Data and Data Privacy ##
1. **Riliability and Originality**: The data provided is internal data from the company and is owned by the City available to the public, and also there's a huge sample
   data with more than 5 million trips per year. So this should be original and reliable source of data.
2. **Comprehensiveness**: In each dataset, it includes information about ride_id for each trip, ride timestamp(start & end), station name (start & end), geographic data including latitude and longitude of each ride, and user status(member or casual)
3. **Current**: The data is continuous to updata monthly
4. **Cited**: Yes

## Procedures ##
1. **Data Wrangling**   (See my code [here](https://github.com/mingyuan9/Chicago-Bike-Share-Company-Project/blob/main/Data_Wrangling.sql))
   - Filter out **invalid entries** that started_at later than or equal to ended_at, and delete entries from the dataset
   - Create two columns: `duration` represents the length of each ride; `day_of_week` represents which day of week the ride happens
   - Filter out bike duration greater than 12 hours, it might cause by forgetting to lock the bikes accidently
   - Format data by trimming lag/lng data whitespaces at the beginning and at the end, and round lag/lng to 6 decimals since it's good enough to see a person
   - Finally, I created a view, `formatted_bike_data`, with rides under 12 hours, and with correct data format   
2. **Data Analysis**    (See my code [here]())

   For this project, we aim to find out what makes casual users want to become an annual member. We're going to study user behavior between casual users and annual members.
   I'll try to answer questions like:
   - What's the different between ride duration between casual riders and members?
   - Is there any seanality trend for the first half of year between casual riders and annual members? by month? by day of week? by hour?
   - What's the user habits to use 3 different types of bikes between casual and annual members?
   - Where's the most busy station?

## Data Visualization ##
After conducting a thorough analysis of the bike-sharing data, a notable trend emerges: **annual members** constitute the majority of rides, accounting for a substantial **67%**. In contrast, **casual users** represent a smaller share, contributing only **32%** of the total rides. 

The figure below shows the **total number of rides** carried out by Cyclistic members and casual riders of the first half year in 2023.
![Total Trips by Member Type](https://github.com/mingyuan9/Chicago-Bike-Share-Company-Project/blob/main/1.Rides_by_member.png)

To learn more about differences between casual riders and annual riders, I want to know how long usually a ride is for the two types of users.
This below figure shows casual riders’ average trip length is more than annual member rides
![avg ride length](https://github.com/mingyuan9/Chicago-Bike-Share-Company-Project/blob/main/2.Avg_ride_length.png)

Next, I want to understand seanality effects on both casual riders and annual members.

