-- Join Employee onto Project to get each project member's experience_years.
-- A plain JOIN (inner join) is enough: every employee_id in Project exists in Employee,
-- so no rows are lost. A left join would give the same result here.
-- Group by project_id, then AVG(e.experience_years) averages that column across each
-- project's members. ROUND(..., 2) gives 2 decimal places.

select p.project_id, round(avg(e.experience_years),2) as average_years from Project as p
Join Employee as e on p.employee_id = e.employee_id
group by p.project_id
