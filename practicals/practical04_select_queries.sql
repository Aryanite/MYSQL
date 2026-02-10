-- ============================================
-- PRACTICAL 04: SELECT QUERIES
-- ============================================
-- SELECT with WHERE, ORDER BY, DISTINCT

USE company_db;

-- Basic SELECT examples using employee table
-- Make sure data is loaded using data/insert_employee.sql

-- ============================================
-- 1. SELECT ALL COLUMNS
-- ============================================

SELECT * FROM employee;
SELECT * FROM department;

-- ============================================
-- 2. SELECT SPECIFIC COLUMNS
-- ============================================

SELECT emp_name, salary FROM employee;
SELECT emp_id, emp_name, job FROM employee;
SELECT dept_name, location FROM department;

-- ============================================
-- 3. WHERE Clause - Filtering
-- ============================================

-- Equal to
SELECT * FROM employee WHERE dept_id = 1;
SELECT emp_name, salary FROM employee WHERE job = 'Manager';

-- Greater than
SELECT emp_name, salary FROM employee WHERE salary > 70000;

-- Less than
SELECT emp_name, salary FROM employee WHERE salary < 60000;

-- Greater than or equal
SELECT emp_name, hire_date FROM employee WHERE hire_date >= '2019-01-01';

-- Not equal
SELECT emp_name, dept_id FROM employee WHERE dept_id != 1;
SELECT emp_name, dept_id FROM employee WHERE dept_id <> 1;

-- ============================================
-- 4. WHERE with AND, OR, NOT
-- ============================================

-- AND
SELECT emp_name, salary, dept_id 
FROM employee 
WHERE salary > 60000 AND dept_id = 1;

-- OR
SELECT emp_name, job 
FROM employee 
WHERE job = 'Manager' OR job = 'Developer';

-- NOT
SELECT emp_name, dept_id 
FROM employee 
WHERE NOT dept_id = 2;

-- Combined
SELECT emp_name, salary, job 
FROM employee 
WHERE (job = 'Manager' OR job = 'Analyst') AND salary > 70000;

-- ============================================
-- 5. WHERE with BETWEEN
-- ============================================

SELECT emp_name, salary 
FROM employee 
WHERE salary BETWEEN 50000 AND 80000;

SELECT emp_name, hire_date 
FROM employee 
WHERE hire_date BETWEEN '2017-01-01' AND '2019-12-31';

-- ============================================
-- 6. WHERE with IN
-- ============================================

SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id IN (1, 2, 3);

SELECT emp_name, job 
FROM employee 
WHERE job IN ('Manager', 'Developer', 'Analyst');

-- NOT IN
SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id NOT IN (1, 2);

-- ============================================
-- 7. WHERE with LIKE
-- ============================================

-- Starts with 'J'
SELECT emp_name FROM employee WHERE emp_name LIKE 'J%';

-- Ends with 'son'
SELECT emp_name FROM employee WHERE emp_name LIKE '%son';

-- Contains 'an'
SELECT emp_name FROM employee WHERE emp_name LIKE '%an%';

-- Second letter 'a'
SELECT emp_name FROM employee WHERE emp_name LIKE '_a%';

-- ============================================
-- 8. WHERE with IS NULL / IS NOT NULL
-- ============================================

SELECT emp_name, mgr_id FROM employee WHERE mgr_id IS NULL;
SELECT emp_name, mgr_id FROM employee WHERE mgr_id IS NOT NULL;

-- ============================================
-- 9. DISTINCT - Remove Duplicates
-- ============================================

SELECT DISTINCT dept_id FROM employee;
SELECT DISTINCT job FROM employee;
SELECT DISTINCT dept_id, job FROM employee;

-- ============================================
-- 10. ORDER BY - Sorting
-- ============================================

-- Ascending (default)
SELECT emp_name, salary FROM employee ORDER BY salary;
SELECT emp_name, salary FROM employee ORDER BY salary ASC;

-- Descending
SELECT emp_name, salary FROM employee ORDER BY salary DESC;

-- Multiple columns
SELECT emp_name, dept_id, salary 
FROM employee 
ORDER BY dept_id ASC, salary DESC;

-- Order by position
SELECT emp_name, salary FROM employee ORDER BY 2 DESC;

-- ============================================
-- 11. LIMIT - Restrict Results
-- ============================================

SELECT * FROM employee LIMIT 5;
SELECT emp_name, salary FROM employee ORDER BY salary DESC LIMIT 3;
SELECT emp_name, hire_date FROM employee ORDER BY hire_date LIMIT 10;

-- LIMIT with offset
SELECT * FROM employee LIMIT 5, 5;  -- Skip 5, get next 5

-- ============================================
-- 12. Combining Everything
-- ============================================

SELECT emp_name, salary, dept_id 
FROM employee 
WHERE salary > 60000 AND dept_id IN (1, 2, 3)
ORDER BY salary DESC 
LIMIT 10;

SELECT DISTINCT job 
FROM employee 
WHERE salary > 55000 
ORDER BY job;

SELECT emp_name, hire_date, salary 
FROM employee 
WHERE hire_date >= '2018-01-01' AND salary BETWEEN 50000 AND 80000
ORDER BY hire_date DESC;

-- ============================================
-- PRACTICAL EXERCISES
-- ============================================

-- Ex 1: Get all employees in IT department (dept_id = 1)
-- Ex 2: Find employees with salary > 70000, sorted by salary
-- Ex 3: List unique job titles in the company
-- Ex 4: Get top 5 highest paid employees
-- Ex 5: Find employees hired in 2019
-- Ex 6: List employees whose names start with 'M' or 'S'
-- Ex 7: Get employees with no manager
-- Ex 8: Find employees in dept 1, 2, or 3 with salary > 60000

-- ============================================
-- END OF PRACTICAL 04
-- ============================================
