# Library Management System - SQL Project

## Project Overview

**Project Title:** Library Management System  
**Database:** `library_db`  
**Project Type:** SQL Database Design & Analysis

This project demonstrates the creation and management of a relational Library Management System using SQL. It includes database design, table relationships, CRUD operations, summary tables using CTAS, and analytical queries.

---

## Objectives

* Design a structured relational database
* Implement primary & foreign key relationships
* Perform CRUD operations
* Generate reports using SQL queries
* Use CTAS (Create Table As Select)

---

## Database Schema

### Tables Used

| Table | Description | Key Columns |
|-------|-------------|-------------|
| branch | Stores branch information | branch_id (PK), manager_id, branch_address, contact_no |
| employees | Staff details | emp_id (PK), emp_name, position, salary, branch_id (FK) |
| members | Registered users | member_id (PK), member_name, member_address, reg_date |
| books | Book inventory | isbn (PK), book_title, category, rental_price, status, author, publisher |
| issued_status | Book issue records | issued_id (PK), issued_member_id (FK), issued_book_isbn (FK), issued_date, issued_emp_id (FK) |
| return_status | Returned book records | return_id (PK), issued_id (FK), return_date, return_book_isbn (FK) |

### Table Creation Scripts

```sql
-- Branch Table
CREATE TABLE branch (
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    branch_address VARCHAR(55),
    contact_no VARCHAR(20)
);

-- Employees Table
CREATE TABLE employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(25),
    position VARCHAR(25),
    salary NUMERIC(10,2),
    branch_id VARCHAR(25) -- FK
);

-- Books Table
CREATE TABLE books (
    isbn VARCHAR(25) PRIMARY KEY,
    book_title VARCHAR(75),
    category VARCHAR(50),
    rental_price FLOAT,
    status VARCHAR(15),
    author VARCHAR(25),
    publisher VARCHAR(50)
);

-- Members Table
CREATE TABLE members (
    member_id VARCHAR(25) PRIMARY KEY,
    member_name VARCHAR(50),
    member_address VARCHAR(75),
    reg_date DATE
);

-- Issued Status Table
CREATE TABLE issued_status (
    issued_id VARCHAR(10) PRIMARY KEY,
    issued_member_id VARCHAR(10), -- FK
    issued_book_name VARCHAR(75),
    issued_date DATE,
    issued_book_isbn VARCHAR(75), -- FK
    issued_emp_id VARCHAR(75) -- FK
);

-- Return Status Table
CREATE TABLE return_status (
    return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(10), -- FK
    return_book_name VARCHAR(75),
    return_date DATE,
    return_book_isbn VARCHAR(75) -- FK
);
```

### Foreign Key Constraints

```sql
-- Issued Status Foreign Keys
ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id) REFERENCES members(member_id);

ALTER TABLE issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn);

ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id);

-- Return Status Foreign Keys
ALTER TABLE return_status
ADD CONSTRAINT fk_issued_id
FOREIGN KEY (issued_id) REFERENCES issued_status(issued_id);

ALTER TABLE return_status
ADD CONSTRAINT fk_return_book_isbn
FOREIGN KEY (return_book_isbn) REFERENCES books(isbn);

-- Employees Foreign Key
ALTER TABLE employees
ADD CONSTRAINT fk_branch_id
FOREIGN KEY (branch_id) REFERENCES branch(branch_id);
```

---

## Features Implemented

### Database Setup
* Created `library_db`
* Defined structured tables
* Applied relationships using foreign keys

### CRUD Operations
* Insert new books
* Update member information
* Delete issue records
* Retrieve issued book data

---

## SQL Query Tasks Completed

### Task 1: Create a New Book Record
**Objective:** Insert a new book into the books table.

```sql
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

SELECT * FROM books WHERE book_title = 'To Kill a Mockingbird';
```

### Task 2: Update an Existing Member's Address
**Objective:** Modify member information.

```sql
UPDATE members 
SET member_name = 'Dev Charaya'
WHERE member_id = 'C101';
```

### Task 3: Delete a Record from the Issued Status Table
**Objective:** Remove a specific issued record.

```sql
DELETE FROM issued_status
WHERE issued_id = 'IS121';
```

