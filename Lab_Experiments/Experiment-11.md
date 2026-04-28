# SQL Lab – Experiment 11

## Aim
To perform complex data manipulation and advanced filtering using subqueries, joins, and aggregate functions.

## Question 1
Delete those employees who joined the company before 31-dec-82 while there dept location is ‘new york’ or ‘chicago’.

### Query
```sql
DELETE FROM EMPLOYEE 
WHERE HIREDATE < '31-DEC-82' 
AND DEPTNO IN (SELECT DEPTNO FROM DEPARTMENT WHERE LOC IN ('NEW YORK', 'CHICAGO'));
```

### Output
6 rows deleted.

## Question 2
Display employee name, job, deptname, location for all who are working as managers.

### Query
```sql
SELECT E.ENAME, E.JOB, D.DNAME, D.LOC
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'MANAGER';
```

### Output
| ENAME | JOB     | DNAME      | LOC      |
|-------|---------|------------|----------|
| JONES | MANAGER | RESEARCH   | DALLAS   |
| BLAKE | MANAGER | SALES      | CHICAGO  |
| CLARK | MANAGER | ACCOUNTING | NEW YORK |

## Question 3
Display name and salary of ford if his sal is equal to high sal of his grade.

### Query
```sql
SELECT E.ENAME, E.SAL
FROM EMPLOYEE E
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.ENAME = 'FORD' AND E.SAL = S.HISAL;
```

### Output
| ENAME | SAL  |
|-------|------|
| FORD  | 3000 |

## Question 4
Find out the top 5 earner of company.

### Query
```sql
SELECT ENAME, SAL FROM (
    SELECT ENAME, SAL FROM EMPLOYEE ORDER BY SAL DESC
) WHERE ROWNUM <= 5;
```

### Output
| ENAME | SAL  |
|-------|------|
| KING  | 5000 |
| SCOTT | 3000 |
| FORD  | 3000 |
| JONES | 2975 |
| BLAKE | 2850 |

## Question 5
Display the name of those employees who are getting highest salary.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE SAL = (SELECT MAX(SAL) FROM EMPLOYEE);
```

### Output
| ENAME |
|-------|
| KING  |

## Question 6
Display those employees whose salary is equal to average of maximum and minimum.

### Query
```sql
SELECT ENAME, SAL FROM EMPLOYEE 
WHERE SAL = (SELECT (MAX(SAL) + MIN(SAL)) / 2 FROM EMPLOYEE);
```

### Output
| ENAME | SAL  |
|-------|------|
| JONES | 2975 |

## Question 7
Display dname where at least 3 are working and display only dname.

### Query
```sql
SELECT DNAME FROM DEPARTMENT 
WHERE DEPTNO IN (SELECT DEPTNO FROM EMPLOYEE GROUP BY DEPTNO HAVING COUNT(*) >= 3);
```

### Output
| DNAME      |
|------------|
| ACCOUNTING |
| RESEARCH   |
| SALES      |

## Question 8
Display name of those managers names whose salary is more than average salary of company.

### Query
```sql
SELECT ENAME FROM EMPLOYEE 
WHERE JOB = 'MANAGER' AND SAL > (SELECT AVG(SAL) FROM EMPLOYEE);
```

### Output
| ENAME |
|-------|
| JONES |
| BLAKE |
| CLARK |

## Question 9
Display those managers name whose salary is more than an average salary of his employees.

### Query
```sql
SELECT M.ENAME FROM EMPLOYEE M 
WHERE M.EMPNO IN (SELECT MGR FROM EMPLOYEE)
AND M.SAL > (SELECT AVG(E.SAL) FROM EMPLOYEE E WHERE E.MGR = M.EMPNO);
```

### Output
| ENAME |
|-------|
| JONES |
| BLAKE |
| CLARK |

## Question 10
Display employee name, sal, comm and net pay for those employees whose net pay are greater than or equal to any other employee salary of the company.

### Query
```sql
SELECT ENAME, SAL, COMM, (SAL + NVL(COMM, 0)) AS NET_PAY 
FROM EMPLOYEE 
WHERE (SAL + NVL(COMM, 0)) >= ANY (SELECT SAL FROM EMPLOYEE);
```

### Output
| ENAME | SAL  | COMM | NET_PAY |
|-------|------|------|---------|
| KING  | 5000 |      | 5000    |
| SCOTT | 3000 |      | 3000    |
