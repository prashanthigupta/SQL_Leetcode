183_Customers_Who_Never_Order.sql

Suppose that a website contains two tables, the Customers table and the Orders table.
Write a SQL query to find all customers who never order anything.

Table: Customers.

+----+-------+
| Id | Name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Table: Orders.

+----+------------+
| Id | CustomerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Using the above tables as example, return the following:

+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+

========================================================================================
##1 left join
   select 
   c.name as Customers
   from customers c
   left join orders o on o.customerid=c.id
   where o.id is null

##2 not in subquary
    select Name as Customers
    from Customers
    where Id not in (select CustomerId from Orders)







