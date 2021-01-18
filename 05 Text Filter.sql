use ogcPubLev1
--exact match criteria 
select state , city , custname
from Customers
where state ='NC'
order by state, city, custname

select state , city , custname
from Customers
where state ='NY' or state ='NC' or state ='ca' or state ='NJ' or state ='VT'
order by state, city, custname

select state , city , custname
from Customers
where not (state ='NY' or state ='NC' or state ='ca' or state ='NJ' or state ='VT')
order by state, city, custname

select state , city , custname
from Customers
where not (state !='NY' or state !='NC' or state !='ca' or state !='NJ' or state !='VT')
order by state, city, custname

--Array method
select state , city , custname
from Customers
where state not in ('NY','NC','ca','NJ','VT')
order by state, city, custname

select state , city , custname
from Customers
where 
	state ='NY' and city ='ryebrook' 
	or state ='NC' and city ='Wilson' 
	or state ='ca' and city='San francisco'
order by state, city, custname

--Wild card searches

select bktitle,partnum 
from Titles
where rtrim(bktitle) like '%ing'

select bktitle,partnum 
from Titles
where bktitle not like '[a-m]%'
order by bktitle

select bktitle,partnum 
from Titles
where bktitle like '[a,d,f]%'
order by bktitle

select bktitle,partnum 
from Titles
where bktitle like '[a d f]%'
order by bktitle

select bktitle,partnum 
from Titles
where bktitle like '[adf]%'
order by bktitle

select bktitle,partnum 
from Titles
where bktitle like '__[hre]%'
order by bktitle

select * from Customers
where custnum like '___7%'

select * from Customers
where custnum like '__[53]__'