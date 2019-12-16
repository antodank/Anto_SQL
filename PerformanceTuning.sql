--As you can see from these simple examples, SQL Server has to read significantly more
--pages when a table is defined with wide rows. This increased I/O cost can cause a significant
--performance drain when performing SQL Server queries, even those queries that are otherwise
--highly optimized. One way to minimize the cost of I/O is to minimize the width of columns
--where possible, and always use the appropriate data type for the job. In the examples given, a
--variable-width character data type (varchar) would have significantly reduced the storage
--requirements of the sample tables. Although I/O cost is often a secondary consideration for
--developers and DBAs, and is often only addressed after slow queries begin to cause drag on a
--system, it’s a good idea to keep the cost of I/O in mind when initially designing your tables.

Use AdventureWorks
drop table dbo.SmallRows
drop table dbo.LargeRows

------------------------------------
--Minimize IO Cost

Use AdventureWorks
--Creating Table with NarrowRows
CREATE TABLE dbo.SmallRows
(
Id int NOT NULL,
LastName nchar(50) NOT NULL,
FirstName nchar(50) NOT NULL,
MiddleName nchar(50) NULL
);
INSERT INTO dbo.SmallRows
(
Id,
LastName,
FirstName,
MiddleName
)
SELECT
ContactID,
LastName,
FirstName,
MiddleName
FROM Person.Contact;


--The sys.fn_PhysLocFormatter function returns the physical locator in the form
--(file:page:slot).
SELECT
sys.fn_PhysLocFormatter(%%physloc%%) AS [Row_Locator],
Id
FROM dbo.SmallRows;
--can fit about 24 rows on a single 8 KB page


--Creating Table with WideRows
CREATE TABLE dbo.LargeRows
(
Id int NOT NULL,
LastName nchar(600) NOT NULL,
FirstName nchar(600) NOT NULL,
MiddleName nchar(600) NULL
);

INSERT INTO dbo.LargeRows
(
Id,
LastName,
FirstName,
MiddleName
)
SELECT
ContactID,
LastName,
FirstName,
MiddleName
FROM Person.Contact;

SELECT
sys.fn_PhysLocFormatter(%%physloc%%) AS [Row_Locator],
Id
FROM dbo.LargeRows;
--can fit 2 rows on a single 8 KB page


--To compare the IO Cost of both the queries
SET STATISTICS IO ON;
SELECT
Id,
LastName,
FirstName,
MiddleName
FROM dbo.SmallRows;
SELECT
Id,
LastName,
FirstName,
MiddleName
FROM dbo.LargeRows;

SET STATISTICS IO OFF;


--built-in Data Compression
--can reduce I/O contention and minimize storage requirements.
-------Row Compression
--SQL Server 2005 introduced an optimization to the storage format 
--for the decimal data type in SP 2.


--got extended in SQL Server 2008
--first make the table perfect with proper indexes (PK)

--Estimating Row Compression Space Savings
EXEC sp_estimate_data_compression_savings 'dbo',
'LargeRows',
NULL,
NULL,
'ROW';


EXEC sp_spaceused N'dbo.LargeRows' --space used  79888 KB

--Turning On Row Compression for a Table
ALTER TABLE dbo.LargeRows REBUILD
WITH (DATA_COMPRESSION = ROW);


--Viewing Space Used by a Table After Applying Row Compression
EXEC sp_spaceused N'dbo.LargeRows'; --1056 kb

--Page Compression
----1. Column Prefix
----2. Page Dictionary


EXEC sp_spaceused N'Person.Contact';--4560k -8k

EXEC sp_estimate_data_compression_savings 'Person',
'contact',
NULL,
NULL,
'PAGE';

--Applying Page Compression to the Person.Contact Table
ALTER TABLE Person.Contact REBUILD
WITH (DATA_COMPRESSION = PAGE);


EXEC sp_spaceused N'Person.Contact' --4048k , 8k(index)



--Sparse Column
--let you optimize NULL value storage in columns
--when it will result in at least 20 to 40 percent
--space savings. For an int column, for instance, at least 64 percent of the values must be NULL
--to achieve a 40 percent space savings with sparse columns.

--Creating Sparse and Nonsparse Tables
CREATE TABLE NonSparseTable
(
CustomerID int NOT NULL PRIMARY KEY,
"HL Road Frame - Black, 58" int NULL,
"HL Road Frame - Red, 58" int NULL,
"HL Road Frame - Red, 62" int NULL,
"HL Road Frame - Red, 44" int NULL,
"HL Road Frame - Red, 48" int NULL,
"HL Road Frame - Red, 52" int NULL,
"HL Road Frame - Red, 56" int NULL,
"LL Road Frame - Black, 58" int NULL
);

