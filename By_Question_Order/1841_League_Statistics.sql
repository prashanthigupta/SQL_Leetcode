1841_League_Statistics.sql

Table: Teams

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| team_id        | int     |
| team_name      | varchar |
+----------------+---------+
team_id is the primary key for this table.
Each row contains information about one team in the league.
 

Table: Matches

+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| home_team_id    | int     |
| away_team_id    | int     |
| home_team_goals | int     |
| away_team_goals | int     |
+-----------------+---------+
(home_team_id, away_team_id) is the primary key for this table.
Each row contains information about one match.
home_team_goals is the number of goals scored by the home team.
away_team_goals is the number of goals scored by the away team.
The winner of the match is the team with the higher number of goals.
 

Write an SQL query to report the statistics of the league. The statistics should be built using the played matches where the winning team gets three points and the losing team gets no points. If a match ends with a draw, both teams get one point.

Each row of the result table should contain:

team_name - The name of the team in the Teams table.
matches_played - The number of matches played as either a home or away team.
points - The total points the team has so far.
goal_for - The total number of goals scored by the team across all matches.
goal_against - The total number of goals scored by opponent teams against this team across all matches.
goal_diff - The result of goal_for - goal_against.
Return the result table in descending order by points. If two or more teams have the same points, order them in descending order by goal_diff. If there is still a tie, order them by team_name in lexicographical order.

The query result format is in the following example:

 

Teams table:
+---------+-----------+
| team_id | team_name |
+---------+-----------+
| 1       | Ajax      |
| 4       | Dortmund  |
| 6       | Arsenal   |
+---------+-----------+

Matches table:
+--------------+--------------+-----------------+-----------------+
| home_team_id | away_team_id | home_team_goals | away_team_goals |
+--------------+--------------+-----------------+-----------------+
| 1            | 4            | 0               | 1               |
| 1            | 6            | 3               | 3               |
| 4            | 1            | 5               | 2               |
| 6            | 1            | 0               | 0               |
+--------------+--------------+-----------------+-----------------+


Result table:
+-----------+----------------+--------+----------+--------------+-----------+
| team_name | matches_played | points | goal_for | goal_against | goal_diff |
+-----------+----------------+--------+----------+--------------+-----------+
| Dortmund  | 2              | 6      | 6        | 2            | 4         |
| Arsenal   | 2              | 2      | 3        | 3            | 0         |
| Ajax      | 4              | 2      | 5        | 9            | -4        |
+-----------+----------------+--------+----------+--------------+-----------+

Ajax (team_id=1) played 4 matches: 2 losses and 2 draws. Total points = 0 + 0 + 1 + 1 = 2.
Dortmund (team_id=4) played 2 matches: 2 wins. Total points = 3 + 3 = 6.
Arsenal (team_id=6) played 2 matches: 2 draws. Total points = 1 + 1 = 2.
Dortmund is the first team in the table. Ajax and Arsenal have the same points, but since Arsenal has a higher goal_diff than Ajax, Arsenal comes before Ajax in the table.

=================================================================================================
with t as (
		select
		*,
		case when home_team_goals=away_team_goals then 1
		     when home_team_goals> away_team_goals then 3
		     else 0 
		end as home_points,
		case when home_team_goals=away_team_goals then 1
		     when home_team_goals< away_team_goals then 3
		     else 0 
		end as away_points
		from matches),
new as (
		select 
		    t.home_team_id as team_id,
		    t.home_team_goals as team_goals,
		    t.home_points as points
		from t
		union all
		select 
		    t.away_team_id as team_id,
		    t.away_team_goals as team_goals,
		    t.away_points as points
		from t   
),
against as (
				select
				tb.team_id,
				sum(tb.goals) as goal_against
				from (select 
							home_team_id as team_id,away_team_goals as goals
							from matches
							union all
							select
							away_team_id as team_id,home_team_goals as goals
							from matches) as tb
				group by tb.team_id
)

select
teams.team_name,
count(new.team_id) as matches_played,
sum(new.points) as points,
sum(new.team_goals) as goal_for,
against.goal_against as goal_against,
sum(new.team_goals)- against.goal_against as goal_diff

from new 
inner join teams on teams.team_id =  new.team_id
inner join against on against.team_id = new.team_id
group by new.team_id
order by sum(new.points) desc, goal_diff desc, teams.team_name asc
