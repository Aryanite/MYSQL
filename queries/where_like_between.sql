-- ============================================
-- WHERE, LIKE, BETWEEN, IN QUERIES
-- ============================================
-- This file demonstrates filtering and pattern matching

USE company_db;

-- ============================================
-- 1. WHERE CLAUSE - Basic Filtering
-- ============================================

-- Get employees with salary greater than 50000
SELECT emp_name, salary 
FROM employee 
WHERE salary > 50000;

-- Get employees in department 1
SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id = 1;

-- Get employees with specific job title
SELECT emp_name, job 
FROM employee 
WHERE job = 'Manager';

-- Get employees hired after a specific date
SELECT emp_name, hire_date 
FROM employee 
WHERE hire_date > '2020-01-01';


-- ============================================
-- 2. COMPARISON OPERATORS
-- ============================================

-- Equal to (=)
SELECT * FROM employee WHERE dept_id = 2;

-- Not equal to (!= or <>)
SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id != 1;

-- Greater than (>)
SELECT emp_name, salary 
FROM employee 
WHERE salary > 60000;

-- Less than (<)
SELECT emp_name, salary 
FROM employee 
WHERE salary < 40000;

-- Greater than or equal to (>=)
SELECT emp_name, salary 
FROM employee 
WHERE salary >= 50000;

-- Less than or equal to (<=)
SELECT emp_name, salary 
FROM employee 
WHERE salary <= 45000;


-- ============================================
-- 3. LOGICAL OPERATORS (AND, OR, NOT)
-- ============================================

-- AND - Both conditions must be true
SELECT emp_name, salary, dept_id 
FROM employee 
WHERE salary > 50000 AND dept_id = 1;

-- OR - At least one condition must be true
SELECT emp_name, salary, dept_id 
FROM employee 
WHERE dept_id = 1 OR dept_id = 2;

-- NOT - Negates a condition
SELECT emp_name, dept_id 
FROM employee 
WHERE NOT dept_id = 3;

-- Complex condition with AND, OR
SELECT emp_name, job, salary 
FROM employee 
WHERE (job = 'Manager' OR job = 'Analyst') 
  AND salary > 55000;


-- ============================================
-- 4. BETWEEN - Range Queries
-- ============================================

-- Get employees with salary between 40000 and 60000 (inclusive)
SELECT emp_name, salary 
FROM employee 
WHERE salary BETWEEN 40000 AND 60000;

-- NOT BETWEEN - Outside range
SELECT emp_name, salary 
FROM employee 
WHERE salary NOT BETWEEN 40000 AND 60000;

-- BETWEEN with dates
SELECT emp_name, hire_date 
FROM employee 
WHERE hire_date BETWEEN '2019-01-01' AND '2021-12-31';

-- BETWEEN with strings (alphabetical range)
SELECT emp_name 
FROM employee 
WHERE emp_name BETWEEN 'A' AND 'M'
ORDER BY emp_name;


-- ============================================
-- 5. IN - Multiple Values
-- ============================================

-- Get employees in specific departments
SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id IN (1, 2, 3);

-- Get employees with specific job titles
SELECT emp_name, job 
FROM employee 
WHERE job IN ('Manager', 'Analyst', 'Clerk');

-- NOT IN - Exclude specific values
SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id NOT IN (1, 3);

-- IN with subquery (employees in departments located in 'New York')
SELECT emp_name 
FROM employee 
WHERE dept_id IN (
    SELECT dept_id 
    FROM department 
    WHERE location = 'New York'
);


-- ============================================
-- 6. LIKE - Pattern Matching
-- ============================================

-- % matches any sequence of characters (0 or more)
-- _ matches exactly one character

-- Names starting with 'J'
SELECT emp_name 
FROM employee 
WHERE emp_name LIKE 'J%';

-- Names ending with 'son'
SELECT emp_name 
FROM employee 
WHERE emp_name LIKE '%son';

-- Names containing 'an'
SELECT emp_name 
FROM employee 
WHERE emp_name LIKE '%an%';

-- Names starting with 'S' and ending with 'h'
SELECT emp_name 
FROM employee 
WHERE emp_name LIKE 'S%h';

