-- - Adding 5 brand new 2021 Honda CR-Vs to the inventory. 
--   They have I4 engines and are classified as a Crossover SUV or CUV. 
--   All of them have beige interiors but the exterior colors are Lilac, Dark Red, Lime, Navy and Sand. 
--   The floor price is $21,755 and the MSR price is $18,999.
BEGIN;

INSERT INTO
    vehiclebodytypes (name)
Values
    ('CUV');

SELECT
    *
FROM
    vehiclebodytypes;

INSERT INTO
    vehiclemakes (name)
Values
    ('Honda');

INSERT INTO
    vehiclemodels (name)
VALUES
    ('CR-V');

INSERT INTO
    Vehicletypes (body_type_id, make_id, model_id)
Values
    (8, 9, 19);

INSERT INTO
    vehicles (
        engine_type,
        vehicle_type_id,
        exterior_color,
        interior_color,
        floor_price,
        msr_price,
        year_of_car
    )
VALUES
    ('I4', 34, 'Lilac', 'Beige', 21755, 18999, 2021),
    (
        'I4',
        34,
        'Dark Red',
        'Beige',
        21755,
        18999,
        2021
    ),
    ('I4', 34, 'Lime', 'Beige', 21755, 18999, 2021),
    ('I4', 34, 'Navy', 'Beige', 21755, 18999, 2021),
    ('I4', 34, 'Sand', 'Beige', 21755, 18999, 2021);

Commit;

-- For the CX-5s and CX-9s in the inventory that have not been sold, change the year of the car to 2021 since we will be updating our stock of Mazdas. For all other unsold Mazdas, update the year to 2020. The newer Mazdas all have red and black interiors.
BEGIN;

with unsold_mazdas as (
    SELECT
        *
    from
        Vehicles v
    where
        v.is_sold is False
        AND (
            v.vehicle_type_id = 6
            OR v.vehicle_type_id = 3
            OR v.vehicle_type_id = 9
        )
)
UPDATE
    vehicles
SET
    year_of_car = 2021,
    interior_color = 'Red and Black'
FROM
    unsold_mazdas
WHERE
    vehicles.vehicle_id = unsold_mazdas.vehicle_id;

COMMIT;

-- The vehicle with VIN YV4852CT5B1628541 has been brought in for servicing. Document that the service department did a tire change, windshield wiper fluid refill and an oil change.
SELECT
    *
from
    Vehicles
where
    VIN = 'YV4852CT5B1628541';

--206
begin;

INSERT INTO
    carrepairtypelogs (date_occured, vehicle_id, repair_type_id)
Values
    (now(), 206, 1),
    (now(), 206, 2);

INSERT INTO
    oilchangelogs (date_occured, vehicle_id)
Values
    (now(), 206);

COMMIT;