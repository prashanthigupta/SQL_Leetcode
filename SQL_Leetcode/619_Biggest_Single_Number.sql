619_Biggest_Single_Number.sql

Table my_numbers contains many numbers in column num including duplicated ones.
Can you write a SQL query to find the biggest number, which only appears once.

+---+
|num|
+---+
| 8 |
| 8 |
| 3 |
| 3 |
| 1 |
| 4 |
| 5 |
| 6 | 
For the sample data above, your query should return the following result:
+---+
|num|
+---+
| 6 |
Note:
If there is no such number, just output null.
 

==================================================================================================================

select
max(t.num) as num

from (
		select
		num, count(num)
		from my_numbers
		group by num
		having count(num)=1
		order by num desc
  ) as t






# Way 1
select(
  select num
  from my_numbers
  group by num
  having count(*) = 1
  order by num desc 
  limit 1
) as num;

# Way 2
SELECT IF(COUNT(*) = 1, num, null) AS num 
FROM my_numbers
GROUP BY num
ORDER BY num DESC 
LIMIT 1;