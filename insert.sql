--page - 276
Use Test
go
create Schema ShareDetails

CREATE TABLE ShareDetails.Shares(
ShareId bigint IDENTITY(1,1) NOT NULL,
ShareDesc nvarchar(50) NOT NULL,
ShareTickerId nvarchar(50) NULL,
CurrentPrice numeric(18, 5) NOT NULL
) ON [PRIMARY]
GO

---this will generate error because double quotes
INSERT INTO [ShareDetails].[Shares]
([ShareDesc]
,[ShareTickerId]
,[CurrentPrice])
VALUES
("ACME'S HOMEBAKE COOKIES INC",
'AHCI',
2.34125)

---to solve this
SET QUOTED_IDENTIFIER OFF
GO


INSERT INTO [ShareDetails].[Shares]
([ShareDesc]
,[ShareTickerId]
,[CurrentPrice])
VALUES
("ACME'S HOMEBAKE COOKIES INC",
'AHCI',
2.34125)




-------------------------
--you have to specify every column every time a record is
--inserted into a table.? NO

--use Default constraint or NULL clause with columns

--since ShareTickerId is NULL, we would have been executes like
--below
INSERT INTO ShareDetails.Shares
(ShareDesc
,CurrentPrice)
VALUES
("ACME'S HOMEBAKE COOKIES INC",
2.34125)

---drill down NULL
--1. is not numeric or alphabet...it is NULL

--2nd row is having NULL
select * from ShareDetails.Shares


--IDENTITY COLUMN
--let's insert third row omitting a NOT NULL column
INSERT INTO ShareDetails.Shares
(CurrentPrice)
VALUES
(2.34125)

--Now add including that column too
INSERT INTO ShareDetails.Shares
(ShareDesc
,CurrentPrice)
VALUES
("new row",
2.34125)

--now let's see the data
select * from ShareDetails.Shares

--Notice, ShareId is 1,2,4 ...her 3 is missing becuse while inserting 3rd row we had error

--to solve this
DELETE FROM ShareDetails.Shares where ShareId=4
select * from ShareDetails.Shares
DBCC CHECKIDENT('ShareDetails.Shares',RESEED,2)

--now add
INSERT INTO ShareDetails.Shares
(ShareDesc
,CurrentPrice)
VALUES
("new row",
2.34125)
select * from ShareDetails.Shares

