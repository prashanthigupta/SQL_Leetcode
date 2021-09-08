
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



