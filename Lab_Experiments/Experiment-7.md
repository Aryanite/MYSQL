# SQL Lab – Experiment 7

## Aim
To perform calculations involving dates, salaries, and aggregate functions with grouping.

## Question 1
Compute the no. of days remaining in this year.

### Query
```sql
SELECT TO_DATE('31-DEC-2026', 'DD-MON-YYYY') - SYSDATE AS DAYS_REMAINING FROM DUAL;
```

### Output
| DAYS_REMAINING |
|----------------|
| 246            |

## Question 2
Find the highest and lowest salaries and the difference between of them.

### Query
```sql
SELECT MAX(SAL) AS HIGHEST, MIN(SAL) AS LOWEST, MAX(SAL) - MIN(SAL) AS DIFFERENCE FROM EMPLOYEE;
```

### Output
| HIGHEST | LOWEST | DIFFERENCE |
|---------|--------|------------|
| 5000    | 800    | 4200       |

## Question 3
List employee whose commission is greater than 25 % of their salaries.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE COMM > (SAL * 0.25);
```

### Output
| ENAME  |
|--------|
| MARTIN |

## Question 4
Make a query that displays salary in dollar format.

### Query
```sql
SELECT ENAME, TO_CHAR(SAL, '$9,999.00') AS SALARY_DOLLAR FROM EMPLOYEE;
```

### Output
| ENAME | SALARY_DOLLAR |
|-------|---------------|
| SMITH | $800.00       |
| ALLEN | $1,600.00     |

## Question 6
Query that will display the total no of employees, and of that total the number who were hired in 1980, 1981, 1982 and 1983.

### Query
```sql
SELECT COUNT(*) AS TOTAL,
COUNT(DECODE(TO_CHAR(HIREDATE, 'YYYY'), '1980', 1)) AS "1980",
COUNT(DECODE(TO_CHAR(HIREDATE, 'YYYY'), '1981', 1)) AS "1981",
COUNT(DECODE(TO_CHAR(HIREDATE, 'YYYY'), '1982', 1)) AS "1982",
COUNT(DECODE(TO_CHAR(HIREDATE, 'YYYY'), '1983', 1)) AS "1983"
FROM EMPLOYEE;
```

### Output
| TOTAL | 1980 | 1981 | 1982 | 1983 |
|-------|------|------|------|------|
| 14    | 1    | 10   | 2    | 1    |

## Question 8
Display department numbers and total number of employees working in each department.

### Query
```sql
SELECT DEPTNO, COUNT(*) AS TOTAL_EMP FROM EMPLOYEE GROUP BY DEPTNO;
```

### Output
| DEPTNO | TOTAL_EMP |
|--------|-----------|
| 10     | 3         |
| 20     | 5         |
| 30     | 6         |

## Question 9
Display the various jobs and total number of employees within each job group.

### Query
```sql
SELECT JOB, COUNT(*) FROM EMPLOYEE GROUP BY JOB;
```

### Output
| JOB       | COUNT(*) |
|-----------|----------|
| CLERK     | 4        |
| SALESMAN  | 4        |
| MANAGER   | 3        |
| ANALYST   | 2        |
| PRESIDENT | 1        |

## Question 10
Display the depart numbers and total salary for each department.

### Query
```sql
SELECT DEPTNO, SUM(SAL) AS TOTAL_SALARY FROM EMPLOYEE GROUP BY DEPTNO;
```

### Output
| DEPTNO | TOTAL_SALARY |
|--------|--------------|
| 10     | 8750         |
| 20     | 10875        |
| 30     | 9400         |
