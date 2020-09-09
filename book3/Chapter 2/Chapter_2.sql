---------- Practice - Employees ----------
-- A sales employee at carnival creates a new sales record for a sale they are trying to close. 
-- The customer, last minute decided not to purchase the vehicle. 
-- Help delete the Sales record with an invoice number of '7628231837'.
DELETE FROM
    sales
WHERE
    invoice_number = '7628231837';

----------
-- An employee was recently fired so we must delete them from our database. 
-- Delete the employee with employee_id of 35. What problems might you run into when deleting? 
-- How would you recommend fixing it?
ALTER TABLE
    -- DROP FK constraint 
    sales DROP CONSTRAINT sales_employee_id_fkey;

ALTER TABLE
    -- add back constraint but set ON DELETE to NULL
    sales
ADD
    CONSTRAINT sales_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE
SET
    NULL;

ALTER TABLE
    dealershipemployees DROP CONSTRAINT sales_employee_id_fkey;

ALTER TABLE
    dealershipemployees
ADD
    CONSTRAINT dealershipemployees_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE
SET
    NULL;

DELETE FROM
    employees
WHERE
    employee_id = 35;