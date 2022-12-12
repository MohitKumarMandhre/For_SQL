-- logs ( *id, num )

select distinct num
from ( 
    select num, lag( num) over( ORDER BY id) as prevNum, lead( num) over( ORDER BY id) as succNum
    from logs
    where num = prevNum and num = succNum
 ) 
;

-- select distict l1.num 
-- from logs as l1 INNER JOIN logs as l2
-- ON l1.id +1 = l2.id and l1.num = l2.num 
-- INNER join logs as l3 
-- where l1.id +2 = l3.id and l1.num = l3.num 
-- ;