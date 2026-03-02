# SQL Lab – Experiment 4

## Aim
To perform advanced filtering using dates, string functions, and complex calculations including annual salary and deductions.

## Question 1
Display the list of employees who have joined the company before 30th June 80 or after 31st Dec 81.

### Query
```sql
SELECT ENAME, HIREDATE FROM EMPLOYEE WHERE HIREDATE < '1980-06-30' OR HIREDATE > '1981-12-31';
```

### Output
| ENAME | HIREDATE   |
|-------|------------|
| SCOTT | 1982-12-09 |
| ADAMS | 1983-01-12 |
| MILLER| 1982-01-23 |
3 rows in set (0.01 sec)

## Question 2
Display the names of employees whose names have second alphabet A in their names.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE ENAME LIKE '_A%';
```

### Output
| ENAME  |
|--------|
| ALLEN  |
| WARD   |
| MARTIN |
| JAMES  |
| ADAMS  |
5 rows in set (0.00 sec)

## Question 3
Display the names of employees whose name is exactly five characters in length.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE LENGTH(ENAME) = 5;
```

### Output
| ENAME |
|-------|
| SMITH |
| ALLEN |
| JONES |
| BLAKE |
| CLARK |
| SCOTT |
| ADAMS |
| JAMES |
8 rows in set (0.00 sec)

## Question 4
Display the names of employees who are not working as salesman or clerk or analyst.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE JOB NOT IN ('SALESMAN', 'CLERK', 'ANALYST');
```

### Output
| ENAME |
|-------|
| JONES |
| BLAKE |
| CLARK |
| KING  |
4 rows in set (0.00 sec)

## Question 5
Display the name of the employee along with their annual salary (sal*12). The name of the employee earning highest salary should appear first.

### Query
```sql
SELECT ENAME, SAL * 12 AS ANNUAL_SALARY FROM EMPLOYEE ORDER BY SAL DESC;
```

### Output
| ENAME | ANNUAL_SALARY |
|-------|---------------|
| KING  | 60000         |
| SCOTT | 36000         |
| FORD  | 36000         |
| JONES | 35700         |
| BLAKE | 34200         |
| CLARK | 29400         |
| ALLEN | 19200         |
| TURNER| 18000         |
| MILLER| 15600         |
| WARD  | 15000         |
| MARTIN| 15000         |
| ADAMS | 13200         |
| JAMES | 11400         |
| SMITH | 9600          |
14 rows in set (0.00 sec)

## Question 6
Display name, sal, hra, pf, da, totalsal for each employee. HRA 15%, DA 10%, PF 5%. Total salary = sal + hra + da - pf.

### Query
```sql
SELECT ENAME, SAL, 
       SAL * 0.15 AS HRA, 
       SAL * 0.10 AS DA, 
       SAL * 0.05 AS PF, 
       (SAL + (SAL * 0.15) + (SAL * 0.10) - (SAL * 0.05)) AS TOTALSAL 
FROM EMPLOYEE;
```

### Output
| ENAME  | SAL  | HRA    | DA    | PF     | TOTALSAL |
|--------|------|--------|-------|--------|----------|
| SMITH  | 800  | 120    | 80    | 40     | 960      |
| ALLEN  | 1600 | 240    | 160   | 80     | 1920     |
| WARD   | 1250 | 187.5  | 125   | 62.5   | 1500     |
| JONES  | 2975 | 446.25 | 297.5 | 148.75 | 3570     |
| MARTIN | 1250 | 187.5  | 125   | 62.5   | 1500     |
| BLAKE  | 2850 | 427.5  | 285   | 142.5  | 3420     |
| CLARK  | 2450 | 367.5  | 245   | 122.5  | 2940     |
| SCOTT  | 3000 | 450    | 300   | 150    | 3600     |
| KING   | 5000 | 750    | 500   | 250    | 6000     |
| TURNER | 1500 | 225    | 150   | 75     | 1800     |
| ADAMS  | 1100 | 165    | 110   | 55     | 1320     |
| JAMES  | 950  | 142.5  | 95    | 47.5   | 1140     |
| FORD   | 3000 | 450    | 300   | 150    | 3600     |
| MILLER | 1300 | 195    | 130   | 65     | 1560     |
14 rows in set (0.01 sec)

## Question 7
Update the salary of each employee by 10% increment who are not eligible for commission.

### Query
```sql
UPDATE EMPLOYEE SET SAL = SAL * 1.10 WHERE COMM IS NULL OR COMM = 0;
```

### Output
Query OK, 11 rows affected (0.01 sec)
Rows matched: 11  Changed: 11  Warnings: 0

## Question 8
Display those employees whose salary is more than 3000 after giving 20% increment.

### Query
```sql
SELECT ENAME, SAL * 1.20 AS NEW_SALARY FROM EMPLOYEE WHERE SAL * 1.20 > 3000;
```

### Output
| ENAME | NEW_SALARY |
|-------|------------|
| JONES | 3570       |
| BLAKE | 3420       |
| SCOTT | 3600       |
| KING  | 6000       |
| FORD  | 3600       |
5 rows in set (0.00 sec)

## Question 9
Display those employees whose salary contains atleast 3 digits.

### Query
```sql
SELECT ENAME, SAL FROM EMPLOYEE WHERE LENGTH(SAL) >= 3;
```

### Output
| ENAME | SAL  |
|-------|------|
| SMITH | 800  |
| ALLEN | 1600 |
| WARD  | 1250 |
| JONES | 2975 |
| MARTIN| 1250 |
| BLAKE | 2850 |
| CLARK | 2450 |
| SCOTT | 3000 |
| KING  | 5000 |
| TURNER| 1500 |
| ADAMS | 1100 |
| JAMES | 950  |
| FORD  | 3000 |
| MILLER| 1300 |
14 rows in set (0.00 sec)

## Question 10
Display names of employees whose names have second alphabet A.

### Query
```sql
SELECT ENAME FROM EMPLOYEE WHERE ENAME LIKE '_A%';
```

### Output
| ENAME  |
|--------|
| ALLEN  |
| WARD   |
| MARTIN |
| JAMES  |
| ADAMS  |
5 rows in set (0.00 sec)
