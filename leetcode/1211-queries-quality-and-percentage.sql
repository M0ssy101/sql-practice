-- No subquery is needed: both values are calculated within each query_name group,
-- so COUNT(*) already gives the group's total. Compare 1633, where the denominator was
-- every user in the table, so it needed a subquery.
-- quality = average of rating / position. SUM(...) / COUNT(*) is the same as AVG(...).
-- poor_query_percentage uses the condition trick from 1934: rating < 3 gives 1 or 0,
-- so SUM counts the poor queries. Divide by the group total and multiply by 100.
-- Shorter equivalent: round(avg(rating/position), 2) and round(avg(rating < 3) * 100, 2).

select query_name, round(sum(rating/position)/count(*),2) as quality, round(sum(rating<3)/count(rating)*100,2) as poor_query_percentage
from Queries
group by query_name
