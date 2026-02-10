-- ============================================
-- AGGREGATE FUNCTIONS IN SQL
-- ============================================
-- COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING

USE company_db;

-- ============================================
-- 1. COUNT - Count Number of Rows
-- ============================================

-- Count total number of employees
SELECT COUNT(*) AS total_employees 
FROM employee;

-- Count employees in a specific department
SELECT COUNT(*) AS dept1_employees 
FROM employee 
WHERE dept_id = 1;

-- Count non-null values in a column
SELECT COUNT(mgr_id) AS employees_with_manager 
FROM employee;

-- Count distinct values (unique departments)
SELECT COUNT(DISTINCT dept_id) AS number_of_departments 
FROM employee;

-- Count distinct job titles
SELECT COUNT(DISTINCT job) AS unique_jobs 
FROM employee;


-- ============================================
-- 2. SUM - Calculate Total
-- ============================================

-- Total salary expense for company
SELECT SUM(salary) AS total_salary_expense 
FROM employee;

-- Total salary for specific department
SELECT SUM(salary) AS dept1_total_salary 
FROM employee 
WHERE dept_id = 1;

-- Total salary for employees hired after 2020
SELECT SUM(salary) AS recent_hires_salary 
FROM employee 
WHERE hire_date > '2020-01-01';


-- ============================================
-- 3. AVG - Calculate Average
-- ============================================

-- Average salary of all employees
SELECT AVG(salary) AS average_salary 
FROM employee;

-- Average salary in department 2
SELECT AVG(salary) AS dept2_avg_salary 
FROM employee 
WHERE dept_id = 2;

-- Average salary for each job title (preview for GROUP BY)
SELECT job, AVG(salary) AS avg_salary 
FROM employee 
GROUP BY job;

-- Round average to 2 decimal places
SELECT ROUND(AVG(salary), 2) AS average_salary 
FROM employee;


-- ============================================
-- 4. MIN - Find Minimum Value
-- ============================================

-- Lowest salary in company
SELECT MIN(salary) AS minimum_salary 
FROM employee;

-- Earliest hire date
SELECT MIN(hire_date) AS first_hire_date 
FROM employee;

-- Lowest salary in department 1
SELECT MIN(salary) AS dept1_min_salary 
FROM employee 
WHERE dept_id = 1;

-- Employee with minimum salary (using subquery)
SELECT emp_name, salary 
FROM employee 
WHERE salary = (SELECT MIN(salary) FROM employee);


-- ============================================
-- 5. MAX - Find Maximum Value
-- ============================================

-- Highest salary in company
SELECT MAX(salary) AS maximum_salary 
FROM employee;

-- Most recent hire date
SELECT MAX(hire_date) AS latest_hire_date 
FROM employee;

-- Highest salary in department 3
SELECT MAX(salary) AS dept3_max_salary 
FROM employee 
WHERE dept_id = 3;

-- Employee with maximum salary
SELECT emp_name, salary 
FROM employee 
WHERE salary = (SELECT MAX(salary) FROM employee);


-- ============================================
-- 6. COMBINING MULTIPLE AGGREGATES
-- ============================================

-- Get all statistics in one query
SELECT 
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employee;

-- Statistics for specific department
SELECT 
    COUNT(*) AS employee_count,
    SUM(salary) AS total_cost,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) AS lowest,
    MAX(salary) AS highest
FROM employee 
WHERE dept_id = 1;


-- ============================================
-- 7. GROUP BY - Group Results
-- ============================================

-- Count employees in each department
SELECT dept_id, COUNT(*) AS employee_count 
FROM employee 
GROUP BY dept_id;

-- Average salary by department
SELECT dept_id, AVG(salary) AS avg_salary 
FROM employee 
GROUP BY dept_id;

-- Total salary expense by department
SELECT dept_id, SUM(salary) AS total_expense 
FROM employee 
GROUP BY dept_id;

-- Statistics by job title
SELECT 
    job,
    COUNT(*) AS num_employees,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employee 
GROUP BY job;

-- Multiple column grouping (department and job)
SELECT 
    dept_id,
    job,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary
FROM employee 
GROUP BY dept_id, job;


-- ============================================
-- 8. GROUP BY with ORDER BY
-- ============================================

-- Departments sorted by average salary (highest first)
SELECT dept_id, AVG(salary) AS avg_salary 
FROM employee 
GROUP BY dept_id 
ORDER BY avg_salary DESC;

-- Job titles sorted by number of employees
SELECT job, COUNT(*) AS employee_count 
FROM employee 
GROUP BY job 
ORDER BY employee_count DESC;

-- Departments by total salary expense
SELECT 
    dept_id,
    SUM(salary) AS total_expense
FROM employee 
GROUP BY dept_id 
ORDER BY total_expense DESC;


-- ============================================
-- 9. HAVING - Filter Groups
-- ============================================