### Task 4: Retrieve All Books Issued by a Specific Employee
**Objective:** List all books issued by employee 'E101'.

```sql
SELECT * FROM issued_status 
WHERE issued_emp_id = 'E101';
```

### Task 5: List Members Who Have Issued More Than One Book
**Objective:** Find members with multiple book issues using GROUP BY.

```sql
SELECT issued_emp_id, COUNT(issued_id) AS total_issued
FROM issued_status 
GROUP BY issued_emp_id
ORDER BY total_issued DESC;
```

### Task 6: Create Summary Tables Using CTAS
**Objective:** Generate book issue count summary.

```sql
WITH book_issued_count AS (
    SELECT b.isbn, b.book_title, COUNT(i.issued_id) AS issue_count
    FROM books AS b
    JOIN issued_status AS i ON b.isbn = i.issued_book_isbn
    GROUP BY b.isbn, b.book_title
)
SELECT * FROM book_issued_count
ORDER BY issue_count DESC;
```

### Task 7: Retrieve All Books in a Specific Category
**Objective:** Filter books by category.

```sql
SELECT * FROM books 
WHERE category = 'Classic';
```

### Task 8: Find Total Rental Income by Category
**Objective:** Calculate revenue by book category.

```sql
SELECT b.category, 
       SUM(b.rental_price) AS total_revenue, 
       COUNT(*) AS total_issues
FROM books AS b
JOIN issued_status AS i ON b.isbn = i.issued_book_isbn
GROUP BY b.category
ORDER BY total_issues DESC;
```

### Task 9: List Members Who Registered in the Last 180 Days
**Objective:** Find recent members using date filtering.

```sql
SELECT * FROM members 
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';
```

### Task 10: List Employees with Their Branch Manager's Name
**Objective:** Use self-join to retrieve employee and manager details.

```sql
SELECT e.emp_name, 
       e.branch_id, 
       b.*, 
       e2.emp_name AS manager_name
FROM employees AS e
JOIN branch AS b ON b.branch_id = e.branch_id
JOIN employees AS e2 ON b.manager_id = e2.emp_id;
```

### Task 11: Create a Table of Books with Rental Price Above Average
**Objective:** Filter books above average rental price.

```sql
SELECT * FROM books 
WHERE rental_price > (SELECT AVG(rental_price) FROM books);
```

### Task 12: Retrieve the List of Books Not Yet Returned
**Objective:** Use LEFT JOIN to find unreturned books.

```sql
SELECT i.*
FROM issued_status AS i 
LEFT JOIN return_status AS r ON i.issued_id = r.issued_id 
WHERE r.return_id IS NULL;
```

---

## Reports Generated

* Book issue statistics
* Rental revenue summary
* Branch performance report
* Active member tracking

---

## Project Workflow

### Phase 1: Database Design
1. Created `library_db` database
2. Designed normalized table structure
3. Defined primary keys for each table
4. Established foreign key relationships

### Phase 2: Table Creation
1. Created all 6 tables with appropriate data types
2. Applied ALTER statements to modify column types
3. Set up foreign key constraints
4. Configured date style settings

### Phase 3: Data Population
1. Inserted sample data for branches
2. Added employee records
3. Populated book inventory
4. Created member records
5. Added issued and return status entries

### Phase 4: Query Implementation
1. Implemented CRUD operations
2. Created complex analytical queries
3. Used CTEs for summary tables
4. Applied various JOIN operations
5. Implemented aggregation functions

### Phase 5: Testing & Validation
1. Verified foreign key constraints
2. Tested all CRUD operations
3. Validated query results
4. Ensured data integrity

---
---

## How to Run This Project

**1. Clone the repository:**
```bash
git clone https://github.com/devcharaya/Library_managment_SQL.git
cd Library_managment_SQL
```

**2. Setup Database:**
* Open your SQL environment (PostgreSQL / MySQL)
* Create the database:
```sql
CREATE DATABASE library_db;
```

**3. Run Scripts:**
* Execute table creation scripts in order
* Apply foreign key constraints
* Insert sample data
* Configure database settings:

```sql
-- Set date style for current session
SET DateStyle = 'ISO, DMY';

-- Set date style for entire database
ALTER DATABASE "Library_managment" SET datestyle TO 'ISO, DMY';
```

