571_Find_Median_Given_Frequency_of_Numbers.sql

The Numbers table keeps the value of number and its frequency.

+----------+-------------+
|  Number  |  Frequency  |
+----------+-------------|
|  0       |  7          |
|  1       |  1          |
|  2       |  3          |
|  3       |  1          |
+----------+-------------+
In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.

+--------+
| median |
+--------|
| 0.0000 |
+--------+
Write a query to find the median of all numbers and name the result as median.

============================================================================================

# Median选判条件
select
    avg(temp.number) as median

from

(select number, 
  sum(Frequency) over(order by number) as ac,
  sum(Frequency) over(order by number desc) as dc,
  sum(Frequency) over() as t
from numbers ) as temp

where temp.ac >=t/2 and temp.dc >=t/2


select  avg(n.Number) as median
from Numbers n
where n.Frequency >= 
       abs((select sum(Frequency) from Numbers where Number<=n.Number) -
              (select sum(Frequency) from Numbers where Number>=n.Number))



WITH tb1 AS (
    SELECT *, 
      -- There are cum_num numbers in TABLE numbers less than or equal to 
      -- number in that record
      -- e.g. There are cum_num = 8 numbers in TABLE numbers less than or 
      -- equal to 1
      -- so you will see [1,1,8,12] AS [Number, Frequency, cum_num, num]
        SUM(frequency) OVER (ORDER BY number) AS cum_num,
        SUM(frequency) OVER () AS num
    FROM numbers
)

SELECT AVG(number*1.0) AS median
FROM tb1
WHERE num / 2.0 BETWEEN cum_num - frequency AND cum_num;