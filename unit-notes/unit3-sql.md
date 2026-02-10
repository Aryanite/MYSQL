# Unit 3: SQL (Structured Query Language)

## What is SQL?

**SQL (Structured Query Language)** is a standard language for managing and manipulating relational databases.

**SQL Categories:**
1. **DDL** (Data Definition Language)
2. **DML** (Data Manipulation Language)
3. **DQL** (Data Query Language)
4. **DCL** (Data Control Language)
5. **TCL** (Transaction Control Language)

---

## 1. DDL (Data Definition Language)

DDL commands define the structure of the database.

### CREATE
Creates new database objects (database, table, index, view).

```sql
-- Create Database
CREATE DATABASE company_db;

-- Create Table
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2),
    dept_id INT
);
```

### ALTER
Modifies existing database objects.

```sql
-- Add Column
ALTER TABLE employee ADD email VARCHAR(100);

-- Modify Column
ALTER TABLE employee MODIFY salary DECIMAL(12,2);

-- Drop Column
ALTER TABLE employee DROP COLUMN email;

-- Rename Column
ALTER TABLE employee RENAME COLUMN emp_name TO employee_name;
```

### DROP
Deletes database objects (cannot be undone).

```sql
-- Drop Table
DROP TABLE employee;

-- Drop Database
DROP DATABASE company_db;
```

### TRUNCATE
Removes all records from table (structure remains).

```sql
TRUNCATE TABLE employee;
```

**Difference: DELETE vs TRUNCATE vs DROP**
- **DELETE**: Removes rows, can use WHERE, can rollback, slower
- **TRUNCATE**: Removes all rows, cannot rollback, faster, resets auto-increment
- **DROP**: Removes entire table structure

---

## 2. DML (Data Manipulation Language)

DML commands manipulate data in tables.

### INSERT
Adds new records to a table.

```sql
-- Insert single row
INSERT INTO employee (emp_id, emp_name, salary, dept_id)
VALUES (101, 'John Doe', 50000, 1);

-- Insert multiple rows
INSERT INTO employee VALUES 
    (102, 'Jane Smith', 60000, 2),
    (103, 'Bob Wilson', 55000, 1);

-- Insert with specific columns
INSERT INTO employee (emp_id, emp_name) 
VALUES (104, 'Alice Brown');
```

### UPDATE
Modifies existing records.

```sql
-- Update single record
UPDATE employee 
SET salary = 55000 
WHERE emp_id = 101;

-- Update multiple records
UPDATE employee 
SET salary = salary * 1.10 
WHERE dept_id = 1;

-- Update all records (be careful!)
UPDATE employee SET dept_id = 1;
```

### DELETE
Removes records from a table.

```sql
-- Delete specific records
DELETE FROM employee WHERE emp_id = 104;

-- Delete with condition
DELETE FROM employee WHERE salary < 30000;

-- Delete all records (structure remains)
DELETE FROM employee;
```

---

## 3. DQL (Data Query Language)

### SELECT Statement

The most important SQL command for retrieving data.

**Basic Syntax:**
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
GROUP BY column
HAVING condition
ORDER BY column;
```

### SELECT Examples

```sql
-- Select all columns
SELECT * FROM employee;

-- Select specific columns
SELECT emp_name, salary FROM employee;

-- Select with alias
SELECT emp_name AS Name, salary AS Salary FROM employee;

-- Select with calculation
SELECT emp_name, salary * 12 AS annual_salary FROM employee;
```

### WHERE Clause
Filters records based on conditions.

```sql
-- Comparison operators
SELECT * FROM employee WHERE salary > 50000;
SELECT * FROM employee WHERE dept_id = 1;
SELECT * FROM employee WHERE emp_name = 'John Doe';

-- Multiple conditions
SELECT * FROM employee WHERE salary > 50000 AND dept_id = 1;
SELECT * FROM employee WHERE dept_id = 1 OR dept_id = 2;
SELECT * FROM employee WHERE NOT dept_id = 3;
```

### DISTINCT
Removes duplicate values.

```sql
SELECT DISTINCT dept_id FROM employee;
```

### ORDER BY
Sorts results.

```sql
-- Ascending (default)
SELECT * FROM employee ORDER BY salary;

