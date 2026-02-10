-- ============================================
-- PRACTICAL 05: AGGREGATE FUNCTIONS
-- ============================================
-- COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING

USE company_db;

-- COUNT
SELECT COUNT(*) AS total_employees FROM employee;
SELECT COUNT(DISTINCT dept_id) AS total_departments FROM employee;
SELECT COUNT(mgr_id) AS employees_with_manager FROM employee;

-- SUM
SELECT SUM(salary) AS total_payroll FROM employee;
SELECT SUM(salary) AS dept1_payroll FROM employee WHERE dept_id = 1;

-- AVG
SELECT AVG(salary) AS average_salary FROM employee;
SELECT ROUND(AVG(salary), 2) AS avg_salary FROM employee WHERE dept_id = 2;

-- MIN and MAX
SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary FROM employee;
SELECT MIN(hire_date) AS first_hire, MAX(hire_date) AS last_hire FROM employee;

-- GROUP BY
SELECT dept_id, COUNT(*) AS emp_count FROM employee GROUP BY dept_id;
SELECT dept_id, AVG(salary) AS avg_salary FROM employee GROUP BY dept_id;
SELECT job, COUNT(*) AS count, AVG(salary) AS avg_sal FROM employee GROUP BY job;

-- GROUP BY with multiple columns
SELECT dept_id, job, COUNT(*) AS count FROM employee GROUP BY dept_id, job;

-- HAVING - Filter groups
SELECT dept_id, COUNT(*) AS emp_count 
FROM employee 
GROUP BY dept_id 
HAVING COUNT(*) > 3;

SELECT dept_id, AVG(salary) AS avg_sal 
FROM employee 
GROUP BY dept_id 
HAVING AVG(salary) > 60000;

SELECT job, SUM(salary) AS total_sal 
FROM employee 
GROUP BY job 
HAVING SUM(salary) > 200000;

-- WHERE + GROUP BY + HAVING
SELECT dept_id, AVG(salary) AS avg_salary 
FROM employee 
WHERE salary > 50000 
GROUP BY dept_id 
HAVING AVG(salary) > 65000;

-- Combined statistics
SELECT 
    dept_id,
    COUNT(*) AS employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employee 
GROUP BY dept_id;

-- Exercises:
-- 1. Find total number of employees
-- 2. Calculate average salary by department
-- 3. Find departments with more than 5 employees
-- 4. Get job titles with avg salary > 70000
-- 5. Count employees hired each year

-- ============================================
-- END OF PRACTICAL 05
-- ============================================
