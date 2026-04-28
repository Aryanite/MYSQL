# SQL Lab – Experiment 6

## Aim
To perform operations using scalar functions, date functions, and format conversions in SQL.

## Question 1
Display empno, ename, deptno from employee table. Instead of display department numbers display the related department name (Use decode function).

### Query
```sql
SELECT EMPNO, ENAME, DEPTNO,
DECODE(DEPTNO, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS') AS DNAME
FROM EMPLOYEE;
```

### Output
| EMPNO | ENAME | DEPTNO | DNAME |
|-------|-------|--------|-------|
| 7369  | SMITH | 20     | RESEARCH |
| 7499  | ALLEN | 30     | SALES |
| 7521  | WARD  | 30     | SALES |

## Question 2
Display your age in days.

### Query
```sql
SELECT ROUND(SYSDATE - TO_DATE('01-01-2000', 'DD-MM-YYYY')) AS AGE_IN_DAYS FROM DUAL;
```

### Output
| AGE_IN_DAYS |
|-------------|
| 9615        |

## Question 3
Display your age in months.

### Query
```sql
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('01-01-2000', 'DD-MM-YYYY')) AS AGE_IN_MONTHS FROM DUAL;
```

### Output
| AGE_IN_MONTHS |
|---------------|
| 315.93        |

## Question 4
Display the current date as 15th August Friday Nineteen Ninety-Seven.

### Query
```sql
SELECT TO_CHAR(SYSDATE, 'DDth Month Day Year') AS FORMATTED_DATE FROM DUAL;
```

### Output
| FORMATTED_DATE |
|----------------|
| 29th April Wednesday Two Thousand Twenty-Six |

## Question 5
Scott has joined the company on Wednesday 13th August Nineteen Ninety.

### Query
```sql
SELECT ENAME || ' has joined the company on ' || TO_CHAR(HIREDATE, 'Day DDth Month Year') AS JOINING_INFO
FROM EMPLOYEE WHERE ENAME = 'SCOTT';
```

### Output
| JOINING_INFO |
|--------------|
| SCOTT has joined the company on Thursday 09th December Nineteen Eighty-Two |

## Question 7
Find the date for nearest Saturday after current date.

### Query
```sql
SELECT NEXT_DAY(SYSDATE, 'SATURDAY') AS NEXT_SATURDAY FROM DUAL;
```

### Output
| NEXT_SATURDAY |
|---------------|
| 02-MAY-26     |

## Question 8
Display current time.

### Query
```sql
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS CURRENT_TIME FROM DUAL;
```

### Output
| CURRENT_TIME |
|--------------|
| 14:30:05     |

## Question 9
Display the date three months Before the current date.

### Query
```sql
SELECT ADD_MONTHS(SYSDATE, -3) AS THREE_MONTHS_AGO FROM DUAL;
```

### Output
| THREE_MONTHS_AGO |
|------------------|
| 29-JAN-26        |

## Question 10
Display those employees who joined in the company in the month of Dec.

### Query
```sql
SELECT * FROM EMPLOYEE WHERE TO_CHAR(HIREDATE, 'MON') = 'DEC';
```

### Output
| EMPNO | ENAME | JOB | MGR | HIREDATE | SAL | COMM | DEPTNO |
|-------|-------|-----|-----|----------|-----|------|--------|
| 7369  | SMITH | CLERK | 7902 | 17-DEC-80 | 800 | | 20 |
| 7788  | SCOTT | ANALYST | 7566 | 09-DEC-82 | 3000 | | 40 |
| 7900  | JAMES | CLERK | 7698 | 03-DEC-81 | 950 | | 30 |
| 7902  | FORD  | ANALYST | 7566 | 03-DEC-81 | 3000 | | 20 |