-- Descending
SELECT * FROM employee ORDER BY salary DESC;

-- Multiple columns
SELECT * FROM employee ORDER BY dept_id, salary DESC;
```

### LIMIT
Limits number of results.

```sql
-- First 5 records
SELECT * FROM employee LIMIT 5;

-- Skip 5, get next 10
SELECT * FROM employee LIMIT 5, 10;
```

---

## SQL Constraints

Constraints enforce rules on data in tables.

### 1. NOT NULL
Column cannot have NULL values.

```sql
CREATE TABLE student (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL
);
```

### 2. UNIQUE
All values in column must be unique.

```sql
CREATE TABLE student (
    id INT UNIQUE,
    email VARCHAR(100) UNIQUE
);
```

### 3. PRIMARY KEY
Uniquely identifies each record (NOT NULL + UNIQUE).

```sql
CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Composite primary key
CREATE TABLE enrollment (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id)
);
```

### 4. FOREIGN KEY
Links two tables together.

```sql
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

-- With actions
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
```

**Referential Actions:**
- **CASCADE**: Delete/update related records
- **SET NULL**: Set foreign key to NULL
- **SET DEFAULT**: Set to default value
- **RESTRICT**: Prevent deletion/update
- **NO ACTION**: Same as RESTRICT

### 5. CHECK
Ensures values meet specific condition.

```sql
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    age INT CHECK (age >= 18),
    salary DECIMAL(10,2) CHECK (salary > 0)
);
```

### 6. DEFAULT
Sets default value for column.

```sql
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    status VARCHAR(20) DEFAULT 'Active',
    hire_date DATE DEFAULT CURRENT_DATE
);
```

---

## SQL Joins

Joins combine rows from two or more tables based on related columns.

### 1. INNER JOIN
Returns matching records from both tables.

```sql
SELECT e.emp_name, d.dept_name
FROM employee e
INNER JOIN department d ON e.dept_id = d.dept_id;
```

### 2. LEFT JOIN (LEFT OUTER JOIN)
Returns all records from left table + matching from right.

```sql
SELECT e.emp_name, d.dept_name
FROM employee e
LEFT JOIN department d ON e.dept_id = d.dept_id;
```

### 3. RIGHT JOIN (RIGHT OUTER JOIN)
Returns all records from right table + matching from left.

```sql
SELECT e.emp_name, d.dept_name
FROM employee e
RIGHT JOIN department d ON e.dept_id = d.dept_id;
```

### 4. FULL JOIN (FULL OUTER JOIN)
Returns all records when there's a match in either table.

```sql
SELECT e.emp_name, d.dept_name
FROM employee e
FULL OUTER JOIN department d ON e.dept_id = d.dept_id;

-- MySQL doesn't support FULL JOIN, use UNION
SELECT e.emp_name, d.dept_name FROM employee e
LEFT JOIN department d ON e.dept_id = d.dept_id
UNION
SELECT e.emp_name, d.dept_name FROM employee e
RIGHT JOIN department d ON e.dept_id = d.dept_id;
```

### 5. CROSS JOIN
Returns Cartesian product (all combinations).

```sql
SELECT e.emp_name, d.dept_name
FROM employee e
CROSS JOIN department d;
```

### 6. SELF JOIN
Table joined with itself.

```sql
-- Find employees and their managers
SELECT e1.emp_name AS Employee, e2.emp_name AS Manager
FROM employee e1
JOIN employee e2 ON e1.manager_id = e2.emp_id;
```

---

## Subqueries (Nested Queries)

A query inside another query.

### Single-row Subquery
Returns single value.

```sql
-- Find employees with salary greater than average
SELECT * FROM employee 
WHERE salary > (SELECT AVG(salary) FROM employee);
```

### Multi-row Subquery
Returns multiple values.

```sql
-- Find employees in departments located in 'New York'
SELECT * FROM employee 
WHERE dept_id IN (SELECT dept_id FROM department WHERE location = 'New York');
```

### Correlated Subquery
Inner query depends on outer query.

```sql
-- Find employees earning more than average in their department
SELECT e1.emp_name, e1.salary 
FROM employee e1
WHERE salary > (
    SELECT AVG(salary) 
    FROM employee e2 
    WHERE e2.dept_id = e1.dept_id
);
```

### EXISTS
Tests for existence of rows.

```sql
SELECT * FROM department d
WHERE EXISTS (
    SELECT 1 FROM employee e WHERE e.dept_id = d.dept_id
);
```

---

## Aggregate Functions

Functions that perform calculations on multiple rows.

```sql
-- COUNT: Number of rows
SELECT COUNT(*) FROM employee;
SELECT COUNT(DISTINCT dept_id) FROM employee;

