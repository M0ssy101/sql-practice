-- Left join keeps every employee. Employees with no row in Bonus get bonus = NULL.
-- Comparing NULL to anything (NULL < 1000) gives NULL ("unknown"), not true, so
-- WHERE drops those rows. bonus < 1000 on its own would lose the no-bonus employees,
-- so add "bonus is null" explicitly to keep them.

Select name, bonus from Employee as e
left join bonus as b on e.empID = b.empID
where bonus is null or bonus < 1000;
