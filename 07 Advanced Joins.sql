use ogcPubLev1

select c.custnum, ordnum, sldate 
from Customers as c
inner join Sales as s on s.custnum = c.custnum

select c.custnum, ordnum, sldate, t.bktitle,t.partnum 
from Customers as c
inner join Sales as s on s.custnum = c.custnum
inner join Titles as t on t.partnum = s.partnum

select c.custnum, ordnum, custname 
from Customers as c
left outer join Sales as s on s.custnum = c.custnum

select c.custnum,s.custnum, ordnum, custname 
from Customers as c
right outer join Sales as s on s.custnum = c.custnum
where c.custnum is null

