==========================================================================================
Amazon 分享的SQL题目
==========================================================================================
Order_History table has two columns: 
CustomerID(varchar), Purchase_Date(date). 
it has order information for all customers since 2010.


Q: return a list of CustomerIDs that purchase products EVERY YEAR between 2010 and 2015

select
customer_id

from (
select
	customerId, 
	year(Purchase_Date) as y,
	count(id)

from Order_History
where year(Purchase_Date) between 2010 and 2015
group by customerId, year(Purchase_Date)
)

group by customer_id
having count(y)=5

1, 2010,xx
1, 2011,
2, 2010,
2, 2011,
2, 2012,
2, 2013
2, 2014
2, 2015

=========================================================================================
Verkada SQL
=========================================================================================
Table 1: customers
ID | first_name | last_name | company

Table 2: touchpoints
ID | timestamp | event_type | value | customer_id

* Q1: count number of customers by length of the company name

select
    length(company) as length_of_company_name,
    count(id) as num_of_customers

from customers 
group by length(company)


* Q2: count cumulative number of touchpoints by date for customers with large company names.
large: company name length>6

with t1 as (

select
   timestamp,
   count(id) as counts_of_touchpoints
from touchpoints
group by timestamp

)

select
 t1.timestamp,
 sum(t1.counts_of_touchpoints) over (order by t1.timestamp) as cumulative_touchpoints

from t1

                            Cumulative
Monday: 10 touchpoints      10
Tuesdays: 15                25
Wed: 11                     36
Thu: 1                      37

==========================================================================================
Metromile SQL  20210909
==========================================================================================
/*
CoderPad provides a basic SQL sandbox with the following schema.
You can also use commands like `show tables` and `desc employees`

employees                             projects
+---------------+---------+           +---------------+---------+
| id            | int     |<----+  +->| id            | int     |
| first_name    | varchar |     |  |  | title         | varchar |
| last_name     | varchar |     |  |  | start_date    | date    |
| salary        | int     |     |  |  | end_date      | date    |
| department_id | int     |--+  |  |  | budget        | int     |
+---------------+---------+  |  |  |  +---------------+---------+
                             |  |  |
departments                  |  |  |  employees_projects
+---------------+---------+  |  |  |  +---------------+---------+
| id            | int     |<-+  |  +--| project_id    | int     |
| name          | varchar |     +-----| employee_id   | int     |
+---------------+---------+           +---------------+---------+
*/


* What is the total salary for each department (please include department names)?

select 
     d.name,
     ifnull(sum(e.salary),0) as total_salary

from departments d
left join employees e on e.department_id = d.id
group by d.id;

* Who (first name, last name) earns the highest salary in the Marketing department?

select
 id
 from departments
 where name="Marketing"

 select
    t.first_name,
    t.last_name
 from

 (select
    e.first_name,
    e.last_name,
    e.salary,
    dense_rank() over (order by e.salary desc) as sorted 
 from employees e
 where e.department_id=3 # MKT
 )  as t
 where t.sorted=1

* Who (first_name, last_name)  has the highest salary for each department 
(please include department names)?

 select
    t.first_name,
    t.last_name,
    t.name as 
 from 
 (
  select
     e.first_name,
     e.last_name,
     e.salary,
     d.name,
     dense_rank() over (partition by e.department_id order by salary desc) as sorted
 from employees e
 join departments d on d.id = e.department_id
 ) as t

 where t.sorted=1

* Which employees are not allocated to any projects?

  select
     e.id 

 from employees e
 where e.id not in 
 (select
    distinct ep.employee_id
 from employees_projects ep)

* Which projects are the most under budget?
select
    p.id,
   sum(e.salary) as actual_use,
    p.budget,
    p.budget /sum(e.salary) as Use_percentage

from projects p
join employees_projects ep on ep.project_id = p.id
left join employees e on e.id = ep.employee_id

group by p.id;






