-- HAVING is used to filter groups (WHERE filters rows)

-- Departments with more than 3 employees
SELECT dept_id, COUNT(*) AS employee_count 
FROM employee 
GROUP BY dept_id 
HAVING COUNT(*) > 3;

-- Departments with average salary > 55000
SELECT dept_id, AVG(salary) AS avg_salary 
FROM employee 
GROUP BY dept_id 
HAVING AVG(salary) > 55000;

-- Job titles with total salary expense > 200000
SELECT job, SUM(salary) AS total_expense 
FROM employee 
GROUP BY job 
HAVING SUM(salary) > 200000;

-- Departments with min salary > 40000
SELECT dept_id, MIN(salary) AS min_salary 
FROM employee 
GROUP BY dept_id 
HAVING MIN(salary) > 40000;


-- ============================================
-- 10. WHERE vs HAVING
-- ============================================

-- WHERE filters rows BEFORE grouping
-- HAVING filters groups AFTER grouping

-- Example 1: Filter first, then group
SELECT dept_id, AVG(salary) AS avg_salary 
FROM employee 
WHERE salary > 40000  -- Filter: only employees with salary > 40000
GROUP BY dept_id;

-- Example 2: Group first, then filter groups
SELECT dept_id, AVG(salary) AS avg_salary 
FROM employee 
GROUP BY dept_id 
HAVING AVG(salary) > 50000;  -- Filter: only departments with avg > 50000

-- Example 3: Using both WHERE and HAVING
SELECT 
    dept_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary
FROM employee 
WHERE salary > 30000          -- First: filter rows
GROUP BY dept_id              -- Then: group
HAVING COUNT(*) >= 2;         -- Finally: filter groups


-- ============================================
-- 11. GROUP BY with JOIN
-- ============================================

-- Employee count and average salary by department name
SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM employee e
JOIN department d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- Total salary expense by location
SELECT 
    d.location,
    SUM(e.salary) AS total_expense
FROM employee e
JOIN department d ON e.dept_id = d.dept_id
GROUP BY d.location;


-- ============================================
-- 12. SALARY CALCULATIONS
-- ============================================

-- Calculate salary ranges by department
SELECT 
    dept_id,
    COUNT(*) AS employees,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary,
    MAX(salary) - MIN(salary) AS salary_range,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employee 
GROUP BY dept_id;

-- Monthly vs Annual salary expenses by department
SELECT 
    dept_id,
    SUM(salary) AS monthly_expense,
    SUM(salary * 12) AS annual_expense
FROM employee 
GROUP BY dept_id;

-- Percentage of total salary by department
SELECT 
    dept_id,
    SUM(salary) AS dept_total,
    ROUND((SUM(salary) * 100.0 / (SELECT SUM(salary) FROM employee)), 2) AS percentage_of_total
FROM employee 
GROUP BY dept_id;


-- ============================================
-- 13. YEAR-WISE HIRING ANALYSIS
-- ============================================

-- Count employees hired each year
SELECT 
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS employees_hired
FROM employee 
GROUP BY YEAR(hire_date)
ORDER BY hire_year;

-- Average salary by hire year
SELECT 
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS employees,
    ROUND(AVG(salary), 2) AS avg_starting_salary
FROM employee 
GROUP BY YEAR(hire_date)
ORDER BY hire_year;


-- ============================================
-- 14. ADVANCED AGGREGATIONS
-- ============================================

-- Find departments where ALL employees earn > 40000
SELECT dept_id 
FROM employee 
GROUP BY dept_id 
HAVING MIN(salary) > 40000;

-- Departments with salary variance
SELECT 
    dept_id,
    COUNT(*) AS emp_count,
    MIN(salary) AS min_sal,
    MAX(salary) AS max_sal,
    ROUND(AVG(salary), 2) AS avg_sal,
    ROUND(STDDEV(salary), 2) AS std_deviation
FROM employee 
GROUP BY dept_id;

-- Get top 3 departments by average salary
SELECT 
    dept_id,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employee 
GROUP BY dept_id 
ORDER BY avg_salary DESC 
LIMIT 3;


-- ============================================
-- PRACTICE EXERCISES
-- ============================================

-- Exercise 1: Count total number of departments
-- Your query here:


-- Exercise 2: Find the average salary for job = 'Manager'
-- Your query here:


-- Exercise 3: Get departments with more than 5 employees
-- Your query here:


-- Exercise 4: Calculate total annual salary expense (monthly * 12)
-- Your query here:


-- Exercise 5: Find job titles with average salary > 60000
-- Your query here:


-- Exercise 6: Get the department with highest total salary expense
-- Your query here:


-- Exercise 7: Count employees hired each month of 2020
-- Your query here:


-- ============================================
-- END OF AGGREGATE FUNCTIONS
-- ============================================
