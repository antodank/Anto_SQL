-- get table info
SELECT * FROM INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'Employees'

--get column info
SELECT TABLE_SCHEMA,TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'id'

-- check exist
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'id')
SELECT 'found' AS search_result 
ELSE 
SELECT 'not found' AS search_result;

-- get column from table
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Album'

select  * from sys.assemblies
select  * from sys.tables
select  * from sys.columns

---gives info about the table including all the cols
exec sp_columns A
