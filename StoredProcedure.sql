CREATE PROCEDURE STP_USD_to_EUR (@USD money)
AS BEGIN
Select @USD / 1.10 as 'Euro'
END

exec STP_USD_to_EUR 50

--just droping the procedure
drop proc STP_USD_to_EUR



-----
GO
CREATE PROCEDURE HumanResources.usp_GetAllEmployees
AS
    SELECT LastName, FirstName, JobTitle, Department
    FROM HumanResources.vEmployeeDepartment;
GO

---
Create PROCEDURE HumanResources.usp_GetEmployees 
    @lastname varchar(40), 
    @firstname varchar(20) 
AS 
    SELECT LastName, FirstName, JobTitle, Department
    FROM HumanResources.vEmployeeDepartment
    WHERE FirstName = @firstname AND LastName = @lastname;

GO
Exec HumanResources.usp_GetEmployees 'Brown','Kevin'


E. Using the WITH RECOMPILE option

F. Using the WITH ENCRYPTION option

----------------Table Valued Parameter
USE Satyam

Create Type StudentType 
as 
Table (SID int,name varchar(20))

CREATE PROCEDURE GetStudent
(@Stud StudentType READONLY)
AS
BEGIN
SELECT * from @Stud
END

-----
DECLARE @StudentList StudentType;
INSERT INTO @StudentList
 VALUES
(1,'a'),
(2,'b');
exec GetStudent @StudentList



------Temporary  Store Proc
--With # and ##
--used for driver specialized solutions
--like database drivers. Open Database Connectivity (ODBC) drivers, for instance, make use of
--temporary SPs to implement SQL Server connectivity functions.


--(also explain execution context)
--Parameter Sniffing 
GO
alter PROCEDURE HumanResources.usp_GetEmployees 
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


---
----Impersonation
--to impersonate another user for a specific block of code

USE AdventureWorks
GO
CREATE LOGIN John WITH PASSWORD = '34r%*Fs$lK!9';
CREATE LOGIN Jane WITH PASSWORD = '4LWcm&(^o!HXk';
CREATE USER John FOR LOGIN John;
CREATE USER Jane FOR LOGIN Jane;
GO
EXEC sp_addrolemember 'db_datareader', 'John';
EXEC sp_addrolemember 'db_ddladmin', 'John';
GO
CREATE PROCEDURE usp_GetAddresses
WITH EXECUTE AS 'John'
AS
SELECT * FROM Person.Address;
GO

ALTER AUTHORIZATION ON usp_GetAddresses
TO John;

--------------------------------------------------------------
--Maintaining Security and Performance using Stored Procedures Part I – Using EXECUTE AS
--http://www.sqlservercentral.com/blogs/wisemanorwiseguy/archive/2009/10/08/maintaining-security-and-performance-using-stored-procedures-part-i-_1320_-using-execute-as.aspx
--I believe that using stored procedures makes your database more secure and makes it simpler to maintain a well performing system.  One area where stored procedures are more difficult to work with than building queries in the GUI or business layer are with dynamic search queries.  Here are some traditional issues with dynamic search in stored procedures:

--If you use traditional IF, ELSE statements to build the procedure you get a long and hard read procedure, and you are less likely to get plan re-use. 
--If you try tricks like WHERE LastName = IsNull(@LastName, LastName) and FirstName = IsNull(@FirstName, FirstName) you can get plan re-use, but the plan used may not be, and many times is not, the best plan to use. 
--If you use dynamic SQL using the EXEC (@sql) syntax you do not get plan re-use, you open yourself up for SQL Injection, and, prior to SQL Server 2005, you had to grant access to the objects used in the query defeating part of the reason for using stored procedures in the first place. 
--If you use dynamic SQL using sp_executsql and parameters you are more likely to get plan re-use, you are safe from sql injection, but, pre-2005, you still needed to grant access to the queried objects. 
--Either dynamic SQL option means creating a large string of SQL and concatenating it, so it can be and, in my opinion is, a pain to read and a pain to make sure you have all your syntax right. 


--Essentially you create the stored procedure and add the WITH EXECUTE AS Caller/Owner/Self/’user name’/’login name’ 
--(see the Books on Line entry for EXECUTE AS for more details) and this changes the context in which 
--the code within the procedure is run.  So you can create a user (SelectAll) in the database that has select
--rights on all the tables and then no matter who calls the stored procedure the procedure will run correctly.
--If you choose to use EXECUTE AS OWNER then the procedure executes in the security context of the Owner of the
--procedure so you can simulate ownership chaining.  



