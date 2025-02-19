-- ### Order
-- 1. Find all subjects sorted by subject
SELECT subject FROM subjects ORDER BY subjects;

-- 2. Find all subjects sorted by location
-- SELECT * FROM subjects ORDER BY location;
SELECT subject FROM subjects ORDER BY location;

-- ### Where
-- 3. Find the book "Little Women"
SELECT * FROM books WHERE title = 'Little Women';

-- SELECT b.title FROM books b 
-- WHERE title = 'Little Women;'

-- 4. Find all books containing the word "Python"
SELECT * FROM books WHERE title LIKE '%Python%';
-- SELECT * From books WHERE LOWER(title) LIKE '%python%'

-- 5. Find all subjects with the location "Main St" sort them by subject
-- SELECT * FROM subjects WHERE location = 'Main St' ORDER BY subject;
SELECT subject FROM subjects WHERE location = 'Main St' ORDER BY subject;

-- ### Joins

-- 6. Find all books about Computers and list ONLY the book titles
SELECT title FROM books
JOIN subjects ON books.subject_id = subjects.id
WHERE subject = 'Computers';

-- define alias in the FROM and JOIN clause
-- books = b and subjects = s

-- SELECT b.title FROM books b  -- here we tell SQL we are calling books 'b'
-- JOIN subjects s  -- here we tell SQL we are calling subjects 's'
-- ON b.subject_id = s.id
-- WHERE s.subject = 'Computers';

-- 7. Find all books and display a result table with ONLY the following columns
-- 	* Book title
SELECT title FROM books;
-- 	* Author's first name
SELECT title, first_name FROM books JOIN authors on books.author_id = authors.id;
-- 	* Author's last name
SELECT title, first_name, last_name  FROM books JOIN authors on books.author_id = authors.id;
-- 	* Book subject
SELECT title, first_name, last_name, subject FROM books
JOIN authors ON books.author_id = authors.id
JOIN subjects ON books.subject_id = subjects.id;

-- SELECT b.title, a.first_name, a.last_name s.subject
-- FROM authors a
-- JOIN books b ON a.id = b.author_id
-- JOIN subjects s ON s.id = b.subject_id;

-- 8. Find all books that are listed in the stock table
-- 	* Sort them by retail price (most expensive first)
-- 	* Display ONLY: title and price
SELECT title, retail FROM editions
JOIN stock ON editions.isbn = stock.isbn
JOIN books ON editions.book_id = books.id
ORDER BY retail DESC;

-- 9. Find the book "Dune" and display ONLY the following columns
-- 	* Book title
-- 	* ISBN number
-- 	* Publisher name
-- 	* Retail price
SELECT title, editions.isbn, name, retail FROM books
JOIN editions ON books.id = editions.book_id
JOIN publishers ON publishers.id = editions.publisher_id
JOIN stock ON editions.isbn = stock.isbn WHERE title ='Dune';

-- 10. Find all shipments sorted by ship date display a result table with ONLY the following columns:
-- 	* Customer first name
-- 	* Customer last name
-- 	* ship date
-- 	* book title
SELECT first_name, last_name, ship_date, title FROM books
JOIN editions ON books.id = editions.book_id
JOIN shipments ON shipments.isbn = editions.isbn
JOIN customers ON shipments.customer_id = customers.id ORDER BY ship_date;

-- ### Grouping and Counting

-- 11. Get the COUNT of all books
SELECT COUNT(*) FROM books;

-- 12. Get the COUNT of all Locations
SELECT COUNT(location) FROM subjects;

-- 13. Get the COUNT of each unique location in the subjects table. Display the count and the location name. (hint: requires GROUP BY).
SELECT COUNT(location), location FROM subjects GROUP BY location;

-- 14. List all books. Display the book_id, title, and a count of how many editions each book has. (hint: requires GROUP BY and JOIN)
SELECT book_id, title, COUNT(edition)
FROM editions JOIN books ON books.id = editions.book_id
GROUP BY book_id, title;

-- SELECT books.title, COUNT(editions.edition)
-- FROM books JOIN editions ON books.id = editions.book_id
-- GROUP BY book_id, title;