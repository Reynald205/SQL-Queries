use ogcPubLev1

-- Equals
select pubdate, devcost, bktitle
from Titles
where devcost is not NULL
order by devcost desc

select pubdate, devcost, bktitle
from Titles
where devcost >= 13187.06 and devcost <=13445.62
order by devcost desc

select pubdate, devcost, bktitle
from Titles
where devcost >=13445.62 or devcost <=13187.06
order by devcost desc

select pubdate, devcost, bktitle
from Titles
where devcost between 13187.06 and 13445.62
order by devcost desc

select pubdate, devcost, bktitle
from Titles
where devcost between 13445.62 and 13187.06
order by devcost desc