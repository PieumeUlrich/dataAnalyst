select *
from parks_and_recreation.employee_demographics;

select first_name, salary, (salary+10000)
from parks_and_recreation.employee_salary;

# MySQL follows the law of PEMDAS => Paranthesis, Exponential, Multiplication, Division, Addition, Substraction

select distinct salary
from parks_and_recreation.employee_salary;

select *
FROM parks_and_recreation.employee_demographics

-- Logical operators Mixed
where (first_name = 'Leslie' AND age = 44) OR age > 55
;


select *
FROM parks_and_recreation.employee_demographics

-- Like statments 
-- % : either start or end means a number of charater sequence followed by a specific caracter given. Eg: %rich, %ri%, Ul%
-- _ : specific number of character determined by the number of under-scores (_) Eg: a__, _a, L__%, ___a
WHERE  birth_date LIKE '199_%'
;



SELECT *
FROM employee_salary m
JOIN employee_demographics e
	ON e.employee_id = m.employee_id
-- GROUP BY m.salary
;