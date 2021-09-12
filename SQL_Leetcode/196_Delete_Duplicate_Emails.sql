196_Delete_Duplicate_Emails.sql

Write a SQL query to delete all duplicate email entries in a table named Person, 
keeping only unique emails based on its smallest Id.

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.
For example, after running your query, 
the above Person table should have the following rows:

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Note:

Your output is the whole Person table after executing your sql. Use delete statement.

========================================================================================
-- Solution 1: SQL Command, Join
DELETE p1 
FROM person p1
JOIN person p2 ON p1.email = p2.email AND p1.id > p2.id;  

DELETE p1 
    FROM Person p1 
    inner join Person p2 on p1.Email = p2.Email 
    where p1.Id > p2.Id    

-- Solution 2: SQL Command, Subquery
DELETE FROM person
WHERE id NOT IN (
    SELECT *
    FROM (
        SELECT MIN(id) AS id
        FROM person
        GROUP BY email
        ) tb1
);
