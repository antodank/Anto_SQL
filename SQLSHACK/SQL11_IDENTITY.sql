
--IDENT_CURRENT returns the last identity value generated for a specific table in any session and any scope.

--@@IDENTITY returns the last identity value generated for any table in the current session, across all scopes.

--SCOPE_IDENTITY returns the last identity value generated for any table in the current session and the current scope.

select IDENT_CURRENT('dbSample.dbo.Employees')

select @@IDENTITY;

SELECT SCOPE_IDENTITY();  