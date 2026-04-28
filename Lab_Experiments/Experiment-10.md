# SQL Lab – Experiment 10

## Aim
To perform advanced data retrieval using set operators and filtering across departments.

## Question 1
Display the names of employees from department number 10 with salary greater than that of any employee working in other departments.

### Query
```sql
SELECT ENAME FROM EMPLOYEE 
WHERE DEPTNO = 10 AND SAL > ANY (SELECT SAL FROM EMPLOYEE WHERE DEPTNO != 10);
```

### Output
| ENAME  |
|--------|
| CLARK  |
| KING   |
| MILLER |

## Question 2
Display the names of employee from department number 10 with salary greater than that of all employee working in other departments.

### Query
```sql
SELECT ENAME FROM EMPLOYEE 
WHERE DEPTNO = 10 AND SAL > ALL (SELECT SAL FROM EMPLOYEE WHERE DEPTNO != 10);
```

### Output
| ENAME |
|-------|
| KING  |

## Question 3
Display the details of employees who are in sales dept and grade is 3.

### Query
```sql
SELECT E.* FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE D.DNAME = 'SALES' AND S.GRADE = 3;
```

### Output
| EMPNO | ENAME | JOB      | MGR  | HIREDATE  | SAL  | COMM | DEPTNO |
|-------|-------|----------|------|-----------|------|------|--------|
| 7499  | ALLEN | SALESMAN | 7698 | 20-FEB-81 | 1600 | 300  | 30     |
| 7844  | TURNER| SALESMAN | 7698 | 08-SEP-81 | 1500 | 0    | 30     |

## Question 4
Display those who are not managers and who are managers anyone.

### Query
```sql
SELECT ENAME, 'MANAGER' AS STATUS FROM EMPLOYEE WHERE EMPNO IN (SELECT MGR FROM EMPLOYEE)
UNION
SELECT ENAME, 'NOT MANAGER' AS STATUS FROM EMPLOYEE WHERE EMPNO NOT IN (SELECT MGR FROM EMPLOYEE WHERE MGR IS NOT NULL);
```

### Output
| ENAME | STATUS      |
|-------|-------------|
| JONES | MANAGER     |
| SMITH | NOT MANAGER |
| SCOTT | MANAGER     |

## Question 5
Display those employees whose manager name is jones.

### Query
```sql
SELECT ENAME FROM EMPLOYEE 
WHERE MGR = (SELECT EMPNO FROM EMPLOYEE WHERE ENAME = 'JONES');
```

### Output
| ENAME |
|-------|
| SCOTT |
| FORD  |
