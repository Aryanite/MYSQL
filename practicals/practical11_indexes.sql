-- ============================================
-- PRACTICAL 11: INDEXES
-- ============================================

USE company_db;

-- ============================================
-- 1. Why Use Indexes?
-- ============================================

/*
Indexes improve query performance by:
- Faster data retrieval
- Quick sorting
- Faster joins
- Enforcing uniqueness

Trade-offs:
- Slower INSERT, UPDATE, DELETE
- Require storage space
*/

-- ============================================
-- 2. CREATE INDEX - Single Column
-- ============================================

CREATE INDEX idx_emp_name ON employee(emp_name);
CREATE INDEX idx_salary ON employee(salary);
CREATE INDEX idx_hire_date ON employee(hire_date);

-- ============================================
-- 3. CREATE INDEX - Multiple Columns
-- ============================================

CREATE INDEX idx_dept_salary ON employee(dept_id, salary);
CREATE INDEX idx_job_salary ON employee(job, salary);

-- ============================================
-- 4. CREATE UNIQUE INDEX
-- ============================================

-- Ensures values are unique (like email)
-- CREATE UNIQUE INDEX idx_email ON employee(email);

-- ============================================
-- 5. Show Indexes
-- ============================================

SHOW INDEX FROM employee;
SHOW INDEX FROM department;

-- Detailed index information
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    SEQ_IN_INDEX,
    NON_UNIQUE
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'company_db' AND TABLE_NAME = 'employee';

-- ============================================
-- 6. Query Performance with EXPLAIN
-- ============================================

-- Without index
EXPLAIN SELECT * FROM employee WHERE job = 'Developer';

-- With index
CREATE INDEX idx_job ON employee(job);
EXPLAIN SELECT * FROM employee WHERE job = 'Developer';

-- ============================================
-- 7. Index Usage Examples
-- ============================================

-- Index helps with WHERE
SELECT * FROM employee WHERE emp_name = 'John Miller';

-- Index helps with ORDER BY
SELECT * FROM employee ORDER BY salary DESC LIMIT 10;

-- Index helps with JOIN
SELECT e.emp_name, d.dept_name 
FROM employee e 
JOIN department d ON e.dept_id = d.dept_id;

-- ============================================
-- 8. When to Use Indexes
-- ============================================

/*
CREATE INDEX on columns that are:
- Frequently used in WHERE clause
- Used in JOIN conditions
- Used in ORDER BY clause
- Frequently searched

DO NOT index:
- Small tables
- Columns with many NULL values
- Columns that are frequently updated
- Columns with low cardinality (few unique values)
*/

-- ============================================
-- 9. DROP INDEX
-- ============================================

DROP INDEX idx_emp_name ON employee;
DROP INDEX idx_hire_date ON employee;

-- Drop index if exists
DROP INDEX IF EXISTS idx_salary ON employee;

-- ============================================
-- 10. ALTER TABLE with Index
-- ============================================

-- Add index using ALTER TABLE
ALTER TABLE employee ADD INDEX idx_dept (dept_id);

-- Drop index using ALTER TABLE
ALTER TABLE employee DROP INDEX idx_dept;

-- ============================================
-- 11. Primary Key and Unique Constraints
-- ============================================

-- Primary key automatically creates index
-- UNIQUE constraint also creates index

-- These already have indexes:
SHOW INDEX FROM employee WHERE Key_name = 'PRIMARY';

-- ============================================
-- 12. Full-Text Index (for text search)
-- ============================================

-- Create table with full-text index
CREATE TABLE articles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    content TEXT,
    FULLTEXT(title, content)
);

-- Search using full-text index
-- SELECT * FROM articles WHERE MATCH(title, content) AGAINST('search term');

-- ============================================
-- Exercises:
-- ============================================

-- 1. Create index on job column
-- 2. Show all indexes on employee table
-- 3. Create composite index on (dept_id, hire_date)
-- 4. Use EXPLAIN to check query performance
-- 5. Drop unused indexes

-- ============================================
-- CLEANUP
-- ============================================

-- DROP INDEX idx_dept_salary ON employee;
-- DROP INDEX idx_job_salary ON employee;
-- DROP INDEX idx_job ON employee;
-- DROP TABLE IF EXISTS articles;

-- ============================================
-- END OF PRACTICAL 11
-- ============================================
