# SQL Lab – Experiment 5

## Aim
To use aggregate functions (COUNT, SUM, MAX, MIN, AVG) and string manipulation functions (UPPER, LOWER, INITCAP, LENGTH).

## Question 1
Display the total number of employee working in the company.

### Query
```sql
SELECT COUNT(*) FROM EMPLOYEE;
```

### Output
| COUNT(*) |
|----------|
| 14       |
1 row in set (0.01 sec)

## Question 2
Display the total salary being paid to all employees.

### Query
```sql
SELECT SUM(SAL) FROM EMPLOYEE;
```

### Output
| SUM(SAL) |
|----------|
| 29025    |
1 row in set (0.00 sec)

## Question 3
Display the maximum salary from employee table.

### Query
```sql
SELECT MAX(SAL) FROM EMPLOYEE;
```

### Output
| MAX(SAL) |
|----------|
| 5000     |
1 row in set (0.00 sec)

## Question 4
Display the minimum salary from employee table.

### Query
```sql
SELECT MIN(SAL) FROM EMPLOYEE;
```

### Output
| MIN(SAL) |
|----------|
| 800      |
1 row in set (0.00 sec)

## Question 5
Display the average salary from employee table.

### Query
```sql
SELECT AVG(SAL) FROM EMPLOYEE;
```

### Output
| AVG(SAL)    |
|-------------|
| 2073.21429  |
1 row in set (0.00 sec)

## Question 6
Display the maximum salary being paid to clerk.

### Query
```sql
SELECT MAX(SAL) FROM EMPLOYEE WHERE JOB = 'CLERK';
```

### Output
| MAX(SAL) |
|----------|
| 1300     |
1 row in set (0.00 sec)

## Question 7
Display the maximum salary being paid in dept no 20.

### Query
```sql
SELECT MAX(SAL) FROM EMPLOYEE WHERE DEPTNO = 20;
```

### Output
| MAX(SAL) |
|----------|
| 3000     |
1 row in set (0.00 sec)

## Question 8
Display the minimum salary paid to any salesman.

### Query
```sql
SELECT MIN(SAL) FROM EMPLOYEE WHERE JOB = 'SALESMAN';
```

### Output
| MIN(SAL) |
|----------|
| 1250     |
1 row in set (0.00 sec)

## Question 9
Display the average salary drawn by managers.

### Query
```sql
SELECT AVG(SAL) FROM EMPLOYEE WHERE JOB = 'MANAGER';
```

### Output
| AVG(SAL) |
|----------|
| 2758.33  |
1 row in set (0.00 sec)

## Question 10
Display the total salary drawn by analyst working in dept no 40.

### Query
```sql
SELECT SUM(SAL) FROM EMPLOYEE WHERE JOB = 'ANALYST' AND DEPTNO = 40;
```

### Output
| SUM(SAL) |
|----------|
| 3000     |
1 row in set (0.00 sec)

## Question 11
Display the names of the employee in Uppercase.

### Query
```sql
SELECT UPPER(ENAME) FROM EMPLOYEE;
```

### Output
| UPPER(ENAME) |
|--------------|
| SMITH        |
| ALLEN        |
| WARD         |
| JONES        |
| MARTIN       |
| BLAKE        |
| CLARK        |
| SCOTT        |
| KING         |
| TURNER       |
| ADAMS        |
| JAMES        |
| FORD         |
| MILLER       |
14 rows in set (0.01 sec)

## Question 12
Display the names of the employee in Lowercase.

### Query
```sql
SELECT LOWER(ENAME) FROM EMPLOYEE;
```

### Output
| LOWER(ENAME) |
|--------------|
| smith        |
| allen        |
| ward         |
| jones        |
| martin       |
| blake        |
| clark        |
| scott        |
| king         |
| turner       |
| adams        |
| james        |
| ford         |
| miller       |
14 rows in set (0.01 sec)

## Question 13
Display the names of the employee in Proper case.

### Query
```sql
SELECT INITCAP(ENAME) FROM EMPLOYEE;
```

### Output
| INITCAP(ENAME) |
|----------------|
| Smith          |
| Allen          |
| Ward           |
| Jones          |
| Martin         |
| Blake          |
| Clark          |
| Scott          |
| King           |
| Turner         |
| Adams          |
| James          |
| Ford           |
| Miller         |
14 rows in set (0.01 sec)

## Question 14
Display the length of Your name using appropriate function.

### Query
```sql
SELECT LENGTH('YourName');
```

### Output
| LENGTH('YOURNAME') |
|--------------------|
| 8                  |
1 row in set (0.00 sec)

## Question 15
Display the length of all the employee names.

### Query
```sql
SELECT ENAME, LENGTH(ENAME) FROM EMPLOYEE;
```

### Output
| ENAME  | LENGTH(ENAME) |
|--------|---------------|
| SMITH  | 5             |
| ALLEN  | 5             |
| WARD   | 4             |
| JONES  | 5             |
| MARTIN | 6             |
| BLAKE  | 5             |
| CLARK  | 5             |
| SCOTT  | 5             |
| KING   | 4             |
| TURNER | 6             |
| ADAMS  | 5             |
| JAMES  | 5             |
| FORD   | 4             |
| MILLER | 6             |
14 rows in set (0.00 sec)
