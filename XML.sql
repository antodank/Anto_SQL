--Creating nvarchar(max) col - using as a text type

DECLARE @myXML AS nvarchar(max)
SET @myXML = '<log><application>Sales</application><description>The connection timed
out</description></log>'
print @myXML


--Creating XML col
--Un-Typed Column
CREATE TABLE UniversalLog(recordID int, description XML)
INSERT UniversalLog(recordID, description)
VALUES(1, '<log><application>Sales</application><description>The connection timed
out.</description></log>')

INSERT UniversalLog(recordID, description)
VALUES(1, 'database unavailable')

select * from UniversalLog


------
--Create Typed Col
CREATE XML SCHEMA COLLECTION LogRecordSchema AS
'<schema xmlns="http://www.w3.org/2001/XMLSchema">
<element name="log">
<complexType>
<sequence>
<element name="application" type="string"/>
<element name="description" type="string"/>
</sequence>
</complexType>
</element>
</schema>'

SELECT xml_schema_namespace(N'dbo',N'LogRecordSchema')

--Drop Table UniversalLog
delete from UniversalLog
ALTER TABLE UniversalLog ALTER COLUMN description XML(LogRecordSchema)


INSERT UniversalLog(recordID, description)
VALUES(1, '<log><application>Sales</application><description>The connection timed
out.</description></log>')

INSERT UniversalLog(recordID, description)
VALUES(2, '<log><application>Purchase</application><description>The connection timed
out.</description></log>')

----error
INSERT UniversalLog(recordID, description)
VALUES(1, 'database unavailable')

--Create schema namespace from existing xsd file
declare @schema XML
SELECT @schema = c FROM OPENROWSET (
BULK 'D:\Tutorials\SQLServer2008\XML\logRecordSchema.xsd', SINGLE_BLOB) AS TEMP(c)
CREATE XML SCHEMA COLLECTION LogRecordSchema1 AS @schema






--Retrieving data in XML form
--FOR XML Syntax
SELECT column list FROM table list WHERE filter criteria
FOR XML RAW | AUTO | EXPLICIT [, XMLDATA] [, ELEMENTS]
[, BINARY BASE64]

--Most people use the AUTO or RAW mode.
--EXPLICIT mode is an explicit pain to work with.


--RAW mode
--returns columns as attributes and rows as row elements.

Use AdventureWorks 
Select * from Production.ProductCategory FOR XML raw

--adds a root
Select * from Production.ProductCategory FOR XML raw, root 

---testing to create a file from table contents
DECLARE @a xml
set @a=(Select *  from Production.ProductCategory FOR XML raw, root )

--returns with XMLSchema
Select * from Production.ProductCategory FOR XML RAW, XMLDATA

--AUTO mode
Select * from Production.ProductCategory FOR XML AUTO

Select D.Name as DeptName,DE.EmployeeID as EmployeeID ,DE.StartDate ,DE.EndDate  from HumanResources.Department D inner join HumanResources.EmployeeDepartmentHistory DE on D.DepartmentID=DE.DepartmentID 
ORDER BY DeptName FOR XML AUTO


--EXPLICIT gives more readable output
Select 1 as Tag, NULL as Parent ,Name as[HumanResources.Department!1!Name!element] , NULL as [HumanResources.EmployeeDepartmentHistory!2!EmpID!element],
NULL as [HumanResources.EmployeeDepartmentHistory!2!SrtDt!element], NULL as [HumanResources.EmployeeDepartmentHistory!2!EndDt!element] from HumanResources.Department 
UNION ALL
Select 2 as Tag, 1 as Parent,D.Name  ,DE.EmployeeID  
 ,DE.StartDate   ,DE.EndDate  
 from HumanResources.Department D inner join HumanResources.EmployeeDepartmentHistory DE on D.DepartmentID=DE.DepartmentID 
 ORDER BY [HumanResources.Department!1!Name!element]
FOR XML EXPLICIT






--XQUERY
--Creating another Table for further practises
CREATE TABLE xmltbl (pk INT IDENTITY PRIMARY KEY, xmlCol XML not null)

INSERT INTO xmltbl values ('<people>
<person>
<name>
<givenName>Martin</givenName>
<familyName>Smith</familyName>
</name>
<age>33</age>
<height>short</height>
</person>
<person>
<name>
<givenName>Stacy</givenName>
<familyName>Eckstein</familyName>
</name>
<age>40</age>
<height>short</height>
</person>
<person>
<name>
<givenName>Tom</givenName>
<familyName>Rizzo</familyName>
</name>
<age>30</age>
<height>medium</height>
</person>
</people>')

--Querying XML Data

--FLWOR stands for For-Let-Where-Order By-Return. FLWOR is --similar to T-SQL’s SELECT, FROM, and
--WHERE statements, in that you can conditionally return --information based on criteria that you set.
--However, instead of returning relational data like T-SQL, --XQuery returns XML data.

--Query()returns all the 'given name'
SELECT xmlCol.query(
'for $p in people
where $p//age
return
<person>
<name>{$p//givenName}</name>
</person>
'
)
FROM xmltbl


---counts the number of person elements
SELECT  xmlCol.query(
'count(people/person)
')
FROM XMLtbl
go


---calculate the rounded average age of people
SELECT xmlCol.query(
'round(avg(//age))
')
FROM XMLtbl
go


-----
SELECT xmlCol.query(
'for $c in (people)
where $c//age
return
<customers>
<name>
{$c//givenName}
</name>
<match>{contains($c,"Martin")}</match>
<maxage>{max($c//age)}</maxage>
</customers>
')
FROM xmltbl
Go


--Retrieve the list of persons whose age>30
SELECT xmlCol.query(
'for $c in (/people/person)
where $c//age>30
return
<name>
{$c//givenName}
</name>
')
FROM xmltbl
Go



--Retrieve the age of the person 'Tom' - assignment
SELECT xmlCol.query(
'for $c in (/people/person)
where $c//givenName="Tom"
return
<name>
{$c//age}
</name>
')
FROM xmltbl
Go




--Basic XML Query Methods
--• query(): Returns the XML that matches your query
--• value(): Returns a scalar value from your XML
--• exist(): Checks for the existence of the specified XML in your XML datatype
--• nodes(): Returns a rowset representation of your XML

-- Create a new table
CREATE TABLE xmltblnew (pk INT IDENTITY PRIMARY KEY, people XML)
GO
--Insert data into the new table
INSERT INTO xmltblnew (people)
SELECT *
FROM OPENROWSET (
BULK 'D:\Tutorials\SQL Server2008\Induction\Day2\XML\XMLSample.xml',
SINGLE_BLOB) AS TEMP
GO


--gets the age of the second person in the XML document and returns
--it as an integer:
SELECT people.value('/people[1]/person[2]/age[1][text()]', 'integer')
as age FROM XMLtblnew
GO


SELECT pk, people FROM xmltblnew
WHERE people.exist('/people/person/name/givenName[.="Tom"]') = 1



--Modifying XML Data
--The modify() method allows you to modify parts of your XML data.
--includes Data Manipulation Language (DML)commands such as 
--insert, delete, and replace value of.

--INSERT
DECLARE @GroceryList xml
SET @GroceryList='<List><Item>Bananas</Item><Item>Apples</Item></List>'
DECLARE @AdditionalItem xml
SET @AdditionalItem='<Item>Dog Food</Item>'
SET @GroceryList.modify
('insert sql:variable("@AdditionalItem") as last into (/List)[1]')
SELECT @GroceryList


--DELETE
DECLARE @GroceryList xml
SET @GroceryList='<List><Item>Bananas</Item><Item>Apples</Item></List>'
SET @GroceryList.modify('delete /List/Item[2]')
SELECT @GroceryList



--Changing a Node Value
--First insert a new value
UPDATE xmltblnew SET people.modify(
'insert <favoriteColor>Red</favoriteColor>
as last into (/people/person[3])[1]')
WHERE pk=1
GO
--Select the data to show the change
SELECT * FROM xmltblnew
GO
--Modify the value
UPDATE xmltblnew SET people.modify(
'replace value of (/people/person[3]/favoriteColor[1]/text())[1]
with "Blue"')
WHERE pk=1
GO
--Select the data to show the change
SELECT * FROM xmltblnew
GO
--Now delete the value
UPDATE xmltblnew SET people.modify(
'delete /people/person[3]/favoriteColor')
WHERE pk=1
GO
--Select the data to show the change
SELECT * FROM xmltblnew
GO



-----XML indexing (appress - page 571)
--PRIMARY

CREATE PRIMARY XML INDEX idx_xmlCol on xmltblnew(people)

--SECONDARY
--PATH - for Query(),Exist(), PROPERTY - for value(), and VALUE-a wildcard search with value()


--Creating a PATH Secondary Index
CREATE XML INDEX idx_xmlCol_PATH on xmltblnew(people)
USING XML INDEX idx_xmlCol FOR PATH
-- Query that would use this index
SELECT people FROM xmltblnew
WHERE (people.exist('/people/person/name/givenName[.="Tom"]') = 1)

--Creating a PROPERTY Secondary Index
CREATE XML INDEX idx_xmlCol_PROPERTY on xmltblnew(people)
USING XML INDEX idx_xmlCol FOR PROPERTY
-- Query that would use this index
SELECT people.value('(/people/person/age)[1]', 'int') FROM xmltblnew

--Creating a VALUE Secondary Index
CREATE XML INDEX idx_xmlCol_VALUE on xmltblnew(people)
USING XML INDEX idx_xmlCol FOR VALUE
-- Query that would use this index
SELECT people FROM xmltblnew WHERE people.exist('//age') = 1


----


-------rough work
CREATE XML SCHEMA COLLECTION ContractSchemas AS '
<schema xmlns="http://www.w3.org/2001/XMLSchema">
<element name="contract" type="string"/>
</schema>
<schema xmlns="http://www.w3.org/2001/XMLSchema">
</schema>'


CREATE TABLE  Contracts (
DocumentId int,
DocumentText xml (ContractSchemas)
)
GO
