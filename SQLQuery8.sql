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

