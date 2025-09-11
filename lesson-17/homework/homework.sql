1. WITH AllDistributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
AllRegions AS (
    SELECT DISTINCT Region FROM #RegionSales
)
SELECT
    ar.Region,
    ad.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM AllDistributors ad
CROSS JOIN AllRegions ar
LEFT JOIN #RegionSales rs
    ON ad.Distributor = rs.Distributor AND ar.Region = rs.Region
ORDER BY
    ad.Distributor, ar.Region;

2. SELECT
    Name
FROM Employee
WHERE id IN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(id) >= 5
);

3. SELECT
    p.product_name,
    SUM(o.unit) AS unit
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
WHERE
    o.order_date >= '2020-02-01' AND o.order_date <= '2020-02-29'
GROUP BY
    p.product_name
HAVING
    SUM(o.unit) >= 100;

4. WITH VendorRank AS (
    SELECT
        CustomerID,
        Vendor,
        RANK() OVER (PARTITION BY CustomerID ORDER BY COUNT(OrderID) DESC) AS RankNum
    FROM
        Orders
    GROUP BY
        CustomerID,
        Vendor
)
SELECT
    CustomerID,
    Vendor
FROM
    VendorRank
WHERE
    RankNum = 1;

5. DECLARE @Check_Prime INT = 91;
DECLARE @IsPrime BIT = 1; 
DECLARE @i INT = 2;

IF @Check_Prime <= 1
    SET @IsPrime = 0;
ELSE
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0; 
            BREAK; 
        END
        SET @i = @i + 1; 
    END

IF @IsPrime = 1
    SELECT 'This number is prime';
ELSE
    SELECT 'This number is not prime';

6. WITH RankedLocations AS (
    SELECT
        Device_id,
        Locations,
        ROW_NUMBER() OVER(PARTITION BY Device_id ORDER BY COUNT(*) DESC) AS rn
    FROM Device
    GROUP BY Device_id, Locations
)
SELECT
    d.Device_id,
    COUNT(DISTINCT d.Locations) AS no_of_location,
    rl.Locations AS max_signal_location,
    COUNT(*) AS no_of_signals
FROM Device d
JOIN RankedLocations rl ON d.Device_id = rl.Device_id AND rl.rn = 1
GROUP BY d.Device_id, rl.Locations;

7. WITH DeptAvgSalary AS (
    SELECT
        EmpID,
        EmpName,
        Salary,
        AVG(Salary) OVER (PARTITION BY DeptID) as AvgDeptSalary
    FROM Employee
)
SELECT
    EmpID,
    EmpName,
    Salary
FROM DeptAvgSalary
WHERE Salary > AvgDeptSalary;

8. WITH MatchCounts AS (
    SELECT
        t.TicketID,
        COUNT(n.Number) AS Matches
    FROM Tickets t
    LEFT JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
)
SELECT
    SUM(
        CASE
            WHEN Matches = (SELECT COUNT(*) FROM Numbers) THEN 100
            WHEN Matches > 0 THEN 10
            ELSE 0
        END
    ) AS TotalWinnings
FROM MatchCounts;

9. SELECT
    Spend_date,
    Platform,
    SUM(Amount) AS Total_Amount,
    COUNT(DISTINCT User_id) AS Total_users
FROM Spending
GROUP BY
    Spend_date,
    Platform
UNION ALL

SELECT
    Spend_date,
    'Both' AS Platform,
    SUM(Amount) AS Total_Amount,
    COUNT(DISTINCT User_id) AS Total_users
FROM Spending
GROUP BY
    Spend_date
ORDER BY
    Spend_date,
    Platform;

10. WITH UnGrouped AS (
        SELECT
        Product,
        1 AS Counter,
        Quantity AS MaxQuantity
    FROM Grouped
    UNION ALL
    SELECT
        Product,
        Counter + 1,
        MaxQuantity
    FROM UnGrouped
    WHERE Counter < MaxQuantity
)
SELECT
    Product,
    1 AS Quantity
FROM UnGrouped
ORDER BY Product;
