DECLARE @Min int;  
DECLARE @Max int;  
SET @Max = 150;  
SET @Min = 1;  
WITH Sequence_Table AS
(
SELECT @Min AS num UNION ALL 
SELECT num + 1 
FROM Sequence_Table WHERE num + 1 <= @Max
)  
SELECT num FROM Sequence_Table  
OPTION(MAXRECURSION 0)  

--Set MAXRECURSION to 0. When 0 is specified , no limit is applied 

WITH tempArray AS  
(  
SELECT 
  ROW_NUMBER() OVER(ORDER BY value DESC) AS ID,value FROM STRING_SPLIT('Anto,Roberto,Gail,Dylan', ',')
)   
SELECT ID, value  
FROM tempArray 

-- =====================================================

DECLARE @StartDate datetime = '2017-03-05'
       ,@EndDate   datetime = '2017-04-11'
;

WITH theDates AS
     (SELECT @StartDate as theDate
      UNION ALL
      SELECT DATEADD(day, 1, theDate)
        FROM theDates
       WHERE DATEADD(day, 1, theDate) <= @EndDate
     )
SELECT theDate, 1 as theValue
  FROM theDates
OPTION (MAXRECURSION 0)

--==============================================

WITH hrs AS
(
    SELECT h = 1
    UNION ALL
    SELECT h + 1
    FROM hrs
    WHERE h + 1 <= 24
)
SELECT 
    d = left(convert(varchar(50),DateAdd(hour, -1 * h, getdate()), 21),10), 
    h = DatePart(hour, DateAdd(hour, -1 * h, getdate())), 
    cnt = 0
FROM hrs order by h

-- ===========================================

DECLARE @StartDate datetime = '2021-01-01'
       ,@EndDate   datetime = '2021-12-31'
;
WITH DateTimeTable AS
		(
			SELECT
			@startDate AS DateAndHour
			UNION ALL
			SELECT
			DATEADD(hour,1,DateAndHour)
			FROM
			DateTimeTable
			WHERE
			DATEADD(day, 1, DateAndHour) <= @EndDate
)
select [day] = left(convert(varchar(50),DateAndHour, 21),10),
[Hour] = DATEPART(hour,	DateAndHour)
  from DateTimeTable
OPTION (MAXRECURSION 0)