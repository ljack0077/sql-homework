1. SELECT id, name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

2. SELECT id, product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

3.SELECT id, name, department_id
FROM employees
WHERE department_id = (SELECT id FROM departments WHERE department_name = 'Sales');

4.SELECT customer_id, name
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

5. SELECT p1.id, p1.product_name, p1.price, p1.category_id
FROM products p1
JOIN (
    SELECT category_id, MAX(price) AS max_price
    FROM products
    GROUP BY category_id
) p2 ON p1.category_id = p2.category_id AND p1.price = p2.max_price;

6. SELECT id, name, salary, department_id
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

7. SELECT id, name, salary, department_id
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);

8. SELECT s.name, g1.course_id, g1.grade
FROM grades g1
JOIN students s ON s.student_id = g1.student_id
WHERE g1.grade = (
    SELECT MAX(grade)
    FROM grades g2
    WHERE g2.course_id = g1.course_id
);

9. SELECT p1.id, p1.product_name, p1.price, p1.category_id
FROM products p1
WHERE 3 = (
    SELECT COUNT(DISTINCT p2.price)
    FROM products p2
    WHERE p2.category_id = p1.category_id AND p2.price >= p1.price
);

10. SELECT id, name, salary, department_id
FROM employees e1
WHERE
    e1.salary > (SELECT AVG(salary) FROM employees)
    AND e1.salary < (SELECT MAX(salary) FROM employees e2 WHERE e2.department_id = e1.department_id);
