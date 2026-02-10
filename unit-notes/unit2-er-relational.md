# Unit 2: ER Model & Relational Model

## Entity-Relationship (ER) Model

The **ER Model** is a high-level conceptual data model that describes data as entities, attributes, and relationships.

---

## ER Model Concepts

### 1. Entity
An **entity** is a real-world object that has independent existence.

**Types:**
- **Strong Entity**: Has its own primary key (e.g., Student, Employee)
- **Weak Entity**: Depends on strong entity, no primary key (e.g., Dependent of Employee)

**Representation:**
- Strong Entity: Rectangle
- Weak Entity: Double Rectangle

### 2. Attributes
**Attributes** are properties that describe an entity.

**Types of Attributes:**

1. **Simple Attribute**: Cannot be divided (e.g., Age, Roll_No)
2. **Composite Attribute**: Can be divided (e.g., Name → FirstName, LastName)
3. **Single-valued**: One value (e.g., Age)
4. **Multi-valued**: Multiple values (e.g., Phone_Numbers)
5. **Derived Attribute**: Calculated from other attributes (e.g., Age from DOB)
6. **Stored Attribute**: Stored directly (e.g., Date_of_Birth)

**Representation:**
- Simple: Oval
- Composite: Oval with connected ovals
- Multi-valued: Double Oval
- Derived: Dashed Oval
- Key Attribute: Underlined

### 3. Relationships
A **relationship** is an association among entities.

**Degree of Relationship:**
- **Unary (1)**: One entity type (e.g., Employee manages Employee)
- **Binary (2)**: Two entity types (e.g., Student enrolls in Course)
- **Ternary (3)**: Three entity types (e.g., Doctor treats Patient in Hospital)

**Cardinality Ratios:**
- **One-to-One (1:1)**: One entity related to one entity (e.g., Person → Passport)
- **One-to-Many (1:N)**: One entity related to many entities (e.g., Department → Employees)
- **Many-to-One (N:1)**: Many entities related to one entity (e.g., Employees → Department)
- **Many-to-Many (M:N)**: Many entities related to many entities (e.g., Students → Courses)

**Participation Constraints:**
- **Total Participation**: Every entity must participate (double line)
- **Partial Participation**: Some entities may not participate (single line)

**Representation:**
- Relationship: Diamond

---

## Keys in Databases

Keys uniquely identify records in a table.

### 1. Super Key
A **super key** is a set of one or more attributes that uniquely identifies a tuple.

**Example:**
For Student table: {Student_ID}, {Student_ID, Name}, {Email}, {Email, Phone}

### 2. Candidate Key
A **candidate key** is a minimal super key (no redundant attributes).

**Example:**
{Student_ID}, {Email} (both can uniquely identify, but minimal)

### 3. Primary Key
A **primary key** is the candidate key chosen to uniquely identify tuples.

**Rules:**
- Must be unique
- Cannot be NULL
- One per table
- Should be simple and stable

**Example:**
Student_ID (chosen as primary key)

### 4. Alternate Key
**Alternate keys** are candidate keys not chosen as primary key.

**Example:**
If Student_ID is primary key, then Email is alternate key.

### 5. Foreign Key
A **foreign key** is an attribute in one table that refers to the primary key of another table.

**Purpose:**
- Establishes relationships between tables
- Maintains referential integrity

**Example:**
```
DEPARTMENT (Dept_ID, Dept_Name)  ← Primary Key: Dept_ID
EMPLOYEE (Emp_ID, Name, Dept_ID) ← Foreign Key: Dept_ID
```

### 6. Composite Key
A **composite key** is a primary key made up of multiple attributes.

**Example:**
```
ENROLLMENT (Student_ID, Course_ID, Semester)
Primary Key: {Student_ID, Course_ID}
```

---

## ER to Relational Mapping

Converting ER diagrams to relational tables follows specific rules.

### Step 1: Mapping Strong Entities
- Create a table for each strong entity
- Entity attributes → Table columns
- Choose primary key

**Example:**
```
Entity: STUDENT (ID, Name, Age)
Table: STUDENT (Student_ID PK, Name, Age)
```

### Step 2: Mapping Weak Entities
- Create a table with its attributes
- Add foreign key from owner entity
- Primary key = Partial key + Foreign key

**Example:**
```
Weak Entity: DEPENDENT (Name, Age) depends on EMPLOYEE
Table: DEPENDENT (Emp_ID FK, Dependent_Name, Age)
Primary Key: (Emp_ID, Dependent_Name)
```

### Step 3: Mapping 1:1 Relationships
**Method 1:** Foreign key approach
- Add foreign key in either table

**Method 2:** Merged table approach
- Combine both entities into one table

