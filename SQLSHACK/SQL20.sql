--Dynamic SQL by writing a query with parameters

--DECLARE @city varchar(75)
--SET @city = 'Mumbai'

--SELECT * FROM tbPerson WHERE City = @city

--Dynamic SQL commands using EXEC
--DECLARE @sqlCommand varchar(1000)
--DECLARE @columnList varchar(75)

--SET @columnList = 'PID, FNAME, LNAME'
--SET @city = '''Mumbai'''
--SET @sqlCommand = 'SELECT ' + @columnList + ' FROM tbPerson WHERE City = ' + @city

--EXEC (@sqlCommand)

--Dynamic SQL commands using sp_executesql

DECLARE @sqlCommand nvarchar(1000)
DECLARE @columnList varchar(75)
DECLARE @city varchar(75)
SET @columnList = 'PID, FNAME, LNAME'
SET @city = 'Mumbai'
SET @sqlCommand = 'SELECT ' + @columnList + ' FROM tbPerson WHERE City = @city'

EXECUTE sp_executesql @sqlCommand, N'@city nvarchar(75)', @city = @city