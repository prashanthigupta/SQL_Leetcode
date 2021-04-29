1699_Number_of_Calls_Between_Two_Persons.sql

Table: Calls

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| from_id     | int     |
| to_id       | int     |
| duration    | int     |
+-------------+---------+
This table does not have a primary key, it may contain duplicates.
This table contains the duration of a phone call between from_id and to_id.
from_id != to_id
 

Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.

Return the result table in any order.

The query result format is in the following example:

 

Calls table:
+---------+-------+----------+
| from_id | to_id | duration |
+---------+-------+----------+
| 1       | 2     | 59       |
| 2       | 1     | 11       |
| 1       | 3     | 20       |
| 3       | 4     | 100      |
| 3       | 4     | 200      |
| 3       | 4     | 200      |
| 4       | 3     | 499      |
+---------+-------+----------+

Result table:
+---------+---------+------------+----------------+
| person1 | person2 | call_count | total_duration |
+---------+---------+------------+----------------+
| 1       | 2       | 2          | 70             |
| 1       | 3       | 1          | 20             |
| 3       | 4       | 4          | 999            |
+---------+---------+------------+----------------+
Users 1 and 2 had 2 calls and the total duration is 70 (59 + 11).
Users 1 and 3 had 1 call and the total duration is 20.
Users 3 and 4 had 4 calls and the total duration is 999 (100 + 200 + 200 + 499).



================================================================================================
# Method 1
WITH CTE AS (
    SELECT to_id as person1, from_id as person2, duration
    FROM Calls
    WHERE from_id > to_id 
    UNION ALL
    SELECT from_id as person1, to_id as person2, duration
    FROM Calls
    WHERE from_id < to_id)

SELECT 
person1, 
person2, 
COUNT(person1) as call_count , 
SUM(duration) as total_duration 
FROM CTE
GROUP BY person1, person2

# Method 2
SELECT 
LEAST(from_id,to_id) as person1,
GREATEST(from_id,to_id) as person2,
COUNT(*) as call_count,
SUM(duration) as total_duration

FROM Calls
GROUP BY person1,person2











WITH CTE AS (
    SELECT to_id person1, from_id person2, duration
    FROM Calls
    WHERE from_id > to_id 
    UNION ALL
    SELECT from_id person1, to_id person2, duration
    FROM Calls
    WHERE from_id < to_id)

SELECT person1, person2, COUNT(person1) call_count , SUM(duration) total_duration 
FROM CTE
GROUP BY person1, person2


select
*,
 case when from_id>to_id then 1
      else 0 end as flag
from calls),

 t2 as(
select
t.to_id as from_id, t.from_id as to_id, t.duration
from t
where flag=1),

t3 as (
select *
from t2
union all
select
t.from_id, t.to_id, t.duration
from t
where t.flag=0)

select
from_id as person1, to_id as person2, count(duration) as call_count,
sum(duration) as total_duration
from t3
group by from_id, to_id