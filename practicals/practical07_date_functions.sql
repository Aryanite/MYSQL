-- ============================================
-- PRACTICAL 07: DATE AND TIME FUNCTIONS
-- ============================================

USE company_db;

-- Current date and time
SELECT NOW(), CURDATE(), CURTIME();
SELECT CURRENT_TIMESTAMP(), CURRENT_DATE(), CURRENT_TIME();

-- Extract parts
SELECT hire_date, YEAR(hire_date), MONTH(hire_date), DAY(hire_date) FROM employee LIMIT 5;
SELECT hire_date, MONTHNAME(hire_date), DAYNAME(hire_date) FROM employee LIMIT 5;
SELECT hire_date, QUARTER(hire_date), WEEK(hire_date) FROM employee LIMIT 5;

-- Date formatting
SELECT hire_date, DATE_FORMAT(hire_date, '%d/%m/%Y') AS formatted FROM employee LIMIT 5;
SELECT hire_date, DATE_FORMAT(hire_date, '%M %d, %Y') AS formatted FROM employee LIMIT 5;

-- Date calculations
SELECT emp_name, hire_date, DATEDIFF(CURDATE(), hire_date) AS days_employed FROM employee;
SELECT emp_name, hire_date, TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years FROM employee;

-- Date arithmetic
SELECT hire_date, DATE_ADD(hire_date, INTERVAL 1 YEAR) AS anniversary FROM employee LIMIT 5;
SELECT hire_date, DATE_SUB(hire_date, INTERVAL 6 MONTH) AS six_months_before FROM employee LIMIT 5;
SELECT CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY) AS next_month;

-- Filtering by date
SELECT emp_name, hire_date FROM employee WHERE YEAR(hire_date) = 2019;
SELECT emp_name, hire_date FROM employee WHERE MONTH(hire_date) = 6;
SELECT emp_name, hire_date FROM employee WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- Group by date parts
SELECT YEAR(hire_date) AS year, COUNT(*) AS hires FROM employee GROUP BY YEAR(hire_date);
SELECT MONTHNAME(hire_date) AS month, COUNT(*) FROM employee GROUP BY MONTH(hire_date);

-- Exercises:
-- 1. Find employees hired in last 365 days
-- 2. Calculate years of service for each employee
-- 3. List employees with anniversaries this month
-- 4. Format hire_date as "Day, DD Month YYYY"
-- 5. Count hires per quarter

-- ============================================
-- END OF PRACTICAL 07
-- ============================================
