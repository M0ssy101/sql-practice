-- Percentage = users registered for the contest / total users * 100.
-- A subquery inside an expression goes in brackets and starts with SELECT:
--   (select count(user_id) from Users)
-- It returns a single value (a "scalar subquery"), so it can be used like a number.
-- It counts all users, not just the current group, which is the denominator we need.
-- ORDER BY with two columns: col1 direction1, col2 direction2.
-- Rows are sorted by percentage (highest first), and ties are broken by contest_id (lowest first).

select r.contest_id, count(u.user_id)/(select count(user_id) from Users)*100 as percentage from Register as r
join Users as u on r.user_id = u.user_id
group by r.contest_id
order by percentage desc, contest_id asc
