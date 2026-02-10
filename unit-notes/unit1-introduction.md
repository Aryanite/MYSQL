# Unit 1: Introduction to DBMS

## What is DBMS?

**Database Management System (DBMS)** is software that manages databases. It allows users to create, read, update, and delete data efficiently.

### Examples:
- MySQL
- PostgreSQL
- Oracle
- MS SQL Server
- MongoDB (NoSQL)

---

## File System vs DBMS

| Feature | File System | DBMS |
|---------|-------------|------|
| **Data Redundancy** | High (duplicate data) | Low (minimal duplication) |
| **Data Inconsistency** | High | Low |
| **Data Integrity** | Difficult to maintain | Easy with constraints |
| **Security** | Limited | Strong (user roles, permissions) |
| **Concurrent Access** | Not supported | Supported |
| **Backup & Recovery** | Manual | Automatic |
| **Query Processing** | Not available | SQL queries |

**Why DBMS?**
- Reduces redundancy
- Maintains consistency
- Enforces integrity constraints
- Provides security
- Allows concurrent access
- Supports backup and recovery

---

## Three-Schema Architecture (ANSI-SPARC)

The three-schema architecture separates the user view from the physical database.

### 1. Internal Level (Physical Schema)
- **Lowest level**
- Describes HOW data is stored physically
- Deals with storage structures, file organization, indexing
- Example: Data stored in blocks on disk

### 2. Conceptual Level (Logical Schema)
- **Middle level**
- Describes WHAT data is stored
- Entire database structure visible to DBA
- Hides physical storage details
- Example: Tables, relationships, constraints

### 3. External Level (View Schema)
- **Highest level**
- Describes HOW users see the data
- Multiple user views of same database
- Provides security by hiding data
- Example: Different views for different departments

**Data Independence:**
- **Logical Independence**: Change conceptual schema without affecting external schema
- **Physical Independence**: Change internal schema without affecting conceptual schema

---

## Data Models

A **data model** is a collection of concepts for describing data structure, relationships, and constraints.

### 1. Hierarchical Model
- **Structure**: Tree-like structure
- **Relationships**: One-to-many (parent-child)
- **Example**: IMS (Information Management System)
- **Limitation**: Cannot handle many-to-many relationships

```
        Organization
            |
    +-------+-------+
    |               |
Department1    Department2
    |               |
Employee       Employee
```

### 2. Network Model
- **Structure**: Graph structure
- **Relationships**: Many-to-many
- **Example**: IDMS (Integrated Database Management System)
- **Advantage**: More flexible than hierarchical
- **Limitation**: Complex to design and implement

```
Student ←→ Course
    ↓         ↓
  Grade ←→ Instructor
```

### 3. Relational Model
- **Structure**: Tables (relations)
- **Relationships**: Using foreign keys
- **Example**: MySQL, PostgreSQL, Oracle
- **Advantage**: Simple, powerful, flexible
- **Standard Query Language**: SQL

**Key Concepts:**
- **Relation**: Table
- **Tuple**: Row
- **Attribute**: Column
- **Domain**: Set of allowed values for an attribute

---

## Database Users

### 1. End Users
**Naive Users:**
- Use predefined applications
- No technical knowledge required
- Example: Bank teller, airline reservation clerk

**Casual Users:**
- Occasional database access
- Use query language when needed
- Example: Managers generating reports

**Sophisticated Users:**
- Engineers, scientists, analysts
- Write complex queries
- Use database for their applications

### 2. Application Programmers
- Develop applications that use database
- Write programs in Java, Python, PHP, etc.
- Create user interfaces

### 3. Database Administrator (DBA)
- Most important user
- Central control of database
- Responsible for overall management

---

## Database Administrator (DBA) Roles

The DBA is responsible for managing the entire database system.

### Key Responsibilities:

1. **Schema Definition**
   - Create and modify database structure
   - Define tables, relationships, constraints

2. **Storage Structure & Access Methods**
   - Decide file organization
   - Create indexes for performance

3. **Schema & Physical Organization Modification**
   - Alter structure as requirements change
   - Reorganize storage for efficiency

4. **Granting Authorization**
   - Manage user accounts
   - Assign permissions and roles
   - Ensure security

5. **Routine Maintenance**
   - Periodic backups
   - Monitor disk space
   - Performance tuning
   - Apply security patches

6. **Monitoring Performance**
   - Track query execution time
   - Optimize slow queries
   - Manage resources

**Skills Required:**
- Deep understanding of DBMS
- Knowledge of SQL
- System administration
- Problem-solving skills
- Security awareness

---

## Important Points for Exams

1. DBMS provides **data independence** (logical and physical)
2. Three-schema architecture has **3 levels**: Internal, Conceptual, External
3. **Relational model** is most popular (uses tables)
4. **DBA** is responsible for overall database management
5. File systems have **high redundancy** and **low security**
6. DBMS supports **concurrent access** and **ACID properties**

---

## Quick Revision Points

- DBMS = Software to manage databases
- File System ❌ vs DBMS ✅
- 3 Schema Levels: Internal → Conceptual → External
- 3 Data Models: Hierarchical, Network, Relational
- Users: Naive, Casual, Sophisticated, Programmers
- DBA: Master of database (schema, security, backup, performance)

---

**Exam Tip:** Focus on differences (File System vs DBMS), three-schema architecture levels, and DBA roles. These are frequently asked questions!
