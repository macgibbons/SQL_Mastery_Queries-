---------- EMPLOYEE REPORTS ----------
--How many emloyees are there for each role?
SELECT
    COUNT(e.employee_type_id) AS number_of_employees,
    et.name
FROM
    employees e
    JOIN employeetypes et ON et.employee_type_id = e.employee_type_id
GROUP BY
    et.employee_type_id;

--How many finance managers work at each dealership?
SELECT
    d.business_name,
    COUNT(e.employee_id) AS number_of_finance_managers
from
    employeetypes et
    JOIN employees e ON et.employee_type_id = e.employee_type_id
    JOIN dealershipemployees de ON de.employee_id = e.employee_id
    JOIN dealerships d ON de.dealership_id = d.dealership_id
WHERE
    e.employee_type_id = 2
GROUP BY
    d.dealership_id;

--Get the names of the top 3 employees who work shifts at the most dealerships?
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    count(d.dealership_id) AS number_of_shifts
from
    employees e
    JOIN dealershipemployees de ON de.employee_id = e.employee_id
    JOIN dealerships d ON d.dealership_id = de.dealership_id
GROUP BY
    e.employee_id
ORDER BY
    number_of_shifts desc
LIMIT
    3;

--Get a report on the top two employees who has made the most sales through leasing vehicles.
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    COUNT(s.sale_id) as number_of_leases,
    SUM(s.price) AS total_lease_sales
FROM
    employees e
    JOIN sales s ON s.employee_id = e.employee_id
WHERE
    s.sales_type_id = 2
GROUP BY
    employee_name
ORDER BY
    number_of_leases DESC
LIMIT
    2;