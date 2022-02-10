-- 1. List the order number and total dollars of all orders.
Select ordernum, totalusd
from orders; 

-- 2. List the last name and home city of people whose prefix is "Ms.".
Select lastName, homecity
from people
where prefix = 'Ms.';

-- 3. List id, name, and quantity on hand of products with quantity more than 1007.
select prodid, name, qtyonhand
from products
where qtyonhand > 1007;

-- 4. List the First name and home city of people born in the 1920s.
Select firstname, homecity
from people
where extract(year from dob) >= 1920 
	and extract(year from dob) < 1930;

-- 5. List the prefix and last name of people who are not "Mr.".
Select prefix, lastname
from people
where prefix != 'Mr.';

-- 6. List all fields for products in neither Dallas nor Duluth that cost US$3 or less.
select *
from products
where city != 'Dallas' 
	and city != 'Duluth' 
	and priceusd <= 3.00;

-- 7. List all fields for orders in January.
select *
from orders 
where extract(month from dateordered) = '1';

-- 8. List all fields for orders in February of US$23,000 or more.
select *
from orders
where extract(month from dateordered) ='2' 
	and totalusd >= 23000;

-- 9. List all orders from the customer whose id is 007.
select *
from orders 
where custid = '007';

-- 10. List all orders from the customer whose id is 005.
select *
from orders 
where custid = '005';

