--01*****001 Basics All Clauses

use ogcPubLev1 --defines database

--02*****
--Select/From

select* from customers 

--the select clause brings in the fields, 
--the asterix indicates all fields

--03*****
--Select/From
--selects specified fields, 
--spaces not required, 
--trailing comma not allowed

select custname,city, state 
from Customers

--04*****
--Select/From/Where

select city,custname,state
from Customers
where state = 'NY' --filters records for NY

--05*****
--Select/From/Where/Order By

select city,custname,state
from Customers
where state = 'NY' or state = 'NJ'
order by city asc, custname desc
 
--alternate sorting technique
--	order by 1 asc, 2 desc
--sort ascending (asc) is default, not required

--06*****
--Select/From/Where/Group By

select state, COUNT(custnum) 
from customers 
where state like 'N%' 
group by state

--07*****
--All major clauses in proper sequence
--Select/From/Where/Group By/Order By/Having/Order By

select state, COUNT(custnum)
from customers 
where state like 'N%' 
group by state
having COUNT(custnum) > 1
order by COUNT(custnum) desc

--08*****
--Adding a JOIN to the FROM clause
--inner join indicates only records that have matches in both tables
--if selected field name exists in both tables, 
--it requires the appropriate table name followed by a period

select customers.custnum, State, qty
from Customers
inner join Sales on Customers.custnum = Sales.custnum 

--joined tables require table name followed by a 
--period and the common field to both tables

--09*****
--Putting it all together

select count(customers.custnum), State, sum(qty)
from Customers
inner join Sales on sales.custnum = Customers.custnum 
where state like 'N%' 
group by state
having COUNT(customers.custnum) > 7
order by sum(qty)desc

--Lab 1*****
--Using 2 tables: Customers and  Slspers (Sales Persons)
--Display following fields:
-----Customer Number
-----Customer Name
-----customers' City
-----customers' State
-----the assigned sales rep's ID
-----the sales rep's first and last name
-----show only the records for the California customers
-----sort by custer name in descending fashion

--Lab Result*****

select Custnum, Custname, city, state, Customers.repid, fname, lname
from Customers
inner join Slspers on Customers.repid = Slspers.repid
where state = 'CA'
order by custname desc