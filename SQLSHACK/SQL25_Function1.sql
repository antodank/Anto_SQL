GO 
CREATE FUNCTION AddTwoIntegers
(
    @FirstInteger int,
    @SecondInteger int
)
RETURNS int
AS
BEGIN
    declare @TotalOfBothIntegers int
    -- add both of our two inputs together
    set @TotalOfBothIntegers = @FirstInteger + @SecondInteger
    -- return them
    RETURN @TotalOfBothIntegers
END
GO

create PROCEDURE GetAddedNumbers
    @StartNumber1 int, 
    @StartNumber2 int
AS
BEGIN
    -- create an in memory table with three integers as fields
    declare  @ResultsTable table (
        Number1 int,
        Number2 int,
        TheirSum int
    )
    
    declare @counter int
    set @counter = 0
    
    -- loop through 10 times
    while @counter < 10
    begin
        set @counter = @counter + 1
        
        -- insert my values into my temp table
        INSERT INTO @ResultsTable 
                    (Number1, Number2, TheirSum) 
        VALUES 
                    (@StartNumber1, @StartNumber2, dbo.AddTwoIntegers(@StartNumber1, @StartNumber2))
      
        set @StartNumber1 = @StartNumber1 + 2
        set @StartNumber2 = @StartNumber2 + 1
    end
    
    select * from  @ResultsTable    
END
GO

EXEC    [dbo].[GetAddedNumbers]
        @StartNumber1 = 1,
        @StartNumber2 = 45

