-- String Function: These are functions placed after the select statement, to format a text
-- based on how we want it to be.

SELECT first_name, UPPER(last_name) uLastName
FROM employee_demographics
WHERE length(last_name) > 6
;


-- Case Statements

SELECT first_name, salary,
CASE
	WHEN salary > 50000 THEN salary * 1.05
    WHEN salary <= 50000 THEN salary * 1.07
END AS Salary_Increase,
CASE 
    WHEN p.department_name = "Finance" THEN salary * 0.10
END AS Bonus
FROM employee_salary e
JOIN parks_departments p
	ON e.dept_id = p.department_id
;



-- Subqueries: So powerful when you want to perform operations without using JOIN
-- calculating average of values

SELECT AVG(avg_s)
FROM (
	SELECT gender, 
		AVG(salary) as avg_s,
        MIN(salary) as min_s,
        MAX(salary) as max_s,
        COUNT(salary) as count_s
    FROM employee_salary s
    LEFT JOIN employee_demographics d -- The goal of doing left join is to make sure all the values in the salary table are being used 
		ON s.employee_id = d.employee_id
    GROUP BY gender
    ) AS T1
;
    

-- Find the user who has a salary but has not given his demographic details.
select *
FROM employee_salary
WHERE employee_id NOT IN (
	SELECT employee_id
    FROM employee_demographics
)
;



-- Window Functions: This function gives the opportunity to display an aggregate value through out the same values
-- without grouping values to distinct. some examples include OVER(), RANK(), ROW_NUMBER()
-- The advantage it gives is that it can perform operations as parameters Eg. RANK() OVER(PARTITION BY gender ORDER BY salary)

SELECT distinct gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_salary s
JOIN employee_demographics d
	ON s.employee_id = d.employee_id
;


SELECT d.first_name, s.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY d.employee_id)
FROM employee_salary s
JOIN employee_demographics d
	ON s.employee_id = d.employee_id
;