# Unit 4: Normalization & Transactions

## Normalization

**Normalization** is the process of organizing data to reduce redundancy and improve data integrity.

### Goals of Normalization:
1. Eliminate redundant data
2. Ensure data dependencies make sense
3. Reduce data anomalies
4. Make database flexible

---

## Functional Dependency (FD)

**Functional Dependency** describes the relationship between attributes.

**Definition:** X → Y means "X functionally determines Y"
- If we know X, we can find Y
- X is called **determinant**
- Y is called **dependent**

**Examples:**
```
Student_ID → Student_Name, DOB, Address
ISBN → Book_Title, Author, Price
Email → User_Name, Password
```

### Types of Functional Dependencies:

1. **Trivial FD**
   - Y is subset of X
   - Example: {ID, Name} → {ID}

2. **Non-Trivial FD**
   - Y is not subset of X
   - Example: {ID} → {Name, Age}

3. **Fully Functional Dependency**
   - Y depends on entire X (not a subset)
   - Example: {Student_ID, Course_ID} → Grade

4. **Partial Dependency**
   - Y depends on part of X
   - Example: {Student_ID, Course_ID} → Student_Name
   - (Student_Name depends only on Student_ID)

5. **Transitive Dependency**
   - X → Y and Y → Z, then X → Z
   - Example: Student_ID → Dept_ID → Dept_Name

---

## Anomalies in Databases

Problems that occur in poorly designed databases:

### 1. Insertion Anomaly
Cannot insert data without having other data.

**Example:**
```
STUDENT_COURSE (Student_ID, Name, Course_ID, Course_Name)
Cannot add new course without enrolling a student
```

### 2. Update Anomaly
Updating data requires multiple changes.

**Example:**
```
If student changes name, must update in all course records
Risk of inconsistent data
```

### 3. Deletion Anomaly
Deleting data causes loss of other data.

**Example:**
```
If student drops last course, we lose student information
```

**Solution:** Normalization!

---

## Normal Forms

### 1st Normal Form (1NF)

**Rules:**
1. Each column contains **atomic** (indivisible) values
2. Each column contains values of **same data type**
3. Each column has a **unique name**
4. **Order** doesn't matter

**Example - Not in 1NF:**
```
STUDENT
+----+-------+------------------+
| ID | Name  | Phone            |
+----+-------+------------------+
| 1  | John  | 123, 456         | ← Multiple values
+----+-------+------------------+
```

**Example - In 1NF:**
```
STUDENT
+----+-------+-------+
| ID | Name  | Phone |
+----+-------+-------+
| 1  | John  | 123   |
| 1  | John  | 456   |
+----+-------+-------+
```

Or create separate table:
```
STUDENT (ID, Name)
STUDENT_PHONE (ID, Phone)
```

---

### 2nd Normal Form (2NF)

**Rules:**
1. Must be in **1NF**
2. **No partial dependency** (all non-prime attributes fully depend on primary key)

**Note:** Only applies to tables with **composite primary key**

**Example - Not in 2NF:**
```
ENROLLMENT (Student_ID, Course_ID, Student_Name, Grade)
Primary Key: (Student_ID, Course_ID)
Problem: Student_Name depends only on Student_ID (partial dependency)
```

**Example - In 2NF:**
```
STUDENT (Student_ID, Student_Name)
ENROLLMENT (Student_ID, Course_ID, Grade)
```

---

### 3rd Normal Form (3NF)

