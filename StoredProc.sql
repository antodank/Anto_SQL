--Store Proc
--sybex - page -180
---user stored Procedure with a param
CREATE PROCEDURE STP_USD_to_EUR (@USD money)
AS BEGIN
Select @USD / 1.10 as 'Euro'
END

exec STP_USD_to_EUR 50

--just droping the procedure
drop proc STP_USD_to_EUR





---starting CLR Stored Proc
--CLR method of is much more efficient at returning operating system file information.

--change the configuration of Server by enabling CLR
sp_configure 'clr_enabled',1
reconfigure

--instance of SQL Server trusts the database and the contents within it.
USE master
alter database AdventureWorks
SET TRUSTWORTHY ON


---First create a .cs file using VS
--compile to .dll
--here i refer MyProc.dll -stored procedure returning information through an OUTPUT parameter

use Demo5
--creating an assembly
CREATE ASSEMBLY MyProcedure1
FROM 'D:\Tutorials\SQL Server2008\HOL\Day2\CLR\MyProc.dll';










---OR Adding File to associate with an assembly
ALTER ASSEMBLY MyProcedure1
ADD FILE FROM 'D:\Tutorials\SQL Server2008\HOL\Day2\CLR\MyProc.dll';

--you can view the file added in this

select * from sys.assembly_files 









--creating the CLR stored procedure
GO
CREATE PROCEDURE PriceSum (@sum1 money OUTPUT)
AS EXTERNAL NAME MyProcedure1.MyProc.PriceSum;
GO


---executing the CLR Stored Proc
DECLARE @sum money;
exec PriceSum @sum OUTPUT
select @sum


drop proc PriceSum
--drop ASSEMBLY MyProcedure




--creating the second proc -Returning Tabular Results
--To send the results of a query directly to the client, use one of the overloads of the Execute method on the SqlPipe object. This is the most efficient way to return results to the client, since the data is transferred to the network buffers without being copied into managed memory. For example:
CREATE PROCEDURE ExecuteToClient
AS EXTERNAL NAME MyProcedure1.MyProc.ExecuteToClient;

--Executing the procedure
exec ExecuteToClient

drop proc ExecuteToClient



--sending a tabular result and a message through SqlPipe.
GO
CREATE PROCEDURE HelloWorld
AS EXTERNAL NAME MyProcedure1.MyProc.HelloWorld;

--Executing
exec HelloWorld

drop proc HelloWorld