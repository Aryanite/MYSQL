-- ============================================
-- PRACTICAL 02: DML COMMANDS
-- ============================================
-- Data Manipulation Language: INSERT, UPDATE, DELETE

USE company_db;

-- ============================================
-- CREATE SAMPLE TABLES FOR PRACTICE
-- ============================================

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT DEFAULT 0,
    created_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ============================================
-- 1. INSERT Command
-- ============================================

-- Insert single row with all columns
INSERT INTO products (product_name, category, price, stock_quantity)
VALUES ('Laptop', 'Electronics', 75000.00, 15);

-- Insert single row with some columns (others get default values)
INSERT INTO products (product_name, category, price)
VALUES ('Mouse', 'Accessories', 500.00);

-- Insert multiple rows
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
    ('Keyboard', 'Accessories', 1500.00, 30),
    ('Monitor', 'Electronics', 12000.00, 20),
    ('Headphones', 'Accessories', 2500.00, 25),
    ('Webcam', 'Accessories', 3500.00, 10),
    ('USB Cable', 'Accessories', 200.00, 50),
    ('Hard Disk', 'Storage', 4500.00, 18),
    ('SSD', 'Storage', 8000.00, 12),
    ('RAM', 'Components', 5500.00, 22);

-- View inserted data
SELECT * FROM products;

-- Insert customers
INSERT INTO customers (customer_name, email, phone, city) VALUES
    ('Rahul Sharma', 'rahul@email.com', '9876543210', 'Mumbai'),
    ('Priya Patel', 'priya@email.com', '9876543211', 'Delhi'),
    ('Amit Kumar', 'amit@email.com', '9876543212', 'Bangalore'),
    ('Sneha Reddy', 'sneha@email.com', '9876543213', 'Hyderabad'),
    ('Vikas Singh', 'vikas@email.com', '9876543214', 'Chennai');

SELECT * FROM customers;

-- Insert orders
INSERT INTO orders (customer_id, product_id, quantity) VALUES
    (1, 1, 1),  -- Rahul bought Laptop
    (1, 3, 2),  -- Rahul bought 2 Keyboards
    (2, 2, 3),  -- Priya bought 3 Mice
    (3, 4, 1),  -- Amit bought Monitor
    (4, 5, 2),  -- Sneha bought 2 Headphones
    (5, 8, 1);  -- Vikas bought Hard Disk

SELECT * FROM orders;


-- ============================================
-- 2. INSERT with SELECT
-- ============================================

-- Create backup table
CREATE TABLE products_backup AS SELECT * FROM products WHERE 1=0;

-- Insert data from another table
INSERT INTO products_backup 
SELECT * FROM products WHERE category = 'Accessories';

-- Verify
SELECT * FROM products_backup;


-- ============================================
-- 3. UPDATE Command
-- ============================================

-- Update single row
UPDATE products 
SET stock_quantity = 20 
WHERE product_id = 1;

-- Update multiple rows
UPDATE products 
SET price = price * 1.10 
WHERE category = 'Accessories';

-- Update with calculation
UPDATE products 
SET stock_quantity = stock_quantity + 10 
WHERE stock_quantity < 15;

-- Update multiple columns
UPDATE products 
SET price = 6000.00, stock_quantity = 25 
WHERE product_id = 10;

-- Update based on condition
UPDATE customers 
SET city = 'Pune' 
WHERE customer_name = 'Rahul Sharma';

-- Update all rows (BE CAREFUL!)
-- UPDATE products SET created_date = CURDATE();

-- View updated data
SELECT * FROM products;
SELECT * FROM customers;


-- ============================================
-- 4. UPDATE with JOIN
-- ============================================

-- Increase price of products that have been ordered
UPDATE products p
INNER JOIN orders o ON p.product_id = o.product_id
SET p.price = p.price * 1.05
WHERE o.quantity > 1;


-- ============================================
-- 5. UPDATE with CASE
-- ============================================

-- Update stock status based on quantity
UPDATE products
SET category = CASE
    WHEN stock_quantity > 30 THEN 'High Stock'
    WHEN stock_quantity BETWEEN 15 AND 30 THEN 'Medium Stock'
    ELSE category
END
WHERE category = 'Accessories';

SELECT product_name, stock_quantity, category FROM products;


-- ============================================
-- 6. DELETE Command
-- ============================================

-- Delete single row
DELETE FROM products 
WHERE product_id = 7;

