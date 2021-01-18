--Views

use ogcPubLev2

--01*****
--Create view of one table

Create View MediumPriceTitles
     as 
select partnum, bktitle, slprice 
from titles
where slprice between 20 and 40

--suggestion: make criteria part of name / discuss
--Verify

select * from MediumPriceTitles
order by slprice

--Remove

drop view MediumPriceTitles

--Lab 1
--Recreate same query with 'order by' clause already in place.
--What are the results? Discuss.


--*******************************************************************************

--02*****
--Create view of multiple tables

Create View AllTablesBase
as 
SELECT 
	*
FROM Customers as c 
	JOIN Sales as s ON s.custnum = c.custnum 
	JOIN Titles as t ON t.partnum = s.partnum 
	JOIN Slspers as r ON r.repid = c.repid
		
--Failed - fix with following select edit

Create View AllTablesBase
     as 
SELECT
    c.*, 
    s.ordnum, sldate, qty,    
    t.*,
    r.lname, fname, commrate,
    qty*slprice as OrderTotal 
FROM Customers as c 
    JOIN Sales as s ON s.custnum = c.custnum 
    JOIN Titles as t  ON t.partnum = s.partnum 
    JOIN Slspers as r ON r.repid = c.repid
	
--Verify

select * from alltablesbase

--Verify

select * from alltablesbase
where state = 'Ny'

--*******************************************************************************

--03*****
--Create view based on another view

--A*****

Create View GrandTotalOrders 
   as 
select SUM(OrderTotal) as GrandTotal
from AllTablesBase

--B*****

Create View CustomerSummaries 
     as
select CustName, SUM(Ordertotal) as CustomerTotals
from AllTablesBase
group by CustName

--*******************************************************************************

--04*****
--Requery a query (layering queries)

select 
    CustName, 
    CustomerTotals, 
    GrandTotal, 
    CustomerTotals/GrandTotal as '% Of Total'
From 
    CustomerSummaries
      cross join
    GrandTotalOrders
Where
    CustomerTotals is not null 
Order By 
    '% of Total' desc
	
--analyze the results

--*******************************************************************************

--05*****
--search for the 5 highest orders

create view top_5_orders
     as 
select top 5 *
from dbo.alltablesbase
order by OrderTotal desc

--06*****
--search for the 5 lowest orders

create view bot_5_orders
	as 
select top 5 *
from dbo.alltablesbase
order by OrderTotal asc

--verify

select custname, ordnum, OrderTotal from top_5_orders
select custname, ordnum, OrderTotal from bot_5_orders

--*******************************************************************************

--07*****
--Edit elements of a view
--change field name in view / 'EXEC' not required

EXEC sp_rename 'AllTablesBase.OrderTotal', 'LineTotal', 'column'

--test prior views for errors

--reverse name change to repair damage

EXEC sp_rename 'AllTablesBase.LineTotal', 'OrderTotal', 'column'

--test repair