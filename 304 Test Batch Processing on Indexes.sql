/* Test Batch 1 on the Titles table
Verify record count and non-existance 
of Title 'Personal Watercraft Safety'*/

--Batch 1
Create Index titlesIndex_PubDate
On Titles(bktitle, slprice);
go

Create Unique Index titles_UniqueName
On Titles(bktitle);
go

Select *
From Titles
Order By 2
go


/* STOP
Execute sp_Help Titles*/
sp_help titles


/* Test Batch 2
Insert new record*/

--Batch 2
INSERT 
Titles (pubdate, partnum, bktitle, slprice, devcost)
VALUES
('2008-08-01', '22222', 'Personal Watercraft Safety', 35, 15382.14)
go

Select *
From Titles
Order By 2
go


/* STOP
Test Batch 3
Insert same Title again with a different partnum
we are testing the index, NOT the primary key*/

--Batch 3
INSERT 
Titles (pubdate, partnum, bktitle, slprice, devcost)
VALUES
('2008-08-01', '33333', 'Personal Watercraft Safety', 35, 15382.14)
go

Select *
From Titles
Order By 2
go


/* STOP 
Batch 3 failed
Insertion of record failed
Remove index Titles_UniqueName
Test Batch 4*/


--Batch 4
drop index titles.Titles_UniqueName;
go

drop index titles.titlesIndex_PubDate;
go

INSERT 
Titles (pubdate, partnum, bktitle, slprice, devcost)
VALUES
('2008-08-01', '33333', 'Personal Watercraft Safety', 35, 15382.14)
go

Select *
From Titles
Order By 2
go


/* STOP execute
--sp_help titles*/
sp_help titles


/*of course you have 2 books that 
are the same name and all the 
other fields also except for the  
part number, so deleteing that 
index is not a good idea*/
delete Titles where bktitle = 'Personal Watercraft Safety'