DECLARE @columns NVARCHAR(MAX), @sql NVARCHAR(MAX);

SET @columns = N'';

SELECT @columns+=N', p.'+QUOTENAME([Name])
FROM
(
    SELECT [DocName] AS [Name]
    FROM [dbo].[InsuranceClaims] AS p
    GROUP BY [DocName]
) AS x;
SET @sql = N'
SELECT [PolNumber], '+STUFF(@columns, 1, 2, '')+' FROM (
SELECT [PolNumber], [Submitted] AS [Quantity], [DocName] as [Name] 
    FROM [dbo].[InsuranceClaims]) AS j PIVOT (SUM(Quantity) FOR [Name] in 
	   ('+STUFF(REPLACE(@columns, ', p.[', ',['), 1, 1, '')+')) AS p;';

print @sql
EXEC sp_executesql @sql


SELECT *
FROM
(
    SELECT [PolNumber],
           [PolType],
           [Effective Date],
           [DocName],
           [Submitted]
    FROM [dbo].[InsuranceClaims]
) AS SourceTable PIVOT(AVG([Submitted]) FOR [DocName] IN([Doc A],
                                                         [Doc B],
                                                         [Doc C],
                                                         [Doc D],
                                                         [Doc E])) AS PivotTable;