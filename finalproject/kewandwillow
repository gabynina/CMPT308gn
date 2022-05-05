-- People --
CREATE TABLE People (
   pid         int not null,
   firstName   text,
   lastName    text,
 primary key(pid)
);

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
 (012, 'Alan',        'Labouseur'),
 (013, 'Booke',       'David'),
 (014, 'Wilfredo',    'Nina'),
 (015, 'Angelina',    'Chirichella'),
 (016, 'Nathan',      'Scott'),
 (017, 'Karen',       'Roe'),
 (018, 'Karin',       'Yannes')
 ;

select *
from People;

--Authors--
CREATE TABLE Authors (
   pid         int not null,
   DOB         date,
 primary key(pid)
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

select * from authors;

--Employees--
CREATE TABLE Employees (
   pid         int not null,
   wageUSD     numeric(10,2),	
 primary key(pid)
);

-- Employees --
INSERT INTO Employees(pid,wageUSD)
VALUES
 (015, 15.00),
 (016, 15.00),
 (017, 17.00),
 (018, 15.00);
 
-- the people who are authors with joins
select * 
from people p inner join authors a on p.pid=a.pid;

--Books--
CREATE TABLE Books ( 
   IBSN         varchar(13) not null,
   title      	varchar(400),			
   priceUSD     numeric(10,2),
   language     text,
   pages        int,
   publisherID  char(4),
   PublishDate  date,					
 primary key(IBSN)
);

INSERT INTO Books(IBSN, title, priceUSD, language, Pages, PublisherID, PublishDate)
VALUES
 (9781501161933, 'The Seven Husbands of Evelyn Hugo', 17.00, 'English', 400, 'pub1', '2018-05-29'),
 (9780804172707, 'A Little Life',                     18.00, 'English', 832, 'pub2', '2016-01-28'),
 (9781501110368, 'It Ends with Us',                   16.99, 'English', 384, 'pub3', '2016-08-02'),
 (9780307474728, 'Cien Años de Soledad',              17.00, 'Spanish', 496, 'pub4', '2009-09-22'),
 (9781573228831, 'Ethics for the New Millennium',     16.00, 'English', 256, 'pub5', '2001-05-01'),
 (9780735219106, 'Where the Crawdads Sing',           18.00, 'English', 400, 'pub6', '2021-03-30'),
 (9780062315007, 'The Alchemist',                     16.99, 'English', 108, 'pub7', '2014-04-15'),
 (9781982160135, 'The Other Black Girl',              27.00, 'English', 368, 'pub3', '2021-06-01'),
 (9781538724736, 'Verity',                            16.99, 'English', 336, 'pub8', '2021-09-26');
 
 
--BookAuthor--
 CREATE TABLE BookAuthor (
   aid         int not null references Authors(pid),
   ISBN        varchar(13),	
 primary key(aid, ISBN)
 );

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

select* from bookauthor

select * 
from people p inner join bookauthor a on a.aid=p.pid;