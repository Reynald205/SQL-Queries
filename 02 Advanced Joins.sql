--Advanced Joins

use ogcPubLev2

--02*****
--inner join

select c.custnum, custname, ordnum, sldate
from Customers as c
inner join Sales as s on s.custnum = C.custnum

--03*****
--left outer join

select c.custnum, custname, ordnum
from Customers as c
left outer join Sales as s on s.custnum = C.custnum

--03A*****continued

select c.custnum, custname, ordnum
from Customers as c
left outer join Sales as s on s.custnum = C.custnum
where ordnum is null --these are the customers without orders
order by custname

--04*****
--right outer join

select c.custnum, custname, ordnum
from Customers as c
right outer join Sales as s on s.custnum = C.custnum

--04A*****continued

select c.custnum, custname, ordnum
from Customers as c
right outer join Sales as s on s.custnum = C.custnum
where c.custnum is null --there are 2 orders without customers

--05*****
--full outer join

select c.custnum, custname, ordnum
from Customers as c
full outer join Sales as s on s.custnum = C.custnum

--this shows all orders for customers that have orders
--also shows all customers even without orders
--also shows any orders that do not have customers attached
--108 records

--Lab 1*****
/*Show the inequalities between the Customers, Sales and Titles tables
  display all the relevant fields: ID Numbers, Names, etc 
  show IDs from the Sales Table but Names from their respective tables
  Interpret the results ie:  
	Which are the books that have not sold?
	Who are the customers that have not bought anything?
	Which orders are written for non existant customers?*/

--Lab Result***** 

select custname, c.custnum, s.Custnum, ordnum, s.partnum, t.partnum, bktitle
from sales as s
full outer join Customers as c on c.custnum = s.custnum
full outer join Titles as t on t.partnum = s.partnum

--06*****
--self join

select c1.custnum, c1.custname, c1.referredby, c2.custname, c2.custnum
from Customers as c1
inner join Customers as c2 on c1.referredby = c2.custnum
order by c2.custname
--18 customers out of 25 were referred by other customers
--try with left, right, and full outer joins	

--06A*****
--taken out to ridiculus lengths
select c.custnum, c.custname, c.referredby, 
		c1.custnum, c1.custname, c1.referredby,
		c2.custnum, c2.custname, c2.referredby,
		c3.custnum, c3.custname, c3.referredby,
		c4.custnum, c4.custname, c4.referredby,
		c5.custnum, c5.custname, c5.referredby,
		c6.custnum, c6.custname, c6.referredby						
from Customers as c
inner join Customers as c1 on c.referredby = c1.custnum
inner join Customers as c2 on c1.referredby = c2.custnum
inner join Customers as c3 on c2.referredby = c3.custnum
inner join Customers as c4 on c3.referredby = c4.custnum
inner join Customers as c5 on c4.referredby = c5.custnum
inner join Customers as c6 on c5.referredby = c6.custnum

--7*****
--cross join(cartesian join)

select c.custnum, custname, ordnum, sldate
from Customers as c
cross join Sales as s 

--8*****
--Intersect (common to both tables)

select bktitle from titles
intersect
select bktitle from obsolete_titles

--9*****
--Except (all from 1st that are not in 2nd)

select * from obsolete_titles
except
select * from titles
 
/*beware that 'Y2K *' has comma in second and 
Clear Cupboards has different pubdate*/
					 
--**************************************************************************					
--OPTIONAL
--**************************************************************************

/*Proof that outer joins are positional
not based on "one to many" relationships.
Single "one to many" scenario*/

--only customers with orders
	
select * from customers as c
	inner join Sales as s on c.custnum = s.custnum
	
	--98 records

--all customers with or without matching orders	

select * from customers as c --customer 1st, sales 2nd
	left join Sales as s on c.custnum = s.custnum
	
	--106 records Customers 1st Sales 2nd

select * from Sales as s --sales 1st, customer 2nd
	right join Customers as c on c.custnum = s.custnum
	
	--106 records
	
--all orders with or without matching customers

select * from customers as c --customer 1st, sales 2nd
	right join Sales as s on c.custnum = s.custnum
	
	--100 records
	
select * from Sales as s --sales 1st, customer 2nd
	left join customers as c on c.custnum = s.custnum
	
	--100 records
	
--**************************************************************************				 
--OPTIONAL
--**************************************************************************

/*comparison of all right, left & full outer join
permutations in a "many to many" scenario
Note different record counts*/

--1

select * from Customers as c
left join Sales as s on s.custnum = c.custnum
left join Titles as t on t.partnum = s.partnum

--106 records

--2

select * from Customers as c
left join Sales as s on s.custnum = c.custnum
right join Titles as t on t.partnum = s.partnum

--135 records

--3

select * from Customers as c
right join Sales as s on s.custnum = c.custnum
left join Titles as t on t.partnum = s.partnum

--100 records

--4

select * from Customers as c
right join Sales as s on s.custnum = c.custnum
right join Titles as t on t.partnum = s.partnum

--136 records

--5

select * from Customers as c
left join Sales as s on s.custnum = c.custnum
full join Titles as t on t.partnum = s.partnum

--143 records

--6

select * from Customers as c
right join Sales as s on s.custnum = c.custnum
full join Titles as t on t.partnum = s.partnum

--137 records

--7

select * from Customers as c
full join Sales as s on s.custnum = c.custnum
left join Titles as t on t.partnum = s.partnum

--108 records

--8

select * from Customers as c
full join Sales as s on s.custnum = c.custnum
right join Titles as t on t.partnum = s.partnum

--136 records

--9

select * from Customers as c
full join Sales as s on s.custnum = c.custnum
full join Titles as t on t.partnum = s.partnum

--145 records