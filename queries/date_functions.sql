-- ============================================
-- DATE AND TIME FUNCTIONS IN SQL
-- ============================================
-- Working with dates, times, and timestamps

USE company_db;

-- ============================================
-- 1. CURRENT DATE AND TIME FUNCTIONS
-- ============================================

-- Get current date (YYYY-MM-DD)
SELECT CURDATE() AS current_date;
SELECT CURRENT_DATE() AS current_date;

-- Get current time (HH:MM:SS)
SELECT CURTIME() AS current_time;
SELECT CURRENT_TIME() AS current_time;

-- Get current date and time (YYYY-MM-DD HH:MM:SS)
SELECT NOW() AS current_datetime;
SELECT CURRENT_TIMESTAMP() AS current_timestamp;
SELECT SYSDATE() AS system_date;

-- Get current timestamp (seconds since 1970-01-01)
SELECT UNIX_TIMESTAMP() AS unix_timestamp;


-- ============================================
-- 2. EXTRACTING PARTS OF DATE
-- ============================================

-- Extract year, month, day from date
SELECT 
    hire_date,
    YEAR(hire_date) AS hire_year,
    MONTH(hire_date) AS hire_month,
    DAY(hire_date) AS hire_day
FROM employee;

-- Get month name and day name
SELECT 
    hire_date,
    MONTHNAME(hire_date) AS month_name,
    DAYNAME(hire_date) AS day_name
FROM employee;

-- Get day of week (1=Sunday, 7=Saturday)
SELECT 
    hire_date,
    DAYOFWEEK(hire_date) AS day_of_week,
    DAYNAME(hire_date) AS day_name
FROM employee;

-- Get day of year (1-365/366)
SELECT 
    hire_date,
    DAYOFYEAR(hire_date) AS day_of_year
FROM employee;

-- Get week number in year
SELECT 
    hire_date,
    WEEK(hire_date) AS week_number
FROM employee;

-- Get quarter (1-4)
SELECT 
    hire_date,
    QUARTER(hire_date) AS quarter
FROM employee;


-- ============================================
-- 3. EXTRACTING TIME PARTS
-- ============================================

-- From a timestamp, extract time components
SELECT 
    NOW() AS current_datetime,
    HOUR(NOW()) AS current_hour,
    MINUTE(NOW()) AS current_minute,
    SECOND(NOW()) AS current_second;


-- ============================================
-- 4. DATE FORMATTING
-- ============================================

-- Format date in different ways
SELECT 
    hire_date,
    DATE_FORMAT(hire_date, '%d/%m/%Y') AS 'DD/MM/YYYY',
    DATE_FORMAT(hire_date, '%m-%d-%Y') AS 'MM-DD-YYYY',
    DATE_FORMAT(hire_date, '%M %d, %Y') AS 'Month DD, YYYY',
    DATE_FORMAT(hire_date, '%W, %M %d, %Y') AS 'Day, Month DD, YYYY'
FROM employee;

-- Common format specifiers:
-- %Y - 4-digit year (2023)
-- %y - 2-digit year (23)
-- %M - Full month name (January)
-- %m - Month number (01-12)
-- %b - Short month name (Jan)
-- %d - Day of month (01-31)
-- %D - Day with suffix (1st, 2nd, 3rd)
-- %W - Full weekday name (Monday)
-- %w - Weekday number (0=Sunday)
-- %a - Short weekday name (Mon)
-- %H - Hour (00-23)
-- %h - Hour (01-12)
-- %i - Minutes (00-59)
-- %s - Seconds (00-59)
-- %p - AM/PM

-- More formatting examples
SELECT 
    hire_date,
    DATE_FORMAT(hire_date, '%d-%b-%Y') AS format1,
    DATE_FORMAT(hire_date, '%D %M %Y') AS format2,
    DATE_FORMAT(hire_date, '%W %d %M %Y') AS format3
FROM employee;

-- Format current datetime
SELECT 
    DATE_FORMAT(NOW(), '%W, %M %D, %Y at %h:%i %p') AS formatted_now;


-- ============================================
-- 5. DATE CALCULATIONS - DATEDIFF
-- ============================================

-- Calculate days between hire date and today
SELECT 
    emp_name,
    hire_date,
    CURDATE() AS today,
    DATEDIFF(CURDATE(), hire_date) AS days_employed
FROM employee;

-- Calculate years of service (approximate)
SELECT 
    emp_name,
    hire_date,
    DATEDIFF(CURDATE(), hire_date) / 365 AS years_of_service
FROM employee;

-- Find employees hired in last 365 days
SELECT emp_name, hire_date 
FROM employee 
WHERE DATEDIFF(CURDATE(), hire_date) <= 365;

-- Days between two specific dates
SELECT DATEDIFF('2024-12-31', '2024-01-01') AS days_in_2024;


-- ============================================
-- 6. DATE ARITHMETIC - DATE_ADD / DATE_SUB
-- ============================================

-- Add days to a date
SELECT 
    hire_date,
    DATE_ADD(hire_date, INTERVAL 30 DAY) AS after_30_days,
    DATE_ADD(hire_date, INTERVAL 1 MONTH) AS after_1_month,
    DATE_ADD(hire_date, INTERVAL 1 YEAR) AS after_1_year
FROM employee;

-- Subtract days from a date
SELECT 
    CURDATE() AS today,
    DATE_SUB(CURDATE(), INTERVAL 7 DAY) AS last_week,
    DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AS last_month,
    DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AS last_year;

-- Calculate employee anniversary dates
SELECT 
    emp_name,
    hire_date,
    DATE_ADD(hire_date, INTERVAL 1 YEAR) AS first_anniversary,
    DATE_ADD(hire_date, INTERVAL 5 YEAR) AS fifth_anniversary
