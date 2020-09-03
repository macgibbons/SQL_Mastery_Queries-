------- PURCHASE INCOME BY DEALSERSHIP ----------
-- Write a query that shows the total purchase sales income per dealership.
SELECT
    SUM(s.price) AS total_purchase_sales,
    d.business_name
FROM
    Sales s
    LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE
    s.sales_type_id = 1
GROUP BY
    d.dealership_id;

--Write a query that shows the purchase sales income per dealership for the current month.
SELECT
    SUM(s.price) AS total_purchase_sales,
    d.business_name
FROM
    Sales s
    LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE
    s.sales_type_id = 1
    AND s.purchase_date >= date_trunc('MONTH', CURRENT_DATE)
GROUP BY
    d.dealership_id;

--Write a query that shows the purchase sales income per dealership for the current year.
SELECT
    SUM(s.price) AS total_purchase_sales,
    d.business_name
FROM
    Sales s
    LEFT JOIN dealerships d on s.dealership_id = d.dealership_id
WHERE
    s.sales_type_id = 1
    AND s.purchase_date >= date_trunc('YEAR', CURRENT_DATE)
GROUP BY
    d.dealership_id;

------- LEASE INCOME BY DEALSERSHIP ----------
-- Write a query that shows the total lease income per dealership.
SELECT
    SUM(s.price) AS total_purchase_sales,
    d.business_name
FROM
    Sales s
    LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE
    s.sales_type_id = 2
GROUP BY
    d.dealership_id;

-- Write a query that shows the lease income per dealership for the current month.
SELECT
    SUM(s.price) AS total_purchase_sales,
    d.business_name
FROM
    Sales s
    LEFT JOIN dealerships d on s.dealership_id = d.dealership_id
WHERE
    s.sales_type_id = 2
    AND s.purchase_date >= date_trunc('MONTH', CURRENT_DATE)
GROUP BY
    d.dealership_id;

-- Write a query that shows the lease income per dealership for the current year.
SELECT
    SUM(s.price) AS total_purchase_sales,
    d.business_name
FROM
    Sales s
    LEFT JOIN dealerships d on s.dealership_id = d.dealership_id
WHERE
    s.sales_type_id = 2
    AND s.purchase_date >= date_trunc('YEAR', CURRENT_DATE)
GROUP BY
    d.dealership_id;

------- TOTAL INCOME BY EMPLOYEE ----------
-- Write a query that shows the total income (purchase and lease) per employee.
SELECT
    SUM(s.price) AS total_purchase_sales,
    CONCAT(e.first_name, ' ', e.last_name) AS Employee_name
FROM
    Sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
GROUP BY
    e.employee_id
ORDER BY
    total_purchase_sales DESC