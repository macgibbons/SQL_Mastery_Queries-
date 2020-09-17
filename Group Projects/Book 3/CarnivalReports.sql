CREATE TABLE AccountsReceivable (
    accounts_receivable_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    credit_amount INT,
    debit_amount INT,
    sales_id INT REFERENCES Sales (sale_id)
);

-- Set up a trigger on the Sales table. When a new row is added, 
-- add a new record to the Accounts Receivable table with the deposit as credit_amount,
-- the timestamp as date_received and the appropriate sale_id.
CREATE
OR REPLACE FUNCTION new_ar_record () RETURNS TRIGGER LANGUAGE PLPGSQL AS $ $ BEGIN
INSERT INTO
    accountsreceivable (
        credit_amount,
        date_received,
        sales_id
    )
VALUES
    (
        NEW.deposit,
        NOW(),
        new.sale_id
    );

RETURN NULL;

END;

$ $;

CREATE TRIGGER new_sale_made
AFTER
INSERT
    ON sales FOR EACH ROW EXECUTE PROCEDURE new_ar_record ();

-- insert to test
INSERT INTO
    sales (
        sales_type_id,
        vehicle_id,
        employee_id,
        dealership_id,
        price,
        invoice_number,
        purchase_date,
        pickup_date,
        deposit
    )
VALUES
    (
        1,
        11,
        111,
        111,
        10111,
        101010101,
        CURRENT_DATE,
        CURRENT_DATE,
        500
    );

-- Set up a trigger on the Sales table for when the sale_returned flag is updated. 
-- Add a new row to the Accounts Receivable table with the deposit as debit_amount, 
-- the timestamp as date_received, etc.
CREATE
OR REPLACE FUNCTION sale_returned_record() RETURNS TRIGGER LANGUAGE PLPGSQL AS $ $ BEGIN
INSERT INTO
    accountsreceivable (
        debit_amount,
        date_received,
        sales_id
    )
VALUES
    (NEW.deposit, NOW(), new.sale_id);

RETURN NULL;

END;

$ $ CREATE TRIGGER new_sale_returned
AFTER
UPDATE
    ON sales FOR EACH ROW EXECUTE PROCEDURE sale_returned_record ();

-- Create a stored procedure with a transaction to handle hiring a new employee. 
-- Add a new record for the employee in the Employees table and add a record to the Dealershipemployees table for the two dealerships the new employee will start at.
CREATE
OR REPLACE PROCEDURE add_new_employee_to_dealerships (
    first_name VARCHAR,
    last_name VARCHAR,
    email_address VARCHAR,
    phone VARCHAR,
    employee_type_id INT,
    dealership_id_1 INT,
    dealership_id_2 INT
) LANGUAGE plpgsql AS $ $ DECLARE NewEmployeeID INT;

BEGIN
INSERT INTO
    employees(
        first_name,
        last_name,
        email_address,
        phone,
        employee_type_id
    )
VALUES
    (
        first_name,
        last_name,
        email_address,
        phone,
        employee_type_id
    ) RETURNING employee_id INTO NewEmployeeId;

INSERT INTO
    dealershipemployees(employee_id, dealership_id)
VALUES
    (newEmployeeID, dealership_id_1);

INSERT INTO
    dealershipemployees(employee_id, dealership_id)
VALUES
    (newEmployeeID, dealership_id_2);

COMMIT;

END $ $;

SELECT
    *
FROM
    dealershipemployees
WHERE
    employee_id = 1001;

CALL add_new_employee_to_dealerships(
    'Herman',
    'Munster',
    'hm@adamsfamily.com',
    '213-853-1000',
    1,
    7,
    3
);