603_Consecutive_Available_Seats.sql

Several friends at a cinema ticket office would like to reserve consecutive available seats.
Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
| seat_id | free |
|---------|------|
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
 

Your query should return the following result for the sample case above.
 

| seat_id |
|---------|
| 3       |
| 4       |
| 5       |
Note:
The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
Consecutive available seats are more than 2(inclusive) seats consecutively available.

==========================================================================================================================

select distinct a.seat_id
from cinema a
inner join cinema b
on abs(a.seat_id - b.seat_id) = 1
and a.free=true and b.free=true
order by a.seat_id;



-- Soltuion 2: Window Function, Subquery
WITH tb1 AS (
    SELECT seat_id, free AS free1,
        LEAD(free) OVER (ORDER BY seat_id) AS free2,
        LAG(free) OVER (ORDER BY seat_id) AS free0
    FROM cinema
)

SELECT seat_id
FROM tb1
WHERE free1 = 1 AND (free2 = 1 OR free0 = 1);



select DISTINCT c1.seat_id 

from cinema c1 
cross join cinema c2
where c1.free=1 and c2.free=1
AND (c2.seat_id = c1.seat_id + 1 OR c2.seat_id = c1.seat_id -1)



select C1.seat_id from cinema C1  where 
C1.free=1 
and 
(
    C1.seat_id+1 in (select seat_id from cinema where free=1) 
    or 
    C1.seat_id-1 in (select seat_id from cinema where free=1) 
) 
order by C1.seat_id
