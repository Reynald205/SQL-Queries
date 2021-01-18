use ogcPubLev1

--simple function, single field
select COUNT(custnum) as CountofCustomers
from Customers

select COUNT(state) as CountofStates
from Customers

select COUNT(referredby) as CountofCustomers
from Customers

select city, COUNT(state) as 'Countof?'
from Customers
group by city
with cube
having COUNT(state)>1 

select
	custname,
	SUM(qty)as SumQTY,
	MAX(qty)as MaxQty,
	MIN(qty)as MinQTY,
	AVG(qty)as AvgQTY,
	Count(qty)as CountQTY
from Sales as s
inner join Titles as t on s.partnum = t.partnum
inner join Customers as c on s.custnum = c.custnum
group by custname
having SUM(qty)<> 0
order by custname

select distinct
	custname, qty	
from 
	Sales , Customers
where 
	sales.custnum = Customers.custnum
order by
	custname