1731_The_Number_of_Employees_Which_Report_to_Each_Employee.sql

Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the primary key for this table.
This table contains information about the employees and 
the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write an SQL query to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.

The query result format is in the following example:


Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
+-------------+---------+------------+-----+
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |
+-------------+---------+------------+-----+

Result table:
+-------------+-------+---------------+-------------+
| employee_id | name  | reports_count | average_age |
+-------------+-------+---------------+-------------+
| 9           | Hercy | 2             | 39          |
+-------------+-------+---------------+-------------+
Hercy has 2 people report directly to him, Alice and Bob. 
Their average age is (41+36)/2 = 38.5, which is 39 after rounding it to the nearest integer.
============================================================================================
select
t.employee_id,
e2.name,
t.reports_count,
t.average_age

from 
	(select
	reports_to as employee_id, 
	count(reports_to) as reports_count,
	round(avg(age)) as average_age
	from employees 
	where reports_to is not null
	group by reports_to)  as t

left join employees e2 on e2.employee_id = t.employee_id
order by t.employee_id









# Self Join
SELECT 
    b.employee_id AS employee_id, 
    b.name AS name, 
    COUNT(*) AS reports_count, 
    ROUND(AVG(a.age)) AS average_age
FROM 
    Employees a JOIN Employees b ON a.reports_to = b.employee_id
GROUP BY 1
ORDER BY 1



