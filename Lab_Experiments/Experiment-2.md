# SQL Lab – Experiment 2

## Aim
To retrieve and filter data from the EMPLOYEE table using various SELECT statements and WHERE clauses.

## Question 1
List all distinct job in Employee.

### Query
```sql
SELECT DISTINCT JOB FROM EMPLOYEE;
```

### Output
| JOB       |
|-----------|
| CLERK     |
| SALESMAN  |
| MANAGER   |
| ANALYST   |
| PRESIDENT |
5 rows in set (0.01 sec)

## Question 2
List all information about employee in Department Number 30.

### Query
```sql
SELECT * FROM EMPLOYEE WHERE DEPTNO = 30;
```

### Output
| EMPNO | ENAME  | JOB      | MGR  | HIREDATE   | SAL  | COMM | DEPTNO |
|-------|--------|----------|------|------------|------|------|--------|
| 7499  | ALLEN  | SALESMAN | 7698 | 1981-02-20 | 1600 | 300  | 30     |
| 7521  | WARD   | SALESMAN | 7698 | 1981-02-22 | 1250 | 300  | 30     |
| 7654  | MARTIN | SALESMAN | 7698 | 1981-09-28 | 1250 | 1400 | 30     |
| 7698  | BLAKE  | MANAGER  | 7839 | 1981-05-01 | 2850 | NULL | 30     |
| 7844  | TURNER | SALESMAN | 7698 | 1981-09-08 | 1500 | 0    | 30     |
| 7900  | JAMES  | CLERK    | 7698 | 1981-12-03 | 950  | NULL | 30     |
6 rows in set (0.00 sec)

## Question 3
Find all department number with department records where Deptno is greater than 20.

### Query
```sql
SELECT DEPTNO FROM DEPARTMENT WHERE DEPTNO > 20;
```

### Output
| DEPTNO |
|--------|
| 30     |
| 40     |
2 rows in set (0.00 sec)

## Question 4
Find all information about all the managers as well as the clerks in department 30.

### Query
```sql
SELECT * FROM EMPLOYEE WHERE DEPTNO = 30 AND (JOB = 'MANAGER' OR JOB = 'CLERK');
```

### Output
| EMPNO | ENAME | JOB     | MGR  | HIREDATE   | SAL  | COMM | DEPTNO |
|-------|-------|---------|------|------------|------|------|--------|
| 7698  | BLAKE | MANAGER | 7839 | 1981-05-01 | 2850 | NULL | 30     |
| 7900  | JAMES | CLERK   | 7698 | 1981-12-03 | 950  | NULL | 30     |
2 rows in set (0.00 sec)

## Question 5
List the Employee name, Employee numbers and department of all clerks.

### Query
```sql
SELECT ENAME, EMPNO, DEPTNO FROM EMPLOYEE WHERE JOB = 'CLERK';
```

### Output
| ENAME  | EMPNO | DEPTNO |
|--------|-------|--------|
| SMITH  | 7369  | 20     |
| ADAMS  | 7876  | 20     |
| JAMES  | 7900  | 30     |
| MILLER | 7934  | 10     |
4 rows in set (0.00 sec)

## Question 6
Find all managers not in department 30.

### Query
```sql
SELECT * FROM EMPLOYEE WHERE JOB = 'MANAGER' AND DEPTNO != 30;
```

### Output
| EMPNO | ENAME | JOB     | MGR  | HIREDATE   | SAL  | COMM | DEPTNO |
|-------|-------|---------|------|------------|------|------|--------|
| 7566  | JONES | MANAGER | 7839 | 1981-04-02 | 2975 | NULL | 20     |
| 7782  | CLARK | MANAGER | 7839 | 1981-06-09 | 2450 | NULL | 10     |
2 rows in set (0.00 sec)

## Question 7
List information about all Employees in department 10 who are not manager or clerks.

### Query
```sql
SELECT * FROM EMPLOYEE WHERE DEPTNO = 10 AND JOB NOT IN ('MANAGER', 'CLERK');
```

### Output
| EMPNO | ENAME | JOB       | MGR  | HIREDATE   | SAL  | COMM | DEPTNO |
|-------|-------|-----------|------|------------|------|------|--------|
| 7839  | KING  | PRESIDENT | NULL | 1981-11-17 | 5000 | NULL | 10     |
1 row in set (0.00 sec)

## Question 8
Find Employees and jobs earning between 1200 and 1400.

### Query
```sql
SELECT ENAME, JOB FROM EMPLOYEE WHERE SAL BETWEEN 1200 AND 1400;
```

### Output
| ENAME  | JOB      |
|--------|----------|
| WARD   | SALESMAN |
| MARTIN | SALESMAN |
| MILLER | CLERK    |
3 rows in set (0.00 sec)

## Question 9
List Name and Department Number of employee who are clerks, analyst or salesman.

### Query
```sql
SELECT ENAME, DEPTNO FROM EMPLOYEE WHERE JOB IN ('CLERK', 'ANALYST', 'SALESMAN');
```

### Output
| ENAME  | DEPTNO |
|--------|--------|
| SMITH  | 20     |
| ALLEN  | 30     |
| WARD   | 30     |
| MARTIN | 30     |
| SCOTT  | 40     |
| TURNER | 30     |
| ADAMS  | 20     |
| JAMES  | 30     |
| FORD   | 20     |
| MILLER | 10     |
10 rows in set (0.00 sec)

## Question 10
List Name and Department Number of employee whose names began with M.

### Query
```sql
SELECT ENAME, DEPTNO FROM EMPLOYEE WHERE ENAME LIKE 'M%';
```

### Output
| ENAME  | DEPTNO |
|--------|--------|
| MARTIN | 30     |
| MILLER | 10     |
2 rows in set (0.00 sec)
