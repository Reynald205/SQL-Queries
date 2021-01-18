use ogcPubLev2

select * from Customers

select custname, city, state
from Customers
where state = 'NY'

select custname, city, state
from Customers
where state = 'NY' and city = 'Rochester' or state ='CA' and city = 'Santa Ana'
order by 2 desc

select state, COUNT(custnum)
from Customers
where state in ('TX','CA','NY')
group by state
order by 2 

select state, COUNT(custnum)as CountofCusts
from Customers
where state in ('TX','CA','NY')
group by state
order by CountofCusts asc 

select state, COUNT(custnum)as CountofCusts
from Customers
where state in ('TX','CA','NY')
group by state
having COUNT(custnum) > 3
order by CountofCusts asc 

select bktitle, t.partnum
from Titles as t
inner join Sales as s on t.partnum = s.partnum
order by bktitle

select bktitle, partnum, qty
from Titles as t
inner join Sales as s on t.partnum = s.partnum
order by bktitle