-- % is the modulo operator: it returns the remainder after division.
-- id % 2 != 0 means id isn't divisible by 2, so it keeps the odd ids.
-- The same trick works for any divisor, e.g. x % 3 = 0 for multiples of 3.
-- MySQL also has MOD(id, 2), which does the same thing.
-- ORDER BY rating DESC puts the highest ratings first.

select id, movie, description, rating from Cinema
where id % 2 != 0 and description != "boring"
order by rating desc
