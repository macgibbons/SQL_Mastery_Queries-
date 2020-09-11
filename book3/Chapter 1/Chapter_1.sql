---------- Practice: Employees ----------
-- Rheta Raymen an employee of Carnival has asked to be transferred to a different dealership location. 
-- She is currently at dealership 751. She would like to work at dealership 20. Update her record to reflect her transfer.
UPDATE
    dealershipemployees
SET
    dealership_id = 20
WHERE
    employee_id = 680
    AND dealership_id = 751;

---------- Practice: Sales ----------
-- A Sales associate needs to update a sales record because her customer want so pay wish 
-- Mastercard instead of American Express. Update Customer, Layla Igglesden Sales record which 
-- has an invoice number of 2781047589.
UPDATE
    sales s
SET
    payment_method = 'mastercard'
WHERE
    invoice_number = '2781047589';