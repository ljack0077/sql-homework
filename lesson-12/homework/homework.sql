1.  SELECT
  p.firstName,
  p.lastName,
  a.city,
  a.state
FROM Person AS p
LEFT JOIN Address AS a
  ON p.personId = a.personId;

2. SELECT
  e.name AS Employee
FROM Employee AS e
JOIN Employee AS m
  ON e.managerId = m.id
WHERE
  e.salary > m.salary;

3. SELECT
  email
FROM Person
GROUP BY
  email
HAVING
  COUNT(email) > 1;

4. WITH RankedEmails AS (
  SELECT
    id,
    ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
  FROM Person
)
DELETE FROM RankedEmails
WHERE
  rn > 1;

5. SELECT
  ParentName
FROM girls
EXCEPT
SELECT
  ParentName
FROM boys;

6. GO SELECT custid, SUM(freight)
  AS TotalSales, MIN(freight)
  AS LeastWeight 
  FROM Sales.Orders 
  WHERE freight > 50 
  GROUP BY custid;

7. SELECT c1.Item AS "Item Cart 1", c2.Item AS "Item Cart 2" 
  FROM Cart1 AS c1 
  FULL OUTER JOIN Cart2 AS c2 
  ON c1.Item = c2.Item;

8. SELECT c.name AS Customers 
  FROM Customers AS c 
  LEFT JOIN Orders AS o 
  ON c.id = o.customerId 
  WHERE o.customerId IS NULL;

9. SELECT s.student_id, s.student_name, sub.subject_name, 
  COUNT(e.subject_name) AS attended_exams
  FROM Students AS s 
  CROSS JOIN Subjects AS sub 
  LEFT JOIN Examinations AS e 
  ON s.student_id = e.student_id AND sub.subject_name = e.subject_name 
  GROUP BY s.student_id, s.student_name, sub.subject_name 
  ORDER BY s.student_id, sub.subject_name;
