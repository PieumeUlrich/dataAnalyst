-- CTEs: Common Table Expressions - To use CTE, you specify with the keyword WITH at the begining 
-- Ex. WITH(SELECT STATEMENT) 677219283 6f5cd519

WITH CTE_table AS(
	SELECT first_name, last_name, salary, d.department_name,
		DENSE_RANK() OVER(PARTITION BY s.dept_id ORDER BY s.dept_id DESC, salary DESC) sal_rank
	FROM employee_salary s
	JOIN parks_departments d
		ON s.dept_id = d.department_id
)
SELECT first_name, last_name, salary, department_name,
CASE 
	WHEN sal_rank < 3 THEN 1
END AS rule
FROM CTE_table
;


SELECT first_name, last_name, sal.salary, sal.dept_id, sal_rank
FROM (SELECT s.employee_id AS e_id,
	DENSE_RANK() OVER(PARTITION BY s.dept_id ORDER BY s.dept_id DESC, salary DESC) AS sal_rank,
	CASE WHEN DENSE_RANK() OVER(PARTITION BY s.dept_id ORDER BY s.dept_id DESC, salary DESC) < 4 THEN 1 END AS cond
FROM employee_salary s
JOIN parks_departments d
	ON s.dept_id = d.department_id
    ) AS t1
JOIN employee_salary sal
	ON t1.e_id = sal.employee_id
WHERE cond is not NULL
ORDER BY sal.dept_id, sal_rank
;

-- Optimal solution
-- Solution to a problem viewed on Linkedin by Kana Sorel, on displaying the top3 employees with high salary per department
SELECT first_name, last_name, sal.salary, sal.dept_id,
	DENSE_RANK() OVER(PARTITION BY sal.dept_id ORDER BY sal.dept_id DESC, salary DESC) AS sal_rank
FROM (SELECT s.employee_id e_id,
	CASE WHEN DENSE_RANK() OVER(PARTITION BY s.dept_id ORDER BY s.dept_id DESC, salary DESC) < 4 THEN 1 END AS cond
FROM employee_salary s
JOIN parks_departments d
	ON s.dept_id = d.department_id
    ) AS t1
JOIN employee_salary sal
	ON t1.e_id = sal.employee_id
WHERE cond is not NULL
;