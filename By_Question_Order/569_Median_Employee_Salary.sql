569_Median_Employee_Salary.sql

The Employee table holds all employees. The employee table has three columns: Employee Id, Company Name, and Salary.

+-----+------------+--------+
|Id   | Company    | Salary |
+-----+------------+--------+
|1    | A          | 2341   |
|2    | A          | 341    |
|3    | A          | 15     |
|4    | A          | 15314  |
|5    | A          | 451    |
|6    | A          | 513    |
|7    | B          | 15     |
|8    | B          | 13     |
|9    | B          | 1154   |
|10   | B          | 1345   |
|11   | B          | 1221   |
|12   | B          | 234    |
|13   | C          | 2345   |
|14   | C          | 2645   |
|15   | C          | 2645   |
|16   | C          | 2652   |
|17   | C          | 65     |
+-----+------------+--------+
Write a SQL query to find the median salary of each company. Bonus points if you can solve it without using any built-in SQL functions.

+-----+------------+--------+
|Id   | Company    | Salary |
+-----+------------+--------+
|5    | A          | 451    |
|6    | A          | 513    |
|12   | B          | 234    |
|9    | B          | 1154   |
|14   | C          | 2645   |
+-----+------------+--------+


============================================================================================
SELECT
	Id, Company,Salary
FROM
	(SELECT *,
			ROW_NUMBER () over (PARTITION BY Company ORDER BY Salary) AS rowk,
			COUNT(Id) over (PARTITION BY Company) AS cnt
	 FROM Employee
	) AS t1
WHERE t1.rowk between cnt*1.0/2 and cnt*1.0/2+1

-- when num % 2 = 0, 
	the r of the median is num/2 and num/2 + 1
-- when num % 2 = 1, 
	the r of the median is (num+1)/2, between num/2 and num/2 + 1

# WHERE t1.rowk IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
  ## cnt=2, (1,2)
  ## cnt=3, (2,2)



