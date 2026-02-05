-- libraray management project 
-- branch table creation
drop table if exists branch
create table branch 
(
  branch_id varchar(10) primary key,
  manager_id varchar(10),
  branch_address varchar(55),
  contact_no varchar(10)

);


-- employes table ceation 
drop table if exists employees;
create table employees
(
  emp_id varchar(10) primary key,
  emp_name varchar(25),
  position varchar(25),
  salary int,
  branch_id varchar(25) --fk
);


-- BOOKS Table creation
drop table if exists books;
create table books(
isbn varchar(25)  primary key,
book_title varchar(75),
category varchar(10),
rental_price float,
status varchar(15),
author varchar(25),
publisher varchar(50)
)

-- Members Table creation
drop table if exists members;
create table members 
(
  member_id varchar(25) primary key,
  member_name varchar(50),
  memeber_address varchar(75),
  reg_date date 
)



-- issued_status Table creation
drop table if exists issued_status;
create table issued_status
(

   issued_id varchar(10) primary key,
   issued_member_id varchar(10), --fk
   issued_book_name varchar(75),
   issued_date date,
   issued_book_isbn varchar(75), -- fk
   issued_emp_id varchar(75) --fk

)

-- return_status Table creation

drop table if exists return_status;
create table return_status
(

   return_id varchar(10) primary key,
   issued_id varchar(10),
   return_book_name varchar(75),
   return_date date,
   return_book_isbn varchar(75)

)

-- foreign key



alter table issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);

alter table issued_status
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn);


alter table issued_status
add constraint fk_employess
foreign key (issued_emp_id)
references employees(emp_id);


alter table return_status
add constraint fk_issued_id
foreign key (issued_id)
references issued_status(issued_id);


alter table employees
add constraint fk_branch_id
foreign key (branch_id)
references branch(branch_id);



alter table return_status
add constraint fk_return_book_isbn
foreign key (return_book_isbn)
references books(isbn);

-- alter category
alter table books
alter column category TYPE Varchar(50);

-- alter contact no.
alter table branch
alter column contact_no TYPE Varchar(20);


--alter table employes
alter table employees
alter column salary type Numeric(10,2);

-- date style fix
SET DateStyle = 'ISO, DMY';


--whole data base date set up
ALTER DATABASE "Library_managment" SET datestyle TO 'ISO, DMY';

SELECT * FROM issued_status WHERE issued_id = 'IS107';





-- retrurn status
INSERT INTO return_status(return_id, issued_id, return_date) 
VALUES
('RS105', 'IS107', '2024-05-03'),
('RS106', 'IS108', '2024-05-05'),
('RS107', 'IS109', '2024-05-07'),
('RS108', 'IS110', '2024-05-09'),
('RS109', 'IS111', '2024-05-11'),
('RS110', 'IS112', '2024-05-13'),
('RS111', 'IS113', '2024-05-15'),
('RS112', 'IS114', '2024-05-17'),
('RS113', 'IS115', '2024-05-19'),
('RS114', 'IS116', '2024-05-21'),
('RS115', 'IS117', '2024-05-23'),
('RS116', 'IS118', '2024-05-25'),
('RS117', 'IS119', '2024-05-27'),
('RS118', 'IS120', '2024-05-29');
SELECT * FROM return_status;
-- memebers
INSERT INTO members(member_id, member_name, memeber_address, reg_date) 
VALUES
('C101', 'Alice Johnson', '123 Main St', '2021-05-15'),
('C102', 'Bob Smith', '456 Elm St', '2021-06-20'),
('C103', 'Carol Davis', '789 Oak St', '2021-07-10'),
('C104', 'Dave Wilson', '567 Pine St', '2021-08-05'),
('C105', 'Eve Brown', '890 Maple St', '2021-09-25'),
('C106', 'Frank Thomas', '234 Cedar St', '2021-10-15'),
('C107', 'Grace Taylor', '345 Walnut St', '2021-11-20'),
('C108', 'Henry Anderson', '456 Birch St', '2021-12-10'),
('C109', 'Ivy Martinez', '567 Oak St', '2022-01-05'),
('C110', 'Jack Wilson', '678 Pine St', '2022-02-25'),
('C118', 'Sam', '133 Pine St', '2024-06-01'),    
('C119', 'John', '143 Main St', '2024-05-01');
SELECT * FROM members;



-- data import done

-- all data retriving 

select * from branch;
select * from books;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;


-- starting the businees probelms

--Task 1
/*Task 1. Create a New Book Record -- "978-1-60129-456-2', 
'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 
'J.B. Lippincott & Co.')"*/

select * from books;

insert into  books(isbn,book_title,category,rental_price,status,author,publisher)
values
(978-1-60129-456-2,'To Kill a Mockingbird','Classic',6.00,'yes','Harper Lee','J.B. Lippincott & Co.');
select * from books where booK_title = 'To Kill a Mockingbird';


-- Task 2
/*
Update an Existing Member's Address
*/

Update Members 
set member_name='Dev Charaya'
where member_id='C101';


/*Task 3: Delete a Record from the Issued Status Table -- 
Objective: Delete the record with issued_id = 'IS121' from the 
issued_status table.*/
select * from issued_status;

delete from issued_status
where issued_id ='IS121';

/*Task 4: Retrieve All Books Issued by a Specific Employee -- 
Objective: Select all books issued by the employee with emp_id = 'E101'.*/
select * from issued_status where issued_emp_id = 'E101';



/*Task 5: List Members Who Have Issued More Than One Book -- 
Objective: Use GROUP BY to find members who have issued more than one book.*/
select Issued_emp_id, count(issued_id) from issued_status 
group by Issued_emp_id
order by  2 desc;


/*Task 6: Create Summary Tables: Used CTAS to 
generate new tables based on query results - each book and total book_issued_cnt** */
select * from books;
select * from issued_status;

with book_issued_count as(
select b.isbn, b.book_title, count(i.issued_id)
from books as b
join  issued_status as i
on b.isbn = i.issued_book_isbn
group by b.isbn
order by 3 desc
)
select * from book_issued_count;


/*Task 7. Retrieve All Books in a Specific Category:*/
select * from books where category='Classic';

/*Task 8: Find Total Rental Income by Category:*/
select b.category, sum(b.rental_price), count(*)
from books as b
join issued_status as i 
on b.isbn=  i.issued_book_isbn
group by category
order by 3 desc;



/*Task 9: List Members Who Registered in the Last 180 Days:*/
select * from members where reg_date>= current_date - interval '180 days';


/* Task 10: List Employees with Their Branch Manager's Name and their branch details
*/


select * from  employees;

select * from branch;
-- join 1 because of the branch details and again for the manager name

select e.emp_name, e.branch_id, b.*,e2.emp_name as manager_name
from employees as e
join branch as b
on b.branch_id = e.branch_id
join employees e2
on b.manager_id = e2.emp_id;


/*Task 11. Create a Table of Books with 
Rental Price Above a Certain Threshold:
*/
 select * from books where rental_price > (select avg(rental_price) from books);

/*
Task 12: Retrieve the List of Books Not Yet Returned
*/

 select * from issued_status
 select * from return_status


 select * from
 issued_status as i 
 left join 
 return_status as r
 on i.issued_id = r.issued_id 
 where r.return_id is NULL;
