-- Same HAVING pattern as 596, but the threshold is a scalar subquery (as in 1633)
-- instead of a fixed number.
-- Instead of checking product by product whether each customer bought it, compare
-- counts: if a customer's number of distinct products equals the total number of
-- products, they bought them all.
-- DISTINCT is needed on the customer side: buying the same product twice must count once.
-- No DISTINCT is needed in the subquery: product_key is Product's primary key, so each
-- product appears once.
-- Comparing counts only works because Customer.product_key is a foreign key to Product,
-- so customers can't have bought products that aren't in the Product table.

select customer_id  from Customer
group by customer_id
having count(distinct product_key) = (select count(product_key) from Product)
