use ogcPubLev1
 -- Inner Joins
select c.custnum, custname, ordnum, sldate
from customers as c
inner join Sales as s on s.custnum = c.custnum

--multiple inner joins
select c.custnum, custname, ordnum, sldate, t.partnum, bktitle
from customers as c
inner join Sales as s on s.custnum = c.custnum
inner join Titles as t on s.partnum = t.partnum

--Alernate method
Select *
from customers as c, Sales as s,Titles as t
where s.custnum = c.custnum and s.partnum = t.partnum

--Inner not needed
select c.custnum, custname, ordnum, sldate, t.partnum, bktitle
from customers as c
join Sales as s on s.custnum = c.custnum
join Titles as t on s.partnum = t.partnum

--Union Joins
select * from Titles 
union --removes dupes
select * from Obsolete_Titles

select * from Titles 
union all --Displays dupes
select * from Titles

select * from Titles 
intersect
select * from Obsolete_Titles

select * from Titles 
union all
select * from Obsolete_Titles
where bktitle like 'clear cu%'
order by bktitle

select *, 'Current' as [Table] from Titles 
union 
select *, 'Obsolete' as "Table" from Obsolete_Titles

Select *
from customers as c, Sales as s,Titles as t
where s.custnum = c.custnum and s.partnum = t.partnum and state like 'n%'