CREATE TABLE SparseTable
(
CustomerID int NOT NULL PRIMARY KEY,
"HL Road Frame - Black, 58" int SPARSE NULL,
"HL Road Frame - Red, 58" int SPARSE NULL,
"HL Road Frame - Red, 62" int SPARSE NULL,
"HL Road Frame - Red, 44" int SPARSE NULL,
"HL Road Frame - Red, 48" int SPARSE NULL,
"HL Road Frame - Red, 52" int SPARSE NULL,
"HL Road Frame - Red, 56" int SPARSE NULL,
"LL Road Frame - Black, 58" int SPARSE NULL
);

--populate these two tables with the following query which returns lots of NULLS
INSERT INTO NonSparseTable
SELECT
CustomerID,
"HL Road Frame - Black, 58",
"HL Road Frame - Red, 58",
"HL Road Frame - Red, 62",
"HL Road Frame - Red, 44",
"HL Road Frame - Red, 48",
"HL Road Frame - Red, 52",
"HL Road Frame - Red, 56",
"LL Road Frame - Black, 58"
FROM
(
SELECT soh.CustomerID, p.Name AS ProductName,
COUNT
(
CASE WHEN sod.LineTotal IS NULL THEN NULL
ELSE 1
END
) AS NumberOfItems
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesOrderDetail sod
ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product p
ON sod.ProductID = p.ProductID
GROUP BY
soh.CustomerID,
sod.ProductID,
p.Name
) src 
PIVOT
(
SUM(NumberOfItems) FOR ProductName
IN
(
"HL Road Frame - Black, 58",
"HL Road Frame - Red, 58",
"HL Road Frame - Red, 62",
"HL Road Frame - Red, 44",
"HL Road Frame - Red, 48",
"HL Road Frame - Red, 52",
"HL Road Frame - Red, 56",
"LL Road Frame - Black, 58"
)
) AS pvt;


INSERT INTO SparseTable
SELECT
CustomerID,
"HL Road Frame - Black, 58",
"HL Road Frame - Red, 58",
"HL Road Frame - Red, 62",
"HL Road Frame - Red, 44",
"HL Road Frame - Red, 48",
"HL Road Frame - Red, 52",
"HL Road Frame - Red, 56",
"LL Road Frame - Black, 58"
FROM
(
SELECT soh.CustomerID, p.Name AS ProductName,
COUNT
(
CASE WHEN sod.LineTotal IS NULL THEN NULL
ELSE 1
END
) AS NumberOfItems
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesOrderDetail sod
ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product p
ON sod.ProductID = p.ProductID
GROUP BY
soh.CustomerID,
sod.ProductID,
p.Name
) src 
PIVOT
(
SUM(NumberOfItems) FOR ProductName
IN
(
"HL Road Frame - Black, 58",
"HL Road Frame - Red, 58",
"HL Road Frame - Red, 62",
"HL Road Frame - Red, 44",
"HL Road Frame - Red, 48",
"HL Road Frame - Red, 52",
"HL Road Frame - Red, 56",
"LL Road Frame - Black, 58"
)
) AS pvt;

--verify the used space for both the tables
EXEC sp_spaceused N'dbo.NonSparseTable'
EXEC sp_spaceused N'dbo.SparseTable'


--Sparse Column Sets
--An XML column set is defined as an xml data type column, and it contains non-NULL sparse column
--data from the table.

--Creating and Populating a Table with a Sparse Column Set
CREATE TABLE dbo.SparseProduct
(
ProductID int NOT NULL PRIMARY KEY,
Name  nchar(40) NOT NULL,
ProductNumber nvarchar(25) NOT NULL,
Color nvarchar(15) SPARSE NULL,
Size nvarchar(5) SPARSE NULL,
SizeUnitMeasureCode nchar(3) SPARSE NULL,
WeightUnitMeasureCode nchar(3) SPARSE NULL,
Weight decimal(8, 2) SPARSE NULL,
Class nchar(2) SPARSE NULL,
Style nchar(2) SPARSE NULL,
SellStartDate datetime NOT NULL,
SellEndDate datetime SPARSE NULL,
DiscontinuedDate datetime SPARSE NULL,
SparseColumnSet xml COLUMN_SET FOR ALL_SPARSE_COLUMNS
);
GO
INSERT INTO dbo.SparseProduct
(
ProductID,
Name,
ProductNumber,
Color,
Size,
SizeUnitMeasureCode,
WeightUnitMeasureCode,
Weight,
Class,
Style,
SellStartDate,
SellEndDate,
DiscontinuedDate
)
SELECT
ProductID,
Name,
ProductNumber,
Color,
Size,
SizeUnitMeasureCode,
WeightUnitMeasureCode,
Weight,
Class,
Style,
SellStartDate,
SellEndDate,
DiscontinuedDate
FROM Production.Product;
GO

