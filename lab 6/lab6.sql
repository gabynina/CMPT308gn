-- 1. Display the cities that makes the most different kinds of products. Experiment with the rank() function.
create view kopcities
as 
select rank() over (order by count(products.city) DESC) as kopcities, city, count(city) as Ccount 
from products
group by city;

select city
from kopcities
where kopcities = 1;

-- 2. Display the names of products whose priceUSD is less than the average priceUSD, in alphabetical order.
select name 
from products 
where priceusd < (select avg(priceusd)
				 from products)
order by name;

-- 3. Display the customer last name, product id ordered, and the totalUSD for all orders made in March of any year, sorted by totalUSD from high to low.
select p.lastname, o.prodid, o.totalusd
from people p inner join customers c on p.pid = c.pid
			  inner join orders o on c.pid = o.custid
where extract(month from o.dateordered) = '3'
order by o.totalusd DESC;

-- 4. Display the last name of all customers (in reverse alphabetical order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs.
select coalesce(p.lastname), sum(o.totalusd) as totalordered
from people p inner join customers c on p.pid =c.pid
			  inner join orders o on c.pid = o.custid
group by p.lastname 
order by p.lastname DESC;

-- 5. Display the names of all customers who bought products from agents based in Chilliwack along with the names of the products they ordered, and the names of the agents who sold it to them.
create view PeopleAgents
as
select p.*
from people p inner join agents a on p.pid = a.pid;

create view Chilliwackagents
as 
select *
from peopleagents
where homecity = 'Chilliwack';

create view PeopleCust
as
select p.*
from People p inner join Customers c on p.pid = c.pid;

select pc.firstname, pc.lastname, prod.name, ch.firstname, ch.lastname
from orders o inner join Chilliwackagents ch on o.agentid = ch.pid
			  inner join products prod on prod.prodid = o.prodid
      		  inner join peoplecust pc on pc.pid = o.custid;

-- 6. Write a query to check the accuracy of the totalUSD column in the Orders table. This means calculating Orders.totalUSD from data in other tables and comparing those values to the values in Orders.totalUSD. Display all rows in Orders where Orders.totalUSD is incorrect, if any. If there are any incorrect values, explain why they are wrong. Round to two decimal places.
select o.*
from orders o inner join products p on p.prodid = o.prodid
		      inner join customers c on c.pid = o.custid 
where o.totalusd != round(((100-c.discountpct)*.01)*(o.quantityordered * p.priceusd) ,2);

-- the totalusd is wrong for both orders
-- ordernum 1017 should be 32510
-- ordernum 1021 should be 67500

-- 7. Display the first and last name of all customers who are also agents.
select p.firstname, p.lastname
from people p inner join agents a on p.pid=a.pid
		      inner join customers c on a.pid =c.pid
where p.pid = c.pid
      and p.pid = a.pid;
-- 8. Create a VIEW of all Customer and People data called PeopleCustomers. Then another VIEW of all Agent and People data called PeopleAgents. Then "select *" from each of them to test them.
create view PeopleCustomers
as
select p.*
from People p inner join Customers c on p.pid = c.pid;

create view PeopleAgents
as
select p.*
from people p inner join agents a on p.pid = a.pid;

select * 
from PeopleAgents;

select *
from PeopleCustomers;
-- 9. Display the first and last name of all customers who are also agents, this time using the views you created.
select pc.firstname, pc.lastname
from PeopleAgents pa inner join PeopleCustomers pc on pa.pid =pc.pid;

-- 10. Compare your SQL in #7 (no views) and #9 (using views). The output is the same. How does that work? What is the database server doing internally when it processes the #9 query?
-- This works because views can be created the same way queries are. Since there have been no modifications to the CAP database tables the views are created the same. 
-- Internally people connects by a Hash to agents then with more hashing people and customers connect to that initial agents hash

