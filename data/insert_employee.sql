-- ============================================
-- INSERT SAMPLE EMPLOYEE DATA
-- ============================================
-- This file populates the employee table with sample data

USE company_db;

-- ============================================
-- INSERT EMPLOYEE RECORDS
-- ============================================

-- Note: Insert managers first (those with mgr_id = NULL)
-- Then insert employees with manager references

-- CEO (No manager)
INSERT INTO employee (emp_id, emp_name, job, salary, hire_date, dept_id, mgr_id, email, phone) VALUES
(101, 'Robert Johnson', 'CEO', 120000.00, '2015-01-15', NULL, NULL, 'robert.j@company.com', '555-0101');

-- Department Heads (Report to CEO)
INSERT INTO employee (emp_id, emp_name, job, salary, hire_date, dept_id, mgr_id, email, phone) VALUES
(102, 'Jennifer Smith', 'IT Manager', 95000.00, '2015-02-01', 1, 101, 'jennifer.s@company.com', '555-0102'),
(103, 'Michael Brown', 'HR Manager', 85000.00, '2015-03-15', 2, 101, 'michael.b@company.com', '555-0103'),
(104, 'Sarah Davis', 'Finance Manager', 90000.00, '2015-04-01', 3, 101, 'sarah.d@company.com', '555-0104'),
(105, 'David Wilson', 'Sales Manager', 88000.00, '2015-05-10', 4, 101, 'david.w@company.com', '555-0105'),
(106, 'Lisa Anderson', 'Marketing Manager', 87000.00, '2016-06-01', 5, 101, 'lisa.a@company.com', '555-0106'),
(107, 'James Martinez', 'Operations Manager', 86000.00, '2016-07-15', 6, 101, 'james.m@company.com', '555-0107'),
(108, 'Patricia Garcia', 'R&D Manager', 92000.00, '2017-01-20', 7, 101, 'patricia.g@company.com', '555-0108');

-- IT Department Employees
INSERT INTO employee (emp_id, emp_name, job, salary, hire_date, dept_id, mgr_id, email, phone) VALUES
(201, 'John Miller', 'Senior Developer', 75000.00, '2016-03-10', 1, 102, 'john.m@company.com', '555-0201'),
(202, 'Emily Taylor', 'Developer', 65000.00, '2017-05-15', 1, 102, 'emily.t@company.com', '555-0202'),
(203, 'Daniel Thomas', 'Developer', 62000.00, '2018-08-20', 1, 102, 'daniel.t@company.com', '555-0203'),
(204, 'Jessica Moore', 'Database Admin', 70000.00, '2017-09-05', 1, 102, 'jessica.m@company.com', '555-0204'),
(205, 'Christopher Lee', 'Systems Analyst', 68000.00, '2018-11-12', 1, 102, 'chris.l@company.com', '555-0205'),
(206, 'Amanda White', 'Junior Developer', 55000.00, '2019-02-28', 1, 102, 'amanda.w@company.com', '555-0206');

-- HR Department Employees
INSERT INTO employee (emp_id, emp_name, job, salary, hire_date, dept_id, mgr_id, email, phone) VALUES
(301, 'Matthew Harris', 'HR Specialist', 58000.00, '2016-04-15', 2, 103, 'matthew.h@company.com', '555-0301'),
(302, 'Ashley Clark', 'Recruiter', 56000.00, '2017-06-20', 2, 103, 'ashley.c@company.com', '555-0302'),
(303, 'Joshua Lewis', 'HR Assistant', 48000.00, '2018-09-10', 2, 103, 'joshua.l@company.com', '555-0303'),
(304, 'Stephanie Walker', 'Training Coordinator', 54000.00, '2019-01-25', 2, 103, 'stephanie.w@company.com', '555-0304');

-- Finance Department Employees
INSERT INTO employee (emp_id, emp_name, job, salary, hire_date, dept_id, mgr_id, email, phone) VALUES
(401, 'Andrew Hall', 'Senior Accountant', 72000.00, '2016-05-01', 3, 104, 'andrew.h@company.com', '555-0401'),
(402, 'Megan Allen', 'Accountant', 61000.00, '2017-07-15', 3, 104, 'megan.a@company.com', '555-0402'),
(403, 'Ryan Young', 'Financial Analyst', 64000.00, '2018-10-20', 3, 104, 'ryan.y@company.com', '555-0403'),
(404, 'Nicole King', 'Accountant', 59000.00, '2019-03-12', 3, 104, 'nicole.k@company.com', '555-0404'),
(405, 'Brandon Wright', 'Junior Analyst', 52000.00, '2020-01-08', 3, 104, 'brandon.w@company.com', '555-0405');

