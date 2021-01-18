/* Edit table structures for referential integrity.
Create all the following code and execute as you go.
If required rerun sp0_Clean_Reinstall_All_DBs 
again to reset databases.  */

use ogcPubLev3
alter table Customers 
alter column custnum nvarchar(5) NOT NULL;
alter table Customers 
add constraint pkeyCust primary key (custnum);
alter table Titles 
alter column partnum nvarchar(5) NOT NULL;
alter table Titles 
add constraint pkeyTitles primary key (partnum);
alter table Slspers 
alter column repid nvarchar(3) NOT NULL;
alter table Slspers 
add constraint pkeyReps primary key (repid);
alter table Sales 
alter column ordnum int NOT NULL;
alter table Sales 
add constraint pkeySales primary key (ordnum);

--test for success and / or failure