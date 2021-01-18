/* Edit table structures for referential 
integrity by creating foreign keys*/

use ogcPubLev3
go

alter table Sales
add constraint fkeyCust foreign key (custnum) 
references Customers (custnum);
go

alter table Sales
add constraint fkeyTitles foreign key (partnum) 
references Titles (partnum);
go

alter table Sales
add constraint fkeyReps foreign key (repid) 
references slspers (repid);
go

alter table Customers 
add constraint fkeySReps foreign key (repid)
references slspers (repid); 
go

/*STOP! Test the process for
SUCCESS and FAILURE*/