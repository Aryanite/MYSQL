-- ============================================
-- PRACTICAL 01: DDL COMMANDS
-- ============================================
-- Data Definition Language: CREATE, ALTER, DROP, TRUNCATE

USE company_db;

-- ============================================
-- 1. CREATE Command
-- ============================================

-- Create a new database
CREATE DATABASE IF NOT EXISTS test_db;

-- Create a simple table
CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE
);

-- Create table with multiple constraints
CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits > 0),
    fee DECIMAL(8, 2) DEFAULT 5000.00
);

-- Create table with foreign key
CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

-- Show created tables
SHOW TABLES;

-- Describe table structure
DESCRIBE student;
DESCRIBE course;


-- ============================================
-- 2. ALTER Command
-- ============================================

-- Add a new column
ALTER TABLE student 
ADD COLUMN phone VARCHAR(15);

-- Add multiple columns
ALTER TABLE student 
ADD COLUMN address VARCHAR(200),
ADD COLUMN city VARCHAR(50);

-- Modify column datatype
ALTER TABLE student 
MODIFY COLUMN age INT NOT NULL;

-- Change column name and datatype
ALTER TABLE student 
CHANGE COLUMN phone mobile VARCHAR(20);

-- Drop a column
ALTER TABLE student 
DROP COLUMN city;

-- Add constraint
ALTER TABLE student 
ADD CONSTRAINT chk_age CHECK (age >= 18 AND age <= 100);

-- Drop constraint
ALTER TABLE student 
DROP CONSTRAINT chk_age;

-- Add primary key (if not exists)
-- ALTER TABLE table_name ADD PRIMARY KEY (column);

-- Add foreign key
ALTER TABLE enrollment
ADD COLUMN grade CHAR(2);

-- Rename table
ALTER TABLE enrollment 
RENAME TO student_enrollment;

-- Rename back
ALTER TABLE student_enrollment 
RENAME TO enrollment;

-- Modify column to add NOT NULL
ALTER TABLE course 
MODIFY course_name VARCHAR(100) NOT NULL;

-- Set default value
ALTER TABLE course 
ALTER COLUMN credits SET DEFAULT 3;

-- Drop default value
ALTER TABLE course 
ALTER COLUMN credits DROP DEFAULT;

-- Show modified structure
DESCRIBE student;
DESCRIBE course;


-- ============================================
-- 3. DROP Command
-- ============================================

-- Drop a table (permanently deletes table and data)
CREATE TABLE temp_table (
    id INT,
    name VARCHAR(50)
);

-- Verify table exists
SHOW TABLES LIKE 'temp%';

-- Drop the table
DROP TABLE temp_table;

-- Drop table if exists (no error if doesn't exist)
DROP TABLE IF EXISTS temp_table;

-- Drop multiple tables
CREATE TABLE table1 (id INT);
CREATE TABLE table2 (id INT);
DROP TABLE IF EXISTS table1, table2;

-- Drop database
CREATE DATABASE IF NOT EXISTS temp_db;
DROP DATABASE IF EXISTS temp_db;


-- ============================================
-- 4. TRUNCATE Command
-- ============================================

-- Insert some sample data first
INSERT INTO student (student_name, age, email) VALUES
    ('Alice Johnson', 20, 'alice@email.com'),
    ('Bob Smith', 22, 'bob@email.com'),
    ('Charlie Brown', 21, 'charlie@email.com');

-- View data
SELECT * FROM student;

-- Count before truncate
SELECT COUNT(*) AS total_students FROM student;

-- TRUNCATE removes all rows but keeps structure
TRUNCATE TABLE student;

-- Verify data is deleted but structure remains
SELECT * FROM student;
DESCRIBE student;


-- ============================================
-- 5. Difference: DELETE vs TRUNCATE vs DROP
-- ============================================

/*
DELETE:
- Removes rows based on WHERE condition
- Can rollback (with transactions)
- Slower for large tables
- Keeps table structure
- Can use WHERE clause
- Triggers are fired
- Example: DELETE FROM table WHERE condition;

TRUNCATE:
- Removes ALL rows
- Cannot rollback (in most cases)
- Faster than DELETE
- Keeps table structure
- Cannot use WHERE clause
- Resets AUTO_INCREMENT
- Triggers are NOT fired
- Example: TRUNCATE TABLE table_name;

DROP:
- Removes entire table (structure + data)
- Cannot rollback
- Fastest
- Removes table completely
- Cannot recover without backup
- Example: DROP TABLE table_name;
*/


-- ============================================
-- 6. CREATE TABLE with SELECT
-- ============================================

-- Create table from another table's data
CREATE TABLE employee_backup 
AS SELECT * FROM employee WHERE dept_id = 1;

-- View backup table
SELECT * FROM employee_backup;

-- Create table with only structure (no data)
CREATE TABLE employee_template 
AS SELECT * FROM employee WHERE 1=0;

-- Verify empty table
SELECT * FROM employee_template;


-- ============================================
-- 7. Temporary Tables
-- ============================================

-- Create temporary table (deleted when session ends)
CREATE TEMPORARY TABLE temp_sales (
    sale_id INT,
    amount DECIMAL(10, 2),
    sale_date DATE
);

-- Insert data
INSERT INTO temp_sales VALUES
    (1, 1500.00, '2024-01-15'),
    (2, 2300.00, '2024-01-16');

-- Query temporary table
SELECT * FROM temp_sales;


-- ============================================
-- 8. CREATE INDEX
-- ============================================

-- Create index on single column
CREATE INDEX idx_student_name ON student(student_name);

-- Create index on multiple columns (composite index)
CREATE INDEX idx_enrollment_student_course 
ON enrollment(student_id, course_id);

-- Create unique index
CREATE UNIQUE INDEX idx_email ON student(email);

-- Show indexes
SHOW INDEX FROM student;


-- ============================================
-- 9. DROP INDEX
-- ============================================

-- Drop an index
DROP INDEX idx_student_name ON student;

-- Drop index if exists
DROP INDEX IF EXISTS idx_email ON student;


-- ============================================
-- 10. ALTER TABLE - Advanced Operations
-- ============================================

-- Add AUTO_INCREMENT to existing column
-- ALTER TABLE student MODIFY student_id INT AUTO_INCREMENT;

-- Remove AUTO_INCREMENT
-- ALTER TABLE student MODIFY student_id INT;

-- Change table engine
ALTER TABLE student ENGINE=InnoDB;

-- Change character set
ALTER TABLE student CONVERT TO CHARACTER SET utf8mb4;


-- ============================================
-- PRACTICAL EXERCISES
-- ============================================

-- Exercise 1: Create a table 'product' with columns:
--   product_id (PK, AUTO_INCREMENT)
--   product_name (NOT NULL)
--   price (DECIMAL, must be > 0)
--   stock_quantity (INT, DEFAULT 0)
-- Your query here:


-- Exercise 2: Add columns 'category' and 'manufacturer' to product table
-- Your query here:


-- Exercise 3: Modify price column to DECIMAL(10, 2)
-- Your query here:


-- Exercise 4: Create an index on product_name
-- Your query here:


-- Exercise 5: Create a backup table of all IT department employees
-- Your query here:


-- Exercise 6: Rename product table to inventory
-- Your query here:


-- ============================================
-- CLEANUP (Optional)
-- ============================================

-- Drop created tables for practice
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS employee_backup;
DROP TABLE IF EXISTS employee_template;


-- ============================================
-- END OF PRACTICAL 01
-- ============================================
