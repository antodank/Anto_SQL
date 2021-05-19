
IF EXISTS (SELECT 1 FROM SYS.TABLES where name ='SampleFruits')
BEGIN 
DROP TABLE SampleFruits
END

CREATE TABLE SampleFruits ( 
Id INT PRIMARY KEY IDENTITY(1,1) , 
FruitName VARCHAR(50) , 
Price INT
)
GO
INSERT INTO SampleFruits VALUES('Apple',20)
INSERT INTO SampleFruits VALUES('Apricot',12)
INSERT INTO SampleFruits VALUES('Banana',8)
INSERT INTO SampleFruits VALUES('Cherry',11)
INSERT INTO SampleFruits VALUES('Strawberry',26)
INSERT INTO SampleFruits VALUES('Lemon',4)  
INSERT INTO SampleFruits VALUES('Kiwi',14)  
INSERT INTO SampleFruits VALUES('Coconut',34) 
INSERT INTO SampleFruits VALUES('Orange',24)  
INSERT INTO SampleFruits VALUES('Raspberry',13)
INSERT INTO SampleFruits VALUES('Mango',9)
INSERT INTO SampleFruits VALUES('Mandarin',19)
INSERT INTO SampleFruits VALUES('Pineapple',22)
GO


IF EXISTS (SELECT 1 FROM SYS.TABLES where name ='Locations_stage')
BEGIN 
DROP TABLE Locations_stage
END

CREATE TABLE [dbo].[Locations_stage](
  [LocationID] [int] NULL,
  [LocationName] [varchar](100) NULL
) 
GO
 
IF EXISTS (SELECT 1 FROM SYS.TABLES where name ='Locations')
BEGIN 
DROP TABLE Locations
END
 
 
CREATE TABLE [dbo].[Locations](
  [LocationID] [int] NULL,
  [LocationName] [varchar](100) NULL
) 
GO
 
 
 
