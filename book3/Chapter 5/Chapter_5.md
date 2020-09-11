# Triggers Introduction

A trigger is a user-defined function that is executed when a specific action occurs. Once the trigger has been defined, it is put into action automatically when the appropriate event takes place.

## Resources to Browse Before Class

- [Introduction to PostgreSQL Trigger](https://www.postgresqltutorial.com/introduction-postgresql-trigger/)
- [PostgreSQL CREATE TRIGGER](https://www.postgresqltutorial.com/creating-first-trigger-postgresql/)
- [PostgreSQL Triggers Explained](https://www.tutorialspoint.com/postgresql/postgresql_triggers.htm)
- [Video: Triggers in SQL](https://www.youtube.com/watch?v=f6VWSlnHGCE)
- [Video: SQL Triggers](https://www.youtube.com/watch?v=gpthfJnvzY8)
- [Learning about DML Triggers](https://www.sqlservercentral.com/articles/learning-about-dml-triggers#:~:text=This%20article%20covers%20DML%20triggers,statements%20used%20to%20manipulate%20data.&text=DDL%20triggers%20are%20triggers%20that,Definition%20Language%20statements%20are%20fired.)

## PostgreSQL Trigger: Keep in Mind

- Triggers must always be associated with a table.
- You can define a trigger for the following events: INSERT, UPDATE, DELETE or TRUNCATE.
- There are row and statement-level triggers: The row-level trigger is invoked once for every row that is affected. The statement-level trigger is invoked only once for each event.
- A trigger can be defined to be invoked before or after the event.

## Create Trigger

In order to create a trigger, we must do two things:

1. Define a define a trigger function with `CREATE FUNCTION`.
1. Bind the function from the previous step to a table with `CREATE TRIGGER`.

### `CREATE FUNCTION`

[User-defined functions](https://www.postgresqltutorial.com/postgresql-create-function/) in PostgreSQL, similar to functions you have used in Object-oriented programming languages, allow a user to define some logic, pass in arguments and has a return a value.

But, a trigger function must be defined to take no arguments and the return value must be of type `trigger`.

Let's look at an example. We are going to create a trigger that will set the pickup date of the vehicle to be seven days from the date of purchase every time a new row is added to the Sales table.

Our first step is to define our trigger function. The keyword `NEW` allows us to access the data in the newly inserted row.

```sql
CREATE FUNCTION set_pickup_date()
  RETURNS TRIGGER
  LANGUAGE PlPGSQL
AS $$
BEGIN
  -- trigger function logic
  UPDATE sales
  SET pickup_date = NEW.purchase_date + integer '7'
  WHERE sales.sale_id = NEW.sale_id;

  RETURN NULL;
END;
$$
```

### `CREATE TRIGGER`

Now that our trigger function has been defined, let's bind it to the Sales table. Note that we are defining our trigger to automatically execute after each insert into the Sales table.

```sql
CREATE TRIGGER new_sale_made
  AFTER INSERT
  ON sales
  FOR EACH ROW
  EXECUTE PROCEDURE set_pickup_date();
```

Try setting up the same trigger in your database and then adding a new sales record to see if the trigger executes.

## Practice: Carnival

1. Create a trigger for when a new Sales record is added, set the purchase date to 3 days from the current date.
1. Create a trigger for updates to the Sales table. If the pickup date is on or before the purchase date, set the pickup date to 7 days after the purchase date. If the pickup date is after the purchase date but less than 7 days out from the purchase date, add 4 additional days to the pickup date.
