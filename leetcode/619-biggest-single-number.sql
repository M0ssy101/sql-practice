-- Aggregates run per group. With GROUP BY num, MAX(num) is computed inside each group,
-- so it just returns each number. To get the max across the filtered results, use two
-- levels: the inner query filters (GROUP BY + HAVING COUNT(*) = 1 keeps numbers that
-- appear once), and the outer query aggregates over what's left.
-- A subquery in FROM (a "derived table") needs an alias. MySQL requires a name for every
-- derived table (AS alias). The name can be anything; it only matters if you refer to it.
-- An outer aggregate always returns one row, so if there are no single numbers,
-- MAX gives NULL, which is what the problem asks for.

SELECT max(num) as num
FROM (select num from MyNumbers
GROUP BY num
HAVING COUNT(*) = 1) as alias


-- Alternative: ORDER BY ... DESC LIMIT 1 wrapped in a scalar subquery.
-- On its own, ORDER BY ... LIMIT 1 returns no rows at all when nothing matches, which
-- fails "return null if none" problems. Wrapping it in SELECT (...) fixes that: an empty
-- scalar subquery becomes NULL, so exactly one row always comes back.
-- Takeaway: when a problem says "return null if none exists", an outer aggregate or a
-- scalar subquery is the standard way to guarantee a row comes back.

SELECT (select num
FROM MyNumbers
GROUP BY num
HAVING COUNT(*) = 1
order by num desc
limit 1) as num
