-- ============================================
-- PRACTICAL 03: CONSTRAINTS
-- ============================================
-- NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT

USE company_db;

-- ============================================
-- 1. NOT NULL Constraint
-- ============================================

-- NOT NULL ensures column cannot have NULL values

CREATE TABLE students (
    student_id INT,
    student_name VARCHAR(100) NOT NULL,  -- Cannot be NULL
    email VARCHAR(100),
    age INT
);

-- Valid insert
INSERT INTO students VALUES (1, 'John Doe', 'john@email.com', 20);

-- This will fail (student_name is NULL)
-- INSERT INTO students VALUES (2, NULL, 'jane@email.com', 21);

-- Add NOT NULL to existing column
ALTER TABLE students 
MODIFY COLUMN email VARCHAR(100) NOT NULL;


-- ============================================
-- 2. UNIQUE Constraint
-- ============================================

-- UNIQUE ensures all values in column are different
-- NULL is allowed (multiple NULLs permitted)

CREATE TABLE users (
    user_id INT,
    username VARCHAR(50) UNIQUE,  -- Each username must be unique
    email VARCHAR(100) UNIQUE,    -- Each email must be unique
    phone VARCHAR(20)
);

-- Valid inserts
INSERT INTO users VALUES (1, 'john123', 'john@email.com', '1234567890');
INSERT INTO users VALUES (2, 'jane456', 'jane@email.com', '0987654321');

-- This will fail (duplicate username)
-- INSERT INTO users VALUES (3, 'john123', 'other@email.com', '1111111111');

-- Add UNIQUE constraint to existing column
ALTER TABLE users 
ADD CONSTRAINT unique_phone UNIQUE (phone);

-- Composite UNIQUE (combination must be unique)
CREATE TABLE enrollment (
    student_id INT,
    course_id INT,
    semester VARCHAR(20),
    UNIQUE (student_id, course_id)  -- Same student can't enroll in same course twice
);


-- ============================================
-- 3. PRIMARY KEY Constraint
-- ============================================

-- PRIMARY KEY = NOT NULL + UNIQUE
-- Only one primary key per table
-- Automatically creates index

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,      -- Primary key
    emp_name VARCHAR(100),
    department VARCHAR(50)
);

-- Primary key with AUTO_INCREMENT
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    order_date DATE
);

-- Composite primary key
CREATE TABLE course_enrollment (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id)  -- Combination is unique
);

-- Add primary key to existing table
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100)
);

ALTER TABLE products 
ADD PRIMARY KEY (product_id);

-- Valid insert
INSERT INTO employees VALUES (101, 'Alice Johnson', 'IT');
INSERT INTO employees VALUES (102, 'Bob Smith', 'HR');

-- This will fail (duplicate primary key)
-- INSERT INTO employees VALUES (101, 'Charlie Brown', 'Finance');

-- This will fail (primary key cannot be NULL)
-- INSERT INTO employees VALUES (NULL, 'David Wilson', 'Sales');


-- ============================================
-- 4. FOREIGN KEY Constraint
-- ============================================

-- FOREIGN KEY establishes relationship between tables
-- Maintains referential integrity

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Insert parent records first
INSERT INTO departments VALUES (1, 'IT');
INSERT INTO departments VALUES (2, 'HR');

-- Valid insert (dept_id exists in departments)
INSERT INTO staff VALUES (101, 'John Doe', 1);
INSERT INTO staff VALUES (102, 'Jane Smith', 2);

-- This will fail (dept_id 99 doesn't exist in departments)
-- INSERT INTO staff VALUES (103, 'Bob Wilson', 99);

-- Foreign key with ON DELETE and ON UPDATE actions
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100)
);

CREATE TABLE assignments (
    assignment_id INT PRIMARY KEY,
    staff_id INT,
    project_id INT,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) 
        ON DELETE CASCADE     -- Delete assignments if staff deleted
        ON UPDATE CASCADE,    -- Update assignment if staff_id changes
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
        ON DELETE SET NULL    -- Set to NULL if project deleted
        ON UPDATE CASCADE
);

-- Add foreign key to existing table
CREATE TABLE tasks (
    task_id INT PRIMARY KEY,
    task_name VARCHAR(100),
    assigned_to INT
);

ALTER TABLE tasks
ADD CONSTRAINT fk_tasks_staff
    FOREIGN KEY (assigned_to) REFERENCES staff(staff_id);


-- ============================================
-- 5. CHECK Constraint
-- ============================================

-- CHECK ensures values meet specific condition

CREATE TABLE persons (
    person_id INT PRIMARY KEY,
    person_name VARCHAR(100),
    age INT CHECK (age >= 18 AND age <= 100),  -- Age between 18 and 100
    salary DECIMAL(10, 2) CHECK (salary > 0),  -- Salary must be positive
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O'))  -- Only M, F, or O allowed
);

-- Valid insert
INSERT INTO persons VALUES (1, 'Alice', 25, 50000.00, 'F');
INSERT INTO persons VALUES (2, 'Bob', 30, 60000.00, 'M');

-- This will fail (age < 18)
-- INSERT INTO persons VALUES (3, 'Charlie', 15, 45000.00, 'M');

-- This will fail (salary <= 0)
-- INSERT INTO persons VALUES (4, 'David', 28, -5000.00, 'M');

-- Named CHECK constraint
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    balance DECIMAL(12, 2),
    account_type VARCHAR(20),
    CONSTRAINT chk_balance CHECK (balance >= 0),
    CONSTRAINT chk_type CHECK (account_type IN ('Savings', 'Current', 'Fixed'))
);

