--Protecting the Structure of Tables and Views

select * from Obsolete_Titles

--build view to see oldest books in Inventory
Create View DisctRackOldest3
as
select  top 3
	partnum, bktitle, 
	MIN(pubdate) as Oldest_Books 
from Obsolete_Titles
group by partnum, bktitle
order by 3

--verify
select * from DisctRackOldest3

--rename  field in underlying table
sp_rename 'Obsolete_Titles.bktitle','Book','column'
--warning was given but after the fact

--verify
select * from DisctRackOldest3
--failed because field name in table has already been changed

--reverse
sp_rename 'Obsolete_Titles.Book','bktitle','column'

--verify again
select * from DisctRackOldest3
--success

--protect the table from change to structure
--with schenabinding clause
Alter View DisctRackOldest3
with schemabinding
as
select  top 3
	partnum, bktitle, 
	MIN(pubdate) as Oldest_Books 
from dbo.Obsolete_Titles --"dbo." is required
group by partnum, bktitle
order by 3

--verify again
select * from DisctRackOldest3
--success

--rename  field in table
sp_rename 'Obsolete_Titles.bktitle','Book','column'
--failed / protection successful

--verify again
select * from DisctRackOldest3
--Life is Good

--*************************************************************************

/*We want to protect tables that go into 
making up the View AllTablesBase. We discover 
that we can't because we used the "*" and 
didn't use "dbo." in joining the tables.  We
decide it will be easier to just drop the old 
view and create a new one.*/

--Remove	
drop view AllTablesBase	

--Create New Version
Create View AllTablesBase
with schemabinding 
as 
SELECT 
--does not allow use of asterix except for multiplication
	c.custnum,custname,referredby,address,city,
		state,zipcode,c.repid as custrep, 
	s.ordnum, sldate, qty,s.repid as salesrep, 
	t.partnum,bktitle,devcost,slprice,pubdate,
	r.lname, fname, commrate,
	qty*slprice as OrderTotal 
FROM
--requires 2 part object name 
	dbo.Customers as c JOIN 
	dbo.Sales as s 
		ON s.custnum = c.custnum JOIN 
	dbo.Titles as t 
		ON t.partnum = s.partnum JOIN 
	dbo.Slspers as r 
		ON r.repid = c.repid
		
-- verify
select * from alltablesbase		

--we want edit a field name in the table 
sp_rename 'titles.slprice','SRP','column'
--failed - good

--verify
select * from alltablesbase
--still reads "slprice"

--we decide to rename the field in the view instead
sp_rename 'AllTablesBase.slprice','SRP','column'
--did not fail 
--tables were protected but the view was not

select * from alltablesbase
/*Now field reads "SRP".  The underlying table was 
protected but not the view.  We wish to protect the 
view also so that objects based on it will follow 
data integrity rules.*/

--reverse the edit
sp_rename 'AllTablesBase.srp','slprice','column'
--verify
--now we will create protection for the view
		
--Create
create view AllMainInnerJoins
with schemabinding
as 	
select
--table aliases are meaningless in this layer
	custnum, custname, referredby, address,
	city, state, zipcode, custrep, ordnum,
	sldate, qty, salesrep, partnum, bktitle,
	devcost, slprice, pubdate, lname, fname, 
	commrate, OrderTotal
from 
--requires 2 part object name
	dbo.AllTablesBase
	
--Verify	
select * from alltablesbase
--success

--test data integrity fully
--test the view level protection
sp_rename 'AllTablesBase.slprice','SRP','column'
--failed - good

sp_rename 'AllTablesBase.salesrep','server','column'
--failed - good

--test the table level protection
sp_rename 'Titles.slprice','SRP','column'
--failed - good

sp_rename 'titles.repid','server','column'
--failed - good

--test the uppermost view level protection
sp_rename 'AllMainInnerJoins.devcost','cost','column'
/*This did not fail because this is the top layer. 
In theory this one should not be used for analysis.  
Its purpose is to simply protect lower layers and 
to create a more robust level of tamper resistance*/
	
--verify
select * from  AllMainInnerJoins

--if desired
drop view AllMainInnerJoins	
drop view AllTablesBase