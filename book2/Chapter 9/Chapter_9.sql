---------- AVAILABLE MODELS ----------
--Across all dealerships, which model of vehicle has the lowest current inventory? 
--This will help dealerships know which models the purchase from manufacturers.
SELECT
    vm.name,
    COUNT(vm.name) AS inventory
FROM
    Vehicles v
    JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
    JOIN vehiclemodels vm ON vm.vehicle_model_id = vt.model_id
WHERE
    NOT EXISTS (
        SELECT
        FROM
            sales s
        where
            s.vehicle_id = v.vehicle_id
    )
GROUP BY
    vm.name
ORDER BY
    inventory
LIMIT
    1;

-- Across all dealerships, which model of vehicle has the highest current inventory? 
-- This will help dealerships know which models are, perhaps, not selling.
SELECT
    vm.name,
    COUNT(vm.name) AS inventory
FROM
    Vehicles v
    JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
    JOIN vehiclemodels vm ON vm.vehicle_model_id = vt.model_id
WHERE
    NOT EXISTS (
        SELECT
        FROM
            sales s
        where
            s.vehicle_id = v.vehicle_id
    )
GROUP BY
    vm.name
ORDER BY
    inventory DESC
LIMIT
    1;

---------- DIVERSE DEALERSHIPS----------
-- Which dealerships are currently selling the least number of vehicle models? 
-- This will let dealerships market vehicle models more effectively per region.
SELECT
    d.business_name,
    COUNT(s.sale_id) AS inventory
FROM
    dealerships d
    JOIN sales s ON s.dealership_id = d.dealership_id
    JOIN vehicles v ON v.vehicle_id = s.vehicle_id
    JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
    JOIN vehiclemodels vm ON vm.vehicle_model_id = vt.model_id
GROUP BY
    d.business_name
Order by
    inventory desc;

-- Which dealerships are currently selling the highest number of vehicle models?
-- This will let dealerships know which regions have either a high population, or less brand loyalty. 
SELECT
    d.business_name,
    COUNT(DISTINCT vm.vehicle_model_id) as number_of_models
FROM
    dealerships d
    JOIN sales s ON s.dealership_id = d.dealership_id
    JOIN vehicles v ON v.vehicle_id = s.vehicle_id
    JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
    JOIN vehiclemodels vm ON vm.vehicle_model_id = vt.model_id
GROUP BY
    d.business_name
ORDER BY
    number_of_models DESC;