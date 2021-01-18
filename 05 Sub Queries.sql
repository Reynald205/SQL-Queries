--Sub Queries

use ogcPubLev2 

--Lesson 01*****
/*filtering for orders with quantities greater than the 
overall average - 1st identify average quantity sold*/

select AVG(qty) from Sales 
--result 205 avg quantity


--finds all sales data based on the average

select 
     custname, c.custnum, ordnum, 
     s.partnum, bktitle, qty 
from Sales as s 
     inner join Customers as c 
        on s.custnum = c.custnum
     inner join Titles as t 
        on s.partnum = t.partnum
where qty > 205
order by qty desc
--result 32 records
--value entered manually and won't update as data changes


/*use subquery to combine both previous 
queries into one simplfied statement*/

select 
    ordnum, custnum, partnum, 
    qty as QtysGreaterThanAvg 
from Sales
where qty > (select AVG(qty) from Sales)
order by qty
--result 33 records
--average updates automatically but still lacks clarity


--insert the subquery into the select clause also 
select 
    ordnum, custnum, partnum, 
    (select AVG(qty) from Sales) as AvgQty,
    qty as QtysGreaterThanAvg 
from Sales
where qty > (select AVG(qty) from Sales)
order by qty
--result 33 records
/*average updates automatically and is also visible 
for sake of clarity but names and titles are not*/


select 
    custname, c.custnum, ordnum, s.partnum, bktitle,
	qty as QtysGreaterThanAvg,
	(select AVG(qty) from Sales)as AvgQty 
from Sales as s 
    inner join Customers as c 
         on s.custnum = c.custnum
    inner join Titles as t 
         on s.partnum = t.partnum
where qty > (select AVG(qty) from Sales) 
order by qty desc
--result 32 records
--joins still required to display extra fields

--*******************************************************************************

--Lesson 02*****
/*Filtering for books that are selling versus those that aren't.
This compares lists from 2 different tbls and returns the matches.
Sold books / use the 'in' operator*/

select partnum, bktitle 
from Titles
where partnum in(select partnum from Sales)
--55 records

--unsold books / use the 'not in' operator
select partnum, bktitle
from Titles
where partnum not in(select partnum from Sales)
--37 records

--*******************************************************************************

--Lesson 03*****
/*target customers for sales blitz, who have 
previously bought books for price >= $35
Multi Level Subqrys*/

select custnum, custname, address, city
from Customers
where custnum in
(
select custnum
from Sales
where partnum in
(
select partnum
from Titles
where slprice>35
)
)
order by custname asc
--10 records

--the following format is easier to read in my opinion

select custnum, custname, address, city
from Customers
where custnum in(select custnum
				 from Sales
				 where partnum in(select partnum
								  from Titles
								  where slprice>35))
order by custname asc

--using inner join method versus sub qry create 
--same results as lesson

select distinct
c.custnum, Custname, address, city, max(slprice) as BkPrice
from Customers as c
inner join Sales as s on c.custnum = s.custnum
inner join Titles as t on s.partnum = t.partnum
group by c.custnum, custname, address, city
having MAX(slprice)>=35
order by custname asc 
--10 records

--*******************************************************************************

--Lesson 04*****
/*Understanding 'Exists' versus 'In' subqueries*/


--'IN'
select custname,custnum from customers 
where custnum in --fld name required
  (select custnum from Sales)
order by custname
--17 Records (actual) - GOOD

--'Exists'
select custname, custnum from customers 
where exists --fld name not allowed
  (select * from Sales)
order by custname
--25 Records (no filter / all from outer) - NOT GOOD

--'Exists'
select custname, custnum from customers 
where custnum = 8864 and exists
  (select * from Sales)
order by custname
--1 Record (prefiltered on outer) - GOOD

--'Exists'
select custname, custnum from customers 
where exists
  (select * from Sales where custnum = 8864)
order by custname
--All Records (prefiltered on inner) - NOT GOOD

/*an 'exists' query only gives a true false 
result whereas the 'in' query returns the 
intersection of the outer and inner query*/

--*******************************************************************************

--Lesson 05*****
/* Any / All Operator*/


SELECT * FROM Titles
WHERE slprice < Any
	(SELECT slprice FROM Titles
	Where slprice between 30 and 40)
order by slprice

--> All: 18 records / has to be > than 40
--> Any: 45 records / could be only > than 30
--< All: 30 records / has to be < than 30
--< Any: 73 records	/ could be only < than 40

select * from Titles order by slprice --92 records