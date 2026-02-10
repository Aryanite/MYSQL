-- ============================================
-- SUBQUERIES IN SQL
-- ============================================
-- Single-row, Multi-row, Correlated Subqueries

USE company_db;

-- ============================================
-- 1. WHAT IS A SUBQUERY?
-- ============================================

-- A subquery is a query nested inside another query
-- Also called: Inner query, Nested query, Subselect

-- Basic structure:
-- SELECT column FROM table WHERE column operator (SELECT column FROM table)


-- ============================================
-- 2. SINGLE-ROW SUBQUERIES
-- ============================================
-- Returns exactly one value (one row, one column)
-- Uses: =, !=, <, >, <=, >= operators

-- Find employees earning more than the average salary
SELECT emp_name, salary 
FROM employee 
WHERE salary > (SELECT AVG(salary) FROM employee);

-- Find employee with maximum salary
SELECT emp_name, salary 
FROM employee 
WHERE salary = (SELECT MAX(salary) FROM employee);

-- Find employee with minimum salary
SELECT emp_name, salary 
FROM employee 
WHERE salary = (SELECT MIN(salary) FROM employee);

-- Employees earning same as employee with emp_id = 101
SELECT emp_name, salary 
FROM employee 
WHERE salary = (SELECT salary FROM employee WHERE emp_id = 101);

-- Employees in the same department as 'John Doe'
SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id = (
    SELECT dept_id 
    FROM employee 
    WHERE emp_name = 'John Doe'
);


-- ============================================
-- 3. MULTI-ROW SUBQUERIES
-- ============================================
-- Returns multiple values (multiple rows)
-- Uses: IN, NOT IN, ANY, ALL operators

-- ============================================
-- 3A. IN Operator
-- ============================================

-- Find employees working in departments located in 'New York'
SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id IN (
    SELECT dept_id 
    FROM department 
    WHERE location = 'New York'
);

-- Find employees with same job as department 1 employees
SELECT emp_name, job 
FROM employee 
WHERE job IN (
    SELECT DISTINCT job 
    FROM employee 
    WHERE dept_id = 1
);


-- ============================================
-- 3B. NOT IN Operator
-- ============================================

-- Find employees NOT in departments located in 'New York'
SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id NOT IN (
    SELECT dept_id 
    FROM department 
    WHERE location = 'New York'
);

-- Employees with jobs not found in department 1
SELECT emp_name, job 
FROM employee 
WHERE job NOT IN (
    SELECT DISTINCT job 
    FROM employee 
    WHERE dept_id = 1
);


-- ============================================
-- 3C. ANY Operator
-- ============================================
-- Compares value to ANY value in the subquery result
-- Must be preceded by =, !=, <, >, <=, >=

-- Employees earning more than ANY employee in dept 1
SELECT emp_name, salary 
FROM employee 
WHERE salary > ANY (
    SELECT salary 
    FROM employee 
    WHERE dept_id = 1
);
-- This means: salary > minimum salary in dept 1

-- Employees earning less than ANY employee in dept 2
SELECT emp_name, salary 
FROM employee 
WHERE salary < ANY (
    SELECT salary 
    FROM employee 
    WHERE dept_id = 2
);
-- This means: salary < maximum salary in dept 2


-- ============================================
-- 3D. ALL Operator
-- ============================================
-- Compares value to ALL values in the subquery result

-- Employees earning more than ALL employees in dept 1
SELECT emp_name, salary 
FROM employee 
WHERE salary > ALL (
    SELECT salary 
    FROM employee 
    WHERE dept_id = 1
);
-- This means: salary > maximum salary in dept 1

-- Employees earning less than ALL employees in dept 2
SELECT emp_name, salary 
FROM employee 
WHERE salary < ALL (
    SELECT salary 
    FROM employee 
    WHERE dept_id = 2
);
-- This means: salary < minimum salary in dept 2


-- ============================================
-- 4. CORRELATED SUBQUERIES
-- ============================================
-- Inner query depends on outer query
-- Executes once for each row in outer query

