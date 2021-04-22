1459_Rectangles_Area.sql

Table: Points

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| x_value       | int     |
| y_value       | int     |
+---------------+---------+
id is the primary key for this table.
Each point is represented as a 2D coordinate (x_value, y_value).
 

Write an SQL query to report all possible axis-aligned rectangles with non-zero area that can be formed by any two points in the Points table.

Each row in the result should contain three columns (p1, p2, area) where:

p1 and p2 are the id-s of the two points that determine the opposite corners of a rectangle.
area is the area of the rectangle and must be non-zero.
Report the query in descending order by area first, then in ascending order by p1-s id if there is a tie, 
then in ascending order by p2-s id if there is another tie.

The query result format is in the following table:

 

Points table:
+----------+-------------+-------------+
| id       | x_value     | y_value     |
+----------+-------------+-------------+
| 1        | 2           | 7           |
| 2        | 4           | 8           |
| 3        | 2           | 10          |
+----------+-------------+-------------+

Result table:
+----------+-------------+-------------+
| p1       | p2          | area        |
+----------+-------------+-------------+
| 2        | 3           | 4           |
| 1        | 2           | 2           |
+----------+-------------+-------------+

![pic](https://assets.leetcode.com/uploads/2021/03/12/rect.png)

The rectangle formed by p1 = 2 and p2 = 3 has an area equal to |4-2| * |8-10| = 4.
The rectangle formed by p1 = 1 and p2 = 2 has an area equal to |2-4| * |7-8| = 2.
Note that the rectangle formed by p1 = 1 and p2 = 3 is invalid because the area is 0.


===================================================================================================================
select
p1.id as p1,
p2.id as p2,
abs(p1.x_value-p2.x_value) * abs(p1.y_value-p2.y_value) as area

from points p1
left join points p2 on p1.id< p2.id
# left join points p2 on p1.id+1 = p2.id
where abs(p1.x_value-p2.x_value) * abs(p1.y_value-p2.y_value)!=0
order by area desc, P1,P2


Points p1 table:
+----------+-------------+-------------+
| id       | x_value     | y_value     |
+----------+-------------+-------------+
| 1        | 2           | 7           |
| 2        | 4           | 8           |
| 3        | 2           | 10          |
+----------+-------------+-------------+
Points p2 table:
+----------+-------------+-------------+
| id       | x_value     | y_value     |
+----------+-------------+-------------+
| 1        | 2           | 7           |
| 2        | 4           | 8           |
| 3        | 2           | 10          |
+----------+-------------+-------------+

# points p1 left join points p2 on p1.id< p2.id

1 2 7 2 4 8
1 2 7 3 2 10
2 4 8 3 2 10
3 2 10 null null null

# points p1 left join points p2 on p1.id+1 = p2.id

1 2 7 2 4 8
2 4 8 3 2 10
3 2 10 null null null