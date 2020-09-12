-- Create a trigger for updates to the Sales table. 
-- If the pickup date is on or before the purchase date, 
-- set the pickup date to 7 days after the purchase date. 
-- If the pickup date is after the purchase date but less than 7 days out from the purchase date, add 4 additional days to the pickup date.
-- Because Carnival is a single company, we want to ensure that there is consistency in the data provided to the user. 
--Each dealership has it's own website but we want to make sure the website URL are consistent and easy to remember. 
--Therefore, any time a new dealership is added or an existing dealership is updated, 
-- we want to ensure that the website URL has the following 
--format: http://www.carnivalcars.com/{name of the dealership with underscores separating words}.
SeLECT
    *
from
    Dealerships;

CREATE
OR REPLACE FUNCTION create_url() RETURNS TRIGGER LANGUAGE plpgsql AS $ $ BEGIN NEW.website := CONCAT(
    'http://www.carnivalcars.com/',
    LOWER(REPLACE(NEW.business_name, ' ', '_'))
);

RETURN NEW;

END;

$ $ CREATE TRIGGER dealership_website BEFORE
UPDATE
    OR
INSERT
    ON Dealerships FOR EACH ROW EXECUTE PROCEDURE create_url();

-- If a phone number is not provided for a new dealership, set the phone number to the default customer care number 777-111-0305.
CREATE
OR REPLACE FUNCTION insert_cutomer_care_number() RETURNS TRIGGER LANGUAGE plpgsql AS $ $ BEGIN IF NEW.phone IS NULL THEN NEW.phone := '777-111-0305';

END IF;

RETURN NEW;

END;

$ $ CREATE TRIGGER dealership_phone_number BEFORE
INSERT
    ON Dealerships FOR EACH ROW EXECUTE PROCEDURE insert_cutomer_care_number();

-- For accounting purposes, the name of the state needs to be part of the dealership's tax id. For example, if the tax id provided is bv-832-2h-se8w for a dealership in Virginia, then it needs to be put into the database as bv-832-2h-se8w--virginia.
CREATE
OR REPLACE FUNCTION add_state_to_tax_id() RETURNS TRIGGER LANGUAGE plpgsql AS $ $ BEGIN NEW.tax_id := CONCAT(NEW.tax_id, '--', LOWER(NEW.state));

RETURN NEW;

END;

$ $ CREATE TRIGGER dealership_tax_id BEFORE
UPDATE
    OR
INSERT
    ON Dealerships FOR EACH ROW EXECUTE PROCEDURE add_state_to_tax_id();