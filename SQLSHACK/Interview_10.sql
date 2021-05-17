
CREATE Table tblAuthors
(
   AuthorId int IDENTITY(1,1) NOT NULL primary key,
   AuthorName nvarchar(50)
)

CREATE Table tblBooks
(
   BookId int IDENTITY(1,1) NOT NULL primary key,
   AuthorId int foreign key references tblAuthors(AuthorId),
   BookName nvarchar(50),
   ISBN_NO nvarchar(50),
   Price   decimal(18,0)
)

-- random number using NEWID()
select   ABS(convert(int, convert (varbinary(4), NEWID(), 1)))

--price
select ROUND(rand() * 1000,2,1)


------------------- bulk entries in table 
Declare @Id int
Set @Id = 1

While @Id <= 100000
Begin 
   Insert Into tblAuthors  values ('Author - ' + CAST(@Id as nvarchar(10)))
   Insert Into tblBooks (AuthorId,BookName,ISBN_NO,Price) values 
   (@Id,'Book - ' + CAST(@Id as nvarchar(10)),ABS(convert(int, convert (varbinary(4), NEWID(), 1))),ROUND(rand() * 1000,2,1))
   Set @Id = @Id + 1
End

Set Statistics IO ON
Set Statistics Time On
Select * from dbo.tblBooks where Price <> 100 and Price <> 500
Set Statistics IO OFF
Set Statistics Time OFF


------------------------ Creating bulk entries using CTE
--CREATE Table tblUsers
--(
--   DataValue int primary key,
--   RandValue int
--)

DECLARE @TemptblUsers TABLE (DataValue int, RandValue INT)

;WITH mycte AS
(
SELECT 1 DataValue
UNION all
SELECT DataValue + 1
FROM    mycte   
WHERE   DataValue + 1 <= 10000
)
INSERT INTO @TemptblUsers(DataValue,RandValue)
SELECT 
        DataValue,
        convert(int, convert (varbinary(4), NEWID(), 1)) AS RandValue
FROM mycte m 
OPTION (MAXRECURSION 0)

DROP table IF EXISTS tblUsers
SELECT * INTO tblUsers FROM @TemptblUsers

SELECT count(*) from tblUsers


-- Copy schema only
DROP table IF EXISTS DEMO_Duplicate1
SELECT * INTO DEMO_Duplicate1 FROM tblUsers WHERE 1 <> 0;

-- Copy schema and Data
DROP table IF EXISTS DEMO_Duplicate2
SELECT * INTO DEMO_Duplicate2 FROM tblUsers WHERE 1 <> 2;

-- INSERT INTO
INSERT INTO DEMO_Duplicate3 select * from tblUsers  

--overriding the default behavior of IDENTITY column
SET IDENTITY_INSERT Demo ON;