Views - MCTS - p -275




SET NUMERIC_ROUNDABORT OFF;
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,
QUOTED_IDENTIFIER, ANSI_NULLS ON;
GO
--Create view with schemabinding.
IF OBJECT_ID ('Sales.vOrders', 'view') IS NOT NULL
DROP VIEW Sales.vOrders ;
GO
CREATE VIEW Sales.vOrders
WITH SCHEMABINDING
AS
SELECT SUM(UnitPrice*OrderQty*(1.00-UnitPriceDiscount)) AS Revenue,
OrderDate, ProductID, COUNT_BIG(*) AS COUNT
FROM Sales.SalesOrderDetail AS od, Sales.SalesOrderHeader AS o
WHERE od.SalesOrderID = o.SalesOrderID
GROUP BY OrderDate, ProductID;
GO
--Create an index on the view.
CREATE UNIQUE CLUSTERED INDEX IDX_V1
ON Sales.vOrders (OrderDate, ProductID);
GO

--already materialised
select * from Sales.vOrders



SELECT SUM(UnitPrice*OrderQty*(1.00-UnitPriceDiscount)) AS Rev,
OrderDate, ProductID
FROM Sales.SalesOrderDetail AS od
JOIN Sales.SalesOrderHeader AS o ON od.SalesOrderID=o.SalesOrderID
AND ProductID BETWEEN 700 and 800
AND OrderDate >= CONVERT(datetime,'05/01/2002',101)
GROUP BY OrderDate, ProductID
ORDER BY Rev DESC;
SELECT OrderDate, SUM(UnitPrice*OrderQty*(1.00-UnitPriceDiscount)) AS Rev
FROM Sales.SalesOrderDetail AS od
JOIN Sales.SalesOrderHeader AS o ON od.SalesOrderID=o.SalesOrderID
AND DATEPART(mm,OrderDate)= 3
AND DATEPART(yy,OrderDate) = 2002
GROUP BY OrderDate
ORDER BY OrderDate ASC;

-------------------------DO NOT USE 
USE Satyam
GO
CREATE LOGIN John WITH PASSWORD = '34r%*Fs$lK!9';
CREATE LOGIN Jane WITH PASSWORD = '4LWcm&(^o!HXk';
CREATE USER John FOR LOGIN John;
CREATE USER Jane FOR LOGIN Jane;
GO
EXEC sp_addrolemember 'db_datareader', 'John';
EXEC sp_addrolemember 'db_ddladmin', 'John';
GO
CREATE view usp_GetAddresses1
AS
SELECT * FROM Person.Address;
GO

ALTER AUTHORIZATION ON usp_GetAddresses1
TO John;



--SETUSER
GRANT SELECT ON usp_GetAddresses1 TO Jane;

SETUSER 'Jane'
SELECT * FROM Person.Address;
--SELECT permission denied on object 'Address', database 'AdventureWorks',
--schema 'Person'.
SELECT * FROM usp_GetAddresses1;
SETUSER 'John'

use Demo

select * from Customer
select * from CustProd


create view test
as
select CustId from Customer union select CPID from CustProd


insert into test values(1,2)