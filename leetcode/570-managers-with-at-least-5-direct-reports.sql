-- Subquery method: group employees by managerId and keep only the managers with 5+ reports.
-- HAVING filters groups after aggregation. WHERE runs before grouping, so it
-- can't use COUNT(*). The outer query then returns the names of those manager ids.
-- A NULL managerId (an employee with no manager) in the subquery is harmless with IN.
-- It only causes problems with NOT IN (see 1581).

select name from Employee
where id in (
    select managerID from Employee
    group by managerID
    having count(*) >=5
)


-- Alternative: self join. e = the employee, m = their manager.
-- Each join row is one direct report, so COUNT(*) per manager is their number of reports.
-- Group by m.id as well as m.name, so two managers who share a name aren't merged.

SELECT m.name
FROM Employee AS e
JOIN Employee AS m ON e.managerId = m.id
GROUP BY m.id, m.name
HAVING COUNT(*) >= 5;