-- Find employees earning more than average in their department
SELECT e1.emp_name, e1.salary, e1.dept_id 
FROM employee e1 
WHERE e1.salary > (
    SELECT AVG(e2.salary) 
    FROM employee e2 
    WHERE e2.dept_id = e1.dept_id
);

-- Find employees with salary higher than their manager
SELECT e.emp_name, e.salary 
FROM employee e 
WHERE e.salary > (
    SELECT m.salary 
    FROM employee m 
    WHERE m.emp_id = e.mgr_id
);

-- Find departments with at least one employee earning > 60000
SELECT dept_id, dept_name 
FROM department d 
WHERE EXISTS (
    SELECT 1 
    FROM employee e 
    WHERE e.dept_id = d.dept_id 
    AND e.salary > 60000
);


-- ============================================
-- 5. EXISTS and NOT EXISTS
-- ============================================
-- Tests for existence of rows in subquery
-- Returns TRUE if subquery returns at least one row

-- Departments that have employees
SELECT dept_id, dept_name 
FROM department d 
WHERE EXISTS (
    SELECT 1 
    FROM employee e 
    WHERE e.dept_id = d.dept_id
);

-- Departments with NO employees
SELECT dept_id, dept_name 
FROM department d 
WHERE NOT EXISTS (
    SELECT 1 
    FROM employee e 
    WHERE e.dept_id = d.dept_id
);

-- Employees who are managers (have subordinates)
SELECT emp_id, emp_name 
FROM employee e1 
WHERE EXISTS (
    SELECT 1 
    FROM employee e2 
    WHERE e2.mgr_id = e1.emp_id
);

-- Employees who are NOT managers
SELECT emp_id, emp_name 
FROM employee e1 
WHERE NOT EXISTS (
    SELECT 1 
    FROM employee e2 
    WHERE e2.mgr_id = e1.emp_id
);


-- ============================================
-- 6. SUBQUERIES IN SELECT CLAUSE
-- ============================================

-- Show employee with their department name
SELECT 
    emp_name,
    salary,
    (SELECT dept_name FROM department d WHERE d.dept_id = e.dept_id) AS dept_name
FROM employee e;

-- Show difference from average salary
SELECT 
    emp_name,
    salary,
    (SELECT AVG(salary) FROM employee) AS avg_salary,
    salary - (SELECT AVG(salary) FROM employee) AS difference
FROM employee;

-- Show employee rank by salary
SELECT 
    emp_name,
    salary,
    (SELECT COUNT(*) FROM employee e2 WHERE e2.salary > e1.salary) + 1 AS salary_rank
FROM employee e1
ORDER BY salary DESC;


-- ============================================
-- 7. SUBQUERIES IN FROM CLAUSE
-- ============================================
-- Also called: Inline views or Derived tables

-- Get departments with average salary > 50000
SELECT dept_id, avg_sal 
FROM (
    SELECT dept_id, AVG(salary) AS avg_sal 
    FROM employee 
    GROUP BY dept_id
) AS dept_averages 
WHERE avg_sal > 50000;

-- Top 3 highest paid employees
SELECT * 
FROM (
    SELECT emp_name, salary 
    FROM employee 
    ORDER BY salary DESC 
    LIMIT 3
) AS top_earners;

-- Department statistics
SELECT 
    d.dept_name,
    ds.emp_count,
    ds.avg_salary
FROM department d
JOIN (
    SELECT 
        dept_id,
        COUNT(*) AS emp_count,
        AVG(salary) AS avg_salary
    FROM employee
    GROUP BY dept_id
) AS ds ON d.dept_id = ds.dept_id;


-- ============================================
-- 8. NESTED SUBQUERIES (Multiple Levels)
-- ============================================

-- Find employees in departments with highest total salary
SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id = (
    SELECT dept_id 
    FROM (
        SELECT dept_id, SUM(salary) AS total_sal 
        FROM employee 
        GROUP BY dept_id 
        ORDER BY total_sal DESC 
        LIMIT 1
    ) AS dept_totals
);

