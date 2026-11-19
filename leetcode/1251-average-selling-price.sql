-- Left join from Prices so every product is included, even products with no units sold.
-- Those get NULLs from UnitsSold.
-- The date conditions keep only the sales whose purchase_date falls inside that price's
-- start_date to end_date window, so each sale is matched to the price in effect at the time.
-- They go in the ON clause, not WHERE. In WHERE, NULL dates fail the comparison and the
-- unsold products would be dropped (the same NULL trap as 577).
-- Shorter equivalent: u.purchase_date BETWEEN p.start_date AND p.end_date.
-- This is a weighted average: total revenue / total units = SUM(price * units) / SUM(units).
-- Use SUM, not COUNT or AVG, because each row holds a units quantity rather than
-- standing for one unit.
-- Unsold products give NULL / NULL = NULL, so IFNULL(..., 0) returns 0 for them.

select p.product_id, ifnull(round(sum(p.price*u.units)/sum(u.units),2),0) as average_price from Prices as p
left join UnitsSold as u on p.product_id = u.product_id
    and u.purchase_date >= p.start_date
    and u.purchase_date <= p.end_date
group by p.product_id
