-- 1. Get all the People data for people who are customers.
select *
from people
where pid in (select pid from customers);

-- 2. Get all the People data for people who are agents.
select * 
from people
where pid in (select pid from agents);

-- 3. Get all of People data for people who are both customers and agents.
select * 
from people
where pid in (select pid from customers) 
	 and pid in (select pid from agents);

-- 4. Get all of People data for people who are neither customers nor agents.
select *
from people
where pid not in (select pid from customers) 
	 and pid not in (select pid from agents);
	 
-- 5. Get the ID of customers who ordered either product 'p01' or 'p03' (or both).
select custid
from orders 
where prodid in ('p01', 'p03');

-- 6. Get the ID of customers who ordered both products 'p01' and 'p03'. List the IDs in order from highest to lowest. Include each ID only once.
select pid
from customers 
where pid in (select custid 
			 from orders
			 where prodid ='p01') 
			 and pid in (select custid
						 from orders
						 where prodid ='p03')
						 order by pid DESC;

-- 7. Get the first and last names of agents who sold products 'p05' or 'p07' in order by last name from Z to A.
select firstname, lastname 
from people 
where exists(select *
			 from orders  
			 where prodid in ('p05', 'p07')
			 and orders.agentid=people.pid)
order by lastname DESC;
	
-- 8. Get the home city and birthday of agents booking an order for the customer whose pid is 008, sorted by home city from A to Z.
select homecity, dob
from people
where exists(select * 
		     from orders 
		     where custid = 008
		     and orders.agentid=people.pid)
order by homecity ASC;
		
-- 9. Get the unique ids of products ordered through any agent who takes at least one order from a customer in Montreal, sorted by id from highest to lowest.
select prodid 
from orders
where agentid in (select agentid 
				  from orders
				  where custid in (select pid
						           from people
						           where homecity = 'Montreal'))
order by prodid DESC;


-- 10. Get the last name and home city for all customers who place orders through agents in Chilliwack or New Orleans.
select lastname, homecity
from people
where pid in (select pid
			  from customers
			  where pid in (select custid
						    from orders
							where agentid in (select pid 
											  from people
											  where homecity in ('Chilliwack', 'New Orleans'))));
											  											  