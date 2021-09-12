614_Second_Degree_Follower.sql

In facebook, there is a follow table with two columns: followee, follower.

Please write a sql query to get the amount of each follower’s follower if he/she has one.

For example:

+-------------+------------+
| followee    | follower   |
+-------------+------------+
|     A       |     B      |
|     B       |     C      |
|     B       |     D      |
|     D       |     E      |
+-------------+------------+
should output:
+-------------+------------+
| follower    | num        |
+-------------+------------+
|     B       |  2         |
|     D       |  1         |
+-------------+------------+
Explaination:
Both B and D exist in the follower list, when as a followee, B's follower is C and D, and D's follower is E. A does not exist in follower list.
 

 

Note:
Followee would not follow himself/herself in all cases.
Please display the result in followers alphabet order.

==================================================================================================================

select
followee as follower, 
count(distinct follower) as num
from follow 
where followee in (select distinct follower from follow)
group by followee
order by followee


# 这个题目不好，改变case大小，所以第一次的做法其实也可以的 not in 之类的 subquery
select 
f1.follower as follower, count(distinct f2.follower) as num
from follow f1
join follow f2 on f1.follower = f2.followee
group by f1.follower
order by f1.follower;





