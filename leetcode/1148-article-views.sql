-- Use AS to rename the output column
-- Use order by to organise the output in ascending order

select distinct author_id as id from Views
where author_id = viewer_id
order by author_id asc;
