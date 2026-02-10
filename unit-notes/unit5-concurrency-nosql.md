# Unit 5: Concurrency Control & NoSQL

## Concurrency Control

**Concurrency Control** ensures correct results when multiple transactions execute simultaneously.

### Goals:
1. Maximize concurrency (allow many transactions)
2. Maintain data consistency
3. Ensure serializability

---

## Lock-Based Protocols

**Locking** is the most common concurrency control mechanism.

### Types of Locks:

#### 1. Shared Lock (S-Lock / Read Lock)
- Multiple transactions can read simultaneously
- No transaction can write
- **Notation**: lock-S(X)

#### 2. Exclusive Lock (X-Lock / Write Lock)
- Only one transaction can write
- No other transaction can read or write
- **Notation**: lock-X(X)

### Lock Compatibility Matrix:

|         | S-Lock | X-Lock |
|---------|--------|--------|
| **S-Lock** | ✓ Yes  | ✗ No   |
| **X-Lock** | ✗ No   | ✗ No   |

**Rules:**
- S-Lock + S-Lock = Compatible (both can read)
- S-Lock + X-Lock = Not compatible
- X-Lock + X-Lock = Not compatible

**Example:**
```
T1: lock-S(A), read(A), unlock(A)
T2: lock-S(A), read(A), unlock(A)  ✓ Allowed (both reading)

T1: lock-X(A), write(A), unlock(A)
T2: lock-S(A), read(A), unlock(A)  ✗ Not allowed (T2 waits)
```

---

## Two-Phase Locking (2PL)

**2PL** is a protocol that ensures serializability.

### Two Phases:

1. **Growing Phase (Lock Phase)**
   - Transaction can **acquire** locks
   - Cannot **release** locks
   - Phase ends when first lock is released

2. **Shrinking Phase (Unlock Phase)**
   - Transaction can **release** locks
   - Cannot **acquire** locks
   - Continues until all locks released

**Rules:**
- Once a lock is released, no new lock can be acquired
- Ensures conflict serializability

**Example:**
```
Transaction T1:
lock-S(A)      ← Growing phase
lock-X(B)      ← Growing phase
read(A)
write(B)
unlock(A)      ← Shrinking phase begins
unlock(B)      ← Shrinking phase
```

### Types of Two-Phase Locking:

#### 1. Basic 2PL
- Can cause deadlock
- Can cause cascading rollback

#### 2. Strict 2PL
- Hold all **exclusive locks** until COMMIT/ABORT
- Prevents cascading rollback
- Most commonly used

#### 3. Rigorous 2PL
- Hold **all locks** (both S and X) until COMMIT/ABORT
- Simplest to implement
- Transactions can be serialized in commit order

### Drawbacks of 2PL:

1. **Deadlock** - Possible (needs detection/prevention)
2. **Cascading Rollback** - In basic 2PL
3. **Reduced Concurrency** - More waiting

---

## Lock Conversions

Upgrading and downgrading locks:

### Lock Upgrade (S → X)
- Convert shared lock to exclusive lock
- Happens during **growing phase**

```
lock-S(A)     ← Initial shared lock
read(A)
upgrade(A)    ← Convert to exclusive
write(A)
```

### Lock Downgrade (X → S)
- Convert exclusive lock to shared lock
- Happens during **shrinking phase**

```
lock-X(A)     ← Initial exclusive lock
write(A)
downgrade(A)  ← Convert to shared
read(A)
```

---

## Timestamp-Based Protocols

**Timestamp** is a unique identifier assigned to each transaction.

### How it Works:

1. Each transaction gets a **timestamp** when it starts
2. Older transactions have smaller timestamps
3. Schedule decided based on timestamp order

**Notation:**
- **TS(T)**: Timestamp of transaction T
- **R-TS(X)**: Largest timestamp of any transaction that read X
- **W-TS(X)**: Largest timestamp of any transaction that wrote X

### Timestamp Ordering Protocol:

**For Read Operation by T on X:**
- If TS(T) < W-TS(X): **Reject** and rollback T
- Else: **Execute** read, update R-TS(X)

**For Write Operation by T on X:**
- If TS(T) < R-TS(X): **Reject** and rollback T
- If TS(T) < W-TS(X): **Reject** and rollback T
- Else: **Execute** write, update W-TS(X)

