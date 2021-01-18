--All Possible Permutations

use ogcPubLev1

--A  inner (only the GOOD stuff)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	inner join 
Sales as s on c.custnum = s.custnum
	inner join
Titles as t on t.partnum = s.partnum
	inner join
Slspers as r on r.repid = s.repid
--98 records

--***********************************************************************************************************************

--B  left outer (the GOOD and the BAD)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	left join 
Sales as s on c.custnum = s.custnum
	left join
Titles as t on t.partnum = s.partnum
	left join
Slspers as r on r.repid = s.repid
--106 records

--***********************************************************************************************************************

--B  left outer (NULLS only)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	left join 
Sales as s on c.custnum = s.custnum
	left join
Titles as t on t.partnum = s.partnum
	left join
Slspers as r on r.repid = s.repid
where
	c.custnum is null or
	s.custnum is null or
	s.ordnum is null or
	s.partnum is null or
	t.partnum is null or
	c.repid is null or
	s.repid is null or
	r.repid is null 
--8 records

--*********************************************************************************************************************

--C  right outer (the GOOD and the BAD)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	right join 
Sales as s on c.custnum = s.custnum
	right join
Titles as t on t.partnum = s.partnum
	right join
Slspers as r on r.repid = s.repid
--101 records

--***********************************************************************************************************************

--C  right outer (NULLS only)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	right join 
Sales as s on c.custnum = s.custnum
	right join
Titles as t on t.partnum = s.partnum
	right join
Slspers as r on r.repid = s.repid
where
	c.custnum is null or
	s.custnum is null or
	s.ordnum is null or
	s.partnum is null or
	t.partnum is null or
	c.repid is null or
	s.repid is null or
	r.repid is null 
--3 records

--*********************************************************************************************************************

--D  full outer (the GOOD and the BAD)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	full join 
Sales as s on c.custnum = s.custnum
	full join
Titles as t on t.partnum = s.partnum
	full join
Slspers as r on r.repid = s.repid
--147 records

--***********************************************************************************************************************

--D  full outer (NULLS Only)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	full join 
Sales as s on c.custnum = s.custnum
	full join
Titles as t on t.partnum = s.partnum
	full join
Slspers as r on r.repid = s.repid
where
	c.custnum is null or
	s.custnum is null or
	s.ordnum is null or
	s.partnum is null or
	t.partnum is null or
	c.repid is null or
	s.repid is null or
	r.repid is null
--49 records	 

--*********************************************************************************************************************

--mixed 1  outer LLR (the GOOD and the BAD)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	left join 
Sales as s on c.custnum = s.custnum
	left join
Titles as t on t.partnum = s.partnum
	right join
Slspers as r on r.repid = s.repid
--100 records

--***********************************************************************************************************************

--mixed 1  outer LLR (NULLS only)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	left join 
Sales as s on c.custnum = s.custnum
	left join
Titles as t on t.partnum = s.partnum
	right join
Slspers as r on r.repid = s.repid
where
	c.custnum is null or
	s.custnum is null or
	s.ordnum is null or
	s.partnum is null or
	t.partnum is null or
	c.repid is null or
	s.repid is null or
	r.repid is null 
--2 records

--*********************************************************************************************************************

--mixed 2  outer LRL (the GOOD and the BAD)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	left join 
Sales as s on c.custnum = s.custnum
	right join
Titles as t on t.partnum = s.partnum
	left join
Slspers as r on r.repid = s.repid
--135 records

--***********************************************************************************************************************

--mixed 2  outer LRL (NULLS only)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	left join 
Sales as s on c.custnum = s.custnum
	right join
Titles as t on t.partnum = s.partnum
	left join
Slspers as r on r.repid = s.repid
where
	c.custnum is null or
	s.custnum is null or
	s.ordnum is null or
	s.partnum is null or
	t.partnum is null or
	c.repid is null or
	s.repid is null or
	r.repid is null 
--37 records

--*********************************************************************************************************************

