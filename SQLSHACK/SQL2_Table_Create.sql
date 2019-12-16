
--create a table inside the new schema
USE AdventureWorks;
GO
CREATE SCHEMA mySchema
    CREATE TABLE myTable (source int, cost int, partnumber int)


--create a table inside the existing schema
CREATE TABLE mySchema.myTable1 (source int, cost int, partnumber int)


--schama meta data retrieval
select * from sys.schemas;


----drop schema
drop table mySchema.myTable
drop table mySchema.myTable1
drop schema mySchema

----view the tables inside a schema
SELECT table_name
FROM AdventureWorks.information_schema.tables
WHERE table_schema = 'mySchema'


----Create Table Syntax
CREATE TABLE [<database>.][<schema>.]<tablename>
(
<columnName> <datatype> [<NULL specification>]
[IDENTITY [(seed,increment)]
--or
<columnName> AS <computed definition>
)

NULL - NOT NULL
--Leaving off the NULL specification altogether, the
--SQL Server default is used.

---To determine the current default property for a database
SELECT name, is_ansi_null_default_on
FROM sys.databases
WHERE name = 'AdventureWorks'

--To set the default for the database, you can use ALTER DATABASE
ALTER DATABASE AdventureWorks
SET ANSI_NULL_DEFAULT OFF




--Example
----turn off default NULLs
use Test
SET ANSI_NULL_DFLT_ON OFF

--create test table

CREATE TABLE testNULL
(
id int
)
--check the values
EXEC sp_help 'testNULL'


---------create table and insert data
use Test
go
Create Schema Inventory
CREATE TABLE Inventory.MovieRating (
MovieRatingId int NOT NULL,
Code varchar(20) NOT NULL,
Description varchar(200) NULL,
AllowYouthRentalFlag bit NOT NULL
)

INSERT INTO Inventory.MovieRating
(MovieRatingId, Code, Description, AllowYouthRentalFlag)
VALUES (0, 'UR','Unrated',1)

----new feature
INSERT INTO Inventory.MovieRating
(MovieRatingId, Code, Description, AllowYouthRentalFlag)
VALUES 
(1, 'G','General Audiences',1),
(2, 'PG','Parental Guidance',1),
(3, 'PG-13','Parental Guidance for Children Under 13',1),
(4, 'R','Restricted, No Children Under 17 without Parent',0)


-----IDENTITY [(seed,increment)]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Inventory].[Movie]'))
DROP TABLE Inventory.Movie
GO
CREATE TABLE Inventory.Movie
(
MovieId int NOT NULL IDENTITY(1,2),
Name varchar(20) NOT NULL,
ReleaseDate date NULL,
Description varchar(200) NULL,
GenreId int NOT NULL,
MovieRatingId int NOT NULL
)

INSERT INTO Inventory.Movie (Name, ReleaseDate,
Description, GenreId, MovieRatingId)
VALUES ('The Maltese Falcon','19411003',
'A private detective finds himself surrounded by strange people ' +
'looking for a statue filled with jewels',2,0),
('Arsenic and Old Lace','19440923',
'A man learns a disturbing secret about his aunt''s methods ' +
'for treating gentlemen callers',1,0)

select * from Test.Inventory.Movie

--SELECT ROW_NUMBER() OVER (PARTITION BY Name ORDER BY MovieId) AS RowNumber,
--MovieId
--FROM Inventory.Movie


--USE Test;
--GO
--drop table MyCustomerTable
--CREATE TABLE MyCustomerTable
--(
--    user_login   varbinary(85) DEFAULT SUSER_SID()
--    ,data_value   varbinary(1)
--);
--GO

--INSERT MyCustomerTable (data_value)
--    VALUES (0x4F);
--GO
--select * from MyCustomerTable


----------------discuss datatypes in ppt-----

----Table with Primary key
--
use Test
CREATE TABLE dbo.TransactionTypes
(
TransactionTypeId int NOT NULL,
TransactionDescription nvarchar(30) NOT NULL,
CreditType bit NOT NULL,
CONSTRAINT PK_sample_table PRIMARY KEY (TransactionTypeId)
)
GO

---show how to use GUI for setting PK





---------------------Assignment
--1. create schema - TransactionDetails
--2. create a table TransactionDetails.TransactionTypes 

USE Test
GO
IF OBJECT_ID('TransactionDetails.TransactionTypes', 'U') IS NOT NULL
DROP TABLE TransactionDetails.TransactionTypes
GO
CREATE TABLE TransactionDetails.TransactionTypes(
TransactionTypeId int IDENTITY(1,1) NOT NULL,
TransactionDescription nvarchar(30) NOT NULL,
CreditType bit NOT NULL
)
GO

---Adding a column
ALTER TABLE dbo.TransactionTypes
ADD AffectCashBalance bit NULL
GO

---adding an IDENTITY column
alter table Student add mark1 int NOT NULL IDENTITY(1,1)

--alter exisitng column
ALTER TABLE TransactionDetails.TransactionTypes
ALTER COLUMN AffectCashBalance bit NOT NULL
GO

---Creating remaining Tables in CustomerDetails
CREATE TABLE CustomerDetails.CustomerProducts(
CustomerFinancialProductId bigint IDENTITY(1,1) NOT NULL,
CustomerId bigint NOT NULL,
FinancialProductId bigint NOT NULL,
AmountToCollect money NOT NULL,
Frequency smallint NOT NULL,
LastCollected datetime NOT NULL,
LastCollection datetime NOT NULL,
Renewable bit NOT NULL
)
ON [PRIMARY]
GO
CREATE TABLE CustomerDetails.FinancialProducts(
ProductId bigint NOT NULL,
ProductName nvarchar(50) NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE ShareDetails.SharePrices(
SharePriceId bigint IDENTITY(1,1) NOT NULL,
ShareId bigint NOT NULL,
Price numeric(18, 5) NOT NULL,
PriceDate datetime NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE ShareDetails.Shares(
ShareId bigint IDENTITY(1,1) NOT NULL,
ShareDesc nvarchar(50) NOT NULL,
ShareTickerId nvarchar(50) NULL,
CurrentPrice numeric(18, 5) NOT NULL
) ON [PRIMARY]
GO




---------------computed column
alter table tablename add colname as 
(case when colname=0 then 0
when colname=1 then 1
when colname=2 and colname=3 then 2
........
else 4
end)

--------------Building a relationship

---creating primary table
Create Table dbo.Orders (OrdID bigint NOT NULL,CustNameName nvarchar(50) NOT NULL);

--altering to make PK
ALTER TABLE dbo.Orders
ADD CONSTRAINT
PK_Orders PRIMARY KEY NONCLUSTERED
(
OrdID
)

---Creating second/remote table
Create Table dbo.OrderDetails(OrdID bigint NOT NULL, ProcID bigint NOT NULL, Qty numeric)
-----creating foreign key using T-SQLOrdID bigint NULL FOREIGN KEY (StateProvinceID) 
REFERENCES dbo.StateProvince(StateProvinceID)

or

--use GUI
--Test DB - Select OrderDetails -RIGHT click- Design- right click - Relationship - add......
