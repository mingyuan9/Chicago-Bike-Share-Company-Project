# Chicago-Bike-Share-Company-Project

## Introduction ##
This project is a part of Google Data Analytics case study, and the data keeps updated periodically by the provider.
Cyclistic is a bike-share company in Chicago. In 2016, the company launched a successful bike-share offering with more than 
5,800 bicycles and 600 docking stations. 

## Goal ##
The director of the marketing team wants to maximize company's profit by converting more casual riders to members. 
My goal is to design a new marketing campaign to convert riders into annual subscription by providing actionable recommendations,
backed up with compelling data and data visualizations.

In order to design a marketing strategy to convert more casual users, it's important to ask:
1. How does user behavior differentiate between casual riders and members?
2. Why would casual riders by Cyclistic annual memberships
3. How can Cyclistic use digital media to influence casual riders to become annual members?

## Data Source ##
Motivate International Inc provides with the data and is available under this [license](https://divvybikes.com/data-license-agreement).
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
   - Filter out **invalid entries** that started_at later than or equal to ended_at, and I would delete entries from the dataset
   - Filter out bike duration greater than 12 hours, it might cause by forgetting to lock the bikes accidently
   - Format data by trimming lag/lng data whitespaces at the beginning and at the end, and round lag/lng to 6 decimals since it's good enough to see a person
   - Finally, I created a view, `formatted_bike_data`, with rides under 12 hours, and with correct data format   
2. **Data Analysis**
