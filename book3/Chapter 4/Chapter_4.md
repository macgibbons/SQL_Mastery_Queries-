# Stored Procedures Practice

Carnival would like to use stored procedures to process valuable business logic surrounding their business. Since they understand that procedures can hold many SQL statements related to a specific task they think it will work perfectly for their current problem.

## Inventory Management

### Selling a Vehicle

Carnival would like to create a stored procedure that handles the case of updating their vehicle inventory when a sale occurs. They plan to do this by flagging the vehicle as _is_sold_ which is a field on the Vehicles table. When set to _True_ this flag will indicate that the vehicle is no longer available in the inventory. Why not delete this vehicle? We don't want to delete it because it is attached to a sales record.

### Returning a Vehicle

Carnival would also like to handle the case for when a car gets returned by a customer. When this occurs they must add the car back to the inventory and mark the original sales record as _returned = True_.

Carnival staff are required to do an oil change on the returned car before putting it back on the sales floor. In our stored procedure, we must also log the oil change within the OilChangeLog table.

### Goals

1. Use the story above and extract the requirements.
2. Build two stored procedures for Selling a car and Returning a car. Be ready to share with your class or instructor your result.