-- Sales Department Employees
INSERT INTO employee (emp_id, emp_name, job, salary, hire_date, dept_id, mgr_id, email, phone) VALUES
(501, 'Kevin Scott', 'Senior Sales Rep', 69000.00, '2016-06-10', 4, 105, 'kevin.s@company.com', '555-0501'),
(502, 'Rachel Green', 'Sales Representative', 58000.00, '2017-08-15', 4, 105, 'rachel.g@company.com', '555-0502'),
(503, 'Justin Adams', 'Sales Representative', 57000.00, '2018-11-20', 4, 105, 'justin.a@company.com', '555-0503'),
(504, 'Lauren Baker', 'Sales Associate', 51000.00, '2019-04-05', 4, 105, 'lauren.b@company.com', '555-0504'),
(505, 'Eric Nelson', 'Sales Representative', 59000.00, '2019-09-18', 4, 105, 'eric.n@company.com', '555-0505'),
(506, 'Brittany Carter', 'Junior Sales Rep', 49000.00, '2020-02-14', 4, 105, 'brittany.c@company.com', '555-0506');

-- Marketing Department Employees
INSERT INTO employee (emp_id, emp_name, job, salary, hire_date, dept_id, mgr_id, email, phone) VALUES
(601, 'Tyler Mitchell', 'Marketing Specialist', 63000.00, '2017-01-10', 5, 106, 'tyler.m@company.com', '555-0601'),
(602, 'Samantha Perez', 'Content Writer', 55000.00, '2018-03-22', 5, 106, 'samantha.p@company.com', '555-0602'),
(603, 'Jason Roberts', 'SEO Specialist', 60000.00, '2018-07-30', 5, 106, 'jason.r@company.com', '555-0603'),
(604, 'Michelle Turner', 'Social Media Manager', 58000.00, '2019-05-16', 5, 106, 'michelle.t@company.com', '555-0604'),
(605, 'Nathan Phillips', 'Graphic Designer', 56000.00, '2020-03-08', 5, 106, 'nathan.p@company.com', '555-0605');

-- Operations Department Employees
INSERT INTO employee (emp_id, emp_name, job, salary, hire_date, dept_id, mgr_id, email, phone) VALUES
(701, 'Gregory Campbell', 'Operations Analyst', 62000.00, '2017-02-15', 6, 107, 'gregory.c@company.com', '555-0701'),
(702, 'Kimberly Parker', 'Process Manager', 65000.00, '2018-04-20', 6, 107, 'kimberly.p@company.com', '555-0702'),
(703, 'Timothy Evans', 'Operations Associate', 54000.00, '2019-06-25', 6, 107, 'timothy.e@company.com', '555-0703'),
(704, 'Rebecca Edwards', 'Quality Analyst', 57000.00, '2020-04-10', 6, 107, 'rebecca.e@company.com', '555-0704');

-- R&D Department Employees
INSERT INTO employee (emp_id, emp_name, job, salary, hire_date, dept_id, mgr_id, email, phone) VALUES
(801, 'Jacob Collins', 'Research Scientist', 78000.00, '2017-03-01', 7, 108, 'jacob.c@company.com', '555-0801'),
(802, 'Victoria Stewart', 'Product Designer', 71000.00, '2018-05-15', 7, 108, 'victoria.s@company.com', '555-0802'),
(803, 'Alexander Morris', 'Research Associate', 66000.00, '2019-07-20', 7, 108, 'alex.m@company.com', '555-0803'),
(804, 'Olivia Rogers', 'Innovation Analyst', 64000.00, '2020-05-01', 7, 108, 'olivia.r@company.com', '555-0804');


-- ============================================
-- VERIFY INSERTED DATA
-- ============================================

-- Display all employees
SELECT * FROM employee ORDER BY emp_id;

-- Count total employees
SELECT COUNT(*) AS total_employees FROM employee;

-- Employee count by department
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM department d
LEFT JOIN employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY employee_count DESC;

-- Salary statistics
SELECT 
    COUNT(*) AS total_employees,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    ROUND(AVG(salary), 2) AS avg_salary,
    SUM(salary) AS total_payroll
FROM employee;

-- Managers and their subordinates
SELECT 
    m.emp_name AS manager,
    COUNT(e.emp_id) AS subordinates
FROM employee m
LEFT JOIN employee e ON e.mgr_id = m.emp_id
GROUP BY m.emp_name
HAVING subordinates > 0
ORDER BY subordinates DESC;


-- ============================================
-- EMPLOYEE SUMMARY
-- ============================================

/*
Total Employees: 43

Department Distribution:
- CEO: 1
- IT: 6 + 1 manager = 7
- HR: 4 + 1 manager = 5
- Finance: 5 + 1 manager = 6
- Sales: 6 + 1 manager = 7
- Marketing: 5 + 1 manager = 6
- Operations: 4 + 1 manager = 5
- R&D: 4 + 1 manager = 5

Salary Range: $48,000 - $120,000

Job Levels:
- Executive: CEO
- Managers: Department heads
- Senior: Senior positions
- Regular: Standard positions
- Junior: Entry-level positions

All employees have:
- Valid email addresses
- Phone numbers
- Hire dates
- Department assignments (except CEO)
- Manager references (except CEO)
*/


-- ============================================
-- END OF EMPLOYEE DATA INSERT
-- ============================================
