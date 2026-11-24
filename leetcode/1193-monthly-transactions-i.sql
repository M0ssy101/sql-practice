-- DATE_FORMAT(col, '%Y-%m') turns a date into year-month text, e.g. 2018-12-18 -> '2018-12'.
-- That lets you group by month instead of by individual day.
-- GROUP BY with two columns makes one group per (month, country) combination.
-- Unlike ORDER BY, the column order doesn't matter: group by country, month gives the same groups.
-- MySQL lets you group by the alias "month" defined in SELECT.
-- COUNT(*) counts all transactions in the group. SUM(state = "approved") counts the approved
-- ones (condition = 1 or 0, as in 1934). SUM(amount) adds up all the amounts.
-- For approved_total_amount, IF(state = "approved", amount, 0) adds the amount for approved
-- rows and 0 for the rest, so the condition applies to this one column only.
-- WHERE can't be used here because it filters rows for the whole query. WHERE state = 'approved'
-- would remove the declined rows from trans_count and trans_total_amount too, making them wrong.
-- Putting the condition inside SUM is often called "conditional aggregation".

select DATE_FORMAT(trans_date, '%Y-%m') AS month,country, count(*) as trans_count, sum(state = "approved") as approved_count, sum(amount) as trans_total_amount, sum(if(state = "approved", amount, 0 )) as approved_total_amount
from Transactions
group by month, country