--view the sparse column set in XML form with a query
SELECT TOP(7)
ProductID,
SparseColumnSet
FROM dbo.SparseProduct;

-------------------------------------

----Blocking query
use mydb 
go
sp_configure 'show advanced options', 1 ;
GO
RECONFIGURE ;
GO
sp_configure 'blocked process threshold', 5 ;
GO
RECONFIGURE ;
GO
--------------------
--profiler
--select the Blocked process report event class (under the Errors and Warnings object)

use mydb
select * from Student

BEGIN TRAN
--select * from Student WITH (TABLOCKX, HOLDLOCK)
Update Student set mark=100 where Sname='d'

rollback

---------------------
--When a stored procedure is compiled for the first time (or in fact any parameterized batch),
-- the values of the parameters supplied with the execution call are used to 
--optimize the statements within that stored procedure. This process is known as "parameter sniffing." If these values are typical, then most calls to that stored procedure will benefit from an efficient query plan. 
--(also explain execution context)
--Parameter Sniffing 
GO
create PROCEDURE HumanResources.usp_GetEmployees 
    @lastname varchar(40), 
    @firstname varchar(20) 
AS 
    SELECT LastName, FirstName, JobTitle, Department
    FROM HumanResources.vEmployeeDepartment
    WHERE FirstName like @firstname AND LastName like @lastname;


--creates a query lan for below statement
Exec HumanResources.usp_GetEmployees '%','%' 

--same plan used here also
Exec HumanResources.usp_GetEmployees 'K%','B%'


--to avoid parameer sniffing use a lcal variable
alter PROCEDURE HumanResources.usp_GetEmployees 
    @lastname varchar(40), 
    @firstname varchar(20) 
AS 
   
   declare @lname varchar(40)=@lastname,@fname varchar(40)=@firstname
    SELECT LastName, FirstName, JobTitle, Department
    FROM HumanResources.vEmployeeDepartment
    WHERE FirstName like @fname AND LastName like @lname;

----------------------------------------------------------------


--Filtered Indexes
--a way to create more targeted indexes that require
--less storage and can support more efficient queries

--creates a filtered index on the Size column of the Production.Product table that excludes NULL

set statistics io on 
SELECT
ProductID,
Size,
SizeUnitMeasureCode
FROM Production.Product
WHERE Size = 'L';
GO

--IO Cost - 0.120139 - 0.003125
--CPU Cost - 0.0007114 - 0.0001691

CREATE NONCLUSTERED INDEX IX_Product_Size
ON Production.Product
(
Size,
SizeUnitMeasureCode
)
WHERE Size IS NOT NULL;
GO
set statistics io on 
SELECT
ProductID,
Size,
SizeUnitMeasureCode
FROM Production.Product
WHERE Size = 'L';
GO

--IO Cost   0.003125
--CPU Cost  0.0001691

SELECT
ProductID,
Size,
SizeUnitMeasureCode
FROM Production.Product
WHERE Size is NULL;
GO

--IO Cost - 0.120139  
--CPU Cost - 0.0007114  


drop index IX_Product_Size ON Production.Product
-----Creating Plan GUIDE 


DBCC FREEPROCCACHE

GO
CREATE PROCEDURE dbo.GetAddressByState
(@State nvarchar(3))
AS
BEGIN
SELECT AddressLine1,AddressLine2, City FROM Person.Address a
INNER JOIN Person.StateProvince s ON s.StateProvinceID=a.StateProvinceID
WHERE s.StateProvinceCode=@State;
END

exec dbo.GetAddressByState 'WA'

EXEC sp_create_plan_guide N'GetAddress_PlanGuide',
N'SELECT AddressLine1,AddressLine2, City FROM Person.Address a
INNER JOIN Person.StateProvince s ON s.StateProvinceID=a.StateProvinceID
WHERE s.StateProvinceCode=@State;',
N'OBJECT',
N'dbo.GetAddressByState',
NULL,
N'OPTION (OPTIMIZE FOR (@State = N''WA''))';

exec dbo.GetAddressByState 'CA'
--EstimateCPU="0.0003561"
EXEC sp_control_plan_guide N'ENABLE', N'GetAddress_PlanGuide';