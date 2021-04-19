512_Game_Play_Analysis_II.sql

Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number 
of games (possibly 0) before logging out on some day using some device.
 

Write a SQL query that reports the device that is first logged in for each player.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+
============================================================================================

with t as (
select
player_id, 
min(event_date) as first_time
from activity
group by player_id)

select
a.player_id, a.device_id
from activity a 
inner join t on t.player_id= a.player_id 
       and t.first_time =a.event_date






select player_id, device_id
    from activity 
    where (player_id, event_date) in 
       (select player_id, min(event_date)
        from activity
        group by player_id)







select player_id, device_id
    from activity 
    where (player_id, event_date) in 
       (select player_id, min(event_date)
        from activity
        group by player_id)

select a2.player_id, a2.device_ida
    from activity a2
    inner join 
             (select a.player_id, min(a.event_date) as mdate
              from activity a
              group by a.player_id) as temp
    on a2.player_id=temp.player_id and a2.event_date=temp.mdate


