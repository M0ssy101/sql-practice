-- 1757. Recyclable and Low Fat Products (Easy)
-- Pattern: basic filter, combining two conditions with AND
-- Note: use single quotes for text values

SELECT product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y';