Use AdventureWorks;
Go
Create User DynamicSQLTest without login; -- no need to create a login as well.

--Next you need to create the stored procedure.
--I’m going to start with a “normal” stored procedure using Option 2 from above, because I also want to demonstrate the difference in performance.  Here’s the procedure:

Use AdventureWorks;
GO
IF OBJECT_ID('dbo.FindPhoneByName', N'P') Is Not Null
    Begin
            Drop Procedure dbo.FindPhoneByName; 
	End;
    Go 
    CREATE PROCEDURE dbo.FindPhoneByName(@LastName nvarchar(50) = null, @FirstName nvarchar(50) = null)
    AS
    BEGIN
    SET NOCOUNT ON;
    Select Title,FirstName,MiddleName,LastName,Suffix,Phone From Person.Contact  Where  LastName Like IsNull(@LastName, LastName) + N'%' And  FirstName Like IsNull(@FirstName, FirstName) + N'%';
    Return; 
    END
    GO


--Give the right to DynamicSQLTest
Use AdventureWorks;
Go
Grant Exec on dbo.FindPhoneByName to DynamicSQLTest;


--To test the security and performance of the stored procedure we are going to execute it 3 times:
	-- with a dbo user and
	-- then repeat as the limited rights user, 
	-- DynamicSQLTest.
	

Exec dbo.FindPhoneByName @FirstName = 'J', @LastName = 'A';
Go
Exec dbo.FindPhoneByName @FirstName = 'J';
Go
Exec dbo.FindPhoneByName @LastName = 'A';
Go


--Then execute the same 3 calls, but run this first to change the security context:
Execute AS User = 'DynamicSQLTest';Go


--If you are running the code in the same SSMS session be sure to issue the REVERT command to return to your original security context.




--The stored procedure calls should run successfully 
--for both users and should produce the same results and performance 
--for both users.  Now we’ll ALTER the procedure to use dynamic SQL:

Alter PROCEDURE dbo.FindPhoneByName (@LastName nvarchar(50) = null, @FirstName nvarchar(50) = null)
AS
BEGIN 
SET NOCOUNT ON;
    Declare @sql_cmd nvarchar(2000),@select nvarchar(1000), @where nvarchar(1000),@parameters nvarchar(1000);
    Set @parameters = N'@FirstName nvarchar(50), @LastName nvarchar(50)'; 
    Set @select = N'Select Title, FirstName, MiddleName,LastName,  Suffix, Phone  From Person.Contact'; 
    Set @where = N' Where 1=1 ' 
    If @LastName is not null  
     Begin  
      Set @where = @where + N' And LastName Like @LastName + N''%'' ';
	 End;   
	If @FirstName is not null  
	Begin 
	Set @where = @where + N' And FirstName Like @FirstName + N''%'''; 
	End;
	Set @sql_cmd = @select + @where; 
	Exec sys.sp_executesql @sql_cmd, @parameters, @LastName = @LastName, @FirstName = @FirstName;
	Return;
	END

--Now when you run our examples, you’ll see that it runs successfully under your original security context, but you receive an error when you run it as the limited rights user:

	--Msg 229, Level 14, State 5, Line 1 

--The SELECT permission was denied on the object 'Contact', database 'AdventureWorks', schema 'Person'.
--This is because the execution context changed and ownership chaining no longer applies.  To get the Dynamic SQL Stored procedure to work add WITH EXECUTE AS OWNER after the parameter definition like this:

ALTER PROCEDURE dbo.FindPhoneByName(@LastName nvarchar(50) = null,@FirstName nvarchar(50) = null)
With Execute As ownerAS

--Then you can re-run the your stored procedure calls and they should work both for the dbo user and the limited rights user because the EXECUTE AS OWNER has enabled access to the tables.

--result : for reference with set statistics io on

--Notice the reduced number of reads required by the Dynamic SQL when only 1 parameter is supplied.  This is because it is using a different query plan, while the Non-Dynamic procedure has one query plan which is not optimal when only one parameter is supplied 
--------------Conclusions
--As you can see some of the limitations of Dynamic SQL have been “cured” by the advent of the EXECUTE AS clause.  This has made it simpler to use Dynamic SQL and get the performance benefits provided by getting a proper execution plan and getting plan re-use.  


