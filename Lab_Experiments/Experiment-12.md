# SQL Lab – Experiment 12

## Aim
To perform advanced analysis using hierarchical queries, departmental comparisons, and data cleanup.

## Question 1
Display those employees whose salary is less than his manager but more than salary of any other managers.

### Query
```sql
SELECT E.ENAME FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MGR = M.EMPNO
WHERE E.SAL < M.SAL 
AND E.SAL > ANY (SELECT SAL FROM EMPLOYEE WHERE EMPNO IN (SELECT MGR FROM EMPLOYEE) AND EMPNO != M.EMPNO);
```

### Output
| ENAME |
|-------|
| FORD  |
| SCOTT |

## Question 2
Find out the number of employees whose salary is greater than their manager salary?

### Query
```sql
SELECT COUNT(*) AS TOTAL_EMP
FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MGR = M.EMPNO
WHERE E.SAL > M.SAL;
```

### Output
| TOTAL_EMP |
|-----------|
| 2         |

## Question 3
Display those managers who are not working under president but they are working under any other manager?

### Query
```sql
SELECT ENAME FROM EMPLOYEE 
WHERE EMPNO IN (SELECT MGR FROM EMPLOYEE)
AND MGR != (SELECT EMPNO FROM EMPLOYEE WHERE JOB = 'PRESIDENT')
AND MGR IS NOT NULL;
```

### Output
| ENAME |
|-------|
| SCOTT |
| FORD  |

## Question 4
Delete those department where no employee working?

### Query
```sql
DELETE FROM DEPARTMENT 
WHERE DEPTNO NOT IN (SELECT DISTINCT DEPTNO FROM EMPLOYEE WHERE DEPTNO IS NOT NULL);
```

### Output
1 row deleted.

## Question 5
Delete those records from emp table whose deptno not available in dept table?

### Query
```sql
DELETE FROM EMPLOYEE WHERE DEPTNO NOT IN (SELECT DEPTNO FROM DEPARTMENT);
```

### Output
0 rows deleted.

## Question 6
Display those earners whose salary is out of the grade available in sal grade table?

### Query
```sql
SELECT ENAME, SAL FROM EMPLOYEE 
WHERE SAL NOT BETWEEN (SELECT MIN(LOSAL) FROM SALGRADE) AND (SELECT MAX(HISAL) FROM SALGRADE);
```

### Output
| ENAME | SAL |
|-------|-----|

## Question 7
Display employee name, sal, comm. And whose net pay is greater than any other in the company?

### Query
```sql
SELECT ENAME, SAL, COMM FROM EMPLOYEE 
WHERE (SAL + NVL(COMM, 0)) = (SELECT MAX(SAL + NVL(COMM, 0)) FROM EMPLOYEE);
```

### Output
| ENAME | SAL  | COMM |
|-------|------|------|
| KING  | 5000 |      |

## Question 8
Display those employees who are working in sales or research?

### Query
```sql
SELECT E.ENAME FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME IN ('SALES', 'RESEARCH');
```

### Output
| ENAME |
|-------|
| SMITH |
| ALLEN |
| WARD  |

## Question 9
Display the grade of jones?

### Query
```sql
SELECT S.GRADE FROM SALGRADE S
JOIN EMPLOYEE E ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.ENAME = 'JONES';
```

### Output
| GRADE |
|-------|
| 4     |

## Question 10
Display the department name the no of characters of which is equal to no of employees in any other department?

### Query
```sql
SELECT D1.DNAME FROM DEPARTMENT D1
WHERE LENGTH(D1.DNAME) IN (SELECT COUNT(*) FROM EMPLOYEE GROUP BY DEPTNO);
```

### Output
| DNAME      |
|------------|
| SALES      |
| RESEARCH   |
| ACCOUNTING |
