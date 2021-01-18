use ogcPubLev1 -- Defines database

SELECT * FROM customers --The * symbol means every field.
where state ='NY'       --Filters records for NY

select city, custname, state
from customers
where state = 'ny' or state ='NJ'
order by 3, 1            --Numbers represent order of fields in select statement

select state, COUNT(custnum)
from Customers
where state like 'N%'
group by state 
order by 2 desc 

select state, COUNT(custnum)
from Customers
where state like 'N%'       --Where for incoming records
group by state
having Count(custnum)>1     --Having for manipulated records
order by COUNT(custnum)desc

select Sales.custnum, state, qty
from Customers
inner join Sales on Customers.custnum = Sales.custnum

select count(Customers.custnum), state, sum(qty)
from Customers inner join Sales on sales.custnum = Customers.custnum
where state like 'N%'
group by state
having COUNT(Customers.custname) >7
order by sum(qty) desc 

--Lab 1***********
select custnum, custname, city, state, Customers.repid, fname, lname
from Customers inner join Slspers on Customers.repid = Slspers.repid
where state = 'CA'
order by custname desc