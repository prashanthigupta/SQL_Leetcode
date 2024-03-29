1435_Create_a_Session_Bar_Chart.sql

Table: Sessions

+---------------------+---------+
| Column Name         | Type    |
+---------------------+---------+
| session_id          | int     |
| duration            | int     |
+---------------------+---------+
session_id is the primary key for this table.
duration is the time in seconds that a user has visited the application.
 

You want to know how long a user visits your application. You decided to create bins of "[0-5>", "[5-10>", "[10-15>" and "15 minutes or more" and count the number of sessions on it.

Write an SQL query to report the (bin, total) in any order.

The query result format is in the following example.

Sessions table:
+-------------+---------------+
| session_id  | duration      |
+-------------+---------------+
| 1           | 30            |
| 2           | 199           |
| 3           | 299           |
| 4           | 580           |
| 5           | 1000          |
+-------------+---------------+

Result table:
+--------------+--------------+
| bin          | total        |
+--------------+--------------+
| [0-5>        | 3            |
| [5-10>       | 1            |
| [10-15>      | 0            |
| 15 or more   | 1            |
+--------------+--------------+

For session_id 1, 2 and 3 have a duration greater or equal than 0 minutes and less than 5 minutes.
For session_id 4 has a duration greater or equal than 5 minutes and less than 10 minutes.
There are no session with a duration greater or equial than 10 minutes and less than 15 minutes.
For session_id 5 has a duration greater or equal than 15 minutes.



================================================================================================================
# Method 1
with t1 as (
select
*,
case when duration/60>=0 and duration/60<5 then "[0-5>"
     when duration/60>=5 and duration/60<10 then "[5-10>"
     when duration/60>=10 and duration/60<15 then "[10-15>"
     else "15 or more" end as bin
from sessions ),

t2 as (
SELECT '[0-5>' AS bin
     UNION ALL
     SELECT '[5-10>' AS bin
     UNION ALL
     SELECT '[10-15>' AS bin
     UNION ALL
     SELECT '15 or more' AS bin )
     
select
t2.bin, count(t1.session_id) as total
from t2 left join t1 on t1.bin=t2.bin
group by t2.bin

# Method 2
SELECT b.bin, IFNULL(COUNT(s.session_id),0) AS total
FROM 
    (SELECT session_id, 
           CASE WHEN duration/60<5 THEN '[0-5>'
                WHEN duration/60>=5 AND duration/60<10 THEN '[5-10>'
                WHEN duration/60>=10 AND duration/60<15 THEN '[10-15>'
                ELSE '15 or more' END AS bin
    FROM sessions) s
RIGHT JOIN 
    (SELECT '[0-5>' AS bin
     UNION ALL
     SELECT '[5-10>' AS bin
     UNION ALL
     SELECT '[10-15>' AS bin
     UNION ALL
     SELECT '15 or more' AS bin) b
       ON b.bin=s.bin
GROUP BY b.bin









