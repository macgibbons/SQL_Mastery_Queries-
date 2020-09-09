-- Who are the top 5 dealership for generating sales income?
SELECT
    SUM(s.price) AS total_purchase_sales,
    d.business_name
FROM
    Sales s
    LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
WHERE
    s.sales_type_id = 1
GROUP BY
    d.dealership_id,
    s.price
ORDER BY
    s.price DESC
LIMIT
    5;

-- Who are the top 5 employees for generating sales income?
SELECT
    SUM(s.price) AS total_purchase_sales,
    CONCAT(e.first_name, ' ', e.last_name) AS Employee_name
FROM
    Sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
WHERE
    s.sales_type_id = 1
GROUP BY
    e.employee_id
ORDER BY
    total_purchase_sales DESC
LIMIT
    5;

-- Which vehicle model generated the most sales income?    
SELECT
    vm.name,
    SUM(s.price)
FROM
    vehicles v
    JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
    JOIN vehiclemodels vm ON vm.vehicle_model_id = vt.model_id
    JOIN Sales s ON s.vehicle_id = v.vehicle_id
WHERE
    s.sales_type_id = 1
GROUP BY
    vm.name,
    s.price
ORDER BY
    s.price DESC
LIMIT
    1;

-- Which employees generate the most income per dealership?
SELECT
    DISTINCT ON (d.dealership_id) d.dealership_id,
    SUM(s.price) AS total_purchase_sales,
    d.business_name,
    CONCAT(e.first_name, ' ', e.last_name) AS Employee_name
FROM
    Sales s
    JOIN employees e ON s.employee_id = e.employee_id
    JOIN dealerships d ON d.dealership_id = s.dealership_id
GROUP BY
    d.dealership_id,
    Employee_name
ORDER BY
    d.dealership_id,
    total_purchase_sales DESC;

--In our Vehicle inventory, show the count of each Model that is in stock.
SELECT
    vm.name,
    COUNT(vm.name) AS inventory
FROM
    Vehicles v
    JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
    JOIN vehiclemodels vm ON vm.vehicle_model_id = vt.model_id
WHERE
    NOT EXISTS (
        SELECT
        FROM
            sales s
        where
            s.vehicle_id = v.vehicle_id
    )
GROUP BY
    vm.name;

--In our Vehicle inventory, show the count of each Make that is in stock.
SELECT
    vm.name,
    COUNT(vm.name) AS inventory
FROM
    Vehicles v
    JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
    JOIN vehiclemakes vm ON vm.vehicle_make_id = vt.make_id
WHERE
    NOT EXISTS (
        SELECT
        FROM
            sales s
        WHERE
            s.vehicle_id = v.vehicle_id
    )
GROUP BY
    vm.name;

--In our Vehicle inventory, show the count of each BodyType that is in stock.
SELECT
    vbt.name,
    COUNT(vbt.name) AS inventory
FROM
    Vehicles v
    JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
    JOIN vehiclebodytypes vbt ON vbt.vehicle_body_type_id = vt.body_type_id
WHERE
    NOT EXISTS (
        SELECT
        FROM
            sales s
        WHERE
            s.vehicle_id = v.vehicle_id
    )
GROUP BY
    vbt.name;

-- Which US state's customers have the highest average purchase price for a vehicle?
SELECT
    TRUNC(AVG(s.price), 2) AS Average_sale,
    c.state
FROM
    Sales s
    JOIN customers c ON c.customer_id = s.customer_id
GROUP BY
    c.state
ORDER BY
    Average_sale DESC
LIMIT
    1;

-- Of the 5 US states with the most customers that you determined above, which of those have the customers with the highest average purchase price for a vehicle?
WITH most_customers AS (
    SELECT
        TRUNC(AVG(s.price), 2) AS Average_sale,
        c.state,
        COUNT(c.customer_id) AS number_of_customers
    FROM
        Sales s
        JOIN customers c ON c.customer_id = s.customer_id
    GROUP BY
        c.state
    ORDER BY
        number_of_customers DESC
    LIMIT
        5
)
SELECT
    *
FROM
    most_customers c
ORDER BY
    average_sale DESC
LIMIT
    1;