-- SUM: Total of values
SELECT SUM(salary) FROM employee;

-- AVG: Average of values
SELECT AVG(salary) FROM employee;

-- MIN: Minimum value
SELECT MIN(salary) FROM employee;

-- MAX: Maximum value
SELECT MAX(salary) FROM employee;
```

### GROUP BY
Groups rows with same values.

```sql
-- Count employees per department
SELECT dept_id, COUNT(*) AS emp_count
FROM employee
GROUP BY dept_id;

-- Average salary per department
SELECT dept_id, AVG(salary) AS avg_salary
FROM employee
GROUP BY dept_id;
```

### HAVING
Filters groups (WHERE filters rows).

```sql
-- Departments with more than 5 employees
SELECT dept_id, COUNT(*) AS emp_count
FROM employee
GROUP BY dept_id
HAVING COUNT(*) > 5;

-- Departments with average salary > 50000
SELECT dept_id, AVG(salary) AS avg_salary
FROM employee
GROUP BY dept_id
HAVING AVG(salary) > 50000;
```

**Difference: WHERE vs HAVING**
- **WHERE**: Filters rows before grouping
- **HAVING**: Filters groups after grouping

---

## Views

A virtual table based on a query.

```sql
-- Create view
CREATE VIEW high_salary_emp AS
SELECT emp_name, salary 
FROM employee 
WHERE salary > 60000;

-- Use view
SELECT * FROM high_salary_emp;

-- Update view
CREATE OR REPLACE VIEW high_salary_emp AS
SELECT emp_name, salary, dept_id
FROM employee 
WHERE salary > 60000;

-- Drop view
DROP VIEW high_salary_emp;
```

**Benefits of Views:**
- Simplify complex queries
- Provide security (hide columns)
- Present data differently

---

## Indexes

Improve query performance.

```sql
-- Create index
CREATE INDEX idx_emp_name ON employee(emp_name);

-- Create unique index
CREATE UNIQUE INDEX idx_email ON employee(email);

-- Create composite index
CREATE INDEX idx_dept_sal ON employee(dept_id, salary);

-- Drop index
DROP INDEX idx_emp_name ON employee;
```

**When to use indexes:**
- Columns used in WHERE clause
- Columns used in JOIN conditions
- Columns used in ORDER BY

**When NOT to use indexes:**
- Small tables
- Columns with frequent updates
- Columns with many NULL values

---

## Important Points for Exams

1. **DDL**: CREATE, ALTER, DROP, TRUNCATE
2. **DML**: INSERT, UPDATE, DELETE
3. **Primary Key**: NOT NULL + UNIQUE
4. **Foreign Key**: References another table
5. **INNER JOIN**: Matching records only
6. **LEFT JOIN**: All from left + matching from right
7. **GROUP BY**: Used with aggregate functions
8. **HAVING**: Filters groups, WHERE filters rows
9. **Subquery**: Query within query
10. **View**: Virtual table

---

## Quick Revision

- **DDL**: Structure (CREATE, ALTER, DROP, TRUNCATE)
- **DML**: Data (INSERT, UPDATE, DELETE)
- **DQL**: Query (SELECT)
- **Constraints**: NOT NULL, UNIQUE, PK, FK, CHECK, DEFAULT
- **Joins**: INNER, LEFT, RIGHT, FULL, CROSS, SELF
- **Aggregate**: COUNT, SUM, AVG, MIN, MAX
- **Clauses**: WHERE, GROUP BY, HAVING, ORDER BY
- **Subquery**: Single-row, Multi-row, Correlated
- **View**: Virtual table

---

**Exam Tip:** Practice writing JOIN queries and subqueries! Know the difference between WHERE and HAVING, DELETE and TRUNCATE. Understand when to use each type of JOIN!
