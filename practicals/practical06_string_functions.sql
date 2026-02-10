-- ============================================
-- PRACTICAL 06: STRING FUNCTIONS
-- ============================================
-- CONCAT, SUBSTRING, LENGTH, UPPER, LOWER, etc.

USE company_db;

-- ============================================
-- 1. CONCAT - Concatenate Strings
-- ============================================

SELECT CONCAT(emp_name, ' - ', job) AS employee_info FROM employee LIMIT 5;
SELECT CONCAT('Employee: ', emp_name, ', Salary: $', salary) FROM employee LIMIT 5;
SELECT CONCAT_WS(' | ', emp_name, job, dept_id) AS info FROM employee LIMIT 5;

-- ============================================
-- 2. LENGTH - String Length
-- ============================================

SELECT emp_name, LENGTH(emp_name) AS name_length FROM employee LIMIT 10;
SELECT emp_name FROM employee WHERE LENGTH(emp_name) > 12;

-- ============================================
-- 3. UPPER and LOWER - Case Conversion
-- ============================================

SELECT UPPER(emp_name) AS uppercase_name FROM employee LIMIT 5;
SELECT LOWER(emp_name) AS lowercase_name FROM employee LIMIT 5;
SELECT CONCAT(UPPER(LEFT(emp_name, 1)), LOWER(SUBSTRING(emp_name, 2))) FROM employee LIMIT 5;

-- ============================================
-- 4. SUBSTRING - Extract Substring
-- ============================================

SELECT SUBSTRING(emp_name, 1, 5) AS first_5_chars FROM employee LIMIT 5;
SELECT SUBSTRING(emp_name, -3) AS last_3_chars FROM employee LIMIT 5;
SELECT LEFT(emp_name, 4) AS first_4 FROM employee LIMIT 5;
SELECT RIGHT(emp_name, 4) AS last_4 FROM employee LIMIT 5;

-- ============================================
-- 5. TRIM, LTRIM, RTRIM - Remove Spaces
-- ============================================

SELECT TRIM('   Hello World   ') AS trimmed;
SELECT LTRIM('   Hello World') AS left_trimmed;
SELECT RTRIM('Hello World   ') AS right_trimmed;

-- ============================================
-- 6. REPLACE - Replace Substring
-- ============================================

SELECT REPLACE(emp_name, ' ', '_') AS modified_name FROM employee LIMIT 5;
SELECT REPLACE(job, 'Manager', 'Head') AS new_title FROM employee WHERE job LIKE '%Manager%';

-- ============================================
-- 7. REVERSE - Reverse String
-- ============================================

SELECT emp_name, REVERSE(emp_name) AS reversed FROM employee LIMIT 5;

-- ============================================
-- 8. LOCATE and POSITION - Find Substring
-- ============================================

SELECT emp_name, LOCATE('a', emp_name) AS position_of_a FROM employee LIMIT 5;
SELECT emp_name FROM employee WHERE LOCATE('John', emp_name) > 0;

-- ============================================
-- 9. REPEAT - Repeat String
-- ============================================

SELECT REPEAT('*', 5) AS stars;
SELECT CONCAT(emp_name, REPEAT('!', 3)) FROM employee LIMIT 5;

-- ============================================
-- 10. LPAD and RPAD - Padding
-- ============================================

SELECT LPAD(emp_id, 6, '0') AS padded_id FROM employee LIMIT 5;
SELECT RPAD(emp_name, 20, '.') AS padded_name FROM employee LIMIT 5;

-- ============================================
-- 11. STRCMP - Compare Strings
-- ============================================

SELECT STRCMP('Hello', 'Hello') AS result;  -- 0 if equal
SELECT STRCMP('A', 'B') AS result;  -- -1 if first < second
SELECT STRCMP('Z', 'A') AS result;  -- 1 if first > second

-- ============================================
-- 12. Practical Examples
-- ============================================

-- Format employee email
SELECT 
    emp_name,
    CONCAT(LOWER(REPLACE(emp_name, ' ', '.')), '@company.com') AS email
FROM employee LIMIT 5;

-- Extract first and last name
SELECT 
    emp_name,
    SUBSTRING_INDEX(emp_name, ' ', 1) AS first_name,
    SUBSTRING_INDEX(emp_name, ' ', -1) AS last_name
FROM employee LIMIT 5;

-- Create initials
SELECT 
    emp_name,
    CONCAT(
        LEFT(SUBSTRING_INDEX(emp_name, ' ', 1), 1),
        LEFT(SUBSTRING_INDEX(emp_name, ' ', -1), 1)
    ) AS initials
FROM employee LIMIT 5;

-- Exercises:
-- 1. Convert all employee names to uppercase
-- 2. Get first 3 characters of each job title
-- 3. Create username: first_name.last_initial@company.com
-- 4. Find employees with names longer than 15 characters
-- 5. Replace all spaces with underscores in employee names

-- ============================================
-- END OF PRACTICAL 06
-- ============================================
