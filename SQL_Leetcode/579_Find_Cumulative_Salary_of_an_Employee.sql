579_Find_Cumulative_Salary_of_an_Employee.sql

The Employee table holds the salary information in a year.

Write a SQL to get the cumulative sum of an employees salary over a period of 3 months 
but exclude the most recent month.

The result should be displayed by Id ascending, and then by 'Month' descending.

Example
Input

| Id | Month | Salary |
|----|-------|--------|
| 1  | 1     | 20     |
| 2  | 1     | 20     |
| 1  | 2     | 30     |
| 2  | 2     | 30     |
| 3  | 2     | 40     |
| 1  | 3     | 40     |
| 3  | 3     | 60     |
| 1  | 4     | 60     |
| 3  | 4     | 70     |
Output

| Id | Month | Salary |
|----|-------|--------|
| 1  | 3     | 90     |
| 1  | 2     | 50     |
| 1  | 1     | 20     |
| 2  | 1     | 20     |
| 3  | 3     | 100    |
| 3  | 2     | 40     |
 

Explanation
Employee '1' has 3 salary records for the following 3 months except the most recent month '4': salary 40 for month '3', 30 for month '2' and 20 for month '1'
So the cumulative sum of salary of this employee over 3 months is 90(40+30+20), 50(30+20) and 20 respectively.

| Id | Month | Salary |
|----|-------|--------|
| 1  | 3     | 90     |
| 1  | 2     | 50     |
| 1  | 1     | 20     |
Employee '2' only has one salary record (month '1') except its most recent month '2'.
| Id | Month | Salary |
|----|-------|--------|
| 2  | 1     | 20     |
 

Employ '3' has two salary records except its most recent pay month '4': month '3' with 60 and month '2' with 40. So the cumulative salary is as following.
| Id | Month | Salary |
|----|-------|--------|
| 3  | 3     | 100    |
| 3  | 2     | 40     |


============================================================================================

-- Solution 1: Window Function, Subquery
SELECT e.id, month, 
    SUM(Salary) OVER (
        PARTITION BY id 
        ORDER BY month
     -- get the cumulative sum of an employee's salary over a period of 3 months 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Salary
FROM Employee e
-- exclude the most recent month for each employee
WHERE month != (SELECT MAX(Month) FROM Employee WHERE id = e.id)
ORDER BY id, month DESC;


-- Solution 2: Join, Subquery
SELECT e1.id, e1.month, SUM(e2.salary) AS Salary
FROM Employee e1
JOIN Employee e2
-- data from table e2 only contained salary over 
-- a period of 3 months until e1.month
ON e1.id = e2.id AND e1.month >= e2.month AND e1.month <= e2.month + 2
-- exclude the most recent month for each employee
WHERE e1.month != (SELECT MAX(month) FROM Employee WHERE id = e1.id)
GROUP BY e1.id, e1.month
ORDER BY e1.id, e1.month DESC;









SELECT   A.Id, MAX(B.Month) as Month, SUM(B.Salary) as Salary
FROM     Employee A 
inner join Employee B on A.Id = B.Id 
       AND B.Month BETWEEN (A.Month-3) AND (A.Month-1)
GROUP BY A.Id, A.Month
ORDER BY Id, Month DESC
