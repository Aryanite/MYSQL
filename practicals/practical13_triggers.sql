-- ============================================
-- PRACTICAL 13: TRIGGERS
-- ============================================

USE company_db;

-- ============================================
-- 1. Setup Tables for Trigger Examples
-- ============================================

CREATE TABLE IF NOT EXISTS audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50),
    action VARCHAR(20),
    old_value TEXT,
    new_value TEXT,
    changed_by VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS salary_changes (
    change_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 2. BEFORE INSERT Trigger
-- ============================================

DELIMITER //
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    -- Ensure salary is not negative
    IF NEW.salary < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
    
    -- Set default hire_date if not provided
    IF NEW.hire_date IS NULL THEN
        SET NEW.hire_date = CURDATE();
    END IF;
END //
DELIMITER ;

-- ============================================
-- 3. AFTER INSERT Trigger
-- ============================================

DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, action, new_value)
    VALUES ('employee', 'INSERT', CONCAT('New employee: ', NEW.emp_name));
END //
DELIMITER ;

-- ============================================
-- 4. BEFORE UPDATE Trigger
-- ============================================

DELIMITER //
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    -- Prevent salary decrease
    IF NEW.salary < OLD.salary THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be decreased';
    END IF;
END //
DELIMITER ;

-- ============================================
-- 5. AFTER UPDATE Trigger
-- ============================================

DELIMITER //
CREATE TRIGGER after_employee_update
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
    -- Log salary changes
    IF NEW.salary != OLD.salary THEN
        INSERT INTO salary_changes (emp_id, old_salary, new_salary)
        VALUES (NEW.emp_id, OLD.salary, NEW.salary);
    END IF;
END //
DELIMITER ;

-- ============================================
-- 6. BEFORE DELETE Trigger
-- ============================================

DELIMITER //
CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN
    -- Prevent deletion of managers
    IF EXISTS (SELECT 1 FROM employee WHERE mgr_id = OLD.emp_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete employee who is a manager';
    END IF;
END //
DELIMITER ;

-- ============================================
-- 7. AFTER DELETE Trigger
-- ============================================

DELIMITER //
CREATE TRIGGER after_employee_delete
AFTER DELETE ON employee
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, action, old_value)
    VALUES ('employee', 'DELETE', CONCAT('Deleted employee: ', OLD.emp_name));
END //
DELIMITER ;

-- ============================================
-- 8. Test Triggers
-- ============================================

-- Test INSERT trigger
-- INSERT INTO employee (emp_name, job, salary, dept_id) 
-- VALUES ('Test Employee', 'Tester', 45000, 1);

-- Test UPDATE trigger
-- UPDATE employee SET salary = 46000 WHERE emp_name = 'Test Employee';

-- View audit log
-- SELECT * FROM audit_log;
-- SELECT * FROM salary_changes;

-- ============================================
-- 9. Show Triggers
-- ============================================

SHOW TRIGGERS;
SHOW TRIGGERS FROM company_db;
SHOW CREATE TRIGGER before_employee_insert;

-- ============================================
-- 10. Drop Triggers
-- ============================================

DROP TRIGGER IF EXISTS before_employee_insert;
DROP TRIGGER IF EXISTS after_employee_insert;
DROP TRIGGER IF EXISTS before_employee_update;
DROP TRIGGER IF EXISTS after_employee_update;
DROP TRIGGER IF EXISTS before_employee_delete;
DROP TRIGGER IF EXISTS after_employee_delete;

-- ============================================
-- Trigger Use Cases:
-- ============================================

/*
1. Audit trails (track changes)
2. Data validation
3. Enforce business rules
4. Maintain derived data
5. Prevent invalid operations
6. Automatic calculations
7. Cross-table updates
*/

-- ============================================
-- CLEANUP
-- ============================================

-- DROP TABLE IF EXISTS audit_log;
-- DROP TABLE IF EXISTS salary_changes;

-- ============================================
-- END OF PRACTICAL 13
-- ============================================
