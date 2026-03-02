# SQL Lab – Experiment 1

## Aim
To perform DDL and DML operations including table creation, deletion, updating, and altering table structures.

## Question 1
Create Employee_master table with data using Employee table.

### Query
```sql
CREATE TABLE Employee_master AS SELECT * FROM EMPLOYEE;
```

### Output
Query OK, 14 rows affected (0.02 sec)
Records: 14  Duplicates: 0  Warnings: 0

## Question 2
Delete all record into Employee_master whose DeptNo is 10.

### Query
```sql
DELETE FROM Employee_master WHERE DEPTNO = 10;
```

### Output
Query OK, 3 rows affected (0.01 sec)

## Question 3
Update 10% in his salary of DEPTNO 20 into Employee_Master.

### Query
```sql
UPDATE Employee_master SET SAL = SAL * 1.10 WHERE DEPTNO = 20;
```

### Output
Query OK, 5 rows affected (0.01 sec)
Rows matched: 5  Changed: 5  Warnings: 0

## Question 4
Alter SAL with size 10,2 in Employee_Master.

### Query
```sql
ALTER TABLE Employee_master MODIFY SAL DECIMAL(10,2);
```

### Output
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

## Question 5
Drop Employee_master Table.

### Query
```sql
DROP TABLE Employee_master;
```

### Output
Query OK, 0 rows affected (0.01 sec)
