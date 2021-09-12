1077_Project_Employees_III.sql

Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table.
 

Write an SQL query that reports the most experienced employees in each project. In case of a tie, report all employees with the maximum number of experience years.

The query result format is in the following example:

Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+

Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 3                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+

Result table:
+-------------+---------------+
| project_id  | employee_id   |
+-------------+---------------+
| 1           | 1             |
| 1           | 3             |
| 2           | 1             |
+-------------+---------------+
Both employees with id 1 and 3 have the most experience among the employees of the first project. 
For the second project, the employee with id 1 has the most experience.

=============================================================================================================================

# Where in
select
p2.project_id,
e2.employee_id

from project p2 
inner join employee e2 on e2.employee_id=p2.employee_id

where (p2.project_id, e2.experience_years) in 
			(select
			p.project_id, max(experience_years) as experience_years
			from project p inner join  employee e on e.employee_id = p.employee_id
			group by p.project_id)

# Window
select
t.project_id,
t.employee_id

from (
		select
		p.project_id,
		p.employee_id,
    dense_rank() over (partition by p.project_id 
											 order by e.experience_years desc) as r
		from project p 
		inner join employee e on e.employee_id = p.employee_id) as t

where t.r=1