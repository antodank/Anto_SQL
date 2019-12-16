IF (OBJECT_ID('tempdb..##tmpTest') IS NOT NULL)
	DROP TABLE ##tmpTest

CREATE TABLE ##tmpTest
(
	Value INT
)

DECLARE @i INT =1 

WHILE (@i <= 100) 
BEGIN

	INSERT INTO ##tmpTest(Value) VALUES(@i)

	SET @i=@i+1
END

select * from ##tmpTest