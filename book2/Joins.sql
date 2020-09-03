-- Get a list of the sales that was made for each sales type.
SELECT 
	s.price,
	s.deposit,
	s.purchase_date,
	st.name AS Sales_type
FROM
	sales s
RIGHT JOIN Salestypes st
	ON s.sales_type_id = st.sales_type_id;


-- Get a list of sales with the VIN of the vehicle, the first name and last name of the customer,
-- first name and last name of the employee who made the sale and the name, city and state of the dealership.
SELECT 
	s.price,
	s.deposit, 
	s.purchase_date,
	v.vin,
	c.first_name AS customer_first_name,
	c.last_name AS customer_last_name,
	e.first_name AS employee_first_name,
	e.Last_name AS employee_last_name,
	d.business_name AS dealership,
	d.city, 
	d.state
FROM
	sales s
INNER JOIN dealerships d
	ON s.dealership_id = d.dealership_id
INNER JOIN vehicles v
	ON s.vehicle_id = v.vehicle_id
INNER JOIN employees e
	ON s.employee_id = e.employee_id
INNER JOIN customers c
	ON s.customer_id = c.customer_id

-- Get a list of all the dealerships and the employees, if any, working at each one.

SELECT 
	e.first_name,
	e.last_name,
	d.business_name
FROM 
	dealerships d
INNER JOIN employees e
	ON e.dealership_id = d.dealership_id

-- With Join table
SELECT
    d.business_name, CONCAT(e.first_name, ' ', e.last_name) as employee_last_name
FROM
    dealerships d  
LEFT JOIN
    dealershipemployees de ON d.dealership_id = de.dealership_id
LEFT JOIN
    employees e ON e.employee_id = de.employee_id


-- Get a list of vehicles with the names of the body type, make, model and color.

SELECT 
	v.exterior_color,
	v.interior_color,
	vbt.name AS body_type,
	vm.name AS make,
	vmo.name AS model
FROM
	vehicles v
LEFT JOIN vehicletypes vt
	ON v.vehicle_type_id = vt.vehicle_type_id
LEFT JOIN vehiclebodytype vbt
	ON vt.body_type_id = vbt.vehicle_body_type_id
LEFT JOIN vehiclemake vm
	ON vt.vehicle_make_id = vm.vehicle_make_id
LEFT JOIN vehiclemodel vmo
	ON vt.vehicle_model_id = vmo.vehicle_model_id

	