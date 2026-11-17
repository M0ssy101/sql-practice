-- Self join: join Weather to itself so each day's row sits next to the previous day's row.
--   t1 = the current day, t2 = the day before.
-- DATE_ADD(t2.recordDate, INTERVAL 1 DAY) gives the date after t2, so the join matches each
-- t1 to the row from exactly one day earlier. Gaps in the dates are handled correctly.
-- Aliases are required in a self join because both sides are the same table.
-- Every column must also be prefixed with its alias (t1.id, t2.temperature),
-- or you get an ambiguity error.

SELECT t1.id
FROM Weather AS t1
JOIN Weather AS t2
  ON t1.recordDate = DATE_ADD(t2.recordDate, INTERVAL 1 DAY)
where t1.temperature > t2.temperature
