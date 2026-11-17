-- Left join Transactions onto Visits, then keep only the visits with no matching transaction
-- (transaction_id is NULL). Group by customer to count those visits.
-- COUNT(column) skips NULLs, and so do other aggregates like SUM, MIN and MAX.
-- Every row here has a NULL transaction_id, so use COUNT(*), which counts all rows.

Select customer_id, count(*) as count_no_trans from Visits
left join Transactions on Visits.visit_id = Transactions.visit_id
where transaction_id is Null
group by customer_id


-- Alternative: NOT IN with a subquery.
-- No join happens here, so the subquery's visit_id is resolved on its own and
-- there is no ambiguity error. You don't need to prefix visit_id with a table name.
-- Watch out: if the subquery returns any NULL visit_id, NOT IN matches nothing.

SELECT customer_id, COUNT(*) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN (SELECT visit_id FROM Transactions)
GROUP BY customer_id;