--mixed 3  outer RLL (the GOOD and the BAD)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	right join 
Sales as s on c.custnum = s.custnum
	left join
Titles as t on t.partnum = s.partnum
	left join
Slspers as r on r.repid = s.repid
--100 records

--***********************************************************************************************************************

--mixed 3  outer RLL (NULLS Only)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	right join 
Sales as s on c.custnum = s.custnum
	left join
Titles as t on t.partnum = s.partnum
	left join
Slspers as r on r.repid = s.repid
where
	c.custnum is null or
	s.custnum is null or
	s.ordnum is null or
	s.partnum is null or
	t.partnum is null or
	c.repid is null or
	s.repid is null or
	r.repid is null 
--2 records

--**********************************************************************************************************************

--mixed 4  outer RRL (the GOOD and the BAD)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	right join 
Sales as s on c.custnum = s.custnum
	right join
Titles as t on t.partnum = s.partnum
	left join
Slspers as r on r.repid = s.repid
--136 records

--***********************************************************************************************************************

--mixed 4  outer RRL (NULLS only)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	right join 
Sales as s on c.custnum = s.custnum
	right join
Titles as t on t.partnum = s.partnum
	left join
Slspers as r on r.repid = s.repid
where
	c.custnum is null or
	s.custnum is null or
	s.ordnum is null or
	s.partnum is null or
	t.partnum is null or
	c.repid is null or
	s.repid is null or
	r.repid is null 
--38 records

--*********************************************************************************************************************

--mixed 5  outer RLR (the GOOD and the BAD)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	right join 
Sales as s on c.custnum = s.custnum
	left join
Titles as t on t.partnum = s.partnum
	right join
Slspers as r on r.repid = s.repid
--102 records

--***********************************************************************************************************************

--mixed 5  outer RLR (NULLS only)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	right join 
Sales as s on c.custnum = s.custnum
	left join
Titles as t on t.partnum = s.partnum
	right join
Slspers as r on r.repid = s.repid
where
	c.custnum is null or
	s.custnum is null or
	s.ordnum is null or
	s.partnum is null or
	t.partnum is null or
	c.repid is null or
	s.repid is null or
	r.repid is null 
--4 records

--*********************************************************************************************************************

--mixed 6  outer LRR (the GOOD and the BAD)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	left join 
Sales as s on c.custnum = s.custnum
	right join
Titles as t on t.partnum = s.partnum
	right join
Slspers as r on r.repid = s.repid
--100 records

--***********************************************************************************************************************

--mixed 6  outer LRR (NULLS only)
select
	s.ordnum as Ordnum,
	c.custname as Customer,
	c.custnum as CCust#,
	s.custnum as SCust#,
	t.bktitle as Title,
	s.partnum as SPart#,
	t.partnum as TPart#,
	r.lname as Rep,
	c.repid as CRep#,
	s.repid as SRep#,
	r.repid as RRep#
from
Customers as c 
	left join 
Sales as s on c.custnum = s.custnum
	right join
Titles as t on t.partnum = s.partnum
	right join
Slspers as r on r.repid = s.repid
where
	c.custnum is null or
	s.custnum is null or
	s.ordnum is null or
	s.partnum is null or
	t.partnum is null or
	c.repid is null or
	s.repid is null or
	r.repid is null 
--2 records

--**********************************************************************************************************************

/*
All possible permutations of the 4 tables of Customers,
Sales, Titles, and Slspers have been applied with all 
possible permutations of inner and outer joins.

1	inner			= 98 records
2	left outer only	= 106 matches 8 NULLS
3	right outer only= 101 matches 3 NULLS
4	full outer only	= 147 matches 49 NULLS
5	mixed outer LLR = 100 matches 2 NULLS
6	mixed outer LRL = 135 matches 37 NULLS
7	mixed outer RLL = 100 matches 2 NULLS
8	mixed outer RRL = 136 matches 38 NULLS
9	mixed outer RLR = 102 matches 4 NULLS
10	mixed outer LRR = 100 matches 2 NULLS
*/
