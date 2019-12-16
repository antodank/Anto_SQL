DROP TABLE IF EXISTS TestNumeric
CREATE TABLE TestNumeric (TestValFloat FLOAT,TestValNum REAL)
 
DECLARE @ValueFloat FLOAT =0
DECLARE @ValueNum int =0
DECLARE @i INT=0

WHILE @i <=1000
BEGIN
SET @ValueFloat=@ValueFloat + 0.1
SET @ValueNum = @ValueNum + 1
INSERT INTO TestNumeric (TestValFloat,TestValNum) VALUES(@ValueFloat,@ValueNum)
SET @i = @i+1
END
 
SELECT * FROM TestNumeric