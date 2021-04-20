602_Friend_Requests_II_Who_Has_the_Most_Friends.sql

In social network like Facebook or Twitter, people send friend requests and accept others requests as well.

Table request_accepted

+--------------+-------------+------------+
| requester_id | accepter_id | accept_date|
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
+--------------+-------------+------------+
This table holds the data of friend acceptance, while requester_id and accepter_id both are the id of a person.
 

Write a query to find the the people who has most friends and the most friends number under the following rules:

It is guaranteed there is only 1 people having the most friends.
The friend request could only been accepted once, which mean there is no multiple records with the same requester_id and accepter_id value.
For the sample data above, the result is:

Result table:
+------+------+
| id   | num  |
|------|------|
| 3    | 3    |
+------+------+
The person with id '3' is a friend of people '1', '2' and '4', so he has 3 friends in total, which is the most number than any others.
Follow-up:
In the real world, multiple people could have the same most number of friends, can you find all these people in this case?

==========================================================================================================================

with temp as (
select r1.requester_id as id , r1.accepter_id as id2
from request_accepted r1
union
select r2.accepter_id as id, r2.requester_id as id2
from request_accepted r2)

select

temp.id,count(temp.id) as num
from temp
group by temp.id
order by count(temp.id) desc
limit 0,1
