-- An expression like e.timestamp - s.timestamp can only use values from the same row.
-- Aggregates such as AVG and SUM are the exception: they work across rows, but only to
-- summarise a group. So to subtract the start time from the end time, both timestamps
-- have to be on one row first. A self join does that: s = the start row, e = the end row.
-- The ON clause can take several conditions joined with AND. Here they pair each
-- process's start row with its own end row on the same machine.
-- A plain JOIN is shorthand for INNER JOIN.
-- ROUND(expression, decimal_places) rounds the average to 3 decimal places.

SELECT s.machine_id, round(avg(e.timestamp - s.timestamp), 3) as processing_time
FROM Activity as s
join Activity as e
    on s.machine_id = e.machine_id
    and s.process_id = e.process_id
    and e.activity_type = "end"
    and s.activity_type = 'start'
group by s.machine_id
