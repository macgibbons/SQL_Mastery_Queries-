-- Get a list of sales records where the sale was a lease

SELECT
    s.vehicle_id,
    s.employee_id,
    s.customer_id,
    s.dealership_id,
    s.price,
    s.deposit,
    s.purchase_date,
    s.pickup_date,
    s.invoice_number,
    s.payment_method
FROM 
    sales s
WHERE 
    s.sales_type_id = 2

-- Get a list of sales 
-- where the purchase date is within the last two years.

SELECT
    s.vehicle_id,
    s.employee_id,
    s.customer_id,
    s.dealership_id,
    s.price,
    s.deposit,
    s.purchase_date,
    s.pickup_date,
    s.invoice_number,
    s.payment_method
FROM 
    sales s
WHERE 
    s.purchase_date >= now() - interval '2 years'

-- Get a list of sales 
-- where the deposit was above 5000 or the customer payed with American Express.


SELECT
    s.vehicle_id,
    s.employee_id,
    s.customer_id,
    s.dealership_id,
    s.price,
    s.deposit,
    s.purchase_date,
    s.pickup_date,
    s.invoice_number,
    s.payment_method
FROM 
    sales s
WHERE 
    s.deposit >= 5000 OR s.payment_method = 'americanexpress'

-- Get a list of employees whose first names start with "M" 
-- or ends with "E"

SELECT 
    e.first_name,
    e.last_name
FROM
    employees e
WHERE 
    e.first_name LIKE 'M%' OR e.first_name LIKE '%e'

-- Get a list of employees 
-- whose phone numbers have the 600 area code.

SELECT 
    e.first_name,
    e.last_name,
    e.phone
FROM
    employees e
WHERE 
    e.phone LIKE '600%'