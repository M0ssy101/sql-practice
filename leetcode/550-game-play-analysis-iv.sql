-- Same pattern as 1174, with two subqueries doing different jobs.
-- Subquery 1, in WHERE: for each player, take their first login (MIN(event_date)) and
-- add 1 day with DATE_ADD (as in 197). That gives (player_id, day after first login) pairs.
-- The pair IN (...) then keeps only rows where the player logged in on that day.
-- So COUNT(*) is the number of players who came back the day after their first login.
-- Subquery 2, in SELECT: (select count(distinct player_id) from Activity) is the total
-- number of players. It's a scalar subquery (as in 1633). It's needed because the WHERE
-- has already filtered the outer query down to returning players.
-- DISTINCT makes each player count once, even though they have many activity rows.
-- fraction = returning players / all players, rounded to 2 decimal places.

select round(count(*)/ (select count(distinct player_id) from Activity),2) as fraction from Activity
where (player_id, event_date) in (select player_id, Date_Add(min(event_date),interval 1 day) from Activity
group by player_id)
