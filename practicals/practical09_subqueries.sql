-- ============================================
-- PRACTICAL 09: SUBQUERIES
-- ============================================

USE company_db;

-- ============================================
-- 1. Single-row Subqueries
-- ============================================

SELECT emp_name, salary 
FROM employee 
WHERE salary > (SELECT AVG(salary) FROM employee);

SELECT emp_name, salary 
FROM employee 
WHERE salary = (SELECT MAX(salary) FROM employee);

SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id = (SELECT dept_id FROM employee WHERE emp_name = 'Robert Johnson');

-- ============================================
-- 2. Multi-row Subqueries with IN
-- ============================================

SELECT emp_name, dept_id 
FROM employee 
WHERE dept_id IN (SELECT dept_id FROM department WHERE location = 'New York');

SELECT emp_name, job 
FROM employee 
WHERE job IN (SELECT DISTINCT job FROM employee WHERE dept_id = 1);

-- ============================================
-- 3. Multi-row Subqueries with ANY/ALL
-- ============================================

SELECT emp_name, salary 
FROM employee 
WHERE salary > ANY (SELECT salary FROM employee WHERE dept_id = 1);

SELECT emp_name, salary 
FROM employee 
WHERE salary > ALL (SELECT salary FROM employee WHERE dept_id = 2);

-- ============================================
-- 4. Correlated Subqueries
-- ============================================

SELECT e1.emp_name, e1.salary, e1.dept_id 
FROM employee e1 
WHERE e1.salary > (SELECT AVG(e2.salary) FROM employee e2 WHERE e2.dept_id = e1.dept_id);

-- ============================================
-- 5. EXISTS and NOT EXISTS
-- ============================================

SELECT dept_id, dept_name 
FROM department d 
WHERE EXISTS (SELECT 1 FROM employee e WHERE e.dept_id = d.dept_id);

SELECT dept_id, dept_name 
FROM department d 
WHERE NOT EXISTS (SELECT 1 FROM employee e WHERE e.dept_id = d.dept_id);

-- ============================================
-- 6. Subqueries in SELECT
-- ============================================

SELECT emp_name, salary, 
       (SELECT AVG(salary) FROM employee) AS avg_salary,
       salary - (SELECT AVG(salary) FROM employee) AS diff
FROM employee LIMIT 5;

-- ============================================
-- 7. Subqueries in FROM
-- ============================================

SELECT dept_id, avg_sal 
FROM (SELECT dept_id, AVG(salary) AS avg_sal FROM employee GROUP BY dept_id) AS dept_avg 
WHERE avg_sal > 60000;

-- ============================================
-- 8. Complex Examples
-- ============================================

-- 2nd highest salary
SELECT MAX(salary) FROM employee WHERE salary < (SELECT MAX(salary) FROM employee);

-- Nth highest salary (3rd)
SELECT DISTINCT salary 
FROM employee e1 
WHERE 3 = (SELECT COUNT(DISTINCT salary) FROM employee e2 WHERE e2.salary >= e1.salary);

-- Exercises:
-- 1. Find employees earning above average
-- 2. Get employees in same dept as highest paid employee
-- 3. List departments with no employees
-- 4. Find employees earning more than all in dept 3
-- 5. Get 3rd highest salary

-- ============================================
-- END OF PRACTICAL 09
-- ============================================
