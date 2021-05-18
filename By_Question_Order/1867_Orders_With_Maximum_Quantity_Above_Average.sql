1867_Orders_With_Maximum_Quantity_Above_Average.sql

Table: OrdersDetails

+-------------+------+
| Column Name | Type |
+-------------+------+
| order_id    | int  |
| product_id  | int  |
| quantity    | int  |
+-------------+------+
(order_id, product_id) is the primary key for this table.
Each row of this table contains the quantity ordered of the product product_id in the order order_id.
A single order with k different products will appear as k separate rows in this table.
 

The average quantity of an order is calculated as (total quantity of products in the order) / (number of different products in the order). The maximum average quantity is the highest average quantity among all orders.

The maximum quantity of an order is the highest quantity of any product purchased in the order.

Write an SQL query to find the order_id of all orders whose maximum quantity is strictly greater than the maximum average quantity.

Return the result table in any order.

The query result format is in the following example:

 

OrdersDetails table:
+----------+------------+----------+
| order_id | product_id | quantity |
+----------+------------+----------+
| 1        | 1          | 12       |
| 1        | 2          | 10       |
| 1        | 3          | 15       |
| 2        | 1          | 8        |
| 2        | 4          | 4        |
| 2        | 5          | 6        |
| 3        | 3          | 5        |
| 3        | 4          | 18       |
| 4        | 5          | 2        |
| 4        | 6          | 8        |
| 5        | 7          | 9        |
| 5        | 8          | 9        |
| 3        | 9          | 20       |
| 2        | 9          | 4        |
+----------+------------+----------+

Result table:
+----------+
| order_id |
+----------+
| 1        |
| 3        |
+----------+

The average quantity of each order is:
- order_id=1: (12+10+15)/3 = 12.3333333
- order_id=2: (8+4+6+4)/4 = 5.5
- order_id=3: (5+18+20)/3 = 14.333333
- order_id=4: (2+8)/2 = 5
- order_id=5: (9+9)/2 = 9
The maximum average quantity is 14.333333

The maximum quantity of each order is:
- order_id=1: max(12, 10, 5) = 12
- order_id=2: max(8, 4, 6, 4) = 8
- order_id=3: max(5, 18, 20) = 20
- order_id=4: max(2, 8) = 8
- order_id=5: max(9, 9) = 9
Only orders 1 and 3 have a maximum quantity strictly greater than the maximum average quantity.

==================================================================================================
# Method 1: Window FUN
select
t.order_id
from 
(select
order_id,
# sum(quantity) / count(distinct product_id) as average_quantity,
max(quantity) as maximum_quantity,
max(avg(quantity)) over () as maxx
from ordersdetails 
group by order_id
) as t
where t.maximum_quantity> t.maxx


# Method 2: Subquery + Having 
SELECT order_id
FROM OrdersDetails
GROUP BY order_id
HAVING MAX(quantity) > (SELECT MAX(AVE_Q)
                        FROM (SELECT order_id,
                              SUM(quantity)/COUNT(DISTINCT product_id) AS AVE_Q
                             FROM OrdersDetails
                             GROUP BY order_id) A)