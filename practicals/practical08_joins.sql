-- ============================================
-- PRACTICAL 08: JOINS
-- ============================================

USE company_db;

-- ============================================
-- 1. INNER JOIN
-- ============================================

SELECT e.emp_name, e.job, d.dept_name 
FROM employee e
INNER JOIN department d ON e.dept_id = d.dept_id;

SELECT e.emp_name, e.salary, d.dept_name, d.location
FROM employee e
INNER JOIN department d ON e.dept_id = d.dept_id
WHERE e.salary > 60000;

-- ============================================
-- 2. LEFT JOIN (LEFT OUTER JOIN)
-- ============================================

SELECT d.dept_name, e.emp_name
FROM department d
LEFT JOIN employee e ON d.dept_id = e.dept_id;

SELECT d.dept_name, COUNT(e.emp_id) AS emp_count
FROM department d
LEFT JOIN employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- ============================================
-- 3. RIGHT JOIN (RIGHT OUTER JOIN)
-- ============================================

SELECT e.emp_name, d.dept_name
FROM employee e
RIGHT JOIN department d ON e.dept_id = d.dept_id;

-- ============================================
-- 4. CROSS JOIN
-- ============================================

SELECT e.emp_name, d.dept_name
FROM employee e
CROSS JOIN department d
LIMIT 20;

-- ============================================
-- 5. SELF JOIN
-- ============================================

-- Find employees and their managers
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employee e
LEFT JOIN employee m ON e.mgr_id = m.emp_id
LIMIT 10;

SELECT e.emp_name AS employee, e.salary AS emp_salary, 
       m.emp_name AS manager, m.salary AS mgr_salary
FROM employee e
INNER JOIN employee m ON e.mgr_id = m.emp_id
WHERE e.salary > m.salary;

-- ============================================
-- 6. Multiple Joins
-- ============================================

SELECT e.emp_name, e.job, d.dept_name, d.location, m.emp_name AS manager
FROM employee e
LEFT JOIN department d ON e.dept_id = d.dept_id
LEFT JOIN employee m ON e.mgr_id = m.emp_id
LIMIT 10;

-- ============================================
-- 7. Join with Aggregates
-- ============================================

SELECT d.dept_name, COUNT(e.emp_id) AS employees, AVG(e.salary) AS avg_salary
FROM department d
LEFT JOIN employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

SELECT d.location, SUM(e.salary) AS total_payroll
FROM department d
INNER JOIN employee e ON d.dept_id = e.dept_id
GROUP BY d.location;

-- Exercises:
-- 1. List all employees with department names
-- 2. Find departments with no employees
-- 3. List employees who earn more than their managers
-- 4. Get employee count by location
-- 5. Find departments with average salary > 60000

-- ============================================
-- END OF PRACTICAL 08
-- ============================================
