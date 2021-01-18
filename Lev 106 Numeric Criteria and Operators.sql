--01*****
use ogcPubLev1

--02*****Equals

select pubdate,devcost, bktitle
from titles
where devcost = 13187.06
order by devcost desc

--03*****Not equal

select pubdate,devcost, bktitle
from titles
where devcost <> 13187.06
order by devcost desc

--04*****Greater than

select pubdate,devcost, bktitle
from titles
where devcost > 13187.06 
order by devcost desc

--05*****Less than

select pubdate,devcost, bktitle
from titles
where devcost < 13187.06 
order by devcost desc

--06*****Greater than or equal

select pubdate,devcost, bktitle
from titles
where devcost >= 13187.06 
order by devcost desc

--07*****Less than or equal

select pubdate,devcost, bktitle
from titles
where devcost <= 13187.06 
order by devcost desc

--verify record count

select pubdate,devcost, bktitle
from titles
order by devcost desc
--92 records

--08*****Greater than or equal zero

select pubdate,devcost, bktitle
from titles
where devcost >= 0
order by devcost desc

--09*****Less than 0

select pubdate,devcost, bktitle
from titles
where devcost <= 0
order by devcost desc

--10*****Is Empty

select pubdate,devcost, bktitle
from titles
where devcost is null
order by devcost desc

--11*****Is Not Empty

select pubdate,devcost, bktitle
from titles
where devcost is not null
order by devcost desc

--12*****Range (searching for an interior range)

select pubdate,devcost, bktitle
from titles
where devcost >= 13187.06 and devcost <= 13445.62
order by devcost desc

--returns 4 records

--13*****Range (searching for an exterior range)

select pubdate,devcost, bktitle
from titles
where devcost >= 13445.62 and devcost <= 13187.06
order by devcost desc

--returns 0 records / Why?

--14*****Range (searching for an exterior range)
--correct method

select pubdate,devcost, bktitle
from titles
where devcost >= 13445.62 or devcost <= 13187.06
order by devcost desc

--returns 84 records

--15*****Between Operator (searching for an interior range)

select pubdate,devcost, bktitle
from titles
where devcost between 13187.06 and 13445.62
order by devcost desc

--this test is inclusive for the test values
--returns 4 records

--16*****Between Operator (searching for an interior range)

select pubdate,devcost, bktitle
from titles
where devcost between 13445.62 and 13187.06
order by devcost desc

--with highest and lowest values reversed
--returns 0 records / incorrect
--be sure to test for lowest 1st, highest 2nd
--and in MS Access it doesn't care and also  
--in some other programs
--NEVER ASSUME / ALWAYS TEST

--17*****Between Operator (searching for an exterior range)

select pubdate,devcost, bktitle
from titles
where not (devcost between 13187.06 and 13445.62)
order by devcost desc

--be sure to test for lowest 1st, highest 2nd
--this test is inclusive for the test values
--returns 82 records

--Lab 1*****
/*How much commission did each Sales Rep make on each order?
  Only show records for those who earned $500 or more.
  Display all relevant fields.
  Which tables contain the required fields?*/

--lab 1 Solution

select 
	Lname as SalesRep,
	s.repid as ID#,
	commrate as CommRate, 
	Ordnum as Ord#,
	qty*slprice as OrderTotal, 
	commrate*qty*slprice as Commission
from 
	slspers as r,
	sales as s, 
	titles as t
where
	r.repid = s.repid
	and
	s.partnum = t.partnum
	and 
	commrate*qty*slprice >= 500
Order by lname	   