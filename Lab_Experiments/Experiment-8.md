# SQL Lab – Experiment 8

## Aim
To perform complex queries involving Joins, subqueries, and multi-table data retrieval.

## Question 1
Display all employees with their dept name.

### Query
```sql
SELECT E.ENAME, D.DNAME 
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO;
```

### Output
| ENAME | DNAME      |
|-------|------------|
| SMITH | RESEARCH   |
| ALLEN | SALES      |
| WARD  | SALES      |

## Question 2
Display those employees whose manager names is jones, and also display their manager name.

### Query
```sql
SELECT E.ENAME AS EMPLOYEE, M.ENAME AS MANAGER
FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MGR = M.EMPNO
WHERE M.ENAME = 'JONES';
```

### Output
| EMPLOYEE | MANAGER |
|----------|---------|
| SCOTT    | JONES   |
| FORD     | JONES   |

## Question 5
Display employee name, his job and his manager. Display also employees who are without manager.

### Query
```sql
SELECT E.ENAME, E.JOB, M.ENAME AS MANAGER
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON E.MGR = M.EMPNO;
```

### Output
| ENAME | JOB       | MANAGER |
|-------|-----------|---------|
| SMITH | CLERK     | FORD    |
| KING  | PRESIDENT |         |

## Question 8
List out all employees by name and number along with their manager’s name and number also display ‘no manager’ who has no manager.

### Query
```sql
SELECT E.ENAME, E.EMPNO, NVL(M.ENAME, 'no manager') AS MGR_NAME, NVL(TO_CHAR(M.EMPNO), ' ') AS MGR_NO
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON E.MGR = M.EMPNO;
```

### Output
| ENAME | EMPNO | MGR_NAME   | MGR_NO |
|-------|-------|------------|--------|
| SMITH | 7369  | FORD       | 7902   |
| KING  | 7839  | no manager |        |

## Question 10
Display employee number, name and location of the department in which he is working.

### Query
```sql
SELECT E.EMPNO, E.ENAME, D.LOC
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO;
```

### Output
| EMPNO | ENAME | LOC      |
|-------|-------|----------|
| 7369  | SMITH | DALLAS   |
| 7499  | ALLEN | CHICAGO  |

## Question 11
Display employee name and department name for each employee.

### Query
```sql
SELECT E.ENAME, D.DNAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO;
```

### Output
| ENAME | DNAME      |
|-------|------------|
| SMITH | RESEARCH   |
| ALLEN | SALES      |
