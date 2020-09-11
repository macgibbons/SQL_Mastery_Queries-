-- Create a trigger for when a new Sales record is added, set the purchase date to 3 days from the current date.
CREATE FUNCTION set_pickup_date() RETURNS TRIGGER LANGUAGE plpgsql AS $ $ BEGIN
UPDATE
    sales
SET
    pickup_date = NEW.purchase_date + integer '3'
WHERE
    sales.sale_id = NEW.sale_id;

RETURN NULL;

END;

$ $ ---
CREATE TRIGGER new_sale_made
AFTER
INSERT
    ON sales FOR EACH ROW EXECUTE PROCEDURE set_pickup_date();

-- Create a trigger for updates to the Sales table. 
-- If the pickup date is on or before the purchase date, 
-- set the pickup date to 7 days after the purchase date. 
-- If the pickup date is after the purchase date but less than 7 days out from the purchase date, add 4 additional days to the pickup date.
CREATE
OR Replace FUNCTION update_pickup_date() RETURNS TRIGGER LANGUAGE plpgsql AS $ $ BEGIN IF NEW.pickup_date <= NEW.purchase_date THEN NEW.pickup_date = NEW.purchase_date + 7;

ELSIF NEW.pickup_date > NEW.purchase_date
AND NEW.pickup_date < NEW.purchase_date + 7 THEN NEW.pickup_date = NEW.pickup_date + 4;

END IF;

RETURN NEW;

END;

$ $ DROP TRIGGER sale_updated on Sales;

CREATE TRIGGER sale_updated BEFORE
UPDATE
    ON sales FOR EACH ROW EXECUTE PROCEDURE update_pickup_date();