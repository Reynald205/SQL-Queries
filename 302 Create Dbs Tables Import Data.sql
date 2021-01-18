--Make sure you are in the Master

Use Master

--Create DB

Create Database Invest_Consult


/*Import Excel InvestConsul.xlsx
1st import Managers Sheet and Products Sheet*/

--test new tables

select * from Managers$ --sheet name

select * from Products$ --sheet name

select * from Activity$ --sheet name


/*Import Range Names "Cosmetics" & "AcctMngrs"*/

--test newest imports

select * from acctmngrs

select * from cosmetics

select * from A_B_3809

/*Import Activity Sheet data

Executed in 18 seconds (approx. depending on CPU)
Records 1,048,572; Note sequence of records
Note length of processing time start to finish
Do an order by on transaction field, note time
Create Primary Key and run with indexes, note time

drop Database InvestmentConsultantsInc (if neccessary)*/


--Optional - Create 2nd DB

Create Database NW_Lev3

--Import Access NorthWindDistributers.mdb
--tables with data included