### Step 4: Mapping 1:N Relationships
- Add foreign key in the "many" side (N side)

**Example:**
```
DEPARTMENT (1) ← manages → (N) EMPLOYEE
EMPLOYEE table gets Dept_ID as foreign key
```

### Step 5: Mapping M:N Relationships
- Create a new relationship table
- Include foreign keys from both entities
- Primary key = combination of both foreign keys

**Example:**
```
STUDENT (M) ←→ (N) COURSE
New table: ENROLLMENT (Student_ID FK, Course_ID FK, Grade)
Primary Key: (Student_ID, Course_ID)
```

### Step 6: Mapping Multi-valued Attributes
- Create a separate table
- Include the multi-valued attribute
- Add foreign key to owner entity

**Example:**
```
EMPLOYEE has multi-valued Phone_Numbers
New table: EMPLOYEE_PHONE (Emp_ID FK, Phone_Number)
Primary Key: (Emp_ID, Phone_Number)
```

---

## Relational Model Concepts

### Relational Model Terminology

| ER Model Term | Relational Model Term |
|---------------|-----------------------|
| Entity | Relation (Table) |
| Attribute | Column (Field) |
| Tuple | Row (Record) |
| Entity Set | Table |

### Key Terms:

**1. Relation (Table)**
- A table with rows and columns
- Has a unique name

**2. Tuple (Row)**
- A single record in a table
- Order doesn't matter

**3. Attribute (Column)**
- A column in a table
- Has a name and domain

**4. Domain**
- Set of allowed values for an attribute
- Example: Age domain = {0 to 120}

**5. Degree**
- Number of attributes in a relation
- Example: STUDENT (ID, Name, Age) has degree 3

**6. Cardinality**
- Number of tuples in a relation
- Example: If 100 students, cardinality = 100

### Properties of Relations

1. **No duplicate tuples**: Each row is unique
2. **Atomic values**: Each cell contains single value
3. **Order of tuples**: Not important
4. **Order of attributes**: Not important (but column names matter)
5. **All values in a column**: Same domain
6. **Each attribute**: Has a unique name

---

## Relational Integrity Constraints

### 1. Domain Constraint
- Each attribute value must be from its domain
- Example: Age must be positive integer

### 2. Key Constraint (Entity Integrity)
- Primary key cannot be NULL
- Primary key must be unique

### 3. Referential Integrity Constraint
- Foreign key must match a primary key value or be NULL
- Cannot have orphan records

**Example:**
```sql
EMPLOYEE (Emp_ID, Name, Dept_ID)
Dept_ID must exist in DEPARTMENT table
```

---

## Relational Algebra (Basic Operations)

Relational algebra is a procedural query language.

### 1. SELECT (σ)
Selects tuples that satisfy a condition.

**Syntax:** σ_condition(Relation)

**Example:** σ_Age>20(STUDENT)

### 2. PROJECT (π)
Selects specific columns.

**Syntax:** π_attribute_list(Relation)

**Example:** π_Name,Age(STUDENT)

### 3. UNION (∪)
Combines tuples from two relations (removes duplicates).

**Condition:** Both relations must be union-compatible.

**Example:** R ∪ S

### 4. SET DIFFERENCE (−)
Tuples in R but not in S.

**Example:** R − S

### 5. CARTESIAN PRODUCT (×)
All possible combinations of tuples.

**Example:** R × S

### 6. RENAME (ρ)
Renames relation or attributes.

**Example:** ρ_STUDENT2(STUDENT)

---

## Important Points for Exams

1. **Entity**: Real-world object (Rectangle in ER diagram)
2. **Weak Entity**: Depends on strong entity (Double Rectangle)
3. **Primary Key**: Cannot be NULL, must be unique
4. **Foreign Key**: References primary key of another table
5. **1:N Mapping**: Foreign key in "N" side
6. **M:N Mapping**: Create new relationship table
7. **Referential Integrity**: Foreign key must match existing primary key
8. **Relational Algebra**: σ (SELECT), π (PROJECT), ∪ (UNION)

---

## Quick Revision

### ER Model:
- Entity (□), Weak Entity (⧈), Attribute (○), Multi-valued (◎), Derived (⃝), Relationship (◇)

### Keys:
- Super Key → Candidate Key → Primary Key
- Alternate Key = Candidate Key - Primary Key
- Foreign Key = References another table

### Cardinality:
- 1:1, 1:N, M:N

### ER to Relational:
- Strong Entity → Table
- Weak Entity → Table + Foreign Key
- 1:N → Foreign Key in N side
- M:N → New table with both foreign keys
- Multi-valued → Separate table

---

**Exam Tip:** Draw ER diagrams for examples! Practice ER-to-Relational mapping with different cardinality scenarios. Know all types of keys!
