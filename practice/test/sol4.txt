-- tree( *id, p_id)

SELECT id, CASE
    when p_id = NULL then 'Root'
    when id IN ( select p_id from tree ) then 'Inner' else 'Leaf'
end
from tree
;

