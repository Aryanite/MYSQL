-- ============================================
-- DATABASE SCHEMA: COMPANY DATABASE
-- ============================================
-- This file creates the base tables for employee management system
-- Tables: DEPARTMENT, EMPLOYEE

-- ============================================
-- CREATE DATABASE
-- ============================================

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS company_db;

-- Use the database
USE company_db;

-- ============================================
-- DROP EXISTING TABLES (if they exist)
-- ============================================

-- Drop tables in correct order (child tables first due to foreign keys)
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;

-- ============================================
-- CREATE DEPARTMENT TABLE
-- ============================================

CREATE TABLE department (
    -- Primary key: Unique identifier for each department
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    
    -- Department name: Cannot be null, must be unique
    dept_name VARCHAR(50) NOT NULL UNIQUE,
    
    -- Department location
    location VARCHAR(100) NOT NULL,
    
    -- When the department was created
    created_date DATE DEFAULT (CURRENT_DATE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add comment to table
ALTER TABLE department COMMENT = 'Stores information about company departments';


-- ============================================
-- CREATE EMPLOYEE TABLE
-- ============================================

CREATE TABLE employee (
    -- Primary key: Unique identifier for each employee
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    
    -- Employee name: Cannot be null
    emp_name VARCHAR(100) NOT NULL,
    
    -- Job title/position
    job VARCHAR(50) NOT NULL,
    
    -- Salary: Must be positive
    salary DECIMAL(10, 2) NOT NULL CHECK (salary > 0),
    
    -- Date when employee was hired
    hire_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    
    -- Foreign key: References department table
    -- Can be NULL (employee not yet assigned to department)
    dept_id INT,
    
    -- Manager ID: Self-referencing foreign key
    -- Can be NULL (employee has no manager, like CEO)
    mgr_id INT,
    
    -- Email: Optional, must be unique if provided
    email VARCHAR(100) UNIQUE,
    
    -- Phone: Optional
    phone VARCHAR(20),
    
    -- CONSTRAINTS
    
    -- Foreign key constraint: dept_id references department table
    CONSTRAINT fk_employee_department 
        FOREIGN KEY (dept_id) 
        REFERENCES department(dept_id)
        ON DELETE SET NULL      -- If department deleted, set employee's dept_id to NULL
        ON UPDATE CASCADE,      -- If dept_id changes, update employee records
    
    -- Self-referencing foreign key: mgr_id references same table
    CONSTRAINT fk_employee_manager 
        FOREIGN KEY (mgr_id) 
        REFERENCES employee(emp_id)
        ON DELETE SET NULL      -- If manager deleted, set mgr_id to NULL
        ON UPDATE CASCADE       -- If emp_id changes, update mgr_id references
        
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add comment to table
ALTER TABLE employee COMMENT = 'Stores information about company employees';


-- ============================================
-- CREATE INDEXES FOR PERFORMANCE
-- ============================================

-- Index on employee name for faster searches
CREATE INDEX idx_emp_name ON employee(emp_name);

-- Index on department ID for faster joins
CREATE INDEX idx_dept_id ON employee(dept_id);

-- Index on job title for faster filtering
CREATE INDEX idx_job ON employee(job);

-- Index on salary for faster range queries
CREATE INDEX idx_salary ON employee(salary);

-- Index on hire_date for date-based queries
CREATE INDEX idx_hire_date ON employee(hire_date);


-- ============================================
-- DISPLAY TABLE STRUCTURES
-- ============================================

-- Show department table structure
DESCRIBE department;

-- Show employee table structure  
DESCRIBE employee;

-- Show all tables in database
SHOW TABLES;


-- ============================================
-- NOTES AND EXPLANATION
-- ============================================

/*
PRIMARY KEY:
- Uniquely identifies each record
- Cannot be NULL
- Automatically creates an index
- One per table

FOREIGN KEY:
- Links two tables together
- Maintains referential integrity
- Value must exist in referenced table (or be NULL)
- dept_id in employee references dept_id in department

ON DELETE CASCADE:
- When parent record deleted, child records also deleted

ON DELETE SET NULL:
- When parent record deleted, foreign key in child set to NULL

ON UPDATE CASCADE:
- When primary key updated in parent, foreign key updated in child

AUTO_INCREMENT:
- Automatically generates unique sequential numbers
- Used for primary keys

CHECK CONSTRAINT:
- Ensures data meets specific condition
- salary > 0 ensures no negative salaries

UNIQUE CONSTRAINT:
- Ensures all values in column are different
- dept_name must be unique
- NULL values are allowed (and multiple NULLs are permitted)

DEFAULT:
- Provides default value if none specified
- hire_date defaults to current date

DECIMAL(10, 2):
- Total 10 digits
- 2 digits after decimal point
- Good for storing money values

VARCHAR vs CHAR:
- VARCHAR: Variable length, saves space
- CHAR: Fixed length, faster for fixed-size data

ENGINE=InnoDB:
- Supports foreign keys
- Supports transactions
- Row-level locking
- Crash recovery

CHARSET=utf8mb4:
- Supports international characters
- Supports emojis
- Recommended for modern applications
*/


-- ============================================
-- VERIFICATION QUERIES
-- ============================================

-- Verify tables are created
SELECT TABLE_NAME, TABLE_TYPE 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'company_db';

-- Verify foreign key constraints
SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'company_db'
AND REFERENCED_TABLE_NAME IS NOT NULL;


-- ============================================
-- END OF SCHEMA CREATION
-- ============================================

-- Next steps:
-- 1. Run data/insert_department.sql to populate department table
-- 2. Run data/insert_employee.sql to populate employee table
