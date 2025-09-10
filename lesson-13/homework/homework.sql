--Easy Tasks

1. SELECT CONCAT(EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME) AS FormattedName
FROM Employees;

2. UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999')
WHERE PHONE_NUMBER LIKE '%124%';

3. SELECT
    FIRST_NAME AS "First Name",
    LEN(FIRST_NAME) AS "Name Length"
FROM Employees
WHERE
    FIRST_NAME LIKE 'A%'
    OR FIRST_NAME LIKE 'J%'
    OR FIRST_NAME LIKE 'M%'
ORDER BY "First Name";

4. SELECT
    MANAGER_ID,
    SUM(SALARY) AS "Total Salary"
FROM Employees
WHERE MANAGER_ID IS NOT NULL AND MANAGER_ID <> 0
GROUP BY MANAGER_ID;

5. SELECT
    Year1,
    (SELECT MAX(v) FROM (VALUES (Max1), (Max2), (Max3)) AS value(v)) AS HighestValue
FROM TestMax;

6. SELECT id, movie, description, rating
FROM cinema
WHERE id % 2 <> 0 AND description <> 'boring';

7. SELECT Id, Vals
FROM SingleOrder
ORDER BY
    CASE WHEN Id = 0 THEN 1 ELSE 0 END,
    Id;

8. SELECT COALESCE(ssn, passportid, itin) AS Identifier
FROM person;

--MEDIUM tasks

1.SELECT
    FullName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM Students;

2.SELECT CustomerID, OrderID, DeliveryState, Amount
FROM Orders
WHERE
    DeliveryState = 'TX'
    AND CustomerID IN (SELECT DISTINCT CustomerID FROM Orders WHERE DeliveryState = 'CA');

3.SELECT STRING_AGG(String, ' ') WITHIN GROUP (ORDER BY SequenceNumber ASC) AS Command
FROM DMLTable;

4.SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM Employees
WHERE (LEN(LOWER(FIRST_NAME) + LOWER(LAST_NAME)) - LEN(REPLACE(LOWER(FIRST_NAME) + LOWER(LAST_NAME), 'a', ''))) >= 3;

5.SELECT
    DEPARTMENT_ID,
    COUNT(*) AS TotalEmployees,
    CAST(
        SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
        AS DECIMAL(5, 2)
    ) AS PctOver3Years
FROM Employees
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;

6.WITH RankedSpacemen AS (
    SELECT
        JobDescription,
        SpacemanID,
        ROW_NUMBER() OVER(PARTITION BY JobDescription ORDER BY MissionCount DESC) as rn_desc,
        ROW_NUMBER() OVER(PARTITION BY JobDescription ORDER BY MissionCount ASC) as rn_asc
    FROM Personal
)
SELECT
    JobDescription,
    MAX(CASE WHEN rn_desc = 1 THEN SpacemanID END) AS MostExperienced,
    MAX(CASE WHEN rn_asc = 1 THEN SpacemanID END) AS LeastExperienced
FROM RankedSpacemen
GROUP BY JobDescription;

--Difficult tasks

1.DECLARE @str VARCHAR(100) = 'tf56sd#%OqH';

WITH Tally AS (
    SELECT TOP (LEN(@str)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
    FROM sys.objects
),
Chars AS (
    SELECT SUBSTRING(@str, N, 1) AS C
    FROM Tally
)
SELECT
    STRING_AGG(CASE WHEN C LIKE '[A-Z]' COLLATE Latin1_General_CS_AS THEN C END, '') AS Uppercase,
    STRING_AGG(CASE WHEN C LIKE '[a-z]' COLLATE Latin1_General_CS_AS THEN C END, '') AS Lowercase,
    STRING_AGG(CASE WHEN C LIKE '[0-9]' THEN C END, '') AS Numbers,
    STRING_AGG(CASE WHEN C NOT LIKE '[A-Za-z0-9]' THEN C END, '') AS Special
FROM Chars;

2. SELECT
    StudentID,
    FullName,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Students;

3. DECLARE @sql NVARCHAR(MAX);

SELECT @sql = STRING_AGG('SELECT ''' + Equation + ''' AS Equation, ' + Equation + ' AS Result', ' UNION ALL ')
FROM Equations;

EXEC sp_executesql @sql;

4. WITH BirthdayCounts AS (
    SELECT
        StudentName,
        Birthday,
        COUNT(*) OVER (PARTITION BY Birthday) as Cnt
    FROM Student
)
SELECT StudentName, Birthday
FROM BirthdayCounts
WHERE Cnt > 1
ORDER BY Birthday, StudentName;

5. SELECT
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;


