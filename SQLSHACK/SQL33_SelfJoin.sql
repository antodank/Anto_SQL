SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES

select * from [dbo].[Employees]
select * from [dbo].[Department]

-- print employess with manager
select e1.id,e1.FirstName as 'empname',e2.FirstName as 'mgrname'
from [dbo].[Employees] e1  join [dbo].[Employees] e2
on e1.ManagerID = e2.[id]

--list the employees who dont have managers
select e1.id,e1.FirstName,e2.FirstName as manager
from [dbo].[Employees] e1 left join [dbo].[Employees] e2
on e1.ManagerID = e2.[id] where e2.[id] is null

--list the employees who are not managers
-- while using in operator subquery should check for null
select id,FirstName from [dbo].[Employees] where id not in 
(select distinct ManagerID from [dbo].[Employees] where ManagerID is not null)


select mgrid,count(empid) from
(select e1.id [empid],e1.FirstName as empname,e2.id mgrid,e2.FirstName mgrname
from [dbo].[Employees] e1  join [dbo].[Employees] e2
on e1.ManagerID = e2.[id]) as tp group by tp.mgrid 



