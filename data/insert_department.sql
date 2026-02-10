-- ============================================
-- INSERT SAMPLE DEPARTMENT DATA
-- ============================================
-- This file populates the department table with sample data

USE company_db;

-- ============================================
-- INSERT DEPARTMENT RECORDS
-- ============================================

-- Insert departments one by one with comments
INSERT INTO department (dept_id, dept_name, location, created_date) VALUES
(1, 'Information Technology', 'New York', '2015-01-15');
-- IT Department: Handles all technical operations

INSERT INTO department (dept_id, dept_name, location, created_date) VALUES
(2, 'Human Resources', 'Chicago', '2015-02-01');
-- HR Department: Manages employee relations and recruitment

INSERT INTO department (dept_id, dept_name, location, created_date) VALUES
(3, 'Finance', 'Boston', '2015-03-10');
-- Finance Department: Handles accounting and financial planning

INSERT INTO department (dept_id, dept_name, location, created_date) VALUES
(4, 'Sales', 'Los Angeles', '2015-04-20');
-- Sales Department: Manages sales and customer relationships

INSERT INTO department (dept_id, dept_name, location, created_date) VALUES
(5, 'Marketing', 'San Francisco', '2016-05-15');
-- Marketing Department: Handles marketing and brand management

INSERT INTO department (dept_id, dept_name, location, created_date) VALUES
(6, 'Operations', 'Seattle', '2016-06-01');
-- Operations Department: Manages day-to-day business operations

INSERT INTO department (dept_id, dept_name, location, created_date) VALUES
(7, 'Research & Development', 'Austin', '2017-01-10');
-- R&D Department: Innovation and product development


-- ============================================
-- ALTERNATIVE: BULK INSERT (Commented out)
-- ============================================

/*
-- If you prefer bulk insert, use this instead:
INSERT INTO department (dept_id, dept_name, location, created_date) VALUES
    (1, 'Information Technology', 'New York', '2015-01-15'),
    (2, 'Human Resources', 'Chicago', '2015-02-01'),
    (3, 'Finance', 'Boston', '2015-03-10'),
    (4, 'Sales', 'Los Angeles', '2015-04-20'),
    (5, 'Marketing', 'San Francisco', '2016-05-15'),
    (6, 'Operations', 'Seattle', '2016-06-01'),
    (7, 'Research & Development', 'Austin', '2017-01-10');
*/


-- ============================================
-- VERIFY INSERTED DATA
-- ============================================

-- Display all departments
SELECT * FROM department;

-- Count total departments
SELECT COUNT(*) AS total_departments FROM department;

-- Departments by location
SELECT location, COUNT(*) AS dept_count 
FROM department 
GROUP BY location;


-- ============================================
-- DEPARTMENT SUMMARY
-- ============================================

/*
Total Departments: 7

Breakdown:
1. IT (New York) - Technology and systems
2. HR (Chicago) - Employee management
3. Finance (Boston) - Financial operations
4. Sales (Los Angeles) - Revenue generation
5. Marketing (San Francisco) - Brand and promotion
6. Operations (Seattle) - Business operations
7. R&D (Austin) - Innovation and development

Locations: 7 different cities across USA
*/


-- ============================================
-- END OF DEPARTMENT DATA INSERT
-- ============================================
