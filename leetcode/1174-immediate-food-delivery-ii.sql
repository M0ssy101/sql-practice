-- Approach in two steps: first narrow the table down to only the rows that matter
-- (each customer's first order), then do the calculation on those rows.
-- Step 1, the subquery: group by customer and take MIN(order_date) to get each customer's
-- first order date. It returns pairs like (1, '2019-08-01'), (2, '2019-08-02').
-- Step 2, the WHERE: (customer_id, order_date) IN (...) compares both columns as a pair,
-- so only rows matching a customer's first order date are kept.
-- Comparing order_date alone isn't enough: another customer's first date could match a
-- later order. The pair ties the date to the right customer.
-- Step 3, the calculation: order_date = customer_pref_delivery_date is 1 or 0 (as in 1934),
-- so SUM counts the immediate first orders. Divide by COUNT(*), the number of first orders,
-- and multiply by 100.
-- Tip: when a subquery is hard to picture, run it on its own first and look at what it
-- returns, then build the outer query around it.

select (sum(order_date = customer_pref_delivery_date)/count(*))*100 as immediate_percentage from Delivery
where (customer_id, order_date) in  (select  customer_id, min(order_date) from Delivery
group by customer_id )
