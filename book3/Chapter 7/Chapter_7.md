# Transactions

A SQL transaction is a single unit of work that could contain multiple operations. A transaction is only considered successful if all the operations in the transaction successfully complete.

## Resources to Browse Before Class

- [PostgreSQL Transaction](https://www.postgresqltutorial.com/postgresql-transaction/)
- [PostgreSQL Transactions](https://www.tutorialspoint.com/postgresql/postgresql_transactions.htm)
- [What are Transactions?](https://www.geeksforgeeks.org/sql-transactions/)
- [SQL Transaction](https://www.w3resource.com/sql/controlling-transactions.php)
- [Video: Database Transactions](https://www.youtube.com/watch?v=5Pia4UFuMKo)
- [Video: SQL Server Programming: Transactions](https://www.youtube.com/watch?v=is03uRYFgqc)

## ACID Properties

A transaction must meet the following four properties:

**Atomicity**: All operations within the transaction must be successful. Otherwise, the transaction is considered to have failed and all operations within the transaction will be rolled back.

**Consistency**: All changes made to the data must be valid. In other words, the state of the data must be valid before and after the transaction.

**Isolation**: No other operation should modify the data while the transaction is executing.

**Durability**: Changes made by the transactions must must be committed and stored in the database permanently.

## Writing a Transaction

The changes made by the transaction will not persist until the keyword `COMMIT`.

```sql
-- start a transaction
BEGIN;
-- You can also use BEGIN TRANSACTION; or BEGIN WORK;

-- insert a new row into the sales type table
INSERT INTO salestypes(name)
VALUES('Lease to Own');

-- commit the change
COMMIT;
-- You can also use COMMIT TRANSACTION; or COMMIT WORK;
```

## Rollback a Transaction

When we rollback a transaction, we are essentially undoing all operations in the transaction.

```sql
-- start a transaction
BEGIN;
-- You can also use BEGIN TRANSACTION; or BEGIN WORK;

-- insert a new row into the sales type table
INSERT INTO employeetypes(name)
VALUES('Accountant');

-- roll back the transaction
ROLLBACK;
-- You can also use ROLLBACK TRANSACTION; or ROLLBACK WORK;
```

## Savepoint

A savepoint allows you to define a special mark within the transaction. You can then use the savepoint to do a partial rollback. You would can undo the changes up to a savepoint.

```sql
-- start a transaction
BEGIN;
-- You can also use BEGIN TRANSACTION; or BEGIN WORK;

-- insert a new row into the sales type table
INSERT INTO salestypes(name)
VALUES('Lease to Own');

SAVEPOINT foo;

-- insert a new row into the employees table
INSERT INTO employees(name)
VALUES('Accountant');

-- roll back to the savepoint
ROLLBACK TO SAVEPOINT foo;
```

## Transactions & Exception Handling

Now let's look at an example of a transaction where we use exception handling. Just like exception handling we have seen in application development, we want to try a block of operations. If any of them fail, then we want to handle the failure. In the case of a transaction, we are rolling back any changes the transaction may have made.

```sql
do $$
DECLARE
  NewCustomerId integer;
  CurrentTS date;

BEGIN

  INSERT INTO
    customers(
      first_name,
      last_name,
      email,
      phone,
      street,
      city,
      state,
      zipcode,
      company_name
    )
  VALUES
    (
      'Roy',
      'Simlet',
      'r.simlet@remves.com',
      '615-876-1237',
      '77 Miner Lane',
      'San Jose',
      'CA',
      '95008',
      'Remves'
    ) RETURNING customer_id INTO NewCustomerId;

  CurrentTS = CURRENT_DATE;

  INSERT INTO
    sales(
      sales_type_id,
      vehicle_id,
      employee_id,
      customer_id,
      dealership_id,
      price,
      deposit,
      purchase_date,
      pickup_date,
      invoice_number,
      payment_method
    )
  VALUES
    (
      1,
      1,
      1,
      NewCustomerId,
      1,
      24333.67,
      6500,
      CurrentTS,
      CurrentTS + interval '7 days',
      1273592747,
      'solo'
    );

EXCEPTION WHEN others THEN
  -- RAISE INFO 'name:%', SQLERRM;
  ROLLBACK;

END;

$$ language plpgsql;
```

## Practice: Carnival

1. Write a transaction to:

- Add a new role for employees called `Automotive Mechanic`
- Add five new mechanics, their data is up to you
- Each new mechanic will be working at all three of these dealerships: Sollowaye Autos of New York, Hrishchenko Autos of New York and Cadreman Autos of New York

1. Create a transaction for:

- Creating a new dealership in Washington, D.C. called Felphun Automotive
- Hire 3 new employees for the new dealership: Sales Manager, General Manager and Customer Service.
- All employees that currently work at Scrogges Autos of District of Columbia will now start working at Felphun Automotive instead.
