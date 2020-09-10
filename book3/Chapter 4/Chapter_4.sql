---------- Selling a Vehicle ----------
-- Carnival would like to create a stored procedure that handles the case of updating their vehicle inventory when a sale occurs. 
-- They plan to do this by flagging the vehicle as is_sold which is a field on the Vehicles table. 
-- When set to True this flag will indicate that the vehicle is no longer available in the inventory. 
-- Why not delete this vehicle? We don't want to delete it because it is attached to a sales record.
ALTER TABLE
    vehicles
ADD
    COLUMN is_sold BOOLEAN;

-- add new is_sold column before create the procedure
CREATE PROCEDURE sell_vehicle(vehicle int) LANGUAGE plpgsql AS $ $ BEGIN
UPDATE
    vehicles
set
    is_sold = true
WHERE
    vehicle_id = vehicle;

END $ $;

---------- Returning a Vehicle ----------
-- Carnival would also like to handle the case for when a car gets returned by a customer. 
-- When this occurs they must add the car back to the inventory and mark the original sales record as returned = True.
-- Carnival staff are required to do an oil change on the returned car before putting it back on the sales floor.
-- In our stored procedure, we must also log the oil change within the OilChangeLog table.
---------
-- CREATE returned column to sales
ALTER TABLE
    sales
ADD
    COLUMN returned BOOLEAN DEFAULT false NOT NULL;

----------
-- CREATE Oilchangelog table
create table OilChangeLogs (
    oil_change_log_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    date_occured timestamp with time zone,
    vehicle_id int,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles (vehicle_id)
);

----------
-- Producure 
CREATE PROCEDURE return_vehicle(INOUT vehicle int) LANGUAGE plpgsql AS $ $ BEGIN
UPDATE
    sales
SET
    returned = true
WHERE
    vehicle_id = vehicle;

UPDATE
    vehicles
set
    is_sold = false
WHERE
    vehicle_id = vehicle;

INSERT INTO
    oilchangelogs (date_occured, vehicle_id)
VALUES
    (current_timestamp, vehicle);

END $ $;