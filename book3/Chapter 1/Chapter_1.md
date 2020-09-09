# Update Operations

This chapter covers writing `UPDATE` statements for modifying data.

## Resources to Browse Before Class

- [PostgreSQL UPDATE Statement](https://www.youtube.com/watch?v=cd-hSl7_pGQ)
- [PostgreSQL UPDATE Tutorial](https://www.postgresqltutorial.com/postgresql-update/)
- [PosgreSQL UPDATES with JOINS](https://www.postgresqltutorial.com/postgresql-update-join/)

<br>

The `UPDATE` statement is used to edit existing records in a table. First you will need to provide the table name, then use the `SET` clause to assign the values to the columns you wish to update.

You will likely need to add a `WHERE` clause to your statement to specify which records to update. If `WHERE` is not included then the `UPDATE` will apply to all records in the table.

Example UPDATE statement:

```sql
UPDATE table_name
SET column1 = value1, column2 = value2...., columnN = valueN
WHERE [condition];
```

Let's see an example of updating an email address for a customer.

```sql
-- UPDATE statement to change an customer
UPDATE  public.customer
SET email = 'juliasmith@gmail.com'
WHERE customer_id = 67;
```

## Practice: Employees

_Rheta Raymen_ an employee of Carnival has asked to be transferred to a different dealership location. She is currently at dealership _751_. She would like to work at dealership _20_. Update her record to reflect her transfer.

## Practice: Sales

A Sales associate needs to update a sales record because her customer want so pay wish Mastercard instead of American Express. Update Customer, _Layla Igglesden_ Sales record which has an invoice number of _2781047589_.
