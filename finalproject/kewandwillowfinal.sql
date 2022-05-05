-- DROP STATEMENTS --

drop table if exists address;
drop table if exists bookauthor;
drop table if exists authors;
drop table if exists books;
drop table if exists orders;
drop table if exists customers;
drop table if exists employees;
drop table if exists genre;
drop table if exists language;
drop table if exists orderfill;
drop table if exists orderstatus;
drop table if exists people;
drop table if exists publisher;

--- CREATE STATEMENTS ---
-- People --
CREATE TABLE People (
   pid         int  not null,
   firstName   text ,
   lastName    text ,
 primary key(pid)
);

--Authors--
CREATE TABLE Authors (
   pid         int not null references people(pid),
   DOB         date,
 primary key(pid)
);


--Employees--
CREATE TABLE Employees (
   pid         int not null references people(pid),
   wageUSD     numeric(10,2),	
 primary key(pid)
);


--Books--
CREATE TABLE Books ( 
   ISBN         varchar(13) not null,
   title      	varchar(400),			
   priceUSD     numeric(10,2),
   languageID   varchar(5),
   pages        int,
   publisherID  char(4),
   PublishDate  date,
   genreID      varchar(4),
 primary key(ISBN)
);

--BookAuthor-
 CREATE TABLE BookAuthor (
   aid         int not null references Authors(pid),
   ISBN        varchar(13),	
 primary key(aid, ISBN)
 );
 
--Address--
 CREATE TABLE Address (
   addressID         varchar(3) not null,
   street            text,
   city              text,
   state             text,
   ZIP               int,
 primary key(addressID)
 );
 
 ----Genre--
CREATE TABLE Genre ( 
   GenreID   varchar(4),
   GenreName text,
 primary key(GenreID)
);

 --OrderStatus
 CREATE TABLE OrderStatus ( 
   StatusID     varchar(4) ,
   Status       text,
 primary key(StatusID)
);

 --OrderFill
 CREATE TABLE OrderFill ( 
   OID         varchar(4) ,
   ISBN        varchar(13) not null,
 primary key(OID,ISBN)
);

 --Orders
 CREATE TABLE Orders ( 
   OID         varchar(4) ,
   CID         int references customers(pid),
   EID         int references employees(pid),
   AddressID   varchar(3), 
   StatusID    text,
   DateOrdered date,
 primary key(OID)
);

 --Customers
 CREATE TABLE Customers ( 
   PID         int references people(pid),
   paymenttype text,
   email       text, 
 primary key(PID)
);

-- CREATE VIEWS
--BOOKWSWITHAUTHORS
create view bookswithauthors
as 
select p.firstname, p.lastname
from bookauthor ba inner join authors a on ba.aid=a.pid
                   inner join books b on ba.isbn = b.isbn
				   inner join people p on p.pid=ba.aid;
				   
-- customers in New York
create view customersNY
as 
select o.cid, o.addressid, a.street, a.city, a.state, a.zip 
from orders o inner join address a on o.addressid=a.addressid
where state = 'NY';

--EMPLOYEENAMES
create view employeenames
as 
select p.firstname, p.lastname, p.pid
from employees e inner join people p on e.pid = p.pid;

-- People --
INSERT INTO People (pid, firstName, lastName)
VALUES
 (001, 'Taylor',      'Jenkins-Reid'),
 (002, 'Hanya',       'Yanagihara'),
 (003, 'Colleen',     'Hoover'),
 (004, 'Gabriel',     'Garcia-Marquez'),
 (005, 'Dalai',       'Lama'),
 (006, 'Delia',       'Owens'),
 (007, 'Paulo',       'Coelho'),
 (008, 'Zakiya',      'Dalila-Harris'),
 (009, 'Gabriella',   'Nina'),
 (010, 'Mya',         'Fernandez'),
 (011, 'Bria',        'Royer'),
 (014, 'Alan',        'Labouseur'),
 (013, 'Booke',       'David'),
 (012, 'Wilfredo',    'Nina'),
 (015, 'Angelina',    'Chirichella'),
 (016, 'Nathan',      'Scott'),
 (017, 'Karen',       'Roe'),
 (018, 'Karin',       'Yannes')
 ;
 
----Language--
CREATE TABLE Language ( 
   languageID   varchar(5),
   languageName text,
 primary key(languageID)
);