-- Delete multiple rows
DELETE FROM products 
WHERE stock_quantity < 5;

-- Delete based on condition
DELETE FROM customers 
WHERE city = 'Pune';

-- Delete with subquery
DELETE FROM products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM orders);


-- ============================================
-- 7. DELETE vs TRUNCATE
-- ============================================

-- DELETE removes specific rows
CREATE TABLE test_delete (
    id INT,
    name VARCHAR(50)
);

INSERT INTO test_delete VALUES (1, 'A'), (2, 'B'), (3, 'C');

-- Delete specific rows
DELETE FROM test_delete WHERE id = 2;
SELECT * FROM test_delete;

-- TRUNCATE removes all rows
TRUNCATE TABLE test_delete;
SELECT * FROM test_delete;


-- ============================================
-- 8. DELETE with JOIN
-- ============================================

-- Delete orders for customers from specific city
-- First, let's re-insert customers
INSERT INTO customers (customer_name, email, phone, city) VALUES
    ('Test User', 'test@email.com', '1111111111', 'TestCity');

INSERT INTO orders (customer_id, product_id, quantity)
SELECT customer_id, 1, 1 FROM customers WHERE city = 'TestCity';

-- Delete orders from customers in TestCity
DELETE o FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE c.city = 'TestCity';

-- Delete the test customer
DELETE FROM customers WHERE city = 'TestCity';


-- ============================================
-- 9. INSERT IGNORE
-- ============================================

-- Insert or ignore if duplicate
INSERT IGNORE INTO customers (customer_id, customer_name, email, city) 
VALUES (1, 'Duplicate User', 'duplicate@email.com', 'Mumbai');

-- No error, just ignores the insert


-- ============================================
-- 10. ON DUPLICATE KEY UPDATE
-- ============================================

-- Update if duplicate key, otherwise insert
INSERT INTO products (product_id, product_name, category, price, stock_quantity)
VALUES (1, 'Updated Laptop', 'Electronics', 80000.00, 20)
ON DUPLICATE KEY UPDATE 
    price = 80000.00,
    stock_quantity = 20;


-- ============================================
-- 11. REPLACE
-- ============================================

-- REPLACE = DELETE + INSERT
REPLACE INTO products (product_id, product_name, category, price, stock_quantity)
VALUES (1, 'New Laptop', 'Electronics', 85000.00, 25);

SELECT * FROM products WHERE product_id = 1;


-- ============================================
-- 12. Bulk Operations
-- ============================================

-- Bulk insert
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
    ('Product A', 'Category1', 1000, 10),
    ('Product B', 'Category1', 2000, 20),
    ('Product C', 'Category2', 3000, 30),
    ('Product D', 'Category2', 4000, 40),
    ('Product E', 'Category3', 5000, 50);

-- Bulk update
UPDATE products 
SET price = price * 0.9 
WHERE category IN ('Category1', 'Category2');

-- Bulk delete
DELETE FROM products 
WHERE category = 'Category3';


-- ============================================
-- PRACTICAL EXERCISES
-- ============================================

-- Exercise 1: Insert 3 new products with your choice of details
-- Your query here:


-- Exercise 2: Update price of all Electronics by increasing 15%
-- Your query here:


-- Exercise 3: Add 5 to stock_quantity for products with price > 5000
-- Your query here:


-- Exercise 4: Delete all products with stock_quantity = 0
-- Your query here:


-- Exercise 5: Insert a new customer and create an order for them
-- Your query here:


-- Exercise 6: Update email for customer with customer_id = 2
-- Your query here:


-- Exercise 7: Delete orders with quantity = 1
-- Your query here:


-- ============================================
-- VIEW FINAL DATA
-- ============================================

SELECT 'Products:' AS Table_Name;
SELECT * FROM products ORDER BY product_id;

SELECT 'Customers:' AS Table_Name;
SELECT * FROM customers ORDER BY customer_id;

SELECT 'Orders:' AS Table_Name;
SELECT * FROM orders ORDER BY order_id;


-- ============================================
-- CLEANUP (Optional)
-- ============================================

-- Drop tables if needed
-- DROP TABLE IF EXISTS orders;
-- DROP TABLE IF EXISTS customers;
-- DROP TABLE IF EXISTS products;
-- DROP TABLE IF EXISTS products_backup;
-- DROP TABLE IF EXISTS test_delete;


-- ============================================
-- END OF PRACTICAL 02
-- ============================================
