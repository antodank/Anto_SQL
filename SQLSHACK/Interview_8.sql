select * from SampleFruits


SELECT * FROM
(SELECT ROW_NUMBER() Over(ORDER BY Id) AS RowNum,*
FROM SampleFruits ) t
WHERE t.RowNum BETWEEN 1 AND 5

-- OFFSET argument specifies how many rows will be skipped from the result
SELECT Id,FruitName, Price
FROM SampleFruits
ORDER BY Id
OFFSET 5 ROWS

-- OFFSET 0 ROWS will fetch all rows
-- OFFSET rows count + 1 ROWS will not fetch anything

SELECT Id,FruitName, Price
FROM SampleFruits
ORDER BY Id
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY

-- Loop
DECLARE @PageNumber AS INT
DECLARE @RowsOfPage AS INT
DECLARE @MaxTablePage  AS FLOAT 
SET @PageNumber=1
SET @RowsOfPage=3
SELECT @MaxTablePage = COUNT(*) FROM SampleFruits
SET @MaxTablePage = CEILING(@MaxTablePage/@RowsOfPage)
WHILE @PageNumber <=  @MaxTablePage
BEGIN
    SELECT FruitName,Price FROM SampleFruits
ORDER BY Id 
OFFSET (@PageNumber-1)*@RowsOfPage ROWS
FETCH NEXT @RowsOfPage ROWS ONLY
SET @PageNumber = @PageNumber + 1
END