/*Forthis example, let’s say you want to know the maximum list price 
of stock you’re holding over all theproduct categories. 
Using a temporary table, this would be a two-part process, as follows:*/

USE AdventureWorks
GO
SELECT p.ProductSubcategoryID, s.Name,SUM(ListPrice) AS ListPrice
INTO #Temp1
FROM Production.Product p
JOIN Production.ProductSubcategory s ON s.ProductSubcategoryID =
p.ProductSubcategoryID
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY p.ProductSubcategoryID, s.Name
--select * from #Temp1

SELECT ProductSubcategoryID,Name,MAX(ListPrice) as 'maximum List Price'
FROM #Temp1
GROUP BY ProductSubcategoryID, Name
HAVING MAX(ListPrice) = (SELECT MAX(ListPrice) FROM #Temp1)
DROP TABLE #Temp1;


----we’ve created a temporary table. This table has no index on it, and therefore SQL Server will complete a
--table scan operation on it when executing the second part. In
--Same query with CTE - a bit simpler and more efficient


WITH ProdList (ProductSubcategoryID,Name,ListPrice) AS
(
SELECT p.ProductSubcategoryID, s.Name,SUM(ListPrice) AS ListPrice
FROM Production.Product p
JOIN Production.ProductSubcategory s ON s.ProductSubcategoryID =
p.ProductSubcategoryID
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY p.ProductSubcategoryID, s.Name
)
SELECT ProductSubcategoryID,Name,MAX(ListPrice)
FROM ProdList
GROUP BY ProductSubcategoryID, Name
HAVING MAX(ListPrice) = (SELECT MAX(ListPrice) FROM ProdList)





------------------------
--multiple CTEs

;WITH CTE1 AS (SELECT 1 AS Col1),
CTE2 AS (SELECT 2 AS Col2)
SELECT CTE1.Col1,CTE2.Col2
FROM CTE1
CROSS JOIN CTE2
GO 

Option 2:

/* Method 2 */
;WITH CTE1 AS (SELECT 1 AS Col1),
CTE2 AS (SELECT COL1+1 AS Col2 FROM CTE1)
SELECT CTE1.Col1,CTE2.Col2
FROM CTE1
CROSS JOIN CTE2
GO 
-------------------------------

/*
Recursive is the process in which the query executes itself. 
It is used to get results based on the output 
of base query. We can use CTE as Recursive CTE (Common Table Expression).

Here, the result of CTE is repeatedly used to get the final resultset.
 The following example will explain in detail where I am using AdventureWorks database 
 and try to find hierarchy of Managers and Employees.*/

USE AdventureWorks
GO
WITH Emp_CTE AS (
SELECT EmployeeID, ContactID, LoginID, ManagerID, Title, BirthDate
FROM HumanResources.Employee
WHERE ManagerID IS NULL
UNION ALL
SELECT e.EmployeeID, e.ContactID, e.LoginID, e.ManagerID, e.Title, e.BirthDate
FROM HumanResources.Employee e
INNER JOIN Emp_CTE ecte ON ecte.EmployeeID = e.ManagerID
)
SELECT *
FROM Emp_CTE
GO 

--In the above example Emp_CTE is a Common Expression Table, the base record for the CTE is
-- derived by the first sql query before UNION ALL. The result of the query gives you the EmployeeID
-- which don’t have ManagerID.

--Second query after UNION AL-L is executed repeatedly to get results and it will 
--continue until it returns no rows. For above e.g. Result will have EmployeeIDs which have
-- ManagerID (ie, EmployeeID of the first result).  This is obtained by joining CTE result with Employee table 
--on columns EmployeeID of CTE with ManagerID of table Employee.

This process is recursive and will continue till there is no ManagerID who doesn’t have EmployeeID.

*/
/*
A recursive CTE is where an initial CTE is built and then the results from that are called recursively
in a UNION statement, returning subsets of data until all the data is returned. This gives you the ability
to create data in a hierarchical fashion, as we will see in our next example.
*/


USE AdventureWorks;
GO
WITH EmployeeReportingStructure
(ManagerID, EmployeeID, EmployeeLevel, Level,
ManagerContactId,ManagerTitle,ManagerFirst,ManagerLast,
EmployeeTitle,EmployeeFirst,EmployeeLast)
AS
(
-- Anchor member definition
SELECT e.ManagerID, e.EmployeeID, e.Title as EmployeeLevel,
0 AS Level,
e.ContactId as ManagerContactId,
CAST(' ' as nvarchar(8)) as ManagerTitle,
CAST(' ' as nvarchar(50)) as ManagerFirst,
CAST(' ' as nvarchar(50)) as ManagerLast,
c.Title as EmployeeTitle,c.FirstName as EmployeeFirst,
c.LastName as EmployeeLast
FROM HumanResources.Employee AS e
INNER JOIN Person.Contact c ON c.ContactId = e.ContactId
WHERE ManagerID IS NULL
UNION ALL
-- Recursive member definition
SELECT e.ManagerID, e.EmployeeID, e.Title as EmployeeLevel, Level + 1,
e.ContactId as ManagerContactId,
m.Title as ManagerTitle,m.FirstName as ManagerFirst,
m.LastName as ManagerLast,
c.Title as EmployeeTitle,c.FirstName as EmployeeFirst,
c.LastName as EmployeeLast
FROM HumanResources.Employee AS e
INNER JOIN Person.Contact c ON c.ContactId = e.ContactId
INNER JOIN EmployeeReportingStructure AS d
ON d.EmployeeID = e.ManagerID
INNER JOIN Person.Contact m ON m.ContactId = d.ManagerContactId
)
-- Statement that executes the CTE
SELECT ManagerID, EmployeeID,
ISNULL(ManagerTitle+' ','')+ManagerFirst+' '+ManagerLast as Manager,
EmployeeLevel,
ISNULL(EmployeeTitle+' ','')+EmployeeFirst+' '+EmployeeLast as Employee,
Level
FROM EmployeeReportingStructure
ORDER BY Level,EmployeeLast,EmployeeFirst
OPTION (MAXRECURSION 4)



----Creating view with CTE
create view numbers 
as 
with numbers(n) as 
( 
select 1 as n union all select n+1 from numbers where n<10000 
) 

select n from numbers 
GO

select * from numbers option (maxrecursion 0)


