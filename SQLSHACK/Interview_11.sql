----------------- Concept of table variable @Table and  temp tables #Table

-- Table variable  stored in tempdb
-- Table Variable acts like a variable and exists for a particular batch of query execution
-- Table can be used as parameter 
-- TRUNCATE statement does not work for table variables
-- The table variable structure cannot be changed after it has been declared
-- table variable in SQL Server is automatically dropped at the end of the batch


-- Temporary Tables are physically created in the tempdb database.
-- can have constraints, index like normal tables.

-- table variable is faster then temporary table.

DECLARE @ExperiementTable TABLE
( 
TestColumn_1 INT, TestColumn_2 VARCHAR(40), TestColumn_3 VARCHAR(40)
);
SELECT TABLE_CATALOG, TABLE_SCHEMA, COLUMN_NAME, DATA_TYPE
FROM tempdb.INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE 'TestColumn%';
    
GO
SELECT TABLE_CATALOG, TABLE_SCHEMA, COLUMN_NAME, DATA_TYPE
FROM tempdb.INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE 'TestColumn%';