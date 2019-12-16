--A trigger is a specialized stored procedure that can execute either on a data modification, known as
--a Data Modification Language (DML) trigger, or on a data model action, such as CREATE TABLE, known
--as a Data Definition Language (DDL) trigger. DML triggers are pieces of code attached to a specific table
--that are set to automatically run in response to an INSERT, DELETE, or UPDATE command. However, a DDL
--trigger is attached to an action that occurs either within a database or within a server.

----DML TRIGGER -Insert/Update/Delete
CREATE TABLE StudentAudit(RowImage char(10),name varchar(20),changedate datetime,ChangeUser varchar(50));


ALTER TRIGGER StudAudit
ON dbo.Student
FOR UPDATE
AS
DECLARE @now DATETIME
SET @now = getdate()
BEGIN TRY
INSERT INTO dbo.StudentAudit
(RowImage, name, ChangeDate, ChangeUser)
SELECT 'BEFORE', DELETED.name, @now, suser_sname()
FROM DELETED
INSERT INTO dbo.StudentAudit
(RowImage, name, ChangeDate, ChangeUser)
SELECT 'AFTER', INSERTED.name, @now, suser_sname()
FROM INSERTED
END TRY
BEGIN CATCH
--Some error handling code
ROLLBACK TRANSACTION
END CATCH

update Student set name='z' where SID=1

Select * from dbo.StudentAudit

-------------------
--DELETE
Create TRIGGER StudAudit1
ON dbo.Student
FOR DELETE
AS

DECLARE @deleted_count int =
(
SELECT COUNT(*)
FROM deleted
);
IF @deleted_count>1
RAISERROR ('Delete Error',5,0)
ROLLBACK TRANSACTION


--
delete from Student

select * from Student
------------------------
--INSERT

CREATE TABLE dbo.trig_example 
(id INT, 
name VARCHAR(12),
salary MONEY) ;
GO
-- Create the trigger.
CREATE TRIGGER dbo.trig1 ON dbo.trig_example FOR INSERT
AS
IF (SELECT COUNT(*) FROM INSERTED
WHERE salary > 100000) > 0
BEGIN
    print 'TRIG1 Error: you attempted to insert a salary > $100,000'
    ROLLBACK TRANSACTION
END ;
GO
-- Try an insert that violates the trigger.
INSERT INTO dbo.trig_example VALUES (1,'Pat Smith',100001) ;
GO
-- Disable the trigger.
ALTER TABLE dbo.trig_example DISABLE TRIGGER trig1 ;
GO
-- Try an insert that would typically violate the trigger.
INSERT INTO dbo.trig_example VALUES (2,'Chuck Jones',100001) ;
GO
-- Re-enable the trigger.
ALTER TABLE dbo.trig_example ENABLE TRIGGER trig1 ;
GO
-- Try an insert that violates the trigger.
INSERT INTO dbo.trig_example VALUES (3,'Mary Booth',100001) ;
GO

-------------------------
--DDL Trigger
--must specify the scope- ALL SERVER or DATABASE

Use Ness
CREATE TRIGGER tddl_tabledropalterprevent
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE, CREATE_TABLE
AS
PRINT 'Tables cannot be dropped or altered!'
ROLLBACK ;


--Forms are CREATE, ALTER, DROP, GRANT, DENY, or REVOKE.


--shows thedata returned by the EVENTDATA() Function
-- Create a table to log DDL CREATE TABLE actions
CREATE TABLE dbo.DdlActionLog
(
EntryNum int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
EventType nvarchar(200) NOT NULL,
PostTime datetime NOT NULL,
Spid int NOT NULL,
LoginName sysname NOT NULL,
UserName sysname NOT NULL,
ServerName sysname NOT NULL,
SchemaName sysname NOT NULL,
DatabaseName sysname NOT NULL,
ObjectName sysname NOT NULL,
ObjectType sysname NOT NULL,
CommandText nvarchar(max) NOT NULL
);
GO

