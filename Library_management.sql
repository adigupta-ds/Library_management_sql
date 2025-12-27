use Lib_management

select * from books
select * from branch
select * from employees
select * from issued_status
select * from members
select * from return_status



--**************************************************************************************************************************************************
--1: Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books(isbn,book_title,category,rental_price,status,author,publisher)VALUES
(978-1-60129-456-2,'To Kill a Mockingbird','Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
select * from books

--2: Update an Existing Member's Address ='125 Oak St' whose member_id = 'C103';

Update members
set member_address='125 Oak St'
where member_id = 'C103'

--3: Delete a Record from the Issued Status Table
 -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

delete from issued_status
where issued_id = 'IS121';

--4: Retrieve All Books Issued by a Specific Employee
 -- Objective: Select all books issued by the employee with emp_id = 'E101'.

select * from issued_status 
where issued_emp_id='E101';

--5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.

select issued_emp_id,count(*) as no_of_books
from issued_status
group by issued_emp_id
having count(*)>1;

--*************************************************************************************************
--3. CTAS (Create Table As Select)



--6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**



SELECT 
    b.isbn,
    b.book_title,
    COUNT(s.issued_id) AS book_issued_cnt
INTO summary
FROM books b
JOIN issued_status s
    ON b.isbn = s.issued_book_isbn
GROUP BY 
    b.isbn,
    b.book_title;

select * from summary

--****************************************************************************************************************************************************


--7: Retrieve All Books in a Specific Category:

select * from books
where category='Classic';


--8:List Members Who Registered in the Last 180 Days:


select * FROM members
WHERE reg_date >= DATEADD(day,-180,GETDATE());


--9: Retrieve the List of Books Not Yet Returned

select * from issued_status as ist 
left join return_status as rs 
on rs.issued_id=ist.issued_id
where rs.return_id is null;


--13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.

--members--issued_status--books--return_status
select 
      ist.issued_member_id,
      m.member_name,
      b.book_title,
      ist.issued_date,
      rs.return_date
from members m
join issued_status ist ON
m.member_id=ist.issued_member_id
join books b ON
b.isbn=ist.issued_book_isbn
left join return_status rs ON
rs.issued_id=ist.issued_id
--filters book returns




--14: Update Book Status on Return
--Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).




--15: Branch Performance Report
--Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.


--Task 16: CTAS: Create a Table of Active Members
--Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.


--Task 18: Identify Members Issuing High-Risk Books
--Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books.

--Task 19: Stored Procedure Objective: Create a stored procedure to manage the status of books in a library system. Description: Write a stored procedure that updates the status of a book in the library based on its issuance. The procedure should function as follows: The stored procedure should take the book_id as an input parameter. The procedure should first check if the book is available (status = 'yes'). If the book is available, it should be issued, and the status in the books table should be updated to 'no'. If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.


--Task 20: Create Table As Select (CTAS) Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

