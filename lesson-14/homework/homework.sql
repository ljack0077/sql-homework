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

4. 
--Hard tasks



