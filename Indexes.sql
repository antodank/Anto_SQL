--Query Requiring a Bookmark Lookup (test 2008 -AdventureWorks)
--Table has a clustered index on ContactId and non clustered index on Lastname
SELECT
ContactID,
LastName,
FirstName,
MiddleName,
Title
FROM Person.Contact
WHERE LastName = N'Duffy';

--The above can be modified by creating a covering index for LastName,FirstName, 
--MiddleName, Title columns



----on AdventureWorks
Create CLUSTERED INDEX ci_postdate ON dbo.DatabaseLog(PostTime)

select * from DatabaseLog



drop index ci_postdate on dbo.DatabaseLog

---NONCLUSTERED INDEX
Create NONCLUSTERED INDEX idx_CustomerAddress_City ON  dbo.DatabaseLog(PostTime)

ALTER INDEX idx_CustomerAddress_City on dbo.DatabaseLog DISABLE
select * from DatabaseLog


ALTER INDEX idx_CustomerAddress_City on dbo.DatabaseLog REBUILD
select * from DatabaseLog

Create NONCLUSTERED INDEX idx_CustomerAddress_City ON dbo.CustomerAddress(City)

--Creating and Testing a Filtered Index on the Production.Product Table
--creates a filtered index on the Size column of the Production.Product table that excludes NULL.

CREATE NONCLUSTERED INDEX IX_Product_Size
ON Production.Product
(
Size,
SizeUnitMeasureCode
)
WHERE Size IS NOT NULL;
GO
SELECT
ProductID,
Size,
SizeUnitMeasureCode
FROM Production.Product
WHERE Size = 'L';
GO


--Actaul or estimated
CREATE TABLE #t1
(
Id int NOT NULL,
LastName nvarchar(50),
FirstName nvarchar(50),
MiddleName nvarchar(50)
);
CREATE INDEX t1_LastName
ON #t1 (LastName);
INSERT INTO #t1
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
Id,
LastName,
FirstName,
MiddleName
FROM #t1
WHERE LastName = N'Duffy';
DROP TABLE #t1;

--In the estimated query plan for this code, the optimizer 
--indicates that it will use a table scan

--The actual query plan, however, uses a much more efficient nonclustered index seek with a bookmark
--lookup operation to retrieve the two relevant rows from the table,



----------------------------
--index Partition compression
ALTER INDEX idx_saleID ON SALESDETAILS
REBUILD PARTITION=ALL
WITH (DATA_Compression=PAGE)
