--Easy tasks
1. SELECT
    PARSENAME(REPLACE(Name, ',', '.'), 2) AS Name,
    PARSENAME(REPLACE(Name, ',', '.'), 1) AS Surname
FROM TestMultipleColumns;

2. SELECT Strs
FROM TestPercent
WHERE Strs LIKE '%!%%' ESCAPE '!';

3. SELECT
    Vals,
    PARSENAME(Vals, 2) AS FirstPart,
    PARSENAME(Vals, 1) AS SecondPart
FROM Splitter;

4. SELECT
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    '1234ABC123456XYZ1234567890ADS',
    '0','X'),'1','X'),'2','X'),'3','X'),'4','X'),'5','X'),'6','X'),'7','X'),'8','X'),'9','X')
    AS ReplacedString;

5.  SELECT ID, Vals
    FROM testDots
    WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

6. SELECT
    texts,
    LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
    FROM CountSpaces;

7. SELECT e.Name AS Employee
    FROM Employee e
    JOIN Employee m
        ON e.ManagerId = m.Id
    WHERE e.Salary > m.Salary; 

8. SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 10 AND DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 15;


--Medium tasks
1. 
DECLARE @str VARCHAR(100) = 'rtcfvty34redt';
SELECT
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@str, '0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9','') AS Characters,
   REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(@str),'a',''),'b',''),'c',''),'d',''),'e',''),'f',''),'g',''),'h',''),'i',''),'j',''),'k',''),'l',''),'m',''),'n',''),'o',''),'p',''),'q',''),'r',''),'s',''),'t',''),'u',''),'v',''),'w',''),'x',''),'y',''),'z','') AS Integers;

2. WITH Temps AS (
    SELECT
        Id,
        Temperature,
        LAG(Temperature, 1, NULL) OVER (ORDER BY RecordDate) AS Prev_Temp
    FROM weather
)
SELECT Id FROM Temps WHERE Temperature > Prev_Temp;

3. SELECT
    player_id,
    MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id;

4. WITH FruitItems AS (
    SELECT
        value,
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS ItemNumber
    FROM fruits
    CROSS APPLY STRING_SPLIT(fruit_list, ',')
)
SELECT value AS ThirdFruit
FROM FruitItems
WHERE ItemNumber = 3;

5. DECLARE @str VARCHAR(100) = 'sdgfhsdgfhs@121313131';

WITH Chars AS (
    SELECT
        CAST(SUBSTRING(@str, 1, 1) AS VARCHAR(100)) AS C,
        1 AS idx
    UNION ALL
    SELECT
        CAST(SUBSTRING(@str, idx + 1, 1) AS VARCHAR(100)),
        idx + 1
    FROM Chars
    WHERE idx < LEN(@str)
)
SELECT C AS CharacterRow FROM Chars;

6. SELECT
    p1.id,
    CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS code
FROM p1
JOIN p2 ON p1.id = p2.id;

7. SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    CASE
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) <= 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) <= 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) <= 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;

8. SELECT
    VALS,
    CASE
        WHEN VALS LIKE '[0-9]%'
        THEN LEFT(VALS, PATINDEX('%[^0-9]%', VALS + 'a') - 1)
    END AS StartingInteger
FROM GetIntegers;

--Hard tasks
1. WITH Parts AS (
    SELECT
        Id,
        Vals,
        CHARINDEX(',', Vals) AS FirstComma,
        CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) AS SecondComma
    FROM MultipleVals
)
SELECT
    Id,
    CONCAT(
        SUBSTRING(Vals, FirstComma + 1, SecondComma - FirstComma - 1),
        ',',
        LEFT(Vals, FirstComma - 1), 
        SUBSTRING(Vals, SecondComma, LEN(Vals)) 
    ) AS SwappedVals
FROM Parts;

2. WITH RankedLogins AS (
    SELECT
        player_id,
        device_id,
        ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date ASC) as rn
    FROM Activity
)
SELECT player_id, device_id
FROM RankedLogins
WHERE rn = 1;

3. WITH DailyAgg AS (
    SELECT
        Area,
        [Date],
        FinancialWeek,
        FinancialYear,
        DayName,
        SUM(ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0)) AS TotalDailySales
    FROM WeekPercentagePuzzle
    GROUP BY Area, [Date], FinancialWeek, FinancialYear, DayName
),
WeeklyAgg AS (
    SELECT
        *,
        SUM(TotalDailySales) OVER (PARTITION BY Area, FinancialWeek, FinancialYear) AS TotalWeeklySales
    FROM DailyAgg
)
SELECT
    Area,
    [Date],
    DayName,
    FinancialWeek,
    TotalDailySales,
    TotalWeeklySales,
    CAST(TotalDailySales * 100.0 / TotalWeeklySales AS DECIMAL(5, 2)) AS PercentageOfWeek
FROM WeeklyAgg
WHERE TotalWeeklySales > 0;