-- Authors --
INSERT INTO Authors(pid,DOB)
VALUES
 (001, '1983-12-20'),
 (002, '1974-09-20' ),
 (003, '1979-12-11'),
 (004, '1927-03-06'),
 (005, '1935-07-06'),
 (006, '1949-04-04'),
 (007, '1947-08-24'),
 (008, '1992-01-01');


-- Employees --
INSERT INTO Employees(pid,wageUSD)
VALUES
 (015, 15.00),
 (016, 15.00),
 (017, 17.00),
 (018, 15.00);

-- INSERT INTO TABLES
INSERT INTO Books(ISBN, title, priceUSD, languageid, Pages, PublisherID, PublishDate, genreID)
VALUES
 (9781501161933, 'The Seven Husbands of Evelyn Hugo', 17.00, 'L0001', 400, 'pub1', '2018-05-29','gfic'),
 (9780804172707, 'A Little Life',                     18.00, 'L0001', 832, 'pub2', '2016-01-28','gfic'),
 (9781501110368, 'It Ends with Us',                   16.99, 'L0001', 384, 'pub3', '2016-08-02','grom'),
 (9780307474728, 'Cien Años de Soledad',              17.00, 'L0002', 496, 'pub4', '2009-09-22','gmag'),
 (9781573228831, 'Ethics for the New Millennium',     16.00, 'L0001', 256, 'pub5', '2001-05-01','grel'),
 (9780735219106, 'Where the Crawdads Sing',           18.00, 'L0001', 400, 'pub6', '2021-03-30','gifc'),
 (9780062315007, 'The Alchemist',                     16.99, 'L0001', 108, 'pub7', '2014-04-15','gfan'),
 (9781982160135, 'The Other Black Girl',              27.00, 'L0001', 368, 'pub3', '2021-06-01','gfic'),
 (9781538724736, 'Verity',                            16.99, 'L0001', 336, 'pub8', '2021-09-26','gthr');
 

INSERT INTO BookAuthor(aid, ISBN)
VALUES
 (001,9781501161933),
 (002,9780804172707),
 (003,9781501110368),
 (004,9780307474728),
 (005,9781573228831),
 (006,9780735219106),
 (007,9780062315007),
 (008,9781982160135),
 (003,9781538724736);



INSERT INTO Language(languageID, languageName)
VALUES
 ('L0001','English'),
 ('L0002','Spanish');


INSERT INTO Genre(GenreID, GenreName)
VALUES
 ('gfic','Fiction'),
 ('grom','Romance'),
 ('grel','Religion'),
 ('gmag','Magical Realism'),
 ('gfan','Fantasy'),
 ('gthr','Thriller');



----Publisher--
CREATE TABLE Publisher ( 
   PublisherID   varchar(4),
   PublisherName text,
 primary key(PublisherID)
);

INSERT INTO Publisher(PublisherID, PublisherName)
VALUES
 ('pub1','Washington Square Press'),
 ('pub2','Anchor'),
 ('pub3','Atria Books'),
 ('pub4','Vintage Espanol'),
 ('pub5','Riverhead Books'),
 ('pub6','G.P. Putnams Sons'),
 ('pub7','HarperOne'),
 ('pub8','Grand Central Publishing');


 INSERT INTO Address(addressID, street, city, state, ZIP)
VALUES
 ('a09','8410 101st',    'Richmond Hill', 'NJ', 11418),
 ('a13','17 Sunset AVE', 'Lynbrook',      'NY', 11563),
 ('a14','209E 81st',     'New York',      'NY', 10028);
 
 

INSERT INTO Customers(PID, paymenttype, email)
VALUES
(9, 'ApplePay', 'gabriellanina@aol.com'),
(10,'Cash',     'myafernandez@yahoo.com'),
(11,'Credit',   'briaroyer45@gmail.com'),
(12,'Cash',     'alanlabouseur34@gmail.com'),
(13,'ApplePay', 'Brookedavis87@aol.com'),
(14,'Credit',   'Wilfredonina@yahoo.com');



INSERT INTO Orders(OID, CID, EID, AddressID, StatusID, DateOrdered)
VALUES
('o001','9',  '15', 'a09', 'S', '2022-05-01'),
('o002','14', '17', 'a14', 'R', '2022-02-05'),
('o004','12', '16', 'a13', 'D', '2022-03-09');


INSERT INTO orderfill(OID, ISBN)
VALUES
('o001','9780062452993'),
('o002','9780307474728'),
('o003','9780062315007'),
('o004','9781501110368'),
('o004','9780804172707')
;


