select * from rides limit 1000;
select * from stations limit 1000;
select * from users limit 1000;

-- count of rows per table 
select
	(select count(*) from rides ),
	(select count(*) from stations ),
	(select count(*) from users  );
    
-- check missing value 
select
sum(ride_id is null) as null_ride_ids,
sum(user_id is null) as null_user_id,
sum(start_station_id is null) as null_start_id,
sum(end_station_id is null) as null_end_id,
sum(start_time is null) as null_start_time,
sum(end_time is null) as null_end_time,
sum(distance_km is null) as null_distance
from rides;

-- set đinh dang 
alter table rides
modify column start_time datetime,
modify column end_time Datetime ;

-- summary statistics for the ride 
select
max(distance_km) as max_dist,ride_idstart_timerides,
min(distance_km) as min_dist,
avg(distance_km) as avg_dist,
min(ABS(timestampdiff(minute,end_time,start_time))) as min_duration_min,
max(ABS(timestampdiff(minute,end_time,start_time))) as max_duration_min,
avg(ABS(timestampdiff(minute,end_time,start_time))) as avg_duration_min

from rides;

-- checking for false starts for the rides

select
Count(Case when (timestampdiff(minute,start_time,end_time)) < 2 then 1 end ) as short_trips ,
count(case when distance_km = 0 then 1 end) as zero_dist_trips
from rides;

-- different membership
select 
membership_level,
count(r.ride_id) as total_ride,
avg(r.distance_km) as avg_dist,
avg(ABS(timestampdiff(minute,r.end_time,r.start_time))) as avg_duration_min
from rides as r
join users as u on r.user_id = u.user_id
group by u.membership_level
order by 2 desc;

-- peak hours
select
extract(hour from start_time) as hour_of_day,
count(*) as ride_count
from rides
group by 1 
order by 2 desc;

-- check for popular station
select 
s.station_name,
count(r.ride_id) as total_ride
from rides as r
join stations as s on r.start_station_id = s.station_id
group by s.station_name
order by 2 desc
limit 10;

-- categorizing rides 
select 
case
when timestampdiff(minute,start_time,end_time) <=10 then 'short' -- 0-10minute
when timestampdiff(minute,start_time,end_time) between 10 and 30 then 'medium'
when timestampdiff(minute,start_time,end_time) >=30 then 'long' 
end as ride_category,
count(*) as total_ride 
from rides
group by 1 ;


-- net flow for each station

with departures as (
select 
start_station_id ,
count(*) as total_departures
from rides 
group by 1),

arrivals as (
select 
end_station_id,
count(*) as total_arrivals
from rides
group by 1 )

select
s.station_name,
d.total_departures,
a.total_arrivals,
(d.total_departures - a.total_arrivals) as net_flow

from stations as s 
join departures as d on s.station_id = d.start_station_id
join arrivals as a on s.station_id = a.end_station_id
order by net_flow asc;

-- user retention
with monthly_signups as(
select date_format(created_at,'%Y-%m-01') as signup_month,
count(user_id) as new_user_count
from users 
group by 1)


select 
signup_month,
new_user_count,
ifnull(lag(new_user_count) over (order by signup_month),0),
round(((new_user_count - ifnull(lag(new_user_count)  over (order by signup_month),0)) / 
nullif((lag(new_user_count) over (order by signup_month)),0) ) *100,2) as mon_growth
from monthly_signups;