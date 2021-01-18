--01*****
use ogcPubLev1

--01
select lname, sales.repid, count(ordnum), sum(qty)
from sales inner join slspers
on Slspers.repid = Sales.repid
group by lname, sales.repid

--Note missing field names

--02
--Alias for Aggregate Function Fields
--Use underscore to connect multiple words

select lname, sales.repid, 
	count(ordnum)as Count_Orders, 
	sum(qty)as Sum_Qty
from sales inner join slspers
on Slspers.repid = Sales.repid
group by lname, sales.repid

--03
--Alias for Fields and Tables

select lname, s.repid, 
	count(ordnum)as Count_Orders, 
	sum(qty)as Sum_Qty
from sales as s inner join slspers as r
on r.repid = s.repid
group by lname, s.repid

--04*****
--Aliases / note multiple methods

select	
	bktitle as Book,
	t.partnum as Book_ID,
	ordnum as Order#, --some special characters ok
	sldate as "Date of Sale", --use double quotes
	Cust_# = custnum, --reverse order requires "="
	qty Quantity, --"as" not required
	slprice SRP, 
	slprice*.75 'Sale Price', --use single quotes
	repid SalesRep
from Titles as t
	inner join Sales s
	on t.partnum =s.partnum 
order by Book

--05*****
--creative use of aliases
--creates non existing field for printout

select *, '[__________]' as Enter_Current_Inventory   
from titles

--Lab 1*****
--from the customers table count the number of California's 
--and  Washington's Customers and name the field:
-------"count of West Coast Customers"

---Lab Result*****
select state, COUNT(custnum) as 'Count of West Coast Customers'
from Customers
where state ='CA' or state ='WA'
group by state