-- ============================================
-- PRACTICAL 10: VIEWS
-- ============================================

USE company_db;

-- ============================================
-- 1. CREATE VIEW - Basic
-- ============================================

CREATE VIEW high_salary_employees AS
SELECT emp_name, job, salary 
FROM employee 
WHERE salary > 70000;

SELECT * FROM high_salary_employees;

-- ============================================
-- 2. CREATE VIEW with JOIN
-- ============================================

CREATE VIEW employee_details AS
SELECT e.emp_id, e.emp_name, e.job, e.salary, d.dept_name, d.location
FROM employee e
LEFT JOIN department d ON e.dept_id = d.dept_id;

SELECT * FROM employee_details LIMIT 10;

-- ============================================
-- 3. CREATE VIEW with Aggregates
-- ============================================

CREATE VIEW department_stats AS
SELECT d.dept_name, 
       COUNT(e.emp_id) AS employee_count,
       ROUND(AVG(e.salary), 2) AS avg_salary,
       SUM(e.salary) AS total_payroll
FROM department d
LEFT JOIN employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

SELECT * FROM department_stats;

-- ============================================
-- 4. CREATE OR REPLACE VIEW
-- ============================================

CREATE OR REPLACE VIEW high_salary_employees AS
SELECT emp_name, job, salary, dept_id 
FROM employee 
WHERE salary > 60000;

SELECT * FROM high_salary_employees LIMIT 5;

-- ============================================
-- 5. CREATE VIEW with Complex Query
-- ============================================

CREATE VIEW manager_subordinates AS
SELECT m.emp_name AS manager, 
       COUNT(e.emp_id) AS subordinate_count,
       AVG(e.salary) AS avg_subordinate_salary
FROM employee m
LEFT JOIN employee e ON e.mgr_id = m.emp_id
GROUP BY m.emp_name
HAVING subordinate_count > 0;

SELECT * FROM manager_subordinates;

-- ============================================
-- 6. Using Views in Queries
-- ============================================

SELECT * FROM high_salary_employees WHERE dept_id = 1;
SELECT dept_name, employee_count FROM department_stats ORDER BY employee_count DESC;

-- ============================================
-- 7. Update Data Through View (if updatable)
-- ============================================

-- Simple views are updatable
-- UPDATE high_salary_employees SET salary = 75000 WHERE emp_name = 'Some Name';

-- ============================================
-- 8. Show View Definition
-- ============================================

SHOW CREATE VIEW employee_details;

-- ============================================
-- 9. List All Views
-- ============================================

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.VIEWS 
WHERE TABLE_SCHEMA = 'company_db';

-- ============================================
-- 10. DROP VIEW
-- ============================================

-- DROP VIEW IF EXISTS high_salary_employees;

-- ============================================
-- Benefits of Views
-- ============================================

/*
1. Simplify complex queries
2. Provide security (hide columns)
3. Present data in different format
4. Logical data independence
5. Reusable query definitions
*/

-- Exercises:
-- 1. Create view of IT department employees
-- 2. Create view showing employee with manager name
-- 3. Create view of departments with avg salary > 65000
-- 4. Create view of recent hires (last 2 years)

-- ============================================
-- CLEANUP
-- ============================================

-- DROP VIEW IF EXISTS high_salary_employees;
-- DROP VIEW IF EXISTS employee_details;
-- DROP VIEW IF EXISTS department_stats;
-- DROP VIEW IF EXISTS manager_subordinates;

-- ============================================
-- END OF PRACTICAL 10
-- ============================================
