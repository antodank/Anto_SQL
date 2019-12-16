--Creating an alias type based on the varchar data type
CREATE TYPE EmpName FROM VARCHAR(100)  
CREATE TYPE EmpAge FROM INT  
CREATE TYPE EmpLocation FROM VARCHAR(500)  

-- this types can be found under programmability -> Types
--  we can create table using these types as column data type
CREATE TABLE EMP(EMP_Name EmpName, Emp_Age EmpAge,Emp_Location EmpLocation)  
DECLARE @Name EmpName 

select * from EMP

--Creating a user-defined table type
CREATE TYPE LocationTableType AS TABLE 
    ( LocationName VARCHAR(50)
    , CostRate INT )
GO

-- we can give default values for the columns of the User-defined Table types
-- we can create the Identity column on the User-defined Table type
-- we can create schema wise types.

--Creating Table type  
  
CREATE TYPE empTempTabtype AS Table (
ID int identity(1,1),
name varchar(100), 
age int, 
location VARCHAR(100) default('mumbai'))    
  
--Creating temp table of above type  
  
DECLARE @emp empTempTabType    
INSERT INTO @emp VALUES('Ankit', 23,'Mumbai')    
INSERT INTO @emp VALUES('Viraj', 30, 'Thane')    
SELECT * FROM @emp   

-- deleting type
drop type empTempTabType






 