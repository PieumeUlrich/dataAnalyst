SELECT gender, MAX(age), MIN(age), COUNT(age)
FROM parks_and_recreation.employee_demographics
-- When we use GROUP BY, we should take care of the field selected at the top in order to have the wanted result
GROUP BY gender
;

SELECT *
FROM parks_and_recreation.employee_demographics
-- When we use ORDER BY, we should know that by default it's ASC but we can also do DESC for the opposite.
-- We can also ORDER BY several fields eg ORDER BY gender, age
ORDER BY age
;

SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary AS sal
WHERE occupation LIKE "%manager%"
GROUP BY occupation
-- HAVING always comes after the GROUP keyword since it's function is to filter after every operation is set
HAVING AVG(salary) > 75000
;