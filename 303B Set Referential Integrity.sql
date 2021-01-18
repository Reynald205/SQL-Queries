/* Edit table structures by creating primary keys 
that are required for referential integrity by  
running the following code as a batch. If required 
rerun sp0_Clean_Reinstall_All_DBs again to reset 
databases. Run all the code below up to the testing 
phase in one pass to demonstrate the batch terminator 
'go' and the statement terminator ';'. */

use ogcPubLev3
go

alter table Customers 
alter column custnum nvarchar(5) NOT NULL;
go

alter table Customers 
add constraint pkeyCust primary key (custnum); 
go

--Fix Titles

alter table Titles 
alter column partnum nvarchar(5) NOT NULL;
go

alter table Titles 
add constraint pkeyTitles primary key (partnum); 
go

--Fix Slspers

alter table Slspers 
alter column repid nvarchar(3) NOT NULL;
go

alter table Slspers 
add constraint pkeyReps primary key (repid);
go

--Fix Sales

alter table Sales 
alter column ordnum int NOT NULL;
go

alter table Sales 
add constraint pkeySales primary key (ordnum);
go

/* STOP! On your own test for bad 
unmatched records and remove them */