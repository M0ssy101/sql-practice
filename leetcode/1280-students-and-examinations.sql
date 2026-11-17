-- CROSS JOIN pairs every row of one table with every row of the other (no ON clause).
-- With 3 students and 3 subjects, that gives 3 x 3 = 9 rows: every student-subject pair.
-- That's needed here because the result must include pairs where the student sat zero exams.
-- Then left join Examinations on both student_id and subject_name, so each pair
-- picks up its exam rows, or a single row of NULLs if there were none.
-- COUNT(ex.student_id) skips NULLs, so pairs with no exams correctly get 0.
-- COUNT(*) would count the NULL row and give 1.
-- ORDER BY can take several columns: rows are sorted by student_id first,
-- then by subject_name within each student.

Select st.student_id, st.student_name, su.subject_name, count(ex.student_id) as attended_exams from Students as st
cross join Subjects as su
left join Examinations as ex on st.student_id = ex.student_id
    and su.subject_name = ex.subject_name
group by st.student_id, st.student_name, su.subject_name
order by st.student_id, su.subject_name asc
