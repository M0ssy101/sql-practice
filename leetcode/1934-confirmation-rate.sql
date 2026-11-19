-- Rate = confirmed messages / all messages, per user.
-- In MySQL a condition like c.action = 'confirmed' gives 1 (true) or 0 (false),
-- so SUM(condition) counts the rows where it's true.
-- COUNT(column) counts every non-NULL row, whatever its value. Transforming the
-- column doesn't change that: COUNT(c.action = 'confirmed') still counts the 0s.
-- That's why the numerator uses SUM and the denominator uses COUNT.
-- Users with no confirmation rows (from the left join) have COUNT = 0, and dividing by
-- zero gives NULL in MySQL. IFNULL(value, 0) turns that NULL into 0.
-- Related: IF(condition, value_if_true, value_if_false), for example
-- AVG(IF(c.action = 'confirmed', 1, 0)) would also compute the rate.

select s.user_id, ifnull(sum(c.action = 'confirmed')/count(c.action), 0) as confirmation_rate from Signups as s
left join Confirmations as c on s.user_id = c.user_id
group by s.user_id
