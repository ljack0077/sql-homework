# Lesson 4: Filtering and Ordering Data

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.


## 🟢 Easy-Level Tasks (10)
1. Write a query to select the top 5 employees from the Employees table.
  SELECT TOP 5 * FROM Employees
  
2. Use SELECT DISTINCT to select unique Category values from the Products table.
  select distinct(Category) from Products_Discounted
  
3. Write a query that filters the Products table to show products with Price > 100.
  select * 
  from Products
  where price > 100

  
4. Write a query to select all Customers whose FirstName start with 'A' using the LIKE operator.
  select * 
  from Customers
  where FirstName like 'A%'
  
5. Order the results of a Products table by Price in ascending order.
  select * 
  from Products
  order by Price asc
  
6. Write a query that uses the WHERE clause to filter for employees with Salary >= 60000 and Department = 'HR'.
  SELECT *
  FROM Employees
  WHERE Salary >= 60000 AND DepartmentName = 'HR';
  
7. Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From  Employees table
  SELECT
    EmployeeID,
    FirstName,
    LastName ,
    DepartmentName,
    Salary,
    HireDate,
    Age,
    ISNULL(Email, 'noemail@example.com') AS Email,
    Country
    
 FROM Employees;
  
8. Write a query that shows all products with Price BETWEEN 50 AND 100.
    select *
  from Products
  where price between 60 and 100
  
9. Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
  select distinct Category, ProductName
  from Products
  
10. After SELECT DISTINCT on two columns (Category and ProductName) Order the results by ProductName in descending order.
  select distinct Category, ProductName
  from Products
  order by ProductName desc
  

________________________________________

## 🟠 Medium-Level Tasks (10)
11. Write a query to select the top 10 products from the Products table, ordered by Price DESC.
    select top 10 *
    from Products
    order by price desc
  
12. Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
    select COALESCE(FirstName, LastName) as DisplayName
    from Employees
  
  
13. Write a query that selects distinct Category and Price from the Products table.
    select distinct Category, Price 
    from Products
  
14. Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
  select * from Employees
  where Age between 30 and 40 and DepartmentName ='Marketing'
  
15. Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
  select *
  from Employees
  order by Salary DESC
  OFFSET 10 ROWS     
  FETCH NEXT 10 ROWS ONLY
  
  
16. Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.
  select *
  from Products
  where price <= 1000 and StockQuantity > 50
  order by StockQuantity asc
  
17. Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
  select * 
  from Products
  where ProductName like '%e%'

  
18. Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
  select * from Employees
  where DepartmentName ='HR' OR DepartmentName ='Finance' OR DepartmentName ='IT'

19. Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.Use customers table
  select *
  from Customers
  Order by City asc, PostalCode desc

  ________________________________________

## 🔴 Hard-Level Tasks 
20. Write a query that selects the top 5 products with the highest sales, using TOP(5) and ordered by SalesAmount DESC.
  select top 5 Products.ProductName, Sales.SaleAmount
  from Sales
  Left join Products
      on  Products.ProductID = Sales.ProductID
  order by SaleAmount desc 


  
21. Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement)
  select concat(FirstName, ' ', LastName) as FullName, *
  from Employees
  
22. Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
  select distinct Category, ProductName, Price 
  from Products
  Where price > 50
    
  
23. Write a query that selects products whose Price is less than 10% of the average price in the Products table. (Do some research on how to find average price of all products)
  select ProductName, Price
  from Products
  where Price < (select AVG(Price) from Products) * 0.10
  
24. Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
  select *
  from Employees
  where Age < 30 and (DepartmentName='HR' or DepartmentName='IT')
  
  
25. Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
    select * 
    from Customers
    where Email like '%gmail.com'
  
26. Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
  select *
  from Employees
  where Salary > ALL (select Salary from Employees where DepartmentName = 'Sales')
  
27. Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and LATEST_DATE in the table. (Search how to get the current date and latest date)
--version1
  
  select *
  from Orders
  where OrderDate between DATEADD(day, -180, GETDATE()) and GETDATE();

--version2
  select *
  from Orders
  where OrderDate between '2025-05-19' and '2025-11-15';


