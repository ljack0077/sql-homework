
🟢 Easy-Level Tasks (10)
Write a query to select the top 5 employees from the Employees table.
Use SELECT DISTINCT to select unique Category values from the Products table.
Write a query that filters the Products table to show products with Price > 100.
Write a query to select all Customers whose FirstName start with 'A' using the LIKE operator.
Order the results of a Products table by Price in ascending order.
Write a query that uses the WHERE clause to filter for employees with Salary >= 60000 and Department = 'HR'.
Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From Employees table
Write a query that shows all products with Price BETWEEN 50 AND 100.
Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
After SELECT DISTINCT on two columns (Category and ProductName) Order the results by ProductName in descending order.
  
🟠 Medium-Level Tasks (10)
Write a query to select the top 10 products from the Products table, ordered by Price DESC.
Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
Write a query that selects distinct Category and Price from the Products table.
Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.
Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.Use customers table
  
🔴 Hard-Level Tasks
Write a query that selects the top 5 products with the highest sales, using TOP(5) and ordered by SalesAmount DESC.
Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement)
Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
Write a query that selects products whose Price is less than 10% of the average price in the Products table. (Do some research on how to find average price of all products)
Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and LATEST_DATE in the table. (Search how to get the current date and latest date)
