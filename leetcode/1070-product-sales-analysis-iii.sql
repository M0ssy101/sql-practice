-- Same pattern as 1174 and 550: use a subquery to pick out the rows you need, then
-- display or calculate from just those rows.
-- The subquery returns each product's first year: (product_id, MIN(year)).
-- The pair IN (...) keeps every sale of that product from that year. If a product had
-- several sales in its first year, all of them are returned, which this problem wants.
-- The "as first_year" alias inside the subquery isn't needed: IN matches by position,
-- not by name. It's harmless, though.

select product_id, year as first_year, quantity, price from Sales
where (product_id, year) in (select product_id, min(year) as first_year from Sales
group by product_id)
