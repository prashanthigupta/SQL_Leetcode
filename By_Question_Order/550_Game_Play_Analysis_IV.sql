550_Game_Play_Analysis_IV.sql

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
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
 

Write an SQL query that reports the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33


============================================================================================
# Method 1
SELECT 
ROUND(COUNT(t2.player_id)/COUNT(t1.player_id)
			,2) AS fraction
FROM

		(SELECT player_id, MIN(event_date) AS first_login 
		 FROM Activity 
		 GROUP BY player_id) as t1 

LEFT JOIN Activity t2 ON t1.player_id = t2.player_id 
      AND t1.first_login = t2.event_date - 1 
      # AND datediff(t2.event_date,t1.first_login) =1


# Method 2
SELECT ROUND(SUM(CASE WHEN a.event_date + 1 = b.event_date THEN 1 ELSE 0 END)
              /COUNT(DISTINCT a.player_id)
			  , 2) AS fraction 

FROM (SELECT player_id, MIN(event_date) AS event_date
      FROM Activity 
      GROUP BY player_id) AS a 
JOIN Activity AS b ON a.player_id = b.player_id