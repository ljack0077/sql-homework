# Lesson 7 Homework Tasks

These homework tasks cover the following topics:
- **Aggregate Functions** (MIN, MAX, COUNT, AVG, SUM)
- **Filtering Aggregated Data with HAVING**

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.

---

# 🟢 Easy-Level Tasks (10)

1. Write a query to find the minimum (MIN) price of a product in the Products table.
2. Write a query to find the maximum (MAX) Salary from the Employees table.
3. Write a query to count the number of rows in the Customers table.
4. Write a query to count the number of unique product categories from the Products table.
5. Write a query to find the total sales amount for the product with id 7 in the Sales table.
6. Write a query to calculate the average age of employees in the Employees table.
7. Write a query to count the number of employees in each department.
8. Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
9. Write a query to calculate the total sales per Customer in the Sales table.
10. Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).

---

# 🟠 Medium-Level Tasks (9)

11. Write a query to calculate the total sales and average sales for each product category from the Sales table.
12. Write a query to count the number of employees from the Department HR.
13. Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
14. Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
15. Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
16. Write a query to filter product categories with an average price greater than 400.
17. Write a query that calculates the total sales for each year in the Sales table.
18. Write a query to show the list of customers who placed at least 3 orders.
19. Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you don't have DeptName).

---

# 🔴 Hard-Level Tasks (6)

20. Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150.
21. Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.
22. Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.
23. Write a query to find total amount for the orders which weights more than $50 for each customer along with their least purchases.(least amount might be lower than 50, use tsql2012.sales.orders table,freight col, ask ur assistant to give the TSQL2012 database).
25. Write a query that calculates the total sales and counts unique products sold in each month of each year, and then filter the months with at least 2 products sold.(Orders)
26. Write a query to find the MIN and MAX order quantity per Year. From orders table.
**Necessary tables:**
```sql

```
