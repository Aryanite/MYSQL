-- ============================================
-- PRACTICAL 14: CURSORS
-- ============================================

USE company_db;

-- ============================================
-- 1. Simple Cursor Example
-- ============================================

DELIMITER //
CREATE PROCEDURE cursor_example()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_name_var VARCHAR(100);
    DECLARE emp_salary DECIMAL(10,2);
    
    -- Declare cursor
    DECLARE emp_cursor CURSOR FOR 
        SELECT emp_name, salary FROM employee;
    
    -- Declare handler for end of cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Open cursor
    OPEN emp_cursor;
    
    -- Loop through cursor
    read_loop: LOOP
        FETCH emp_cursor INTO emp_name_var, emp_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Process each row
        SELECT emp_name_var, emp_salary;
    END LOOP;
    
    -- Close cursor
    CLOSE emp_cursor;
END //
DELIMITER ;

-- Call procedure
-- CALL cursor_example();

-- ============================================
-- 2. Cursor with Calculation
-- ============================================

DELIMITER //
CREATE PROCEDURE calculate_bonus()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_id_var INT;
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE bonus DECIMAL(10,2);
    
    DECLARE emp_cursor CURSOR FOR 
        SELECT emp_id, salary FROM employee;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Create temp table for results
    CREATE TEMPORARY TABLE IF NOT EXISTS bonus_results (
        emp_id INT,
        salary DECIMAL(10,2),
        bonus DECIMAL(10,2)
    );
    
    TRUNCATE bonus_results;
    
    OPEN emp_cursor;
    
    read_loop: LOOP
        FETCH emp_cursor INTO emp_id_var, emp_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate bonus (10% of salary)
        SET bonus = emp_salary * 0.10;
        
        -- Insert into temp table
        INSERT INTO bonus_results VALUES (emp_id_var, emp_salary, bonus);
    END LOOP;
    
    CLOSE emp_cursor;
    
    -- Show results
    SELECT * FROM bonus_results;
END //
DELIMITER ;

CALL calculate_bonus();

-- ============================================
-- 3. Cursor with Conditional Logic
-- ============================================

DELIMITER //
CREATE PROCEDURE categorize_salaries()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_name_var VARCHAR(100);
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE category VARCHAR(20);
    
    DECLARE emp_cursor CURSOR FOR 
        SELECT emp_name, salary FROM employee;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS salary_categories (
        emp_name VARCHAR(100),
        salary DECIMAL(10,2),
        category VARCHAR(20)
    );
    
    TRUNCATE salary_categories;
    
    OPEN emp_cursor;
    
    read_loop: LOOP
        FETCH emp_cursor INTO emp_name_var, emp_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Categorize salary
        IF emp_salary > 80000 THEN
            SET category = 'High';
        ELSEIF emp_salary > 55000 THEN
            SET category = 'Medium';
        ELSE
            SET category = 'Low';
        END IF;
        
        INSERT INTO salary_categories VALUES (emp_name_var, emp_salary, category);
    END LOOP;
    
    CLOSE emp_cursor;
    
    SELECT * FROM salary_categories ORDER BY salary DESC;
END //
DELIMITER ;

CALL categorize_salaries();

-- ============================================
-- 4. Cursor with Update
-- ============================================

DELIMITER //
CREATE PROCEDURE update_salaries_cursor()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_id_var INT;
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE new_salary DECIMAL(10,2);
    
    DECLARE emp_cursor CURSOR FOR 
        SELECT emp_id, salary FROM employee WHERE salary < 60000;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN emp_cursor;
    
    read_loop: LOOP
        FETCH emp_cursor INTO emp_id_var, emp_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Increase salary by 5%
        SET new_salary = emp_salary * 1.05;
        
        -- Update in database (commented out for safety)
        -- UPDATE employee SET salary = new_salary WHERE emp_id = emp_id_var;
        
        SELECT emp_id_var, emp_salary AS old_salary, new_salary;
    END LOOP;
    
    CLOSE emp_cursor;
END //
DELIMITER ;

-- CALL update_salaries_cursor();

-- ============================================
-- 5. Drop Procedures
-- ============================================

DROP PROCEDURE IF EXISTS cursor_example;
DROP PROCEDURE IF EXISTS calculate_bonus;
DROP PROCEDURE IF EXISTS categorize_salaries;
DROP PROCEDURE IF EXISTS update_salaries_cursor;

-- ============================================
-- Cursor Notes:
-- ============================================

/*
Cursors allow row-by-row processing

Components:
1. DECLARE cursor
2. DECLARE handler
3. OPEN cursor
4. FETCH cursor
5. CLOSE cursor

When to use:
- Complex row-by-row calculations
- When SET operations won't work
- Procedural logic needed

Performance:
- Slower than SET operations
- Use only when necessary
*/

-- ============================================
-- END OF PRACTICAL 14
-- ============================================
