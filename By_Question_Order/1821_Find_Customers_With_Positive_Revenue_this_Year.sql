1821_Find_Customers_With_Positive_Revenue_this_Year.sql

Table: Customers

+--------------+------+
| Column Name  | Type |
+--------------+------+
| customer_id  | int  |
| year         | int  |
| revenue      | int  |
+--------------+------+
(customer_id, year) is the primary key for this table.
This table contains the customer ID and the revenue of customers in different years.
Note that this revenue can be negative.
 

Write an SQL query to report the customers with postive revenue in the year 2021.

Return the result table in any order.

The query result format is in the following example:

 

Customers
+-------------+------+---------+
| customer_id | year | revenue |
+-------------+------+---------+
| 1           | 2018 | 50      |
| 1           | 2021 | 30      |
| 1           | 2020 | 70      |
| 2           | 2021 | -50     |
| 3           | 2018 | 10      |
| 3           | 2016 | 50      |
| 4           | 2021 | 20      |
+-------------+------+---------+

Result table:
+-------------+
| customer_id |
+-------------+
| 1           |
| 4           |
+-------------+

Customer 1 has revenue equal to 30 in year 2021.
Customer 2 has revenue equal to -50 in year 2021.
Customer 3 has no revenue in year 2021.
Customer 4 has revenue equal to 20 in year 2021.
Thus only customers 1 and 4 have postive revenue in year 2021.



========================================================================================
select
customer_id
from customers
where year=2021
group by customer_id
having sum(revenue)>0

# Seeing the example it is intuitive to think of using groupby and i used 
# the same but many solutions are not using 
# groupby so it made me think, and lead to this post to help others like me. 

# group by is not required as it is given in question customer_id and year 
# is a primary key 
# so there won't be multiple revenues of same customer for the year 2021 
# as it would lead to PRIMARY KEY constraint violation.
select
customer_id
from customers
where year=2021 and revenue>0 