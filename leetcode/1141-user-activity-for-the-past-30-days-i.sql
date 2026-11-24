-- SQL runs the clauses in this order: FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY.
-- WHERE runs before SELECT, so the alias "day" doesn't exist yet there. Use the real
-- column name, activity_date. MySQL makes an exception for GROUP BY and lets you use the
-- alias, which is why "group by day" works. ORDER BY can always use aliases.
-- Date window: the 30 days ending on 2019-07-27, including that day.
-- > (2019-07-27 minus 30 days) and <= 2019-07-27 gives exactly 30 days (06-28 to 07-27).
-- Interval format: DATE_ADD(date, INTERVAL +/-n DAY). A negative n goes back in time.
-- DATE_SUB(date, INTERVAL n DAY) does the same thing.
-- COUNT(DISTINCT user_id) counts each user once per day, even if they did many activities.

select activity_date as day, count(distinct user_id) as active_users from Activity
where activity_date > Date_add('2019-07-27',interval -30 Day) and activity_date <= '2019-07-27'
group by day
