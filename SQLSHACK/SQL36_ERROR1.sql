-- ON Stops the message that shows the count of the number of rows affected
-- OFF Shows the no of rows afftected
SET NOCOUNT OFF
select * from [dbo].[Employees]
select @@ROWCOUNT

-- @@ROWCOUNT Returns the number of rows affected by the last statement.

Declare @val1 int;  
Declare @val2 int; 
BEGIN TRY
SET @val1 = 10
Set @val2 = @val1 / 2;
select @val2 ;
END TRY
BEGIN CATCH
END CATCH
select @@TRANCOUNT;


--@@TRANCOUNT - Returns the number of BEGIN TRANSACTION statements
--BEGIN TRANSACTION statement increments @@TRANCOUNT by 1. 
--ROLLBACK TRANSACTION / COMMIT TRANSACTION decrements @@TRANCOUNT to 0


-- @@IDENTITY - eturns the last-inserted identity value.

-- @@ERROR Returns the error number for the last Transact-SQL statement executed



BEGIN TRY
BEGIN TRANSACTION;
insert into [dbo].[Employees] values ('kk','bf','Male',10000,2)
insert into [dbo].[Employees] values ('xx','nn','Male',5000,3)
PRINT 'Added1'
insert into [dbo].[Employees] values ('ll','ll','Male',5000,4)
PRINT 'Added2'
COMMIT  TRANSACTION;
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;
 
    DECLARE @ErrorNumber INT = ERROR_NUMBER();
    DECLARE @ErrorLine INT = ERROR_LINE();
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
    DECLARE @ErrorState INT = ERROR_STATE();
 
    PRINT 'Actual error number: ' + CAST(@ErrorNumber AS VARCHAR(10));
    PRINT 'Actual line number: ' + CAST(@ErrorLine AS VARCHAR(10));
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH