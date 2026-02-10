-- ============================================
-- BASIC SQL QUERIES
-- ============================================
-- This file contains fundamental SELECT queries for beginners

-- Ensure you're using the correct database
USE company_db;

-- ============================================
-- 1. SELECT ALL COLUMNS
-- ============================================

-- Retrieve all columns and rows from employee table
SELECT * FROM employee;

-- Retrieve all columns and rows from department table
SELECT * FROM department;


-- ============================================
-- 2. SELECT SPECIFIC COLUMNS
-- ============================================

-- Get only employee names and salaries
SELECT emp_name, salary FROM employee;

-- Get employee ID and job title
SELECT emp_id, job FROM employee;

-- Get department names and locations
SELECT dept_name, location FROM department;


-- ============================================
-- 3. USING COLUMN ALIASES
-- ============================================

-- Rename columns in output for better readability
SELECT emp_name AS 'Employee Name', 
       salary AS 'Monthly Salary' 
FROM employee;

-- Alias without AS keyword (also works)
SELECT emp_name 'Name', 
       job 'Position', 
       salary 'Salary' 
FROM employee;

-- Calculate annual salary with alias
SELECT emp_name, 
       salary AS monthly_salary,
       salary * 12 AS annual_salary
FROM employee;


-- ============================================
-- 4. DISTINCT - Remove Duplicates
-- ============================================

-- Get unique job titles
SELECT DISTINCT job FROM employee;

-- Get unique department IDs
SELECT DISTINCT dept_id FROM employee;

-- Get unique combinations of job and department
SELECT DISTINCT job, dept_id FROM employee;


-- ============================================
-- 5. SIMPLE CALCULATIONS
-- ============================================

-- Calculate annual salary for all employees
SELECT emp_name, 
       salary,
       salary * 12 AS annual_salary
FROM employee;

-- Add 10% bonus to salary
SELECT emp_name,
       salary,
       salary * 1.10 AS salary_with_bonus
FROM employee;

-- Calculate tax (assuming 20% tax)
SELECT emp_name,
       salary,
       salary * 0.20 AS tax,
       salary * 0.80 AS salary_after_tax
FROM employee;


-- ============================================
-- 6. ORDER BY - Sorting Results
-- ============================================

-- Sort employees by name (ascending - default)
SELECT emp_name, salary 
FROM employee 
ORDER BY emp_name;

-- Sort by salary (ascending)
SELECT emp_name, salary 
FROM employee 
ORDER BY salary;

-- Sort by salary (descending - highest first)
SELECT emp_name, salary 
FROM employee 
ORDER BY salary DESC;

-- Sort by multiple columns: first by dept_id, then by salary
SELECT emp_name, dept_id, salary 
FROM employee 
ORDER BY dept_id ASC, salary DESC;

-- Sort by job title descending, then name ascending
SELECT emp_name, job, salary 
FROM employee 
ORDER BY job DESC, emp_name ASC;


-- ============================================
-- 7. LIMIT - Restrict Number of Results
-- ============================================

-- Get only first 5 employees
SELECT * FROM employee LIMIT 5;

-- Get top 3 highest paid employees
SELECT emp_name, salary 
FROM employee 
ORDER BY salary DESC 
LIMIT 3;

-- Get employees ranked 4-6 by salary (skip 3, get next 3)
SELECT emp_name, salary 
FROM employee 
ORDER BY salary DESC 
LIMIT 3, 3;

-- Get 5 employees with lowest salaries
SELECT emp_name, salary 
FROM employee 
ORDER BY salary ASC 
LIMIT 5;


-- ============================================
-- 8. COMBINING MULTIPLE CONCEPTS
-- ============================================

-- Get unique jobs, sorted alphabetically
SELECT DISTINCT job 
FROM employee 
ORDER BY job;

-- Top 5 earners with formatted output
SELECT emp_name AS 'Employee',
       job AS 'Position',
       salary AS 'Salary'
FROM employee
ORDER BY salary DESC
LIMIT 5;

-- Employees with annual salary, sorted by annual salary
SELECT emp_name,
       salary AS monthly,
       salary * 12 AS yearly
FROM employee
ORDER BY yearly DESC;


-- ============================================
-- 9. LITERAL VALUES IN SELECT
-- ============================================

-- Add constant text to results
SELECT emp_name, 
       'works as' AS description, 
       job
FROM employee;

-- Add fixed values
SELECT emp_name,
       salary,
       'USD' AS currency
FROM employee;


-- ============================================
-- 10. MATHEMATICAL OPERATIONS
-- ============================================

-- Various calculations
SELECT emp_name,
       salary,
       salary + 5000 AS 'Salary + Bonus',
       salary - 1000 AS 'Salary - Tax',
       salary * 2 AS 'Double Salary',
       salary / 2 AS 'Half Salary'
FROM employee
LIMIT 5;


-- ============================================
-- PRACTICE EXERCISES
-- ============================================

-- Exercise 1: List all employees alphabetically by name
-- Your query here:


-- Exercise 2: Show top 10 highest paid employees
-- Your query here:


-- Exercise 3: Display unique departments from employee table
-- Your query here:


-- Exercise 4: Calculate quarterly salary (salary * 3) for all employees
-- Your query here:


-- Exercise 5: Show employees sorted by hire_date (newest first)
-- Your query here:


-- ============================================
-- END OF BASIC QUERIES
-- ============================================