**4. Execute Queries:**
* Navigate to the `queries/` folder
* Run the SQL files in your database client

---

## Key SQL Concepts Demonstrated

### Joins
* **INNER JOIN:** Combining books and issued_status tables
* **LEFT JOIN:** Finding unreturned books
* **SELF JOIN:** Retrieving employee-manager relationships

### Aggregations
* **COUNT():** Counting book issues per employee
* **SUM():** Calculating total rental income
* **AVG():** Finding average rental price
* **GROUP BY:** Grouping data by category/employee
* **HAVING:** Filtering grouped results

### Subqueries
* Used in filtering books above average rental price
* Nested queries for complex data retrieval

### Date Functions
* **CURRENT_DATE:** Getting today's date
* **INTERVAL:** Date arithmetic for filtering recent members
* Date formatting and comparisons

### Common Table Expressions (CTE)
* WITH clause for book issue count summary
* Improved query readability and organization

---

## Database Relationships

* **branch** → **employees** (One-to-Many)
* **employees** → **issued_status** (One-to-Many)
* **members** → **issued_status** (One-to-Many)
* **books** → **issued_status** (One-to-Many)
* **issued_status** → **return_status** (One-to-One)

---

## Skills Demonstrated

* **Database Design:** Normalized relational schema with 6 interconnected tables
* **SQL DDL:** CREATE, ALTER, DROP statements
* **SQL DML:** INSERT, UPDATE, DELETE operations
* **Constraint Management:** Primary keys, Foreign keys, Data integrity
* **Complex Joins:** INNER JOIN, LEFT JOIN, SELF JOIN
* **Aggregations:** COUNT, SUM, AVG with GROUP BY and ORDER BY
* **Subqueries:** Nested queries for filtering and comparisons
* **Common Table Expressions (CTE):** WITH clause for readable queries
* **Date Functions:** CURRENT_DATE, INTERVAL for date arithmetic
* **Data Analysis:** Generating reports and insights from raw data
* **Query Optimization:** Efficient query writing and indexing considerations

---

## Technologies Used

* **Database:** PostgreSQL / MySQL
* **SQL Version:** SQL Standard
* **Tools:** pgAdmin / MySQL Workbench / SQL Client

---

## Key Learning Outcomes

* Understanding of normalized database design (3NF)
* Proficiency in writing complex SQL queries
* Implementation of referential integrity using foreign keys
* Creating analytical reports from raw data
* Using CTEs for improved query structure
* Managing relationships between multiple tables
* Applying date functions for temporal analysis
* Performance considerations in query design

---

## Query Execution Order

**Follow this sequence for best results:**

1. **Setup Phase:**
   - Create database
   - Create all tables (branch, employees, members, books, issued_status, return_status)
   - Apply ALTER statements for column modifications

2. **Relationships Phase:**
   - Add all foreign key constraints
   - Verify relationships

3. **Data Phase:**
   - Insert data into branch table
   - Insert data into employees table
   - Insert data into members table
   - Insert data into books table
   - Insert issued_status records
   - Insert return_status records

4. **Analysis Phase:**
   - Execute Tasks 1-12 in sequence
   - Verify results after each task

---

## Future Enhancements

* Add stored procedures for common operations
* Implement triggers for automatic record updates
* Create views for frequently accessed reports
* Add indexes for performance optimization
* Implement user authentication system
* Develop a web-based frontend interface

---

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/NewFeature`)
3. Commit your changes (`git commit -m 'Add NewFeature'`)
4. Push to the branch (`git push origin feature/NewFeature`)
5. Open a Pull Request

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## Author

**Dev Charaya**  
MCA Student | Data Analytics Enthusiast

**Connect with me:**
* GitHub: [@devcharaya](https://github.com/devcharaya)
* LinkedIn: [https://www.linkedin.com/in/dev-charaya-186b40314/]
* Email: [charayadev11@gmail.com]

---

## Project Status

**Status:** Completed  
**Level:** Intermediate SQL Practice Project

---

## Acknowledgments

* SQL documentation and best practices
* Database design principles
* Open-source SQL community

---

## Contact

For any questions or suggestions, feel free to:
* Open an issue on GitHub
* Reach out via email
* Connect on LinkedIn
