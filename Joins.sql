----example of a FROM clause join specification
--returns the product and supplier information for any combination of parts supplied by a company for which the company name starts with the letter F and the price of the product is more than $10.

use Ness
Create Table Student(SID int,name varchar(20))
Create Table Test(TestID int,SID int,Mark decimal)


insert into Student values(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e'),(6,'f')
insert into Test values(1,1,85),(2,3,35),(3,5,80),(4,100,90)



delete  from Test


--inner join
Select S.name,T.Mark FROM Student S inner join Test T on (S.SID=T.SID)
GO







Select S.name,T.Mark FROM Student S left outer join Test T on (S.SID=T.SID)
GO

Select S.name,T.Mark FROM Student S right outer join Test T on (S.SID=T.SID)
GO
Select S.name,T.Mark FROM Student S full outer join Test T on (S.SID=T.SID)
GO


SELECT ProductID, Purchasing.Vendor.VendorID, Name
FROM Purchasing.ProductVendor JOIN Purchasing.Vendor
    ON (Purchasing.ProductVendor.VendorID = Purchasing.Vendor.VendorID)
WHERE StandardPrice > $10
  AND Name LIKE N'F%'
GO

----The readability is further improved if table aliases are used

SELECT pv.ProductID, v.VendorID, v.Name
FROM Purchasing.ProductVendor pv JOIN Purchasing.Vendor v
    ON (pv.VendorID = v.VendorID)
WHERE StandardPrice > $10
    AND Name LIKE N'F%'


--contains the same join condition specified in the WHERE clause:
--specifying them in the FROM clause is recommended
SELECT pv.ProductID, v.VendorID, v.Name
FROM Purchasing.ProductVendor pv, Purchasing.Vendor v
WHERE pv.VendorID = v.VendorID
    AND StandardPrice > $10
    AND Name LIKE N'F%'

--types of joins
-- 1. Inner joins
	-- use a comparison operator to match rows from two tables based on the values in common columns from each table
	
-- 2. Outer join
	--LEFT Outer JOIN
		--includes all the rows from the left table specified 
	--RIGHT Outer JOIN
		--A right outer join is the reverse of a left outer join. 
	--FULL OUTER JOIN 
		--returns all rows in both the left and right tables.
-- 3.Self joins 

	--A table can be joined to itself in a self-join
	
	
	---Examples
	--inner join retrieving the employees who are also sales persons:
	
	USE AdventureWorks;
	GO
	SELECT e.EmployeeID
	FROM HumanResources.Employee AS e
    INNER JOIN Sales.SalesPerson AS s
    ON e.EmployeeID = s.SalesPersonID

--Joins Using Operators Other Than Equal
--to find sales prices of product 718 that are less than the 
--list price recommended for that product. 

USE AdventureWorks;
GO
SELECT DISTINCT p.ProductID, p.Name, p.ListPrice, sd.UnitPrice AS 'Selling Price'
FROM Sales.SalesOrderDetail AS sd
    JOIN Production.Product AS p 
    ON sd.ProductID = p.ProductID AND sd.UnitPrice < p.ListPrice
WHERE p.ProductID = 718;
GO


--joining more than two tables
SELECT p.Name, v.Name
FROM Production.Product p
JOIN Purchasing.ProductVendor pv
ON p.ProductID = pv.ProductID
JOIN Purchasing.Vendor v
ON pv.VendorID = v.VendorID
WHERE ProductSubcategoryID = 15
ORDER BY v.Name



---Left Outer Joins
--include all products, regardless of whether a review has been written for one
USE AdventureWorks;
GO
SELECT p.Name, pr.ProductReviewID
FROM Production.Product p
LEFT OUTER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID


--Right Outer Joins
--include all sales persons in the results, regardless of whether they are assigned a territory
USE AdventureWorks;
GO
SELECT st.Name AS Territory, sp.SalesPersonID
FROM Sales.SalesTerritory st 
RIGHT OUTER JOIN Sales.SalesPerson sp
ON st.TerritoryID = sp.TerritoryID ;


--Full Outer Joins
USE AdventureWorks;
GO

-- The OUTER keyword following the FULL keyword is optional.
--returns only those products that have no matching sales orders, as well as those sales orders that are not matched to a product (although all sales orders, in this case, are matched to a product). 

SELECT p.Name, sod.SalesOrderID
FROM Production.Product p
FULL OUTER JOIN Sales.SalesOrderDetail sod
ON p.ProductID = sod.ProductID
WHERE p.ProductID IS NULL
OR sod.ProductID IS NULL
ORDER BY p.Name ;

---Self Join
Create Table Emp(EmpId int, Name varchar(50),MgrID int)

insert into Emp values (1, 'aaa',4),(2,'bbb',1),(3,'ccc',2),(4,'ddd',5),(5,'eee',3)

SELECT  E1.Name as 'Employee' ,E2.Name as 'Manager'
FROM dbo.Emp  E1
INNER JOIN dbo.Emp  E2
ON E1.MgrID=E2.EmpId 



--------------------------------------
----example of inner join
SELECT *
FROM HumanResources.Employee AS E
INNER JOIN HumanResources.EmployeeAddress AS EA ON
E.EmployeeID = EA.EmployeeID



--left outer join
SELECT *
FROM HumanResources.Employee AS E
LEFT OUTER JOIN HumanResources.EmployeeAddress AS EA ON
E.EmployeeID = EA.EmployeeID


------sub query
---------selects all the employees from the Employee table if
----------the employee’s ID is in the EmployeeAddress table:
SELECT *
FROM HumanResources.Employee AS E
WHERE E.EmployeeID IN
(
SELECT EmployeeID
FROM HumanResources.EmployeeAddress
)


--You can also write this query using the correlated form of a subquery. Correlated
--means that the subquery uses one or more columns from the outer query. The following
--query is logically equivalent to the preceding noncorrelated version:
SELECT *
FROM HumanResources.Employee AS E
WHERE EXISTS
(
SELECT *
FROM HumanResources.EmployeeAddress EA
WHERE E.EmployeeID = EA.EmployeeID
)

---subquery in the Select ----best
SELECT EmployeeID,
(
SELECT EA.AddressID
FROM HumanResources.EmployeeAddress EA
WHERE EA.EmployeeID = E.EmployeeID
) AS AddressId
FROM HumanResources.Employee AS E


SELECT AddressID
FROM HumanResources.EmployeeAddress 
WHERE EmployeeID = 1

select AddressLine1,AddressLine2,City,PostalCode from Person.Address where AddressID =(SELECT AddressID
FROM HumanResources.EmployeeAddress 
WHERE EmployeeID = 1)