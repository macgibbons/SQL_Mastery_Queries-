-- 1. Write a transaction to:
--   - Add a new role for employees called `Automotive Mechanic`
--   - Add five new mechanics, their data is up to you
--   - Each new mechanic will be working at all three of these dealerships: Sollowaye Autos of New York, Hrishchenko Autos of New York and Cadreman Autos of New York
BEGIN;

INSERT INTO
    employeetypes (name)
Values
    ('Automotive Mechanic');

INSERT INTO
    employees (
        first_name,
        last_name,
        email_address,
        phone,
        employee_type_id
    )
VALUES
    (
        'Mac',
        'Gibbons',
        'macgibbons@gmail.com',
        '123-456-7891',
        10
    ),
    (
        'Doug',
        'Bonham',
        'dougb@ymail.com',
        '123-456-7891',
        10
    ),
    (
        'Taylor',
        'Reiss',
        'Treiss@hotmail.com',
        '123-456-7891',
        10
    ),
    (
        'Sam',
        'Katz',
        'samkatz@gmail.com',
        '123-456-7891',
        10
    ),
    (
        'Alex',
        'Reyes',
        'areyes36@gmail.com',
        '123-456-7891',
        10
    );

INSERT INTO
    dealershipemployees (employee_id, dealership_id)
VALUES
    (1006, 50),
    (1006, 128),
    (1006, 322),
    (1007, 50),
    (1007, 128),
    (1007, 322),
    (1008, 50),
    (1008, 128),
    (1008, 322),
    (1009, 50),
    (1009, 128),
    (1009, 322),
    (1010, 50),
    (1010, 128),
    (1010, 322);

COMMIT;

-- 2. Create a transaction for:
--   - Creating a new dealership in Washington, D.C. called Felphun Automotive
--   - Hire 3 new employees for the new dealership: Sales Manager, General Manager and Customer Service.
--   - All employees that currently work at Scrogges Autos of District of Columbia will now start working 
--     at Felphun Automotive instead.
BEGIN;

INSERT INTO
    dealerships (business_name, city, state)
Values
    ('Felphun Automotive', 'Washington', 'D.C');

INSERT into
    dealershipemployees (employee_id, dealership_id)
Values
    (1, 1005),
    (4, 1005),
    (10, 1005);

UPDATE
    dealershipemployees
SET
    dealership_id = 1005
WHERE
    dealership_id = 129;

COMMIT;