INSERT INTO orderstatus(StatusID, Status)
VALUES
('D','Delivered'),
('P','Processing'),
('S','Shipped')
;


SELECT p.publishername, count(distinct b.isbn) as publishersum
FROM books b inner join publisher p on b.publisherid=p.publisherid
GROUP BY p.publishername
ORDER BY "publishersum" DESC
LIMIT 1;

SELECT o.eid 
FROM orders o inner join employees e on o.eid=e.pid 
			  inner join people p on o.cid = p.pid
WHERE firstname = 'Alan';


SELECT b.title
FROM orders o inner join orderfill of on o.oid = of.oid
              inner join people p on p.pid = o.cid
			  inner join books b on b.isbn = of.isbn
WHERE firstname = 'Wilfredo' and lastname ='Nina'
GROUP BY b.title;

--- stored procedures
CREATE OR REPLACE FUNCTION searchBook(TEXT, REFCURSOR) RETURNS refcursor AS
$$
DECLARE
searchFirst TEXT := $1;
resultSet REFCURSOR := $2;
BEGIN
OPEN resultset FOR
 SELECT *
 FROM books
 WHERE searchFirst = title;
return resultSet;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION howmanypages(TEXT,  REFCURSOR) RETURNS refcursor AS
$$
DECLARE
searchFirst TEXT := $1;
resultSet REFCURSOR := $2;
BEGIN
OPEN resultset FOR
 SELECT pages
 FROM books
 WHERE searchFirst = title;
return resultSet;
end;
$$
LANGUAGE plpgsql;

SELECT howmanypages('Cien Años de Soledad', 'results');
FETCH ALL FROM results;

				   
				   			   

CREATE OR REPLACE FUNCTION bookswrittenby(TEXT, TEXT, REFCURSOR) RETURNS refcursor AS
$$
DECLARE
searchFirst TEXT := $1;
searchLast TEXT := $2;
resultSet REFCURSOR := $3;
BEGIN
OPEN resultset FOR
 SELECT *
 FROM bookswithauthors
 WHERE firstname = searchFirst
 AND lastname = searchLast;
return resultSet;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION ValidatePeople()
RETURNS TRIGGER AS
$$
BEGIN
IF NEW.firstName IS NULL THEN
RAISE EXCEPTION 'firstName may not be NULL';
END IF;
IF NEW.lastName IS NULL THEN
RAISE EXCEPTION 'lastName may not be NULL';
END IF;
RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER validPeople
BEFORE INSERT OR UPDATE ON People
FOR EACH ROW
EXECUTE PROCEDURE ValidatePeople();




CREATE OR REPLACE FUNCTION ValidateBook()
RETURNS TRIGGER AS
$$
BEGIN
IF NEW.title IS NULL THEN
RAISE EXCEPTION 'You must enter the title of the book';
END IF;
RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER validbook
BEFORE INSERT OR UPDATE ON Books
FOR EACH ROW
EXECUTE PROCEDURE ValidateBook();

INSERT INTO Books(ISBN, title, priceUSD, languageid, Pages, PublisherID, PublishDate, genreID)
VALUES(9780307389732, NULL , 16.95, 'L0001', 368, 'pub4', '2007-10-05','gfic');



--SECURITY 

CREATE ROLE owner;
GRANT ALL ON ALL TABLES IN SCHEMA PUBLIC TO owner;

CREATE ROLE mangers;
grant SELECT, INSERT, UPDATE, DELETE on address to managers;
grant SELECT, INSERT, UPDATE, DELETE on bookauthor to managers;
grant SELECT, INSERT, UPDATE, DELETE on authors to managers;
grant SELECT, INSERT, UPDATE, DELETE on books to managers;
grant SELECT, INSERT, UPDATE, DELETE on orders to managers;
grant SELECT, INSERT, UPDATE, DELETE on customers to managers;
grant SELECT, INSERT, UPDATE, DELETE on genre to managers;
grant SELECT, INSERT, UPDATE, DELETE on language to managers;
grant SELECT, INSERT, UPDATE, DELETE on orderfill to managers;
grant SELECT, INSERT, UPDATE, DELETE on orderstatus to managers;
grant SELECT, INSERT, UPDATE, DELETE on people to managers;
grant SELECT, INSERT, UPDATE, DELETE on publisher to managers;
grant SELECT, on employees to managers;