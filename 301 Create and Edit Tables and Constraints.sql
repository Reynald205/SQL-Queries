--*****Adv Create and Edit Table Structure

use ogcPubLev3

--lesson 01*****
--Create Applicants tbl

create table Applicants 
(
aptid varchar(5) not null,
lname varchar(15) not null,
fname varchar(20) null, 
aptaddress varchar(40),  
bthdate smalldatetime,
age int null,
ethnicbkgrd varchar(20),
political_Affiliation varchar(3),
phone varchar(12)
);

--verify structure

sp_help Applicants

--***************************************************************************************

--lesson 02*****
--Edit Applicants tbl structure
--Add fields and Constraints

alter table Applicants
add 
city varchar(40),
state varchar(40),
gender varchar(1),
Zip varchar(10),--allows for zip plus four
check(len(phone)=12);

--Drop fields
alter table Applicants
drop 
column ethnicbkgrd,
column political_Affiliation;

--verify structure and test with an insertion

sp_help Applicants

-- sequence in gui interface

INSERT applicants (aptid, lname, fname, aptaddress,
	bthdate, age, phone, city, state, gender, zip)
--Maps following data to correct fields / not required if
--fields are in sme sequence as in table
VALUES 
	('pvanr', 'van Rossum', 'Peter', '55 Main Street',
	 '3/7/1951', 63, '555-555-1212', 'Washington', 'NJ', 'M',07882)
--attempt phone # with 9 or 11 numbers to test "check len"	
--test primary key, test zip code
 
select * from applicants

drop table applicants
