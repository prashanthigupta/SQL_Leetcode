197_Rising_Temperature.sql

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature in a certain day.
 

Write an SQL query to find all dates id with higher temperature 
compared to its previous dates (yesterday).

Return the result table in any order.

The query result format is in the following example:

Weather
+----+------------+-------------+
| id | recordDate | Temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+

Result table:
+----+
| id |
+----+
| 2  |
| 4  |
+----+
In 2015-01-02, temperature was higher than the previous day (10 -> 25).
In 2015-01-04, temperature was higher than the previous day (20 -> 30).

============================================================================================
##1 using datediff FUN
    select w2.Id 
    from Weather w1
    inner join Weather w2
        on datediff(w2.RecordDate, w1.RecordDate) = 1 
    where w2.Temperature > w1.Temperature

##2 Using subdate to get the date earlier
    SELECT w1.Id 
    FROM  Weather as w1 
    inner JOIN  Weather AS w2
             ON w1.RecordDate = SUBDATE(w2.RecordDate, 1) 
    WHERE w1.Temperature > w2.Temperature 

##3 Using to_days FUN
    select a.Id 
    from Weather a
    inner join Weather b
        on to_days(a.RecordDate) - to_days(b.RecordDate) = 1
    where a.Temperature > b.Temperature

