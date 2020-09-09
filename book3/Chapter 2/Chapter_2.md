# Deleting Data

This chapter covers writing `DELETE FROM` statements and how they are affected by foreign key constraints.

## Resources to Browse Before Class

- [PostgreSQL DELETE FROM Statement](https://www.youtube.com/watch?v=c7AAkX39_Wo)
- [PostgreSQL DELETE FROM Tutorial](https://www.postgresqltutorial.com/postgresql-delete/)
- [ON DELETE SET NULL Example](https://til.hashrocket.com/posts/c6866dc6c1-set-foreign-key-to-null-on-delete-in-postgres)
- [DELETE CASCADE Tutorial](https://kb.objectrocket.com/postgresql/how-to-use-the-postgresql-delete-cascade-1369)
- [PosgreSQL DELETE with JOINS](https://www.postgresqltutorial.com/postgresql-delete-join/)

<br>

The `DELETE FROM` statement is used to delete existing records in a table. First you will need to provide the table name and then a WHERE clause to specify which records to delete. If WHERE is not included then all records will be deleted.

Example DELETE FROM statement:

```sql
DELETE FROM table_name
WHERE [condition];
```

Let's delete an existing sales record from the Sales table

```sql
-- DELETE statement to delete one specific record:
DELETE FROM sales WHERE sales.sale_id = 100;

-- DELETE statement to delete specific records by id:
DELETE FROM  sales WHERE sales.sale_id IN (100, 200, 300);

-- DELETE statement to delete a specific vehicle record by year of car:
DELETE FROM  vehicles WHERE year_of_car <= '2017';
```

Now if you run the last DELETE above you will get the following error:

```
ERROR:  update or delete on table "vehicles" violates foreign key constraint "sales_vehicle_id_fkey" on table "sales"
DETAIL:  Key (vehicle_id)=(6) is still referenced from table "sales".
SQL state: 23503
```

Because the vehicle record that is being deleted has a foreign key in the Sales table we can't easily delete this record unless the foriegn key is removed. We don't want to ever remove the constraint so another option is to specify how our contraint should behave upon a DELETE.

## ON DELETE CASCADE

The use of `ON DELETE CASCADE` is done when CREATE or ALTER of a table takes place. In this example _products_ is the parent table and _inventory_ is the child table.

When we define our foreign key contraint with `ON DELETE CASCADE` this tells the database server to delete records in the child table when data in the parent table is deleted. In other words, when we run a DELETE statement to remove a record in the Products table, the database server will automatically know to delete any records in the inventory table with the specified year_of_car.

### Example of delete with cascade

```sql
CREATE TABLE products
( product_id INT PRIMARY KEY,
  product_name VARCHAR(50) NOT NULL,
  category VARCHAR(25)
);

CREATE TABLE inventory
( inventory_id INT PRIMARY KEY,
  product_id INT NOT NULL,
  quantity INT,
  min_level INT,
  max_level INT,
  CONSTRAINT fk_inv_product_id
    FOREIGN KEY (product_id)
    REFERENCES products (product_id)
    ON DELETE CASCADE
);
```

It's not always a desirable affect to delete other table's records when we delete another table's records. We could accidentally delete data we dont mean to. There are other options outside of `ON DELETE CASCADE`.

`ON DELETE [ { NO ACTION | CASCADE | SET NULL | SET DEFAULT } ] `

`NO ACTION` : No action is performed with the child data when the parent data is deleted or updated.

`CASCADE` : Child data is either deleted or updated when the parent data is deleted or updated.

`SET NULL` : Child data is set to NULL when the parent data is deleted or updated.

`SET DEFAULT` : Child data is set to their default values when the parent data is deleted or updated.

## Practice - Employees

1. A sales employee at carnival creates a new sales record for a sale they are trying to close. The customer, last minute decided not to purchase the vehicle. Help delete the Sales record with an invoice number of '7628231837'.
2. An employee was recently fired so we must delete them from our database. Delete the employee with employee_id of 35. What problems might you run into when deleting? How would you recommend fixing it?
