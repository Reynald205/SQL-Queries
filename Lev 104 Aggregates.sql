--01*****
use ogcPubLev1

--02*****
--simple aggregate function, single field 

select COUNT(custnum)as CountOfCustomers
from customers

--03*****
--simple aggregate function, 
--plus non aggregated field

select state, COUNT(custnum)as CountOfCustomers
from customers

--03A*****
--simple aggregate function, 
--plus non aggregated field grouped

select state, COUNT(custnum)as CountOfCustomers
from customers
group by state

--03B*****
--simple aggregate function, 
--plus non aggregated field grouped
--and with grand total

select state, COUNT(custnum)as CountOfCustomers
from customers
group by state
with cube --grand total

--03C*****
--simple aggregate function, 
--plus non aggregated field grouped
--and with grand total 
--and filtered

select state, COUNT(custnum)as CountOfCustomers
from customers
group by state
with cube
having COUNT(custnum) > 1

--Lab 1*****Whats wrong with previous cube?
--analyze results and explain why this occurs

--04*****
--Five aggregate functions, grouped by 2 fields

select
	state, 
	ordnum,
	SUM(qty)as SumQty,
	MAX(qty) as MaxQty,
	MIN(qty)as MinQty,
	AVG(qty) as AvgQty,
	Count(qty)as CountQty
from Sales as s
inner join Titles as t on s.partnum = t.partnum
inner join Customers as c on s.custnum = c.custnum
group by state, ordnum
having SUM(qty) <> 0
order by state, ordnum

--Lab 2*****Whats wrong with previous qry?
--analyze results and explain how this can be corrected

--Lab 2 Solution*****

select
	state, 
	SUM(qty)as SumQty,
	MAX(qty) as MaxQty,
	MIN(qty)as MinQty,
	AVG(qty) as AvgQty,
	Count(qty)as CountQty
from Sales as s
inner join Titles as t on s.partnum = t.partnum
inner join Customers as c on s.custnum = c.custnum
group by state
having SUM(qty) <> 0
order by state


--********************************************************************************
--Distinct, similar Concept to grouping
--11*****Note record count

select 
	custname
from 
	sales, customers
where 
	Sales.custnum = Customers.custnum
order by
	custname

--11A*****
--add distinct / note record count

select
	distinct custname
from 
	sales, customers
where 
	Sales.custnum = Customers.custnum
order by
	custname
	
--11B 
--add qty / note record count / explain difference

select
	distinct custname, qty
from 
	sales, customers
where 
	Sales.custnum = Customers.custnum
order by
	custname

--********************************************************************************
--Deprecated in 2012, removed in 2014
--Alternate summary method using "Compute By"

SELECT c.custnum, custname, ordnum, qty
from Sales as s
inner join Titles as t
on s.partnum=t.partnum
inner join Customers as c
on s.custnum=c.custnum
ORDER BY custname
COMPUTE SUM(qty)  by custname


--********************************************************************************
--Lab 3*****
--How much money did each customer generate in total sales
--aggregate function performed on a calculation 

select
	Custname, 
	ordnum,
	SUM(qty*slprice)as Customer_Total
from Sales as s
inner join Titles as t on s.partnum = t.partnum
inner join Customers as c on s.custnum = c.custnum
where qty <> 0
group by Custname, ordnum
order by custname, ordnum

--*****Whats wrong with previous qry and how do we fix it
--*****It creates order summaries rather than customer summaries

--Lab 3 Solution*****

select
	Custname, 
	SUM(qty*slprice)as Order_Total
from Sales as s
inner join Titles as t on s.partnum = t.partnum
inner join Customers as c on s.custnum = c.custnum
where qty <> 0
group by Custname
order by custname

--when using the group by clause, less is actually more
--only display fields that you truly need