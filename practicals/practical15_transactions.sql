-- ============================================
-- PRACTICAL 15: TRANSACTIONS
-- ============================================

USE company_db;

-- ============================================
-- 1. Basic Transaction with COMMIT
-- ============================================

START TRANSACTION;

-- Insert new department
INSERT INTO department (dept_name, location) 
VALUES ('Testing', 'Test City');

-- Verify insert
SELECT * FROM department WHERE dept_name = 'Testing';

-- Commit transaction
COMMIT;

-- ============================================
-- 2. Transaction with ROLLBACK
-- ============================================

START TRANSACTION;

-- Insert employee
INSERT INTO employee (emp_name, job, salary, dept_id) 
VALUES ('Temp Employee', 'Temp Job', 40000, 1);

-- Verify insert
SELECT * FROM employee WHERE emp_name = 'Temp Employee';

-- Rollback (undo changes)
ROLLBACK;

-- Verify rollback (record should not exist)
SELECT * FROM employee WHERE emp_name = 'Temp Employee';

-- ============================================
-- 3. Transaction with SAVEPOINT
-- ============================================

START TRANSACTION;

-- First operation
INSERT INTO department (dept_name, location) 
VALUES ('Dept A', 'Location A');

-- Create savepoint
SAVEPOINT sp1;

-- Second operation
INSERT INTO department (dept_name, location) 
VALUES ('Dept B', 'Location B');

-- Create another savepoint
SAVEPOINT sp2;

-- Third operation
INSERT INTO department (dept_name, location) 
VALUES ('Dept C', 'Location C');

-- Rollback to sp2 (Dept C insert undone)
ROLLBACK TO sp2;

-- Rollback to sp1 (Dept B insert also undone)
ROLLBACK TO sp1;

-- Commit (only Dept A remains)
COMMIT;

-- ============================================
-- 4. Bank Transfer Example (ACID)
-- ============================================

-- Create accounts table for demo
CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100),
    balance DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO accounts VALUES 
    (1, 'Alice', 5000.00),
    (2, 'Bob', 3000.00);

-- Transfer 1000 from Alice to Bob
START TRANSACTION;

-- Debit from Alice
UPDATE accounts 
SET balance = balance - 1000 
WHERE account_id = 1;

-- Check if sufficient balance
SELECT balance FROM accounts WHERE account_id = 1;

-- Credit to Bob
UPDATE accounts 
SET balance = balance + 1000 
WHERE account_id = 2;

-- Verify balances
SELECT * FROM accounts;

-- Commit transaction
COMMIT;

-- ============================================
-- 5. Transaction with Error Handling
-- ============================================

DELIMITER //
CREATE PROCEDURE transfer_money(
    IN from_account INT,
    IN to_account INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE current_balance DECIMAL(10,2);
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Transaction failed and rolled back' AS message;
    END;
    
    START TRANSACTION;
    
    -- Check balance
    SELECT balance INTO current_balance 
    FROM accounts 
    WHERE account_id = from_account;
    
    IF current_balance < amount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient balance';
    END IF;
    
    -- Debit
    UPDATE accounts 
    SET balance = balance - amount 
    WHERE account_id = from_account;
    
    -- Credit
    UPDATE accounts 
    SET balance = balance + amount 
    WHERE account_id = to_account;
    
    COMMIT;
    SELECT 'Transaction successful' AS message;
END //
DELIMITER ;

-- Test procedure
-- CALL transfer_money(1, 2, 500);

-- ============================================
-- 6. Autocommit Mode
-- ============================================

-- Check autocommit status
SELECT @@autocommit;

-- Disable autocommit
SET autocommit = 0;

-- Now every statement needs explicit COMMIT
UPDATE accounts SET balance = 1000 WHERE account_id = 1;
ROLLBACK;  -- Undoes the update

-- Enable autocommit
SET autocommit = 1;

-- ============================================
-- 7. Transaction Isolation Levels
-- ============================================

-- Show current isolation level
SELECT @@transaction_isolation;

-- Set isolation level
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- ============================================
-- 8. Demonstrating ACID Properties
-- ============================================

/*
A - Atomicity: All or nothing
  Either entire transaction succeeds or fails completely
  
C - Consistency: Valid state to valid state
  Database integrity constraints maintained
  
I - Isolation: Transactions don't interfere
  Concurrent transactions isolated from each other
  
D - Durability: Permanent changes
  Once committed, changes persist even after crash
*/

-- ============================================
-- 9. Lock Tables (for transaction control)
-- ============================================

-- Lock table for writing
-- LOCK TABLES accounts WRITE;

-- Perform operations
-- UPDATE accounts SET balance = balance + 100 WHERE account_id = 1;

-- Unlock tables
-- UNLOCK TABLES;

-- ============================================
-- 10. View Transaction Log
-- ============================================

-- In MySQL, transactions are logged in binary log
-- SHOW BINARY LOGS;
-- SHOW BINLOG EVENTS;

-- ============================================
-- Cleanup
-- ============================================

DROP PROCEDURE IF EXISTS transfer_money;
DROP TABLE IF EXISTS accounts;

-- Delete test department
DELETE FROM department WHERE dept_name IN ('Testing', 'Dept A', 'Dept B', 'Dept C');

-- ============================================
-- Transaction Best Practices
-- ============================================

/*
1. Keep transactions short
2. Don't hold locks for long
3. Handle errors properly
4. Use appropriate isolation level
5. Always COMMIT or ROLLBACK
6. Avoid nested transactions
7. Use SAVEPOINT for partial rollback
*/

-- ============================================
-- END OF PRACTICAL 15
-- ============================================
