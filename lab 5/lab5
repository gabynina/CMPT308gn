-- 1. Show all the People data (and only people data) for people who are customers.
select p.pid, p.prefix, p.firstname, p.lastname, p.suffix, p.homecity, p.dob
from people p inner join Customers c on p.pid = c.pid;

-- 2. Show all the People data (and only the people data) for people who are agents. 
select p.pid, p.prefix, p.firstname, p.lastname, p.suffix, p.homecity, p.dob
from People p inner join Agents a on p.pid = a.pid;

-- 3. Show all People and Agent data for people who are both customers and agents. Use joins this time; no subqueries.
select p.pid, p.prefix, p.firstname, p.lastname, p.suffix, p.homecity, p.dob, a.pid, a.paymentterms, a.commissionpct 
from people p inner join customers c on p.pid = c.pid
		      inner join agents a on c.pid = a.pid;
			  
-- 4. Show the First name of customers who have never placed an order. Use subqueries.
select firstname
from people 
where pid in (select pid 
			  from customers 
			  where pid not in (select custid 
							   from orders));
							   
-- 5. Show the First name of customers who have never placed an order. Use one inner and one outer join.
select p.firstname
from people p inner join customers c on p.pid = c.pid 
			  left outer join orders o on c.pid = o.custid
where o.ordernum is null;

-- 6. Show the id and commission percent of Agents who booked an order for the Customer whose id is 008, sorted by commission percent from high to low. Use joins; no subqueries.
select distinct a.pid, a.commissionpct
from agents a inner join orders o on a.pid = o.agentid
		      left outer join customers c on o.agentid = c.pid
where o.custid = 008
order by commissionpct DESC;

-- 7. Show the last name, home city, and commission percent of Agents who booked an order for the customer whose id is 001, sorted by commission percent from high to low. Use joins.
select distinct p.lastname, p.homecity, a.commissionpct
from agents a inner join orders o on a.pid = o.agentid
			  inner join people p on o.agentid = p.pid
		      left outer join customers c on o.agentid = c.pid
			  
where o.custid = 001
order by commissionpct DESC;

-- 8. Show the last name and home city of customers who live in the city that makes the fewest different kinds of products. (Hint: Use count and group by on the Products table. You may need limit as well.)
select p.lastname, p.homecity, count(p.homecity) as "num ordered"
from people p inner join customers c on p.pid = c.pid
			  inner join orders o on c.pid = o.custid
			  left outer join products pr on p.homecity = pr.city
group by p.lastname, p.homecity
order by "num ordered" DESC
limit 1;

-- 9. Show the name and id of all Products ordered through any Agent who booked at least one order for a Customer in Arlington, sorted by product name from A to Z. You can use joins or subqueries. Better yet, do it both ways and impress me.
select pr.name, pr.prodid
from products pr inner join orders o on pr.prodid = o.prodid
				 inner join agents a on a.pid = o.agentid
				 inner join customers c on c.pid = o.custid
				 inner join people p on c.pid = p.pid
where homecity = 'Arlington'
order by name ASC; 

-- 10. Show the First and last name of customers and agents living in the same city, along with the name of their shared city. (Living in a city with yourself does not count, so exclude those from your results.)
select p1.firstname, p1.lastname, p1.homecity
from people p1 inner join people p2 on p1.homeCity=p2.homecity
where p1.firstname != p2.firstname
order by homecity;
