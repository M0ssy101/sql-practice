-- Sales has product_id but not product_name, so join Product to look up the name for each sale.
-- Left join keeps every sale even if its product_id has no match in Product (product_name would be NULL).
-- Prefix the join columns with their table names because both tables have a product_id column.

select product_name, year, price from Sales
left join Product on Sales.product_id = Product.product_id
