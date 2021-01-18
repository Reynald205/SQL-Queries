--01*****
use ogcPubLev1

--02*****
--exact match criteria

select state, city, custname
from Customers
where state ='NC' 
order by state, city, custname

/*Clone query and simply 
edit the where clause*/

--03*****
--inclusive match in same field (or)

select state,city,custname
from Customers
where state ='ny' or state ='NC' or 
	state ='ca' or state ='NJ' or State = 'VT'
order by state, city, custname

--any of five states required
--we have no "VT" customers

--04*****
--inclusive with an array (better)

select state, city, custname
from customers
where state in ('ny','NC','ca','NJ','VT')
order by state, city, custname

--05*****
--exclusive technique (poor)

select state,city,custname
from Customers
where not state ='ny' and not state ='NC' and 
	not state ='ca' and not state ='VT'
order by state, city, custname

--06*****
--alternate exclusive technique (ok) 
--doesn't work in some apps for text

select state,city,custname
from Customers
where  state <> 'ny' and  state <>'NC' and 
	state <> 'ca' and state <> 'VT' 
order by state, city, custname

--07*****
--alternate exclusive technique (better)

select state,city,custname
from Customers
where not(state='ny' or state='NC' or 
	state='ca' or state='VT')
order by state, city, custname

--08*****
--alternate exclusive technique (best and simplest)

select state, city, custname
from customers
where state not in ('ny','NC','ca','VT')
order by city, custname

--09*****
--inclusive criteria in multiple fields (simple)

select state,city,custname
from Customers
where state ='NY' and city ='ryebrook' 
	or state ='NC' and city ='Wilson'
	or state='ca' and city='San Francisco'
order by state, city, custname

--10*****
/*inclusive criteria in multiple fields
each record must match 2 or more criteria
both city and state required 
(tedious but accurate)*/

select state, city, custname
from Customers
where state='NY' and city='Chester' 
	or state='NY' and city ='Santa Ana'
	or state='NC' and city ='Wilson'
	or state='NC' and city ='Chester'	
	or state='ca' and city='San Francisco' 
	or  state ='CA' and city ='Greensboro'
order by state, city, custname

--Correct result / most robust and works in most 
--applications but very laborious / returns 4 records

--11 last alternate technique*****
--inclusive with 2 arrays for multiple fields

select state, city, custname
from customers
where state in ('ny','NC','ca') or
	city in('San Francisco','Wilson',
	'Santa Ana','Greensboro','Chester')
order by state, city, custname

/*Lacks clarity. 'Or' gives 13 records versus
'and' which gives 6 records*/

--********************************************************************
--wild card criteria
--********************************************************************

--12*****

select bktitle, partnum from titles
where bktitle like 'a%'


 --anything that starts with 'a'
--"like" instead of "=" is required with wildcard searches

--13***** 
select bktitle, partnum from titles 
where bktitle like '%g'


/* Lab 1 anything that ends with 'g' 
does not return "All Kinds of Knitting"... WHY ...??
What is wrong with previous query*/

--14*****
--Lab 1 *****


--testing

select bktitle, partnum from titles
where bktitle like '% '


--solution

select bktitle, partnum from titles 
where rtrim(bktitle) like '%g'

--anything that ends with 'g' 
--removes blank spaces prior to search


--15*****
--searching for an array of 1st initials

select bktitle, partnum from titles
where bktitle like '[a-m]%' 
order by bktitle
           
--starts with any of 'a' thru 'm'
--hyphen indicates first thru last


--16*****
/*looking for 1 of 3 initial 
characters - 3 different methods*/

select bktitle, partnum from titles
where bktitle like '[a,d,f]%'
order by bktitle

select bktitle, partnum from titles
where bktitle like '[a d f]%'
order by bktitle 

select bktitle, partnum from titles
where bktitle like '[adf]%'
order by bktitle
 
--comma and space seperators are optional


--17*****
--searching for second initial or
--position in string / use underscore

select bktitle, partnum from titles  
where bktitle like '_[hr]%'      
order by bktitle

--look for 'h' or 'r'
--in second position

--18*****
/*searching for a specific number
in a specified position
some IDs are 4 or 5 digets long*/

select * from Customers  
where custnum like '___7%' 

--19*****
select * from Customers         
where custnum like '__[53]__'
  
--5 or 3 must be the 3rd number 
--in a string of 5 numbers

--20*****
--Lab 2 *****

/*The titles table contains a "learning" 
series of language books. We wish to display 
all of them except the book that deals 
with "Learning to Crochet". We also need 
to display the price field and sort by title.*/


--Solution

select 
	bktitle as Title, 
	partnum as Book#, 
	slprice as Price
from 
	titles
where 
	bktitle like 'learning%' 
	and 
	bktitle not like '%crochet%'
order by 
	title