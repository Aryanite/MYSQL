# SQL Lab – Experiment 9

## Aim
To perform data retrieval using advanced subqueries, filtering, and aggregation.

## Question 1
Display the name of emp name who earns highest salary.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE SAL = (SELECT MAX(SAL) FROM EMPLOYEE);
```

### Output
| ENAME |
|-------|
| KING  |

## Question 2
Display the employee number and name of employee working as clerk and earning highest salary among clerks.

### Query
```sql
SELECT EMPNO, ENAME FROM EMPLOYEE 
WHERE JOB = 'CLERK' AND SAL = (SELECT MAX(SAL) FROM EMPLOYEE WHERE JOB = 'CLERK');
```

### Output
| EMPNO | ENAME  |
|-------|--------|
| 7934  | MILLER |

## Question 3
Display the names of the salesman who earns a salary more than the highest salary of any clerk.

### Query
```sql
SELECT ENAME FROM EMPLOYEE 
WHERE JOB = 'SALESMAN' AND SAL > (SELECT MAX(SAL) FROM EMPLOYEE WHERE JOB = 'CLERK');
```

### Output
| ENAME |
|-------|
| ALLEN |

## Question 6
Display the names of the employees who earn highest salary in their respective departments.

### Query
```sql
SELECT ENAME, DEPTNO, SAL FROM EMPLOYEE E
WHERE SAL = (SELECT MAX(SAL) FROM EMPLOYEE WHERE DEPTNO = E.DEPTNO);
```

### Output
| ENAME | DEPTNO | SAL  |
|-------|--------|------|
| KING  | 10     | 5000 |
| SCOTT | 20     | 3000 |
| FORD  | 20     | 3000 |
| BLAKE | 30     | 2850 |

## Question 8
Display the employee names who are working in accounting dept.

### Query
```sql
SELECT ENAME FROM EMPLOYEE 
WHERE DEPTNO = (SELECT DEPTNO FROM DEPARTMENT WHERE DNAME = 'ACCOUNTING');
```

### Output
| ENAME |
|-------|
| CLARK |
| KING  |
| MILLER|

## Question 10
Display the job groups having total salary greater than the maximum salary for managers.

### Query
```sql
SELECT JOB, SUM(SAL) FROM EMPLOYEE
GROUP BY JOB
HAVING SUM(SAL) > (SELECT MAX(SAL) FROM EMPLOYEE WHERE JOB = 'MANAGER');
```

### Output
| JOB      | SUM(SAL) |
|----------|----------|
| CLERK    | 4150     |
| SALESMAN | 5600     |
| ANALYST  | 6000     |
| PRESIDENT| 5000     |
