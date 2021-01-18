--Logic Statements and Variables

select bktitle as Book, slprice as Price,
	case 
		when slprice < 20 then slprice+1 
		when slprice >= 50 then slprice-1
		else slprice 
	end
	as NewPrice
from Titles
order by Price


create view PricingCategories
as
SELECT Book_ID = partnum, Book = bktitle
     ,Price = slprice, Price_Range = 
  CASE 
    WHEN slprice < 20 THEN '$0-$20'
    WHEN slprice >= 20 and slprice < 30 THEN '$20-$30'
    WHEN slprice >= 30 and slprice < 40 THEN '$30-$40'
    WHEN slprice >= 40 and slprice < 50 THEN '$40-$50'
    ELSE '$50-$100'
  END
FROM Titles


select Price_Range
     ,COUNT(book_Id)#_of_books
from pricingCategories
group by price_range


--Variables


declare @Dsct1 as float = 0.05
declare @Dsct2 as float = 0.10
declare @Dsct3 as float = 0.15

select 
     Custname, Bktitle, Qty, slprice 
	,qty * slprice as Total
    ,CASE 
        WHEN qty <= 200 THEN @Dsct1
		WHEN qty <= 400 THEN @Dsct2
        ELSE  @Dsct3
	END as Discount
	,qty * slprice *
	CASE 
    	 WHEN qty <= 200 THEN 1-@Dsct1
		 WHEN qty <= 400 THEN 1-@Dsct2
		 ELSE  1-@Dsct3
	END as DiscountedPrice
from
	Customers as c, Sales as s, Titles as t
where
	c.custnum = s.custnum and
	s.partnum = t.partnum
order by custname
 
 
--User Functions


CREATE Function GetDsct
  (@Dsct1 float, @Dsct2 float, @Dsct3 float) 
RETURNS TABLE 
RETURN 
select 
   Custname as Customer, Bktitle as Book, Qty
   ,slprice as SRP
   ,qty*slprice as Total
   ,CASE 
      WHEN qty <=200 THEN @Dsct1
      WHEN qty <=400 THEN @Dsct2
      ELSE @Dsct3
   END as Discount
   ,CASE 
      WHEN qty <=200 THEN (qty*slprice)*(1-@Dsct1)
      WHEN qty <=400 THEN (qty*slprice)*(1-@Dsct2)
      ELSE  (qty*slprice)*(1-@Dsct3)
   END as DiscountPrice
from
   Customers as c, Sales as s, Titles as t
where
   c.custnum=s.custnum and
   s.partnum=t.partnum


/*Values to variables must be supplied at 
run time. They may not be left empty therefore 
there is no need to apply values when they 
are declared as they will be over written*/

SELECT * FROM GetDsct (.1,.2,.3)
order by 3,1,2