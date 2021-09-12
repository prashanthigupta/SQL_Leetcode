1468_Calculate_Salaries.sql

Table Salaries:

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| company_id    | int     |
| employee_id   | int     |
| employee_name | varchar |
| salary        | int     |
+---------------+---------+
(company_id, employee_id) is the primary key for this table.
This table contains the company id, the id, the name and the salary for an employee.
 

Write an SQL query to find the salaries of the employees after applying taxes.

The tax rate is calculated for each company based on the following criteria:

0% If the max salary of any employee in the company is less than 1000$.
24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
49% If the max salary of any employee in the company is greater than 10000$.
Return the result table in any order. Round the salary to the nearest integer.

The query result format is in the following example:

Salaries table:
+------------+-------------+---------------+--------+
| company_id | employee_id | employee_name | salary |
+------------+-------------+---------------+--------+
| 1          | 1           | Tony          | 2000   |
| 1          | 2           | Pronub        | 21300  |
| 1          | 3           | Tyrrox        | 10800  |
| 2          | 1           | Pam           | 300    |
| 2          | 7           | Bassem        | 450    |
| 2          | 9           | Hermione      | 700    |
| 3          | 7           | Bocaben       | 100    |
| 3          | 2           | Ognjen        | 2200   |
| 3          | 13          | Nyancat       | 3300   |
| 3          | 15          | Morninngcat   | 7777   |
+------------+-------------+---------------+--------+

Result table:
+------------+-------------+---------------+--------+
| company_id | employee_id | employee_name | salary |
+------------+-------------+---------------+--------+
| 1          | 1           | Tony          | 1020   |
| 1          | 2           | Pronub        | 10863  |
| 1          | 3           | Tyrrox        | 5508   |
| 2          | 1           | Pam           | 300    |
| 2          | 7           | Bassem        | 450    |
| 2          | 9           | Hermione      | 700    |
| 3          | 7           | Bocaben       | 76     |
| 3          | 2           | Ognjen        | 1672   |
| 3          | 13          | Nyancat       | 2508   |
| 3          | 15          | Morninngcat   | 5911   |
+------------+-------------+---------------+--------+
For company 1, Max salary is 21300. Employees in company 1 have taxes = 49%
For company 2, Max salary is 700. Employees in company 2 have taxes = 0%
For company 3, Max salary is 7777. Employees in company 3 have taxes = 24%
The salary after taxes = salary - (taxes percentage / 100) * salary
For example, Salary for Morninngcat (3, 15) after taxes = 7777 - 7777 * (24 / 100) = 7777 - 1866.48 = 5910.52, which is rounded to 5911.




===================================================================================================================

with new as (
select
*,
case when max(salary) over (partition by company_id) < 1000 then 0
     when max(salary) over (partition by company_id) between 1000 and 10000
          then 0.24
     else 0.49
end as rate

from salaries)

select
company_id, employee_id, employee_name,
round(salary - salary * (rate)) as salary

from new














# window
select 
company_id, employee_id, employee_name,
round(
    case when max(salary) over(partition by company_id) 
              between 1000 and 10000                 
              then salary * 0.76
         when max(salary) over(partition by company_id) 
              > 10000 
              then salary * 0.51 
         else salary 
    end
    ,0) as salary
from salaries

# subquery
select s2.company_id, s2.employee_id, s2.employee_name,
       round((s2.salary-s2.salary*temp.tax) ,0) as salary
from salaries s2
left join 
(select s.company_id as id,
   (case when max(s.salary)<1000 then 0
        when max(s.salary) between 1000 and 10000 then 0.24
        else 0.49
   end) as tax
from salaries s
group by s.company_id) as temp
on s2.company_id=temp.id