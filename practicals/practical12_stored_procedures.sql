-- ============================================
-- PRACTICAL 12: STORED PROCEDURES
-- ============================================

USE company_db;

-- ============================================
-- 1. CREATE Simple Stored Procedure
-- ============================================

DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM employee;
END //
DELIMITER ;

-- Call procedure
CALL GetAllEmployees();

-- ============================================
-- 2. Procedure with IN Parameter
-- ============================================

DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN dept_id_param INT)
BEGIN
    SELECT emp_name, job, salary 
    FROM employee 
    WHERE dept_id = dept_id_param;
END //
DELIMITER ;

CALL GetEmployeesByDept(1);

-- ============================================
-- 3. Procedure with OUT Parameter
-- ============================================

DELIMITER //
CREATE PROCEDURE GetEmployeeCount(OUT emp_count INT)
BEGIN
    SELECT COUNT(*) INTO emp_count FROM employee;
END //
DELIMITER ;

CALL GetEmployeeCount(@total);
SELECT @total AS total_employees;

-- ============================================
-- 4. Procedure with INOUT Parameter
-- ============================================

DELIMITER //
CREATE PROCEDURE IncreaseSalary(INOUT salary_amount DECIMAL(10,2), IN percentage DECIMAL(5,2))
BEGIN
    SET salary_amount = salary_amount * (1 + percentage/100);
END //
DELIMITER ;

SET @sal = 50000;
CALL IncreaseSalary(@sal, 10);
SELECT @sal AS new_salary;

-- ============================================
-- 5. Procedure with Multiple Parameters
-- ============================================

DELIMITER //
CREATE PROCEDURE GetSalaryRange(
    IN min_sal DECIMAL(10,2), 
    IN max_sal DECIMAL(10,2)
)
BEGIN
    SELECT emp_name, job, salary 
    FROM employee 
    WHERE salary BETWEEN min_sal AND max_sal
    ORDER BY salary;
END //
DELIMITER ;

CALL GetSalaryRange(50000, 80000);

-- ============================================
-- 6. Procedure with IF-ELSE
-- ============================================

DELIMITER //
CREATE PROCEDURE GetSalaryLevel(IN emp_id_param INT)
BEGIN
    DECLARE sal DECIMAL(10,2);
    DECLARE level VARCHAR(20);
    
    SELECT salary INTO sal FROM employee WHERE emp_id = emp_id_param;
    
    IF sal > 80000 THEN
        SET level = 'High';
    ELSEIF sal > 50000 THEN
        SET level = 'Medium';
    ELSE
        SET level = 'Low';
    END IF;
    
    SELECT sal, level;
END //
DELIMITER ;

CALL GetSalaryLevel(101);

-- ============================================
-- 7. Procedure with LOOP
-- ============================================

DELIMITER //
CREATE PROCEDURE InsertNumbers(IN n INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_numbers (num INT);
    TRUNCATE temp_numbers;
    
    WHILE i <= n DO
        INSERT INTO temp_numbers VALUES (i);
        SET i = i + 1;
    END WHILE;
    
    SELECT * FROM temp_numbers;
END //
DELIMITER ;

CALL InsertNumbers(10);

-- ============================================
-- 8. Show Procedures
-- ============================================

SHOW PROCEDURE STATUS WHERE Db = 'company_db';
SHOW CREATE PROCEDURE GetAllEmployees;

-- ============================================
-- 9. DROP Procedure
-- ============================================

DROP PROCEDURE IF EXISTS GetAllEmployees;
DROP PROCEDURE IF EXISTS GetEmployeesByDept;
DROP PROCEDURE IF EXISTS GetEmployeeCount;
DROP PROCEDURE IF EXISTS IncreaseSalary;
DROP PROCEDURE IF EXISTS GetSalaryRange;
DROP PROCEDURE IF EXISTS GetSalaryLevel;
DROP PROCEDURE IF EXISTS InsertNumbers;

-- ============================================
-- Exercises:
-- ============================================

-- 1. Create procedure to get employees by job title
-- 2. Create procedure to update employee salary
-- 3. Create procedure to count employees in a department
-- 4. Create procedure with salary increment logic

-- ============================================
-- END OF PRACTICAL 12
-- ============================================
