--doesn’t contain any data or information.
 --All it contains is the query that the user defines when creating the view
 
 --can contain one or more columns not all (user does not have access to base table)
 
 use Ness
 GO
 CREATE VIEW myView
 As
 Select * from Student
 
 Select * from myView
 
 insert into myView values(7,'g')
 
 drop Table Student
 
 
 CREATE VIEW myView1 with SchemaBinding
 As
 Select SID,name from dbo.Student
 
 
 
 WITH ENCRYPTION
 
 sp_helptext PurchaseOrderReject
 
 
 --implementing row-level security
 --or horizontal filtering
 ----------------------NOn UPDATABLE VIEW-----------
create view sem_v1  as select * from dbo.sem1
 where marks>75 WITH CHECK OPTION
 
insert into sem_v1 values('g',62)
