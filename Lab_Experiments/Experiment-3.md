# SQL Lab – Experiment 3

## Aim
To practice sorting, pattern matching using LIKE, and performing basic arithmetic operations in SQL queries.

## Question 1
List all employees and jobs in Department 30 in descending order by salary.

### Query
```sql
SELECT ENAME, JOB FROM EMPLOYEE WHERE DEPTNO = 30 ORDER BY SAL DESC;
```

### Output
| ENAME  | JOB      |
|--------|----------|
| BLAKE  | MANAGER  |
| ALLEN  | SALESMAN |
| TURNER | SALESMAN |
| WARD   | SALESMAN |
| MARTIN | SALESMAN |
| JAMES  | CLERK    |
6 rows in set (0.00 sec)

## Question 2
List job and Department Number of employees whose name are five letters long begin with “A” and end with “N”.

### Query
```sql
SELECT JOB, DEPTNO FROM EMPLOYEE WHERE ENAME LIKE 'A___N';
```

### Output
| JOB      | DEPTNO |
|----------|--------|
| SALESMAN | 30     |
1 row in set (0.00 sec)

## Question 3
Display the name of employees whose name start with alphabet S.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE ENAME LIKE 'S%';
```

### Output
| ENAME |
|-------|
| SMITH |
| SCOTT |
2 rows in set (0.00 sec)

## Question 4
Display the names of employees whose name ends with alphabet S.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE ENAME LIKE '%S';
```

### Output
| ENAME |
|-------|
| JONES |
| ADAMS |
| JAMES |
3 rows in set (0.00 sec)

## Question 5
Display the names of employees working in department number 10 or 20 or 40 or employees working as clerks, salesman or analyst.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE DEPTNO IN (10, 20, 40) OR JOB IN ('CLERK', 'SALESMAN', 'ANALYST');
```

### Output
| ENAME  |
|--------|
| SMITH  |
| ALLEN  |
| WARD   |
| JONES  |
| MARTIN |
| CLARK  |
| SCOTT  |
| KING   |
| TURNER |
| ADAMS  |
| JAMES  |
| FORD   |
| MILLER |
13 rows in set (0.00 sec)

## Question 6
Display employee number and names for employees who earn commission.

### Query
```sql
SELECT EMPNO, ENAME FROM EMPLOYEE WHERE COMM IS NOT NULL AND COMM > 0;
```

### Output
| EMPNO | ENAME  |
|-------|--------|
| 7499  | ALLEN  |
| 7521  | WARD   |
| 7654  | MARTIN |
3 rows in set (0.00 sec)

## Question 7
Display employee number and total salary for each employee. (Assuming total salary = sal + comm)

### Query
```sql
SELECT EMPNO, SAL + IFNULL(COMM, 0) AS TOTAL_SALARY FROM EMPLOYEE;
```

### Output
| EMPNO | TOTAL_SALARY |
|-------|--------------|
| 7369  | 800          |
| 7499  | 1900         |
| 7521  | 1550         |
| 7566  | 2975         |
| 7654  | 2650         |
| 7698  | 2850         |
| 7782  | 2450         |
| 7788  | 3000         |
| 7839  | 5000         |
| 7844  | 1500         |
| 7876  | 1100         |
| 7900  | 950          |
| 7902  | 3000         |
| 7934  | 1300         |
14 rows in set (0.00 sec)

## Question 8
Display employee number and annual salary for each employee.

### Query
```sql
SELECT EMPNO, SAL * 12 AS ANNUAL_SALARY FROM EMPLOYEE;
```

### Output
| EMPNO | ANNUAL_SALARY |
|-------|---------------|
| 7369  | 9600          |
| 7499  | 19200         |
| 7521  | 15000         |
| 7566  | 35700         |
| 7654  | 15000         |
| 7698  | 34200         |
| 7782  | 29400         |
| 7788  | 36000         |
| 7839  | 60000         |
| 7844  | 18000         |
| 7876  | 13200         |
| 7900  | 11400         |
| 7902  | 36000         |
| 7934  | 15600         |

## Question 9
Display the names of all employees working as clerks and drawing a salary more than 3,000.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE JOB = 'CLERK' AND SAL > 3000;
```

### Output
No rows selected.

## Question 10
Display the names of employees who are working as clerk, salesman or analyst and drawing a salary more than 3,000.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE JOB IN ('CLERK', 'SALESMAN', 'ANALYST') AND SAL > 3000;
```

### Output
No rows selected.
