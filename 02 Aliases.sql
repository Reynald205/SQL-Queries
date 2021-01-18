use ogcPubLev1

select lname, sales.repid, COUNT(ordnum),sum(qty)
from sales inner join Slspers
on Sales.repid = Slspers.repid
group by lname, Sales.repid

--Alias for Aggerate Function fields using the "as" keyword.
select lname, sales.repid, 
	COUNT(ordnum) as Count_Orders,
	sum(qty) as Sum_Qty
from sales inner join Slspers
on Sales.repid = Slspers.repid
group by lname, Sales.repid

select lname, s.repid, 
	COUNT(ordnum) as Count_Orders,
	sum(qty) as Sum_Qty
from sales as s inner join Slspers as r --Using "as" to substitute field names in case its too long
on s.repid = r.repid
group by lname, s.repid

select -- Alias types
	bktitle as Book,
	t.partnum as Book_ID,
	ordnum as Order#,
	sldate as "Date of Sale",
	Cust_# = custnum,
	qty Quantity,
	slprice*.75 'Sale Price',
	repid SalesRep
from Titles as t inner join Sales s 
on t.partnum = s.partnum
order by Book

select *, '[_____________]' as Enter_Current_Inventory
from Titles

--Lab 1
Select state, COUNT(custnum) as "Count of West Coast Customers"
from Customers
where state = 'CA' or state = 'WA'
group by state