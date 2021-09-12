1126_Active_Businesses.sql

Table: Events

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| business_id   | int     |
| event_type    | varchar |
| occurences    | int     | 
+---------------+---------+
(business_id, event_type) is the primary key of this table.
Each row in the table logs the info that an event of some type occured at some business for a number of times.
 

Write an SQL query to find all active businesses.

An active business is a business that has more than one event type with occurences greater than the average occurences of that event type among all businesses.

The query result format is in the following example:

Events table:
+-------------+------------+------------+
| business_id | event_type | occurences |
+-------------+------------+------------+
| 1           | reviews    | 7          |
| 3           | reviews    | 3          |
| 1           | ads        | 11         |
| 2           | ads        | 7          |
| 3           | ads        | 6          |
| 1           | page views | 3          |
| 2           | page views | 12         |
+-------------+------------+------------+

Result table:
+-------------+
| business_id |
+-------------+
| 1           |
+-------------+ 
Average for 'reviews', 'ads' and 'page views' are (7+3)/2=5, (11+7+6)/3=8, (3+12)/2=7.5 respectively.
Business with id 1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8) so it is an active business.



===========================================================================================================================


select e.business_id
from events e left join 
(select
event_type, avg(occurences) as average
from events
group by event_type) as t on t.event_type=e.event_type

where e.occurences>t.average
group by e.business_id
having count(*)>1








with t as (
select
*,
avg(occurences) over (partition by event_type) as avg_occurence ,
case when occurences>
          avg(occurences) over (partition by event_type) then "above"
     when  occurences<
          avg(occurences) over (partition by event_type) then "below"
     else "same"
end as flag
from events)

select
t.business_id
from t
group by business_id
having sum(t.flag="above")>1








-- Solution 1: Window Function, Subquery, CASE WHEN
-- calculate average occurences of event types amont all business
WITH tb1 AS (
    SELECT *,
        AVG(occurences*1.0) OVER (PARTITION BY event_type) AS avg_oc
    FROM Events
)

SELECT business_id
FROM tb1
GROUP BY business_id
-- count number of event types of a business with occurences 
-- greater than the average occurences of that event type among all businesses
HAVING SUM(CASE WHEN occurences > avg_oc THEN 1 ELSE 0 END) > 1;









# Most votes
select business_id                                     
from
(select event_type, avg(occurences) as ave_occurences  
 from events as e1
 group by event_type
) as temp1
right join events as e2 on temp1.event_type = e2.event_type   
where e2.occurences > temp1.ave_occurences            
group by business_id
having count(distinct temp1.event_type) > 1 # distinct good

# 二刷
select e.business_id
from events e left join 
(select
event_type, avg(occurences) as average
from events
group by event_type) as t on t.event_type=e.event_type

where e.occurences>t.average
group by e.business_id
having count(*)>1