**Example:**
```
T1: TS = 1
T2: TS = 2

R-TS(A) = 0, W-TS(A) = 0

T1: read(A)   → Success, R-TS(A) = 1
T2: read(A)   → Success, R-TS(A) = 2
T1: write(A)  → Reject! (TS(T1)=1 < R-TS(A)=2)
```

### Advantages:
- No deadlock
- No waiting

### Disadvantages:
- More rollbacks
- Can cause starvation
- Cascading rollback possible

---

## Thomas Write Rule

Modification of timestamp ordering to reduce rollbacks.

**Rule:**
If TS(T) < W-TS(X), **ignore** the write (don't rollback)

**Reason:** A later transaction has already written, so this write is outdated.

**Benefit:** Reduces unnecessary rollbacks

---

## Multiversion Concurrency Control (MVCC)

Maintain multiple versions of each data item.

**How it Works:**
1. Each write creates a new version
2. Each version has a timestamp
3. Reads access appropriate version
4. No blocking between readers and writers

**Example:**
```
A0 (version 0)

T1 (TS=1): write(A) → Creates A1
T2 (TS=2): read(A)  → Reads A0 (if T1 not committed)
T3 (TS=3): write(A) → Creates A3
```

**Used by:** PostgreSQL, Oracle, MySQL InnoDB

**Advantages:**
- Readers don't block writers
- Writers don't block readers
- High concurrency

---

## Recovery Techniques

**Recovery** ensures database consistency after failures.

### Types of Failures:

1. **Transaction Failure**
   - Logical error (invalid input)
   - System error (deadlock)

2. **System Crash**
   - Power failure
   - Operating system crash
   - Lost volatile memory (RAM)

3. **Disk Failure**
   - Head crash
   - Disk damage
   - Lost non-volatile memory

---

## Log-Based Recovery

**Log** is a sequence of log records recording all database activities.

### Types of Log Records:

1. **Transaction Start**: `<T start>`
2. **Transaction Write**: `<T, X, old_value, new_value>`
3. **Transaction Commit**: `<T commit>`
4. **Transaction Abort**: `<T abort>`

**Example Log:**
```
<T1 start>
<T1, A, 100, 150>    ← T1 changed A from 100 to 150
<T1, B, 200, 250>
<T1 commit>
<T2 start>
<T2, C, 300, 400>
<System crash>
```

### Recovery Techniques:

#### 1. Deferred Database Modification
- Don't modify database until transaction commits
- Log all changes
- If crash before commit: **ignore transaction**
- If crash after commit: **redo operations**

**Algorithm:**
```
REDO all committed transactions
```

#### 2. Immediate Database Modification
- Modify database during transaction execution
- Log before modification
- If crash before commit: **undo operations**
- If crash after commit: **redo operations**

**Algorithm:**
```
UNDO all uncommitted transactions
REDO all committed transactions
```

---

## Checkpoints

**Checkpoint** reduces recovery time by saving database state periodically.

### How Checkpoints Work:

1. Stop accepting new transactions
2. Complete all active transactions
3. Write all buffers to disk
4. Write checkpoint record to log
5. Resume normal operation

**Checkpoint Record:** `<checkpoint L>`
- L = list of active transactions

### Recovery with Checkpoints:

```
Only consider transactions that started after last checkpoint
Transactions before checkpoint are already on disk
```

**Benefits:**
- Faster recovery
- Smaller log to scan
- Reduced work

**Example:**
```
T1: commit
T2: active
<checkpoint (T2)>
T3: start
T4: start
<crash>

Recovery: Only check T2, T3, T4 (ignore T1)
```

---

## ARIES Recovery Algorithm

**ARIES** (Algorithm for Recovery and Isolation Exploiting Semantics) is an advanced recovery method.

### Three Phases:

1. **Analysis Phase**
   - Scan log forward from last checkpoint
   - Identify active transactions
   - Identify dirty pages

2. **Redo Phase**
   - Scan log forward
   - Redo all operations (even for aborted transactions)
   - Restore database to state at crash time

3. **Undo Phase**
   - Scan log backward
   - Undo all uncommitted transactions
   - Write undo records to log

**Features:**
- Write-Ahead Logging (WAL)
- Repeating history during redo
- Logging changes during undo

---

## NoSQL Databases

**NoSQL** (Not Only SQL) databases are designed for large-scale data storage and high performance.

### Why NoSQL?

**Traditional RDBMS Limitations:**
- Difficult to scale horizontally
- Fixed schema (rigid)
- Not suitable for big data
- Slower for simple queries

**NoSQL Advantages:**
- Horizontal scalability
- Flexible schema
- High performance
- Handles big data
- High availability

---

## Types of NoSQL Databases

### 1. Key-Value Stores
- Simplest NoSQL database
- Store data as key-value pairs
- Very fast reads/writes

**Examples:** Redis, DynamoDB, Riak

**Structure:**
```
Key    → Value
user:1 → {"name": "John", "age": 30}
user:2 → {"name": "Jane", "age": 25}
```

**Use Cases:**
- Session management
- Caching
- Shopping cart

### 2. Document Stores
- Store data as documents (JSON, XML, BSON)
- Flexible schema
- Each document is self-contained

**Examples:** MongoDB, CouchDB, Firebase

**Structure:**
```json
{
  "_id": "1",
  "name": "John",
  "age": 30,
  "address": {
    "city": "New York",
    "zip": "10001"
  },
  "hobbies": ["reading", "coding"]
}
```

**Use Cases:**
- Content management
- E-commerce catalogs
- User profiles

### 3. Column-Family Stores
- Store data in column families
- Optimized for read/write of columns
- Scalable

**Examples:** Cassandra, HBase, Google Bigtable

**Structure:**
```
Row Key: user:1
  Column Family: personal
    name: "John"
    age: 30
  Column Family: contact
    email: "john@example.com"
    phone: "123-456-7890"
```

**Use Cases:**
- Analytics
- Data warehousing
- Time-series data

### 4. Graph Databases
- Store data as nodes and edges
- Optimized for relationships
- Efficient for connected data

**Examples:** Neo4j, OrientDB, Amazon Neptune

**Structure:**
```
(Person:John)-[:FRIENDS_WITH]->(Person:Jane)
(Person:John)-[:WORKS_AT]->(Company:TechCorp)
```

**Use Cases:**
- Social networks
- Recommendation engines
- Fraud detection

---

## CAP Theorem

In distributed systems, you can only guarantee **2 out of 3**:

1. **Consistency (C)**
   - All nodes see same data at same time
   - Every read gets latest write

2. **Availability (A)**
   - Every request gets a response
   - System remains operational

3. **Partition Tolerance (P)**
   - System continues despite network failures
   - Works even if messages are lost

**Trade-offs:**
- **CA**: Consistent + Available (not partition-tolerant) → RDBMS
- **CP**: Consistent + Partition-tolerant (not always available) → MongoDB, HBase
- **AP**: Available + Partition-tolerant (not always consistent) → Cassandra, DynamoDB

**In practice:** Partition tolerance is mandatory (networks fail), so choose between C and A.

---

## BASE Properties (NoSQL)

Alternative to ACID for NoSQL databases:

- **BA**: Basically Available (system available most of time)
- **S**: Soft state (state may change without input)
- **E**: Eventual consistency (system will become consistent eventually)

**ACID vs BASE:**
- ACID: Strong consistency, immediate
- BASE: Weak consistency, eventual

---

## Important Points for Exams

1. **2PL**: Growing phase (acquire locks) + Shrinking phase (release locks)
2. **Strict 2PL**: Hold exclusive locks until commit
3. **Timestamp**: Older transactions have priority
4. **MVCC**: Multiple versions, high concurrency
5. **Checkpoint**: Saves state, faster recovery
6. **NoSQL Types**: Key-Value, Document, Column-Family, Graph
7. **CAP**: Can only have 2 of 3 (Consistency, Availability, Partition tolerance)
8. **BASE**: NoSQL alternative to ACID

---

## Quick Revision

### Locking:
- **S-Lock**: Shared (Read)
- **X-Lock**: Exclusive (Write)
- **2PL**: Growing + Shrinking phase

### Timestamp:
- Order by timestamp
- No deadlock, more rollbacks

### Recovery:
- **Deferred**: Modify after commit (REDO)
- **Immediate**: Modify before commit (UNDO + REDO)
- **Checkpoint**: Save state periodically

### NoSQL:
- **Key-Value**: Redis (cache)
- **Document**: MongoDB (flexible)
- **Column**: Cassandra (scalable)
- **Graph**: Neo4j (relationships)

### CAP:
- Pick 2: Consistency, Availability, Partition-tolerance

---

**Exam Tip:** Understand 2PL phases with examples! Know different NoSQL types and their use cases. Remember CAP theorem trade-offs. Practice recovery scenarios with logs!
