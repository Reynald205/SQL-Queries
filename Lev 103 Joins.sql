--01*****
use ogcPubLev1

--02*****
--inner join

select c.custnum, custname, ordnum, sldate
from Customers as c
inner join Sales as s on s.custnum = C.custnum

--03*****
--multiple inner joins

select c.custnum, custname, ordnum, sldate, t.partnum, bktitle
from Customers as c
inner join Sales as s on s.custnum = C.custnum
inner join Titles as t on s.partnum = t.partnum

---04*****continued
--alternate technique uses where clause for the inner join

select * 
from Customers as c, sales as s, titles as t 
where c.custnum = s.custnum and s.partnum = t.partnum

--5*****
--union join

select* from Titles
union
select* from obsolete_Titles

--6A*****

select*,'Current' as Table from Titles
union
select*,'Obsolete' as Table from obsolete_Titles

--6B*****

select*,'Current' as [Table] from Titles
union
select*,'Obsolete' as [Table] from obsolete_Titles

--7A*****
--union join

select* from Titles
union
select* from Titles

--won't include dupes

--7B*****
--union all join

select* from Titles
union all
select* from Titles

--will include dupes