-- Names with exactly 4 characters (four underscores)
SELECT emp_name 
FROM employee 
WHERE emp_name LIKE '____';

-- Names with second letter 'o'
SELECT emp_name 
FROM employee 
WHERE emp_name LIKE '_o%';

-- NOT LIKE - Exclude pattern
SELECT emp_name 
FROM employee 
WHERE emp_name NOT LIKE 'A%';


-- ============================================
-- 7. LIKE with Numbers
-- ============================================

-- Employee IDs starting with '10'
SELECT emp_id, emp_name 
FROM employee 
WHERE emp_id LIKE '10%';

-- Salaries ending in '000'
SELECT emp_name, salary 
FROM employee 
WHERE salary LIKE '%000';


-- ============================================
-- 8. IS NULL / IS NOT NULL
-- ============================================

-- Find employees with no manager
SELECT emp_name, mgr_id 
FROM employee 
WHERE mgr_id IS NULL;

-- Find employees who have a manager
SELECT emp_name, mgr_id 
FROM employee 
WHERE mgr_id IS NOT NULL;

-- Employees with no department assigned
SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id IS NULL;


-- ============================================
-- 9. COMBINING CONDITIONS
-- ============================================

-- Employees in IT or HR with salary > 50000
SELECT emp_name, job, salary 
FROM employee 
WHERE (job = 'Developer' OR job = 'HR Manager') 
  AND salary > 50000;

-- Employees hired in 2020 with salary between 40k-60k
SELECT emp_name, hire_date, salary 
FROM employee 
WHERE hire_date BETWEEN '2020-01-01' AND '2020-12-31'
  AND salary BETWEEN 40000 AND 60000;

-- Names starting with A, B, or C and salary > 45000
SELECT emp_name, salary 
FROM employee 
WHERE (emp_name LIKE 'A%' OR emp_name LIKE 'B%' OR emp_name LIKE 'C%')
  AND salary > 45000;


-- ============================================
-- 10. CASE-INSENSITIVE SEARCHING
-- ============================================

-- MySQL is case-insensitive by default for LIKE
-- These both work the same:
SELECT emp_name FROM employee WHERE emp_name LIKE 'john%';
SELECT emp_name FROM employee WHERE emp_name LIKE 'JOHN%';

-- For case-sensitive search, use BINARY
SELECT emp_name 
FROM employee 
WHERE BINARY emp_name LIKE 'John%';


-- ============================================
-- 11. COMPLEX PATTERN MATCHING
-- ============================================

-- Email addresses ending with specific domain
SELECT emp_name, email 
FROM employee 
WHERE email LIKE '%@company.com';

-- Phone numbers with specific area code
SELECT emp_name, phone 
FROM employee 
WHERE phone LIKE '555%';

-- Find employees with middle initial
SELECT emp_name 
FROM employee 
WHERE emp_name LIKE '% _.%';


-- ============================================
-- 12. PERFORMANCE TIPS
-- ============================================

-- Avoid leading wildcards (slower)
-- SLOW: LIKE '%John'
-- FAST: LIKE 'John%'

-- Use BETWEEN instead of >= AND <=
-- BETTER: salary BETWEEN 40000 AND 60000
-- WORKS: salary >= 40000 AND salary <= 60000


-- ============================================
-- PRACTICE EXERCISES
-- ============================================

-- Exercise 1: Find employees with names starting with 'M' or 'S'
-- Your query here:


-- Exercise 2: Get employees with salary NOT between 30000 and 70000
-- Your query here:


-- Exercise 3: Find employees in dept 1, 2, or 4 with job as 'Analyst'
-- Your query here:


-- Exercise 4: List employees hired between 2018 and 2020
-- Your query here:


-- Exercise 5: Find employees whose names contain 'er' and salary > 45000
-- Your query here:


-- Exercise 6: Get employees with 5-letter names
-- Your query here:


-- Exercise 7: Find employees not in departments 1 and 3
-- Your query here:


-- ============================================
-- END OF WHERE/LIKE/BETWEEN QUERIES
-- ============================================