-- Add CHECK to existing column
ALTER TABLE persons
ADD CONSTRAINT chk_name CHECK (LENGTH(person_name) >= 3);


-- ============================================
-- 6. DEFAULT Constraint
-- ============================================

-- DEFAULT provides default value if none specified

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    price DECIMAL(8, 2) DEFAULT 299.99,        -- Default price
    stock INT DEFAULT 0,                       -- Default stock
    publication_date DATE DEFAULT (CURRENT_DATE),  -- Default to today
    status VARCHAR(20) DEFAULT 'Available'     -- Default status
);

-- Insert without specifying default columns
INSERT INTO books (book_title, author) 
VALUES ('MySQL Basics', 'John Smith');

-- Insert with some defaults
INSERT INTO books (book_title, author, price) 
VALUES ('Advanced SQL', 'Jane Doe', 499.99);

-- View data (see default values)
SELECT * FROM books;

-- Add DEFAULT to existing column
ALTER TABLE books 
ALTER COLUMN status SET DEFAULT 'In Stock';

-- Remove DEFAULT
ALTER TABLE books 
ALTER COLUMN status DROP DEFAULT;


-- ============================================
-- 7. Multiple Constraints Together
-- ============================================

CREATE TABLE complete_example (
    -- Primary key with auto increment
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    -- NOT NULL + UNIQUE
    username VARCHAR(50) NOT NULL UNIQUE,
    
    -- NOT NULL + CHECK
    email VARCHAR(100) NOT NULL CHECK (email LIKE '%@%'),
    
    -- CHECK constraint
    age INT CHECK (age >= 18),
    
    -- DEFAULT value
    registration_date DATE DEFAULT (CURRENT_DATE),
    
    -- DEFAULT + CHECK
    status VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive', 'Suspended')),
    
    -- Foreign key (assuming users table exists)
    -- referred_by INT,
    -- FOREIGN KEY (referred_by) REFERENCES complete_example(id)
    
    balance DECIMAL(10, 2) DEFAULT 0 CHECK (balance >= 0)
);

-- Test inserts
INSERT INTO complete_example (username, email, age) 
VALUES ('user123', 'user@example.com', 25);

INSERT INTO complete_example (username, email, age, status) 
VALUES ('admin', 'admin@example.com', 30, 'Active');

SELECT * FROM complete_example;


-- ============================================
-- 8. Naming Constraints
-- ============================================

CREATE TABLE with_named_constraints (
    id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    age INT,
    salary DECIMAL(10, 2),
    
    -- Named PRIMARY KEY
    CONSTRAINT pk_id PRIMARY KEY (id),
    
    -- Named UNIQUE
    CONSTRAINT uq_email UNIQUE (email),
    
    -- Named CHECK
    CONSTRAINT chk_age CHECK (age >= 18),
    CONSTRAINT chk_salary CHECK (salary > 0),
    
    -- Named NOT NULL is done at column level
    CONSTRAINT nn_name CHECK (name IS NOT NULL)
);


-- ============================================
-- 9. Dropping Constraints
-- ============================================

-- Drop CHECK constraint
ALTER TABLE persons 
DROP CONSTRAINT chk_name;

-- Drop FOREIGN KEY constraint
-- ALTER TABLE tasks
-- DROP FOREIGN KEY fk_tasks_staff;

-- Drop UNIQUE constraint
ALTER TABLE users 
DROP INDEX unique_phone;

-- Drop PRIMARY KEY (must drop foreign keys first)
-- ALTER TABLE products 
-- DROP PRIMARY KEY;


-- ============================================
-- 10. Viewing Constraints
-- ============================================

-- View all constraints for a table
SELECT 
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'company_db'
AND TABLE_NAME = 'complete_example';

-- View CHECK constraints
SELECT 
    TABLE_NAME,
    CONSTRAINT_NAME,
    CHECK_CLAUSE
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'company_db';


-- ============================================
-- PRACTICAL EXERCISES
-- ============================================

-- Exercise 1: Create table 'library_members' with:
--   - member_id (PK, AUTO_INCREMENT)
--   - member_name (NOT NULL, minimum 3 characters)
--   - email (UNIQUE, NOT NULL)
--   - age (CHECK >= 13)
--   - membership_type (DEFAULT 'Standard', CHECK IN ('Standard', 'Premium'))
-- Your query here:


-- Exercise 2: Create tables 'authors' and 'books_catalog' with FK relationship
-- Your query here:


-- Exercise 3: Add CHECK constraint to ensure phone is 10 digits
-- Your query here:


-- Exercise 4: Create table with composite primary key
-- Your query here:


-- ============================================
-- CLEANUP (Optional)
-- ============================================

-- DROP TABLE IF EXISTS students;
-- DROP TABLE IF EXISTS users;
-- DROP TABLE IF EXISTS enrollment;
-- DROP TABLE IF EXISTS employees;
-- DROP TABLE IF EXISTS orders;
-- DROP TABLE IF EXISTS course_enrollment;
-- DROP TABLE IF EXISTS products;
-- DROP TABLE IF EXISTS assignments;
-- DROP TABLE IF EXISTS tasks;
-- DROP TABLE IF EXISTS staff;
-- DROP TABLE IF EXISTS projects;
-- DROP TABLE IF EXISTS departments;
-- DROP TABLE IF EXISTS persons;
-- DROP TABLE IF EXISTS accounts;
-- DROP TABLE IF EXISTS books;
-- DROP TABLE IF EXISTS complete_example;
-- DROP TABLE IF EXISTS with_named_constraints;


-- ============================================
-- END OF PRACTICAL 03
-- ============================================