-- Employees earning more than average of top 5 salaries
SELECT emp_name, salary 
FROM employee 
WHERE salary > (
    SELECT AVG(salary) 
    FROM (
        SELECT salary 
        FROM employee 
        ORDER BY salary DESC 
        LIMIT 5
    ) AS top_5_salaries
);


-- ============================================
-- 9. SUBQUERY WITH INSERT
-- ============================================

-- Insert employees from one table to another
-- (Example - create backup table first)
-- INSERT INTO employee_backup 
-- SELECT * FROM employee WHERE dept_id = 1;


-- ============================================
-- 10. SUBQUERY WITH UPDATE
-- ============================================

-- Give 10% raise to employees earning less than department average
-- UPDATE employee e1
-- SET salary = salary * 1.10
-- WHERE salary < (
--     SELECT AVG(salary) 
--     FROM employee e2 
--     WHERE e2.dept_id = e1.dept_id
-- );


-- ============================================
-- 11. SUBQUERY WITH DELETE
-- ============================================

-- Delete employees with salary less than minimum in dept 1
-- DELETE FROM employee 
-- WHERE salary < (
--     SELECT MIN(salary) 
--     FROM (SELECT salary FROM employee WHERE dept_id = 1) AS temp
-- );


-- ============================================
-- 12. COMPLEX EXAMPLES
-- ============================================

-- Find 2nd highest salary
SELECT MAX(salary) AS second_highest 
FROM employee 
WHERE salary < (SELECT MAX(salary) FROM employee);

-- Find Nth highest salary (example: 3rd highest)
SELECT DISTINCT salary 
FROM employee e1 
WHERE 3 = (
    SELECT COUNT(DISTINCT salary) 
    FROM employee e2 
    WHERE e2.salary >= e1.salary
);

-- Employees with salary above department average and overall average
SELECT emp_name, salary, dept_id 
FROM employee e1 
WHERE salary > (SELECT AVG(salary) FROM employee)
  AND salary > (
      SELECT AVG(salary) 
      FROM employee e2 
      WHERE e2.dept_id = e1.dept_id
  );

-- Departments where ALL employees earn > 40000
SELECT dept_id, dept_name 
FROM department d 
WHERE NOT EXISTS (
    SELECT 1 
    FROM employee e 
    WHERE e.dept_id = d.dept_id 
    AND e.salary <= 40000
);

-- Employees who earn more than at least 3 other employees
SELECT emp_name, salary 
FROM employee e1 
WHERE 3 <= (
    SELECT COUNT(*) 
    FROM employee e2 
    WHERE e2.salary < e1.salary
);


-- ============================================
-- 13. SUBQUERY PERFORMANCE TIPS
-- ============================================

-- Use JOIN instead of subquery when possible (usually faster)
-- SUBQUERY version:
SELECT e.emp_name, 
       (SELECT dept_name FROM department d WHERE d.dept_id = e.dept_id) AS dept_name
FROM employee e;

-- JOIN version (better performance):
SELECT e.emp_name, d.dept_name
FROM employee e
JOIN department d ON e.dept_id = d.dept_id;


-- EXISTS is faster than IN for large datasets
-- Use EXISTS when you only need to check existence, not actual values


-- ============================================
-- PRACTICE EXERCISES
-- ============================================

-- Exercise 1: Find employees with above-average salary
-- Your query here:


-- Exercise 2: Get employees in same department as highest paid employee
-- Your query here:


-- Exercise 3: Find employees who earn more than all employees in dept 3
-- Your query here:


-- Exercise 4: List departments with more than average number of employees
-- Your query here:


-- Exercise 5: Find employees hired after the first employee in their department
-- Your query here:


-- Exercise 6: Get 3rd highest salary in the company
-- Your query here:


-- Exercise 7: Find employees earning exactly the average salary of their department
-- Your query here:


-- ============================================
-- END OF SUBQUERIES
-- ============================================
