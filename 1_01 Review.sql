--Review

--01*****Defines Database to use

use ogcPubLev2

--02*****selects all fields / 25 records

select * from Customers

--03*****filters records / 6 records

select Custname, City, State
from Customers
where state = 'NY'

--04*****filters with multiple criteria and sorts / 2 records

select Custname, City, State
from Customers
where state = 'NY' and city = 'Rochester' or state = 'CA' and City = 'Santa Ana'
Order by state asc

--05*****groups and summarizes (aggregates) / in operator / 3 records

select state, COUNT(custnum)
from Customers
where state in ('TX', 'CA', 'Ny')
Group by state

--06*****alias / 3 records

select state, COUNT(custnum) as CountOfCusts
from Customers
where state in ('TX','CA', 'Ny')
Group by state
order by COUNT(custnum) desc

--07*****having (filter aggregates) / sort by alias / 2 records

select state, COUNT(custnum) as CountOfCusts
from Customers
where state in ('TX','CA', 'Ny')
Group by state
having COUNT(custnum) > 3
order by CountOfCusts desc

--08*****inner join / table aliases / 99 records

select bktitle, t.partnum, qty
from titles as t
inner join Sales as s on t.partnum = s.partnum

--09*****left outer joins / 136 records

select bktitle, t.partnum, qty
from titles as t
left outer join Sales as s on t.partnum = s.partnum

--10*****right outer joins / 100 records

select bktitle, t.partnum, qty
from titles as t
right outer join Sales as s on t.partnum = s.partnum