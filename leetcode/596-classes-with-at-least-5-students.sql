-- WHERE filters individual rows before grouping, so counts don't exist yet at that point.
-- HAVING filters groups after grouping, so it can use aggregates like COUNT().
-- Rule of thumb: a condition on a row's value goes in WHERE; a condition on an
-- aggregate goes in HAVING. (See 570 and the clause order in 1141.)
-- COUNT(DISTINCT student) makes sure a student listed twice in the same class
-- only counts once.

select class from Courses
group by class
having count(distinct student)>=5
