-- Stored Procedures: Just like procedures in programming languages like Python without paramters

DELIMITER $$ -- We specify this so that the compiler won't treat ; as the end of our code
CREATE PROCEDURE largeSalaries()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000
	;
    SELECT *
	FROM employee_salary
	WHERE salary >= 100000
	;
END $$
DELIMITER ;

-- CALL largeSalaries();
-- CALL new_procedure();

-- Procedures that take parameters
-- We specify this so that the compiler won't treat ; as the end of our code

DELIMITER $$
CREATE PROCEDURE OldMoreThan2(IN amount INT, IN given_age INT)
BEGIN
	SELECT s.employee_id, s.first_name, s.last_name, age, salary
	FROM employee_salary s
    JOIN employee_demographics d
		ON s.employee_id = d.employee_id
	WHERE salary >= amount AND age > given_age
    ;
END $$
DELIMITER ; -- comment

CALL OldmoreThan(60000, 40);

-- A Comment can't be added at on the Top DELIMITER statement since this makes the code not to compile

-- Triggers : Does not take a parenthesis, and type AFTER, (BEFORE) FOR EACH ROW.
DELIMITER $$
CREATE TRIGGER AutoEmployeeUpdate
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
    INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name)
    ;
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, "John", "NKWAMU", "Teacher", 70000, NULL);

SELECT *
FROM employee_demographics
;


SELECT *
FROM employee_demographics;

-- Events: Come to solve the probleme of automation in SQL, where records are been transformed for a certain period given by the script
-- Ex. The script down deletes people that are aged more than 60 years after every one minute
DELIMITER $$
CREATE EVENT remove_retires
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >= 60
    ;
END $$
DELIMITER ;


-- Ex. Script that automatically updates the ages of people based on the birth_date provided.
DELIMITER $$
CREATE EVENT update_age
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
	UPDATE employee_demographics
    SET age = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), birth_date)), '%Y') + 0
    ;
END $$
DELIMITER ;


SELECT birth_date, age,
	DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), birth_date)), '%Y') + 0 New_Age
FROM employee_demographics
;