FROM employee;

-- Probation end date (90 days after hire)
SELECT 
    emp_name,
    hire_date,
    DATE_ADD(hire_date, INTERVAL 90 DAY) AS probation_end
FROM employee;


-- ============================================
-- 7. INTERVAL TYPES
-- ============================================

-- Various interval examples
SELECT 
    NOW() AS current_time,
    DATE_ADD(NOW(), INTERVAL 5 SECOND) AS plus_5_seconds,
    DATE_ADD(NOW(), INTERVAL 10 MINUTE) AS plus_10_minutes,
    DATE_ADD(NOW(), INTERVAL 2 HOUR) AS plus_2_hours,
    DATE_ADD(NOW(), INTERVAL 7 DAY) AS plus_7_days,
    DATE_ADD(NOW(), INTERVAL 2 WEEK) AS plus_2_weeks,
    DATE_ADD(NOW(), INTERVAL 3 MONTH) AS plus_3_months,
    DATE_ADD(NOW(), INTERVAL 1 YEAR) AS plus_1_year;


-- ============================================
-- 8. AGE CALCULATIONS
-- ============================================

-- Calculate age from date of birth
-- Assuming we have a DOB column (example with hire_date instead)
SELECT 
    emp_name,
    hire_date,
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_since_hired,
    TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) AS months_since_hired,
    TIMESTAMPDIFF(DAY, hire_date, CURDATE()) AS days_since_hired
FROM employee;


-- ============================================
-- 9. LAST DAY OF MONTH
-- ============================================

-- Get last day of current month
SELECT LAST_DAY(CURDATE()) AS last_day_current_month;

-- Last day of hire month
SELECT 
    emp_name,
    hire_date,
    LAST_DAY(hire_date) AS last_day_of_hire_month
FROM employee;


-- ============================================
-- 10. CREATING DATES FROM PARTS
-- ============================================

-- Create date from year, month, day
SELECT MAKEDATE(2024, 100) AS date_from_day_of_year;

-- Create time from hours, minutes, seconds
SELECT MAKETIME(14, 30, 45) AS time_created;


-- ============================================
-- 11. DATE QUERIES - Filtering by Date
-- ============================================

-- Employees hired in specific year
SELECT emp_name, hire_date 
FROM employee 
WHERE YEAR(hire_date) = 2020;

-- Employees hired in specific month
SELECT emp_name, hire_date 
FROM employee 
WHERE MONTH(hire_date) = 6;

-- Employees hired in Q1 (January-March)
SELECT emp_name, hire_date 
FROM employee 
WHERE QUARTER(hire_date) = 1;

-- Employees hired on Monday
SELECT emp_name, hire_date, DAYNAME(hire_date) AS day 
FROM employee 
WHERE DAYOFWEEK(hire_date) = 2;

-- Employees hired in last 30 days
SELECT emp_name, hire_date 
FROM employee 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Employees hired between two dates
SELECT emp_name, hire_date 
FROM employee 
WHERE hire_date BETWEEN '2019-01-01' AND '2020-12-31';


-- ============================================
-- 12. GROUP BY with Date Functions
-- ============================================

-- Count employees hired each year
SELECT 
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS employees_hired
FROM employee 
GROUP BY YEAR(hire_date)
ORDER BY hire_year;

-- Count employees hired each month
SELECT 
    YEAR(hire_date) AS year,
    MONTHNAME(hire_date) AS month,
    COUNT(*) AS employees_hired
FROM employee 
GROUP BY YEAR(hire_date), MONTH(hire_date)
ORDER BY year, MONTH(hire_date);

-- Average salary by hire year
SELECT 
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS emp_count,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employee 
GROUP BY YEAR(hire_date);


-- ============================================
-- 13. TIME ZONE FUNCTIONS
-- ============================================

-- Convert to different time zone
SELECT 
    NOW() AS local_time,
    CONVERT_TZ(NOW(), '+00:00', '+05:30') AS india_time,
    CONVERT_TZ(NOW(), '+00:00', '-05:00') AS eastern_time;


-- ============================================
-- 14. PRACTICAL EXAMPLES
-- ============================================

-- Find employees completing 1 year this month
SELECT 
    emp_name,
    hire_date,
    DATE_ADD(hire_date, INTERVAL 1 YEAR) AS anniversary_date
FROM employee 
WHERE MONTH(DATE_ADD(hire_date, INTERVAL 1 YEAR)) = MONTH(CURDATE())
  AND YEAR(DATE_ADD(hire_date, INTERVAL 1 YEAR)) = YEAR(CURDATE());

-- Calculate weekend days in a period
SELECT 
    emp_name,
    hire_date,
    DAYNAME(hire_date) AS hired_on_day,
    CASE 
        WHEN DAYOFWEEK(hire_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type
FROM employee;

-- Seniority analysis
SELECT 
    emp_name,
    hire_date,
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 1 THEN 'New'
        WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 3 THEN 'Junior'
        WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 5 THEN 'Mid-level'
        ELSE 'Senior'
    END AS seniority_level
FROM employee;


-- ============================================
-- PRACTICE EXERCISES
-- ============================================

-- Exercise 1: List employees with their tenure in years and months
-- Your query here:


-- Exercise 2: Find employees hired in the same month as today
-- Your query here:


-- Exercise 3: Calculate retirement date (hire_date + 35 years)
-- Your query here:


-- Exercise 4: Count employees by day of week they were hired
-- Your query here:


-- Exercise 5: Find employees whose hire date anniversary is next month
-- Your query here:


-- Exercise 6: Format current date as "Day, DD Month YYYY"
-- Your query here:


-- ============================================
-- END OF DATE FUNCTIONS
-- ============================================
