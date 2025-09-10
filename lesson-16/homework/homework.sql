
-- Easy Tasks

1.WITH NumbersCTE AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1
    FROM NumbersCTE
    WHERE Number < 1000
)
SELECT Number
FROM NumbersCTE
OPTION (MAXRECURSION 1000);

2.SELECT
    e.FirstName,
    e.LastName,
    TotalSalesPerEmployee.TotalSales
FROM Employees e
JOIN (
    SELECT
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS TotalSalesPerEmployee ON e.EmployeeID = TotalSalesPerEmployee.EmployeeID;

3.sql
WITH SalaryCTE AS (
    SELECT AVG(Salary) AS AverageSalary
    FROM Employees
)
SELECT AverageSalary
FROM SalaryCTE;

4.SELECT
    p.ProductName,
    ProductMaxSale.HighestSale
FROM Products p
JOIN (
    SELECT
        ProductID,
        MAX(SalesAmount) AS HighestSale
    FROM Sales
    GROUP BY ProductID
) AS ProductMaxSale ON p.ProductID = ProductMaxSale.ProductID;

5. WITH DoublingCTE AS (
    SELECT 1 AS DoubledValue
    UNION ALL
    SELECT DoubledValue * 2
    FROM DoublingCTE
    WHERE DoubledValue < 500000 
SELECT DoubledValue
FROM DoublingCTE;

6.WITH EmployeeSalesCounts AS (
    SELECT EmployeeID, COUNT(SalesID) AS NumberOfSales
    FROM Sales
    GROUP BY EmployeeID
    HAVING COUNT(SalesID) > 5
)
SELECT
    e.FirstName,
    e.LastName,
    esc.NumberOfSales
FROM Employees e
JOIN EmployeeSalesCounts esc ON e.EmployeeID = esc.EmployeeID;

7. WITH HighValueProducts AS (
    SELECT DISTINCT ProductID
    FROM Sales
    WHERE SalesAmount > 500
)
SELECT
    p.ProductName,
    p.Price
FROM Products p
JOIN HighValueProducts hvp ON p.ProductID = hvp.ProductID;

8. WITH AverageSalary AS (
    SELECT AVG(Salary) as AvgSal
    FROM Employees
)
SELECT
    e.FirstName,
    e.LastName,
    e.Salary
FROM Employees e, AverageSalary av
WHERE e.Salary > av.AvgSal;

--Medium Tasks

1.SELECT
    e.FirstName,
    e.LastName,
    TopEmployees.OrderCount
FROM Employees e
JOIN (
    SELECT TOP 5
        EmployeeID,
        COUNT(SalesID) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
    ORDER BY OrderCount DESC
) AS TopEmployees ON e.EmployeeID = TopEmployees.EmployeeID;

2.SELECT
    dt.CategoryID,
    SUM(dt.SalesAmount) AS TotalCategorySales
FROM (
    SELECT
        p.CategoryID,
        s.SalesAmount
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
) AS dt
GROUP BY dt.CategoryID;

3.WITH FactorialCTE (n, fact) AS (
    SELECT 1, CAST(1 AS BIGINT)
    UNION ALL
    SELECT n + 1, CAST(fact AS BIGINT) * (n + 1)
    FROM FactorialCTE
    WHERE n < 20
)
SELECT
    n1.Number,
    f.fact AS Factorial
FROM Numbers1 n1
JOIN FactorialCTE f ON n1.Number = f.n;

4.WITH SplitterCTE AS (
    SELECT Id, CAST(SUBSTRING(String, 1, 1) AS VARCHAR(30)) AS C, 1 AS CharIndex
    FROM Example
    UNION ALL
    SELECT s.Id, CAST(SUBSTRING(e.String, s.CharIndex + 1, 1) AS VARCHAR(30)), s.CharIndex + 1
    FROM SplitterCTE s
    JOIN Example e ON s.Id = e.Id
    WHERE s.CharIndex < LEN(e.String)
)
SELECT Id, C AS Character FROM SplitterCTE ORDER BY Id, CharIndex;

5. WITH MonthlySales AS (
    SELECT
        EOMONTH(SaleDate) AS MonthEnd,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EOMONTH(SaleDate)
),
SalesWithLag AS (
    SELECT
        MonthEnd,
        TotalSales,
        LAG(TotalSales, 1, 0) OVER (ORDER BY MonthEnd) AS PreviousMonthSales
    FROM MonthlySales
)
SELECT
    FORMAT(MonthEnd, 'yyyy-MM') AS Month,
    TotalSales,
    PreviousMonthSales,
    TotalSales - PreviousMonthSales AS SalesDifference
FROM SalesWithLag;

6.SELECT
    e.FirstName,
    e.LastName,
    qs.SalesYear,
    qs.SalesQuarter,
    qs.TotalQuarterlySales
FROM Employees e
JOIN (
    SELECT
        EmployeeID,
        YEAR(SaleDate) AS SalesYear,
        DATEPART(quarter, SaleDate) AS SalesQuarter,
        SUM(SalesAmount) AS TotalQuarterlySales
    FROM Sales
    GROUP BY EmployeeID, YEAR(SaleDate), DATEPART(quarter, SaleDate)
    HAVING SUM(SalesAmount) > 45000
) AS qs ON e.EmployeeID = qs.EmployeeID;

-- Difficult Tasks

1.WITH FibonacciCTE (n, current_fib, next_fib) AS (
    SELECT 1, CAST(0 AS BIGINT), CAST(1 AS BIGINT)
    UNION ALL
    SELECT n + 1, next_fib, current_fib + next_fib
    FROM FibonacciCTE
    WHERE n < 20 
)
SELECT current_fib AS FibonacciNumber FROM FibonacciCTE;

2.SELECT Id, Vals
FROM FindSameCharacters
WHERE
    LEN(Vals) > 1
    AND REPLACE(Vals, LEFT(Vals, 1), '') = '';

3. DECLARE @n INT = 5;
WITH NumberSequence (n, val) AS (
    SELECT 1, CAST('1' AS VARCHAR(MAX))
    UNION ALL
    SELECT n + 1, val + CAST(n + 1 AS VARCHAR(MAX))
    FROM NumberSequence
    WHERE n < @n
)
SELECT val AS CumulativeSequence FROM NumberSequence;

4.SELECT
    e.FirstName,
    e.LastName,
    TopSellers.TotalSales
FROM Employees e
JOIN (
    SELECT TOP 1 WITH TIES
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(month, -6, GETDATE())
    GROUP BY EmployeeID
    ORDER BY TotalSales DESC
) AS TopSellers ON e.EmployeeID = TopSellers.EmployeeID;

5.WITH Extracted AS (
    SELECT
        Pawan_slug_name,
        LEN(Pawan_slug_name) - CHARINDEX('-', REVERSE(Pawan_slug_name)) + 1 AS HyphenPos,
        SUBSTRING(Pawan_slug_name,
            LEN(Pawan_slug_name) - CHARINDEX('-', REVERSE(Pawan_slug_name)) + 2,
            LEN(Pawan_slug_name)) AS PotentialNum
    FROM RemoveDuplicateIntsFromNames
),
NumbersToRemove AS (
    SELECT
        Pawan_slug_name,
        PotentialNum
    FROM Extracted
    WHERE
        ISNUMERIC(PotentialNum) = 1 
        AND (
            LEN(PotentialNum) = 1 
            OR
            REPLACE(PotentialNum, LEFT(PotentialNum, 1), '') = '' 
        )
)
SELECT
    r.Pawan_slug_name AS Original,
    CASE
        WHEN ntr.Pawan_slug_name IS NOT NULL
        THEN LEFT(r.Pawan_slug_name, LEN(r.Pawan_slug_name) - LEN(ntr.PotentialNum))
        ELSE r.Pawan_slug_name
    END AS CleanedName
FROM RemoveDuplicateIntsFromNames r
LEFT JOIN NumbersToRemove ntr ON r.Pawan_slug_name = ntr.Pawan_slug_name;
