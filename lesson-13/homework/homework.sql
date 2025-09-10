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


