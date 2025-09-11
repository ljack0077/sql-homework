1.  DECLARE @CurrentDate DATE = '2025-04-25';

    CREATE TABLE #MonthlySales (
        ProductID INT,
        TotalQuantity INT,
        TotalRevenue DECIMAL(18, 2)
    );

    INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
    SELECT
        s.ProductID,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE YEAR(s.SaleDate) = YEAR(@CurrentDate) AND MONTH(s.SaleDate) = MONTH(@CurrentDate)
    GROUP BY s.ProductID;

    SELECT * FROM #MonthlySales;

    DROP TABLE #MonthlySales;
  2. CREATE VIEW vw_ProductSalesSummary AS
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,
        ISNULL(SUM(s.Quantity), 0) AS TotalQuantitySold
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category;
    GO
    SELECT * FROM vw_ProductSalesSummary ORDER BY ProductID;
    GO
    DROP VIEW vw_ProductSalesSummary;
    GO
  3. CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
    RETURNS DECIMAL(18, 2)
    AS
    BEGIN
        DECLARE @TotalRevenue DECIMAL(18, 2);

        SELECT @TotalRevenue = ISNULL(SUM(s.Quantity * p.Price), 0.00)
        FROM Sales s
        JOIN Products p ON s.ProductID = p.ProductID
        WHERE s.ProductID = @ProductID;

        RETURN @TotalRevenue;
    END;
    GO
    SELECT dbo.fn_GetTotalRevenueForProduct(1) AS RevenueForProduct1;
    GO
    DROP FUNCTION fn_GetTotalRevenueForProduct;
    GO
   
4. CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
    RETURNS TABLE
    AS
    RETURN
    (
        SELECT
            p.ProductName,
            ISNULL(SUM(s.Quantity), 0) AS TotalQuantity,
            ISNULL(SUM(s.Quantity * p.Price), 0.00) AS TotalRevenue
        FROM Products p
        LEFT JOIN Sales s ON p.ProductID = s.ProductID
        WHERE p.Category = @Category
        GROUP BY p.ProductName
    );
    GO
    SELECT * FROM dbo.fn_GetSalesByCategory('Groceries');
    GO
    DROP FUNCTION fn_GetSalesByCategory;
    GO
   
5. CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
    RETURNS VARCHAR(3)
    AS
    BEGIN
        IF @Number <= 1 RETURN 'No';
        IF @Number = 2 RETURN 'Yes';
        IF @Number % 2 = 0 RETURN 'No';

        DECLARE @i INT = 3;
        WHILE @i <= SQRT(@Number)
        BEGIN
            IF @Number % @i = 0 RETURN 'No';
            SET @i = @i + 2;
        END

        RETURN 'Yes';
    END;
    GO
    SELECT dbo.fn_IsPrime(7) AS Is7Prime, dbo.fn_IsPrime(10) AS Is10Prime;
    GO
    DROP FUNCTION dbo.fn_IsPrime;
    GO
   
6. CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
    RETURNS TABLE
    AS
    RETURN
    (
        WITH NumberSequence AS (
            SELECT @Start AS Number
            UNION ALL
            SELECT Number + 1
            FROM NumberSequence
            WHERE Number < @End
        )
        SELECT Number FROM NumberSequence
    );
    GO
    SELECT * FROM dbo.fn_GetNumbersBetween(5, 15);
    GO
    DROP FUNCTION fn_GetNumbersBetween;
    GO
   
7.  CREATE TABLE Employee (id INT, salary INT);
    INSERT INTO Employee VALUES (1, 100), (2, 200), (3, 300);
    GO
   CREATE FUNCTION dbo.getNthHighestSalary(@N INT) RETURNS INT AS
    BEGIN
        RETURN (
            SELECT DISTINCT salary
            FROM Employee
            ORDER BY salary DESC
            OFFSET @N - 1 ROWS
            FETCH NEXT 1 ROWS ONLY
        );
    END;
    GO
    SELECT dbo.getNthHighestSalary(2) AS HighestNSalary;
    GO
    DROP FUNCTION dbo.getNthHighestSalary;
    DROP TABLE Employee;
    GO
  
8.  CREATE TABLE RequestAccepted (requester_id INT, accepter_id INT, accept_date DATE);
    INSERT INTO RequestAccepted VALUES
    (1, 2, '2016/06/03'), (1, 3, '2016/06/08'), (2, 3, '2016/06/08'), (3, 4, '2016/06/09');
    GO
    WITH AllFriends AS (
        SELECT requester_id AS id FROM RequestAccepted
        UNION ALL
        SELECT accepter_id AS id FROM RequestAccepted
    )
    SELECT TOP 1
        id,
        COUNT(*) as num
    FROM AllFriends
    GROUP BY id
    ORDER BY num DESC;
    GO
    DROP TABLE RequestAccepted;
    GO
  9. CREATE TABLE Customers (customer_id INT PRIMARY KEY, name VARCHAR(100), city VARCHAR(50));
    CREATE TABLE Orders (order_id INT PRIMARY KEY, customer_id INT, order_date DATE, amount DECIMAL(10,2));
    INSERT INTO Customers VALUES (1, 'Alice Smith', 'New York'),(2, 'Bob Jones', 'Chicago'),(3, 'Carol White', 'Los Angeles');
    INSERT INTO Orders VALUES (101, 1, '2024-12-10', 120.00), (102, 1, '2024-12-20', 200.00), (103, 1, '2024-12-30', 220.00),
    (104, 2, '2025-01-12', 120.00), (105, 2, '2025-01-20', 180.00);
    GO
    CREATE VIEW vw_CustomerOrderSummary AS
    SELECT
        c.customer_id,
        c.name,
        ISNULL(COUNT(o.order_id), 0) AS total_orders,
        ISNULL(SUM(o.amount), 0.00) AS total_amount,
        MAX(o.order_date) AS last_order_date
    FROM Customers c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name;
    GO
    SELECT * FROM vw_CustomerOrderSummary;
    GO
    DROP VIEW vw_CustomerOrderSummary;
    DROP TABLE Orders;
    DROP TABLE Customers;
    GO
    
10. CREATE TABLE Gaps (RowNumber INT PRIMARY KEY, TestCase VARCHAR(100) NULL);
    INSERT INTO Gaps VALUES (1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),(5,'Bravo'),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,'Charlie'), (11, NULL), (12, NULL);
    GO
    WITH Grouping AS (
        SELECT
            RowNumber,
            TestCase,
            COUNT(TestCase) OVER (ORDER BY RowNumber) AS grp
        FROM Gaps
    )
    SELECT
        RowNumber,
        FIRST_VALUE(TestCase) OVER (PARTITION BY grp ORDER BY RowNumber) AS Workflow
    FROM Grouping;
    GO
    DROP TABLE Gaps;
    GO
    ```
