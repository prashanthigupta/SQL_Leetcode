-- Question:
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id is the primary key for this table.
 

Write an SQL query to find all numbers that appear at least three times consecutively.

Return the result table in any order.

The query result format is in the following example:


Logs table:
+----+-----+
| Id | Num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+

Result table:
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
1 is the only number that appears consecutively for at least three times.

=============================================================================================
-- Solution: Join

select
distinct l1.num as ConsecutiveNums  
# distinct is very important 没有的话 如果有四个连续的数字就gg了

from logs l1 
join logs l2 on l1.id+1=l2.id
join logs l3 on l1.id+2=l3.id

where l1.num=l2.num and l2.num=l3.num

Example:
		  1a
	 1a 2b
1a 2b 3c
2b 3c 4c
3c 4c 5c
4c 5c
5c

-- Solution: Window Function
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT num,
        LEAD(num) OVER (ORDER BY id)  AS next,
        LAG(num) OVER (ORDER BY id)  AS prev
    FROM logs
    ) tb1
WHERE num = next AND next = prev;

