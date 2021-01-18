--Advanved Functions

--Basic Math and Aggregations

select 
	  AVG(qty) as Avg
     ,AVG(qty)+1 as AvgQtyPlus_1
     ,AVG(qty)-1 as AvgQtyMinus_1
     ,COUNT(ordnum) as CountOfOrders
     ,SUM(qty) as SumOfQtys
     ,SUM(qty)*2 as QtysDoubled
     ,SUM(qty)/COUNT(ordnum) as CalculatedAvg
from Sales

--Date Functions

select 
      bktitle as Books 
     ,pubdate as Date
     ,DATEPART(year,pubdate) as Year
     ,DATEPART(month,pubdate) as Month
     ,DATEPART(day,pubdate) as Day
from 
     titles
where 
	 DATEPART(year,pubdate) > 2007 
     and DATEPART(year,pubdate) < 2009
order by 
	 pubdate


select 
	 count(bktitle)as [records]
	,datepart(Year,pubdate) as [year]
from 
	titles
group by 
	datepart(Year,pubdate)


select 
     t.partnum
     ,bktitle Title
     ,ordnum
     ,sldate OrderDate
     ,sldate + 30 ShipDate
     ,DATEADD(MONTH, 6, sldate) 
     'No interest if Paid in Full by'
from 
	 Sales s join Titles t 
		on s.partnum = t.partnum 


select 
     bktitle as Title
     ,datediff(year,pubdate,getdate())
		as 'Years in Print'
from obsolete_titles


select 
     bktitle as Title
     ,round(datediff(day,pubdate,
     getdate())/365.25,3) 
		as 'Years in Print'
from 
	 obsolete_titles


--Text Functions


select 
     lname +', '+ fname +' - '+ repid as Full_Name,
     commrate as Commission_Rate
from Slspers
order by lname 


select 
	rtrim(lname) +', '+ rtrim(fname) +' - '
	     + repid as Full_Name,
	commrate as Commission_Rate
from Slspers
order by lname


select 
	RTRIM(lname)+', '+left(fname,1)+' - '+repid as Sales_Rep,
	'[     ]' as 'Check', '[     ]' as Direct_Deposit,
	'Please_Check_One' as Instructions 
from Slspers
order by lname


select bktitle, replace(bktitle,',','|') 
as No_Commas  from titles


select bktitle, slprice, replicate('$',slprice) as graph, 
	len(replicate('$',slprice)) as #_of_Chars
from titles


--Optional


select 
	lname as Last_Name,
	ltrim(reverse(lname))as Reversed,
	'a' as Search_For, 
	PATINDEX('%a%',lname) as In_Position,
	SUBSTRING(lname,PATINDEX('%a%',lname),10) as Extract_Balance,
	upper(RIGHT(rtrim(lname),1)) as Last_Char
from slspers
	where PATINDEX('%a%',lname)>=1

	
--Lab*****

--Create email addresses for all employees along side their
--ID numbers - result should look like the following example:
--   r.gibson@ogcbooks.com


select 
	repid as Emp#,
	RTRIM(lname)+', '+fname as Full_Name,
	LOWER(left(fname,1)+'.'+rtrim(lname)+'@ogcPub.com') as eMail
from slspers