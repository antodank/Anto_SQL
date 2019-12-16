---Functions
--scalar
--
GO
CREATE FUNCTION fn_Dollar_to_Euro(@dollar money)
returns money
as
begin
declare @result money
set @result = @dollar /1.10
return @result
end

GO

---
--testing.........

select dbo.fn_Dollar_to_Euro (50)



------------
GO
Create FUNCTION dbo.CalculateCircleArea (@Radius float=1.0)
RETURNS float
WITH RETURNS NULL ON NULL INPUT
AS
BEGIN
RETURN PI() * POWER(@Radius, 2);
END;
GO
SELECT dbo.CalculateCircleArea(10);
SELECT dbo.CalculateCircleArea(NULL);
SELECT dbo.CalculateCircleArea(2.5);
SELECT dbo.CalculateCircleArea(DEFAULT)

SELECT
OBJECTPROPERTY(OBJECT_ID('dbo.CalculateCircleArea'),'IsDeterministic');
GO

----


--Recursive Scalar UDF
GO
CREATE FUNCTION dbo.CalculateFactorial (@n int = 1)
RETURNS decimal(38, 0)
WITH RETURNS NULL ON NULL INPUT
AS
BEGIN
RETURN
(CASE
WHEN @n <= 0 THEN NULL
WHEN @n > 1 THEN CAST(@n AS float) * dbo.CalculateFactorial (@n - 1)
WHEN @n = 1 THEN 1
END);
END;

GO
SELECT dbo.CalculateFactorial(NULL); -- Returns NULL
SELECT dbo.CalculateFactorial(-1);-- Returns NULL
SELECT dbo.CalculateFactorial(0); -- Returns NULL
SELECT dbo.CalculateFactorial(5); -- Returns 120
SELECT dbo.CalculateFactorial(32);-- Returns 263130836933693520000000000000000000
--As you can see, the dbo.CalculateFactorial function easily handles the 32 levels of recursion


-----
---Table-Valued Functions
GO
CREATE FUNCTION GetMarks (@SID int)
RETURNS TABLE
AS
RETURN 
(
    SELECT * from Test where SID=@SID
 );
GO 
 Select * from GetMarks(3)
 
 GO
 
 