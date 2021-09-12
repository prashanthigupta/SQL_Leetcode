The Employee table holds all employees. Every employee has an Id, a salary, 
and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who have the highest salary in each of the departments. 
For the above tables, your SQL query should return the following rows (order of rows 
does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
Explanation:

Max and Jim both have the highest salary in the IT department and 
Henry has the highest salary in the Sales department.

================================================================================
# Method 1
select
temp.department,
temp.employee,
temp.salary

from (
		select
		d.name as department,
		e.name as employee,
		e.salary as salary,
		dense_rank() over (partition by e.departmentid order by e.salary desc) as r
		
		from employee e 
		join department d on e.departmentid= d.id
     ) as temp

where temp.r=1


# Method 2
## IT: 90000, 80000; Sales: 80000 then bug, so we need to include department id
select temp.name as department, e2.name as employee,e2.salary as salary
    from
    (select e.departmentid,d.name, max(e.salary) as ms from employee e
    inner join department d on d.id=e.departmentid
    group by e.departmentID, d.name) as temp

inner join employee e2 on e2.departmentid=temp.departmentid 
      and temp.ms=e2.salary

## window fun
select
t.department, t.employee, t.salary
from
(select
  d.name as department,
  e.name as employee,
  e.salary,
  max(e.salary) over (partition by e.departmentid) as r
from employee e
join department d on d.id=e.departmentid ) as t
where t.salary=t.r
