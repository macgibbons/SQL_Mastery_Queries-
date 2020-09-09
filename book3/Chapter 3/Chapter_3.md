# Stored Procedures

## Goals

After reading this chapter, doing the exercises, and engaging in discussion with your instructor and peers, you should be able to...

1. Create/call a stored procedures
2. Understand the benefits of stored procedures
3. Understand when to use stored procedures

## Read/Watch Before Class

1. [Creating a Stored Procedure](https://www.youtube.com/watch?v=NdpniWg-KFg)
2. [PosgreSQL CREATE Procedure tutorial](https://www.postgresqltutorial.com/postgresql-create-procedure/)
3. [Intro to Stored Procedures](https://www.geeksforgeeks.org/postgresql-introduction-to-stored-procedures/)
4. [CREATE PROCEDURE Documentation](https://www.postgresql.org/docs/11/sql-createprocedure.html)
5. [Stored Procedures vs in-app queries](https://www.brentozar.com/archive/2019/03/should-we-use-stored-procedures-or-queries-built-in-the-app/)

## What are Stored Procedures?

Stored procedures are predefined procedural statements for executing SQL. They are stored on the database server and executed at will.

Though similair to SQL's User Defined Functions (UDF), stored procedures (SP) do not use the return statment to return a value. The `RETURN` can be used however to halt a procedure.

It is a common practice to use stored procedures for all procedures except SELECT. It is better to use SELECT statments with User Defined Function since these function have a return statement.

The big difference between SP and UDF's is UDF's can be used just like an expression in regular SQL statements whereas stored procedures must be invoked by using the `CALL` statement.

## Creating/Executing a Stored Procredure

Defining a procedure requires a name, parameters, and embedded sql statements. It also specifies the procedural language to be used, and has \$\$ at the beginning and end of the contain SQL.

Despite not being able to use the RETURN statement to return data there is a way to return data if needed through the parameter definitions.

Parameters can have `IN`, `INOUT` modes as well. The `IN` parameter is what gets sent to the SP from our code whereas the `INOUT` paremeter is what our code sends back to our program.

```sql
CREATE PROCEDURE insert_data(IN a varchar, INOUT b varchar)
LANGUAGE plpgsql
AS $$
BEGIN

INSERT INTO tbl VALUES (a);
INSERT INTO tbl VALUES (b);

END
$$;
```

To execute the stored procedure we use the `CALL` statement.

```sql
CALL insert_data(1, 2);
```

### Why or Why Not Use Stored Procedures?

#### Advantages

- Improved performance
  - Procedures are compiled and stored making the response quick.
  - You can group SQL statements together in one single call to the database making it faster than multiple calls.
  - Procedures are stored on the database server as opposed to the client.
  - There is the ability to control transactions within a procedure.
- Network efficiency
  - Stored procedures can include SQL queries with large amounts of processing power that otherwise would be expensive when pulling query results across the network for a client program to process. Since it's all done on the database server it's faster.
- Modularity - We can modularize business logic on the server rather than rely on each version of a program to properly execute the rules.
- Security - When applications are only allowed to access data from the database via stored procedures it limits direct access to tables, thus making it more secure.

#### Disadvantages

- Version Control - There is no way to track changes made to stored procedures since it lives on the database server and not in a version controlled file.
- Debugging - It is not usualy possible to debug a stored procedure. If so it would be very tedious and would involve using the database profiler.
- Testing - The ability to test the business logic that has been encapsulated in a stored procedure is very difficult to test. Unit testing is not possible, since there is no clear way to sperate domain logic from the data.