**Rules:**
1. Must be in **2NF**
2. **No transitive dependency** (non-prime attributes don't depend on other non-prime attributes)

**Example - Not in 3NF:**
```
EMPLOYEE (Emp_ID, Name, Dept_ID, Dept_Name)
Primary Key: Emp_ID
Problem: Dept_Name depends on Dept_ID (transitive: Emp_ID → Dept_ID → Dept_Name)
```

**Example - In 3NF:**
```
EMPLOYEE (Emp_ID, Name, Dept_ID)
DEPARTMENT (Dept_ID, Dept_Name)
```

---

### Boyce-Codd Normal Form (BCNF)

**Rules:**
1. Must be in **3NF**
2. For every functional dependency X → Y, X must be a **super key**

**Example - In 3NF but not in BCNF:**
```
COURSE_INSTRUCTOR (Student_ID, Course, Instructor)
FDs: {Student_ID, Course} → Instructor
     Instructor → Course
Problem: Instructor → Course, but Instructor is not a super key
```

**Example - In BCNF:**
```
STUDENT_INSTRUCTOR (Student_ID, Instructor)
COURSE_INSTRUCTOR (Instructor, Course)
```

**Key Difference: 3NF vs BCNF**
- **3NF**: Non-prime attributes don't depend on other non-prime attributes
- **BCNF**: All determinants must be candidate keys (stricter)

---

## Normalization Summary

| Normal Form | Rule |
|-------------|------|
| **1NF** | Atomic values, no repeating groups |
| **2NF** | 1NF + No partial dependency |
| **3NF** | 2NF + No transitive dependency |
| **BCNF** | 3NF + Every determinant is a candidate key |

**Steps:**
```
Unnormalized → 1NF → 2NF → 3NF → BCNF
```

---

## Transactions

A **transaction** is a logical unit of work that contains one or more SQL statements.

**Example:**
```sql
-- Bank transfer transaction
BEGIN TRANSACTION;
    UPDATE account SET balance = balance - 1000 WHERE acc_id = 101;
    UPDATE account SET balance = balance + 1000 WHERE acc_id = 102;
COMMIT;
```

---

## ACID Properties

ACID ensures reliable transaction processing.

### 1. Atomicity
**All or Nothing**
- Either all operations complete successfully, or none do
- If any operation fails, entire transaction is rolled back

**Example:**
```
Transfer $1000: Debit from A, Credit to B
Both must happen, or neither
```

### 2. Consistency
**Valid State**
- Transaction brings database from one valid state to another
- All integrity constraints are maintained

**Example:**
```
Total money before = Total money after
No money is created or destroyed
```

### 3. Isolation
**Concurrent Execution**
- Transactions execute independently
- Intermediate state of one transaction is invisible to others
- Prevents interference

**Example:**
```
Two transactions on same account happen as if sequential
```

### 4. Durability
**Permanent Changes**
- Once committed, changes are permanent
- Survive system failures
- Stored in non-volatile memory

**Example:**
```
After commit, data persists even if system crashes
```

---

## Transaction States

```
Active → Partially Committed → Committed
  ↓
Failed → Aborted
```

1. **Active**: Transaction is executing
2. **Partially Committed**: After final statement executes
3. **Committed**: Transaction successfully completed
4. **Failed**: Normal execution cannot proceed
5. **Aborted**: Transaction rolled back, database restored

---

## Serializability

**Serializability** ensures concurrent transactions produce the same result as serial execution.

### Types:

1. **Conflict Serializability**
   - Based on conflicting operations
   - Two operations conflict if:
     - Belong to different transactions
     - Access same data item
     - At least one is write operation

2. **View Serializability**
   - Based on final database state
   - Schedule S is view serializable if equivalent to some serial schedule

**Conflict Operations:**
- Read-Write (R-W)
- Write-Read (W-R)
- Write-Write (W-W)

**Non-conflict:**
- Read-Read (R-R)

---

## Concurrency Control

### Problems Without Concurrency Control:

1. **Lost Update Problem**
   - Two transactions update same data
   - One update is lost

2. **Dirty Read Problem**
   - Transaction reads uncommitted data from another transaction
   - If that transaction rollback, read is invalid

3. **Unrepeatable Read Problem**
   - Transaction reads same data twice, gets different values
   - Another transaction modified data in between

4. **Phantom Read Problem**
   - Transaction re-executes query, gets different rows
   - Another transaction inserted/deleted rows

---

## Deadlock

**Deadlock** occurs when two or more transactions wait for each other to release locks.

**Example:**
```
Transaction T1: Locks A, waits for B
Transaction T2: Locks B, waits for A
→ Deadlock!
```

### Deadlock Handling:

1. **Deadlock Prevention**
   - Design system to ensure deadlock never occurs
   - Methods:
     - Wait-Die scheme (older waits, younger dies)
     - Wound-Wait scheme (older wounds younger, younger waits)

2. **Deadlock Detection**
   - Allow deadlock to occur
   - Periodically check for deadlock
   - Use wait-for graph
   - If cycle detected → deadlock exists

3. **Deadlock Recovery**
   - Abort one or more transactions
   - Rollback victim transaction
   - Restart transaction

### Deadlock Prevention Techniques:

1. **Lock all resources at once**
2. **Impose ordering on resources**
3. **Use timeout**
4. **Preemption**

---

## Transaction Control Commands

```sql
-- Start transaction
START TRANSACTION;
-- or
BEGIN;

-- Save changes permanently
COMMIT;

-- Undo changes
ROLLBACK;

-- Create savepoint
SAVEPOINT savepoint_name;

-- Rollback to savepoint
ROLLBACK TO savepoint_name;

-- Release savepoint
RELEASE SAVEPOINT savepoint_name;
```

**Example:**
```sql
START TRANSACTION;
UPDATE account SET balance = balance - 1000 WHERE id = 1;
SAVEPOINT debit_done;
UPDATE account SET balance = balance + 1000 WHERE id = 2;
-- If error occurs
ROLLBACK TO debit_done;
-- Or if success
COMMIT;
```

---

## Important Points for Exams

1. **1NF**: Atomic values
2. **2NF**: No partial dependency
3. **3NF**: No transitive dependency
4. **BCNF**: Every determinant is super key
5. **ACID**: Atomicity, Consistency, Isolation, Durability
6. **Serializability**: Concurrent = Serial execution
7. **Deadlock**: Circular wait for resources
8. **Transaction States**: Active → Partially Committed → Committed

---

## Quick Revision

### Normalization:
- **1NF**: No multi-valued attributes
- **2NF**: 1NF + No partial dependency
- **3NF**: 2NF + No transitive dependency
- **BCNF**: 3NF + Determinants are super keys

### ACID:
- **A**: All or Nothing
- **C**: Valid State
- **I**: Independent Execution
- **D**: Permanent Changes

### Deadlock:
- **Prevention**: Avoid deadlock
- **Detection**: Find deadlock
- **Recovery**: Abort transaction

### Commands:
- BEGIN/START TRANSACTION
- COMMIT
- ROLLBACK
- SAVEPOINT

---

**Exam Tip:** Practice normalization examples step-by-step! Understand functional dependencies. Know ACID properties with examples. Practice identifying deadlock scenarios!
