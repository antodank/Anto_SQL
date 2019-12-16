select * from  sys.tables

WITH PartitionTables AS(
	SELECT 
		DENSE_RANK() OVER (ORDER BY is_ms_shipped) PlusId
		, (ROW_NUMBER() OVER (PARTITION BY is_ms_shipped ORDER BY [name])) Id
		, (DENSE_RANK() OVER (ORDER BY is_ms_shipped)*1000) + (ROW_NUMBER() OVER (PARTITION BY is_ms_shipped ORDER BY [name])) GroupId
		, is_ms_shipped
		,[name]
	FROM sys.tables
)
SELECT *
FROM PartitionTables