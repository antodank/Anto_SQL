USE [dbSample];  
GO  
IF OBJECT_ID(N'dbSample.usp_tblEmployee',N'P')IS NOT NULL  
    DROP PROCEDURE dbSample.usp_tblEmployee;  
GO  
CREATE PROCEDURE usp_tblEmployee  
    (  
    @EmpID INT  
    ,@sal INT  
   )  
AS  
-- Declare variables used in error checking.  
DECLARE @ErrorVar INT;  
DECLARE @RowCountVar INT;  
  
-- Execute the UPDATE statement.  
Update tblEmployee set Salary=@sal Where Emp_IID=@EmpID
  
-- Save the @@ERROR and @@ROWCOUNT values in local   
-- variables before they are cleared.  
SELECT @ErrorVar = @@ERROR  
    ,@RowCountVar = @@ROWCOUNT;  
 
-- the UPDATE statement returns a foreign key violation error #547.  
IF @ErrorVar <> 0  
    BEGIN  
        IF @ErrorVar = 547  
            BEGIN  
                PRINT N'ERROR: A check constraint violation occurred.';   
            END  
        ELSE  
            BEGIN  
                PRINT N'ERROR: error '  
                    + RTRIM(CAST(@ErrorVar AS NVARCHAR(10)))  
                    + N' occurred.';  
            END   
	END

-- Check the row count. @RowCountVar is set to 0   
-- if an invalid @PurchaseOrderID was specified.  
	IF @RowCountVar = 0  
		BEGIN  
			PRINT 'Warning: specified salary is not in valid range.';  
			RETURN 1;  
		END
	ELSE    
		BEGIN  
			PRINT 'Employee salary updated';  
		RETURN 0;  
	END;  
  
 
GO  

exec usp_tblEmployee @EmpID = 1,@sal = 25000