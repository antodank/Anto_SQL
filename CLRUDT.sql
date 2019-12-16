USE HP;
CREATE ASSEMBLY Point
FROM 'D:\Tutorials\SQLServer2005\DataTypesnTables\Point.dll' 
WITH PERMISSION_SET = SAFE;

CREATE TYPE dbo.Point 
EXTERNAL NAME Point.[Point];

--select  * from sys.assemblies






----------create table with UDT
CREATE TABLE dbo.Points 
(ID int IDENTITY(1,1) PRIMARY KEY, PointValue Point)


--Inserting Data in a UDT Column
INSERT INTO dbo.Points (PointValue) VALUES (CONVERT(Point, '3,4'));
INSERT INTO dbo.Points (PointValue) VALUES (CONVERT(Point, '1,5'));
INSERT INTO dbo.Points (PointValue) VALUES (CAST ('1,99' AS Point));


---displays binary value
select * from dbo.Points;

--displays values after conversion
select ID, PointValue.ToString() as PointValue from dbo.Points;


--or use CAST or CONVERT
SELECT ID, CAST(PointValue AS varchar) 
FROM dbo.Points;

SELECT ID, CONVERT(varchar, PointValue) 
FROM dbo.Points;


--selecting only X or Y value
SELECT ID, PointValue.X AS xVal, PointValue.Y AS yVal 
FROM dbo.Points;


sp_configure 'clr enabled', 1 
Reconfigure






--------------------Working with Variables
DECLARE @PointValue Point;
SET @PointValue = (SELECT PointValue FROM dbo.Points
    WHERE ID = 2);
SELECT @PointValue.ToString() AS PointValue;


















---Comparing Data
--if you have set the IsByteOrdered property to true 
SELECT ID, PointValue.ToString() AS Points 
FROM dbo.Points
WHERE PointValue > CONVERT(Point, '2,2');

---You can compare internal values of the UDT regardless of the IsByteOrdered setting if the values themselves are comparable. The following Transact-SQL statement selects rows where X is greater than Y:
SELECT ID, PointValue.ToString() AS PointValue 
FROM dbo.Points
WHERE PointValue.X < PointValue.Y;



---use comparison operators with variables

DECLARE @ComparePoint Point;
SET @ComparePoint = CONVERT(Point, '3,4');
SELECT ID, PointValue.ToString() AS MatchingPoint 
FROM dbo.Points
WHERE PointValue = @ComparePoint;




----Invoking UDT Methods
SELECT ID, PointValue.X AS [Point.X], 
    PointValue.Y AS [Point.Y],
    PointValue.Distance() AS DistanceFromZero 
FROM dbo.Points;



----Updating Data in a UDT Column
UPDATE dbo.Points
SET PointValue = CAST('1,88' AS Point)
WHERE ID = 3


UPDATE dbo.Points
SET PointValue.Y = 99
WHERE ID = 3






---If the UDT has been defined with byte ordering set to true, Transact-SQL can evaluate the UDT column in a WHERE clause. 
UPDATE dbo.Points
SET PointValue = '4,5'
WHERE PointValue = '3,4';










