-- Create a view that lists all vehicle body types, makes and models.
CREATE VIEW vehicle_types AS
SELECT
    vbt.name AS body_type,
    vm.name AS model,
    vma.name AS make
FROM
    vehicles v
    JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
    JOIN vehiclebodytypes vbt ON vbt.vehicle_body_type_id = vt.body_type_id
    JOIN vehiclemodels vm ON vm.vehicle_model_id = vt.model_id
    JOIN vehiclemakes vma ON vma.vehicle_make_id = vt.make_id;

--Create a view that shows the total number of employees for each employee type.
CREATE VIEW employee_type_numbers AS
SELECT
    et.name,
    COUNT(e.employee_type_id) AS number_of_employees
FROM
    employees e
    JOIN employeetypes et ON et.employee_type_id = e.employee_type_id
GROUP BY
    et.employee_type_id;

--Create a view that lists all customers without exposing their emails, phone numbers and street address.
CREATE VIEW customers_without_personal_info AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state,
    c.zipcode,
    c.company_name
FROM
    customers c;

--Create a view named `sales2018` that shows the total number of sales for each sales type for the year 2018.
CREATE VIEW sales2018 AS
SELECT
    st.name AS sales_type,
    COUNT(s.sale_id) AS number_of_sales
FROM
    sales s
    JOIN salestypes st ON st.sales_type_id = s.sales_type_id
WHERE
    date_part('year', s.purchase_date) = '2018'
GROUP BY
    st.name;

--Create a view that shows the employee at each dealership with the most number of sales.