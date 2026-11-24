-- Group by teacher, then count their subjects.
-- DISTINCT is the key part: a teacher can teach the same subject in several departments,
-- so the same subject_id can appear in more than one row. COUNT(DISTINCT subject_id)
-- counts each subject once. A plain COUNT(*) would count it once per department.

select teacher_id, count(distinct subject_id) as cnt from Teacher
group by teacher_id
