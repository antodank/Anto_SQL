SELECT [ID],[FirstName] + ' ' + [LastName],Salary FROM [dbo].[Employees] ORDER BY [Salary] DESC
OFFSET 3 ROWS FETCH NEXT 3 ROWS ONLY