--drop trigger dbo.tddl_tabledropalterprevent
CREATE TRIGGER AuditCreateTable
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
-- Assign the XML event data to an xml variable
DECLARE @event_data xml;
SET @event_data = EVENTDATA();
-- Shred the XML event data and insert a row in the log table
INSERT INTO dbo.DdlActionLog
(
EventType,
PostTime,
Spid,
LoginName,
UserName,
ServerName,
SchemaName,
DatabaseName,
ObjectName,
ObjectType,
CommandText
)
SELECT
EventNode.value(N'EventType[1]', N'nvarchar(200)'),
EventNode.value(N'PostTime[1]', N'datetime'),
EventNode.value(N'SPID[1]', N'int'),
EventNode.value(N'LoginName[1]', N'sysname'),
EventNode.value(N'UserName[1]', N'sysname'),
EventNode.value(N'ServerName[1]', N'sysname'),
EventNode.value(N'SchemaName[1]', N'sysname'),
EventNode.value(N'DatabaseName[1]', N'sysname'),
EventNode.value(N'ObjectName[1]', N'sysname'),
EventNode.value(N'ObjectType[1]', N'sysname'),
EventNode.value(N'(TSQLCommand/CommandText)[1]', 'nvarchar(max)')
FROM @event_data.nodes('/EVENT_INSTANCE') EventTable(EventNode);
END;
GO

--Testing the DDL Trigger with a CREATE TABLE Statement
CREATE TABLE dbo.MyTable (i int);
GO

SELECT
EntryNum,
EventType,
UserName,
ObjectName,
CommandText
FROM DdlActionLog;
GO

--delete from DdlActionLog
drop Table dbo.MyTable 
drop Trigger  tddl_tabledropalterprevent ON DATABASE -- tRIGGERS EXIST OUTSIDE THE SCHEMA, SO ON DATABASE IS mandatory


--Logon triggers - new to 2005 SP2
--These triggers fire in response to a SQL Server LOGON event-after authentication succeeds, 
--but before the user session is established

--You can perform
--tasks ranging from simple LOGON event auditing to more advanced tasks like restricting the
--number of simultaneous sessions for a login or denying users the ability to create sessions
--during certain times.

--Example uses logon triggers to deny a given user the ability to log into SQL Server 
--during a specified time period 
--to deny the sample login the ability to log into SQL Server between 
--the hours of 9:00 and 11:00 PM on --Saturday nights.

--Creating a Test Login and Logon Denial Schedule
CREATE LOGIN PublicUser
WITH PASSWORD = 'p@$$w0rd';
GO
CREATE TABLE dbo.DenyLogonSchedule
(
UserId sysname NOT NULL,
DayOfWeek int NOT NULL,
TimeStart time NOT NULL,
TimeEnd time NOT NULL,
PRIMARY KEY (UserId, DayOfWeek, TimeStart, TimeEnd)
);
GO
INSERT INTO dbo.DenyLogonSchedule
(
UserId,
DayOfWeek,
TimeStart,
TimeEnd
)
VALUES
(
'PublicUser',
7,
'21:00:00',
'23:00:00'
);
GO
--Sample Logon Trigger
CREATE TRIGGER DenyLogons
ON ALL SERVER
WITH EXECUTE AS 'sa'
FOR LOGON
AS
BEGIN
IF EXISTS
(
SELECT 1
FROM AdventureWorks.dbo.DenyLogonSchedule
WHERE UserId = ORIGINAL_LOGIN()
AND DayOfWeek = DATEPART(WeekDay, GETDATE())
AND CAST(GETDATE() AS TIME) BETWEEN TimeStart AND TimeEnd
)
BEGIN
ROLLBACK TRANSACTION;
END;
END;
GO

DISABLE Trigger ALL ON ALL SERVER;
--DISABLE Trigger ALL ON  DATABASE;

--select ORIGINAL_LOGIN()