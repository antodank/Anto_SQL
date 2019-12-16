with cte as
(
SELECT 'First' as col1 ,1 as col2
UNION ALL
SELECT 'Second' as col1  ,2 as col2
UNION ALL
SELECT 'Third' as col1 ,3 as col2
UNION ALL
SELECT 'Fourth' as col1 ,4 as col2
UNION ALL
SELECT 'Fifth' as col1 ,5 as col2
UNION ALL
SELECT 'Six' as col1 ,null as col2
)
--select count(col2) from cte  
select * from cte  