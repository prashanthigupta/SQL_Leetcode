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























