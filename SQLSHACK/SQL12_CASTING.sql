

--CAST AND CONVERT
--functions convert an expression of one data type to another.

SELECT 9.5 AS OriginalData, CAST(9.5 AS int) AS intData,CAST(9.5 AS decimal(6,2)) AS decimaldata;

SELECT 9.5 AS OriginalData, CONVERT(int, 9.5) AS intData, CONVERT(decimal(6,4), 9.5) AS decimaldata;

--PARSE  
--Use PARSE only for converting from string to date/time and number types
SELECT PARSE('Monday, 13 December 2010' AS datetime2 USING 'en-US') AS Result;


--TRY_CAST() TRY_CONVERT() 
--Returns a value cast to the specified data type if the cast succeeds; otherwise, returns null.

SELECT CASE WHEN TRY_CAST('test' AS float) IS NULL THEN 'Cast failed' ELSE 'Cast succeeded'  END AS Result; 
SELECT CASE WHEN TRY_CONVERT(float, 'test') IS NULL THEN 'Cast failed' ELSE 'Cast succeeded' END AS Result; 

SET DATEFORMAT dmy;  
SELECT TRY_CONVERT(datetime2, '12/31/2010') AS Result;   

SET DATEFORMAT mdy;  
SELECT TRY_CONVERT(datetime2, '12/31/2010') AS Result;  