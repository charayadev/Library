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

| Table | Description |
|-------|-------------|
| branch | Stores branch information |
| employees | Staff details |
| members | Registered users |
| books | Book inventory |
| issued_status | Book issue records |
| return_status | Returned book records |

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

| Task | Description |
|------|-------------|
| Add new book | Insert book into system |
| Update member | Modify address |
| Delete issue | Remove issued record |
| Books by employee | Retrieve issued books |
| Members with multiple issues | Group & filter |
| CTAS summary table | Book issue count |
| Books by category | Filtering |
| Rental income | Aggregation |
| Recent members | Date filtering |
| Employee & branch report | Joins |
| Unreturned books | LEFT JOIN logic |
| Branch performance | Aggregated report |
| Active members | CTAS |
| Top employees | Issue count ranking |

---

## Reports Generated

* Book issue statistics
* Rental revenue summary
* Branch performance report
* Active member tracking

---

## Project Structure

```
library-management-sql/
│
├── schema/
│   ├── create_database.sql      # Database creation
│   ├── create_tables.sql        # Table definitions
│   └── insert_data.sql          # Sample data
│
├── queries/
│   ├── crud_operations.sql      # CRUD examples
│   ├── analysis_queries.sql     # Analytical queries
│   └── reports.sql              # Report generation
│
└── README.md                    # Project documentation
```

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
* Execute table creation scripts
* Insert sample data
* Run query tasks

**4. Execute Queries:**
* Navigate to the `queries/` folder
* Run the SQL files in your database client

---

## Sample Queries

### Add New Book
```sql
INSERT INTO books (isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-0-553-29698-2', 'The Catcher in the Rye', 'Classic', 7.00, 'yes', 'J.D. Salinger', 'Little, Brown');
```

### Update Member Information
```sql
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
```

### Retrieve Books by Employee
```sql
SELECT e.emp_name, b.book_title, i.issued_date
FROM issued_status i
JOIN employees e ON i.issued_emp_id = e.emp_id
JOIN books b ON i.issued_book_isbn = b.isbn;
```

### Branch Performance Report
```sql
SELECT b.branch_id, b.manager_id, COUNT(i.issued_id) AS total_books_issued
FROM branch b
LEFT JOIN employees e ON b.branch_id = e.branch_id
LEFT JOIN issued_status i ON e.emp_id = i.issued_emp_id
GROUP BY b.branch_id, b.manager_id
ORDER BY total_books_issued DESC;
```

### CTAS - Active Members Summary
```sql
CREATE TABLE active_members AS
SELECT m.member_id, m.member_name, COUNT(i.issued_id) AS total_books_issued
FROM members m
JOIN issued_status i ON m.member_id = i.issued_member_id
GROUP BY m.member_id, m.member_name
HAVING COUNT(i.issued_id) > 1;
```

---

## Database Relationships

* **branch** → **employees** (One-to-Many)
* **employees** → **issued_status** (One-to-Many)
* **members** → **issued_status** (One-to-Many)
* **books** → **issued_status** (One-to-Many)
* **issued_status** → **return_status** (One-to-One)

---

## Skills Demonstrated

* Relational Database Design
* SQL Joins (INNER, LEFT, RIGHT)
* Aggregations (`SUM`, `COUNT`, `AVG`, `GROUP BY`, `HAVING`)
* CTAS (Create Table As Select)
* Data Analysis Queries
* Foreign Key Constraints
* Data Integrity Management
* Query Optimization

---

## Technologies Used

* **Database:** PostgreSQL / MySQL
* **SQL Version:** SQL Standard
* **Tools:** pgAdmin / MySQL Workbench / SQL Client

---

## Key Learning Outcomes

* Understanding of normalized database design
* Proficiency in writing complex SQL queries
* Implementation of database constraints
* Creating analytical reports from raw data
* Using CTAS for summary table creation
* Managing relationships between multiple tables

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
