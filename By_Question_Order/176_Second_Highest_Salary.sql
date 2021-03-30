Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. 
If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

====================================================================================

-- Solution 1: Subquery
SELECT MAX(salary) AS secondhighestsalary
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee);

-- Solution 2: Window Function
SELECT AVG(salary) as SecondHighestSalary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) as r
    FROM employee
    ) tb1
WHERE r = 2;

-- Solution 3: 
select Salary as SecondHighestSalary 
from Employee
union 
select null
order by SecondHighestSalary desc # 这里变成salary好像就不行了
limit 1,1

-- Solution 4: OFFSET FETCH
SELECT (
    SELECT DISTINCT salary
    FROM employee
    ORDER BY salary DESC
    OFFSET 1 ROW
    FETCH NEXT 1 ROW ONLY
) AS SecondHighestSalary;
