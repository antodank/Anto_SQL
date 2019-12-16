USE dbSample

--Create TABLE tblEmployee  
--(  
--Emp_IId Int identity(1,1),  
--First_Name Nvarchar(MAX) Not NUll,  
--Last_Name Nvarchar(MAX) Not Null,  
--Salary Int Not Null check(Salary>10000),  
--City Nvarchar(Max) Not Null  
--) 
-- we have set check constraint in above table as salary should be more tha 10000

-- @@ERROR and ERROR_NUMBER() returns the number that caused error
-- but ERROR_NUMBER() only works in catch block
-- @@ERROR will give you the error number for the last Transact-SQL statement executed.

select * from tblEmployee


declare @erno int


USE dbSample
GO
Update tblEmployee set Salary=5000 Where Emp_IID=1 
if @@ERROR = 547
BEGIN
PRINT 'A check constraint violation occurred.'
END
ELSE
BEGIN
PRINT 'Salary Updated'
END
GO

BEGIN TRY
Update tblEmployee set Salary=5000 Where Emp_IID=1 
if @@ERROR = 547
BEGIN
PRINT 'A check constraint violation occurred.'
END
ELSE
BEGIN
PRINT 'Salary Updated'
END
END TRY
BEGIN CATCH
print @@ERROR
print ERROR_LINE()
print ERROR_MESSAGE()
print ERROR_Severity()
print ERROR_PROCEDURE()
print ERROR_STATE()
END CATCH



BEGIN TRY  
SELECT SALARY + First_Name From [dbo].[tblEmployee] Where Emp_IID=2
END TRY  
BEGIN CATCH  
SELECT ERROR_STATE() AS ErrorState , ERROR_MESSAGE() ErrorMsg ,ERROR_SEVERITY() AS ErrorSeverity; 
END CATCH


--     


--USE dbSample
--Create TABLE tblEmployee  
--(  
--Emp_IId Int identity(1,1),  
--First_Name Nvarchar(MAX) Not NUll,  
--Last_Name Nvarchar(MAX) Not Null,  
--Salary Int Not Null check(Salary>10000),  
--City Nvarchar(Max) Not Null  
--) 
-- we have set check constraint in above table as salary should be more tha 10000


declare @erno int
BEGIN TRY
Update tblEmployee set Salary=5000 Where Emp_IID=1 
END TRY
BEGIN CATCH
print @@ERROR
print ERROR_NUMBER() 
END CATCH

-- @@ERROR and ERROR_NUMBER() returns the number that caused error
-- but ERROR_NUMBER() only works in catch block




-- Exception handling in SQL
--TRY…CATCH construct catches all execution errors that have a severity higher than 10 that 
--do not close the database connection
--A TRY block must be immediately followed by an associated CATCH block.

--Declare @val1 int;  
--Declare @val2 int;  
--BEGIN TRY  
--	Set @val1=8;  
--	Set @val2=@val1/0; /* Error Occur Here */  
--END TRY  
--BEGIN CATCH  
--	Print 'Error Occur that is:'  
--	Print Error_Message()  
--END CATCH 

--ERROR_MESSAGE returns the message text of the error that caused the erro

-- Throw used for used define error
--Declare @val1 int;  
--Declare @val2 int;  
--BEGIN TRY  
--Set @val1=8;  
--Set @val2=@val1%2;   
--if @val1=1  
--Print ' Error Not Occur'  
--else  
--Begin  
--Print 'Error Occur';  
--Throw 60000,'Number Is Even',5  
--End  
--END TRY  
--BEGIN CATCH  
--Print 'Error Occur that is:'  
--Print Error_Message()  
--END CATCH



