-- Joins combine columns 
-- Joining 2 tables with the simple INNER JOIN or JOIN matches values from both tables (kind of intersection)
SELECT * -- to specifie fields which are repetitive in both tables specify the table or use it's alias
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT * -- to specifie fields which are repetitive in both tables specify the table or use it's alias
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal -- with the right join, all values found on the second table 
	ON dem.employee_id = sal.employee_id
;

-- Multiple Join

SELECT dem.employee_id, dem.first_name, age, occupation, pd.department_name
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments as pd
	ON sal.dept_id = pd.department_id
    
;


-- Unions combine row no matter the values they return, so be careful in the output fields

SELECT first_name, last_name, "Highly Paid" AS Label
FROM employee_salary
WHERE salary > 70000
UNION
SELECT first_name, last_name, "Old Man"
FROM employee_demographics
WHERE age > 40 AND gender = "Male"
UNION
SELECT first_name, last_name, "Old Lady"
FROM employee_demographics
WHERE age > 40 AND gender = "Female"
ORDER BY first_name, last_name
;