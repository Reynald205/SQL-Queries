/* Test for unmatched records.
What needs to be done with them?
What needs to be done first (real world?) */

select custname, c.custnum, s.custnum, ordnum,
	s.partnum, t.partnum, bktitle
from Sales as s
	left join Customers as c
		on s.custnum = c.custnum
	left join Titles as t
		on s.partnum = t.partnum
	left join slspers as r
		on r.repid = s.repid
where c.custnum is null
	or t.partnum is null;


--Remove the unmatched records

delete sales where ordnum in (00199,00200);