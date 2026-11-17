-- When specify the columns that are being joined on if they have the same name then /
-- it throws an ambigious error. So then specify the table as below.
-- Remember to join on the larger table to get a full view of the data, including nulls

Select name, unique_id from Employees
left join EmployeeUNI on Employees.id = EmployeeUNI.id

