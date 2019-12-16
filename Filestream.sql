/*============================================================================
  Summary:  This script redefines a table which currently uses the 
  VARBINARY(MAX) data type to store photos to use a 
  VARBINARY(MAX) FILESTREAM data type. The actual pictures are then stored
  on the file system.
  
  Note: Create the following directory before running this script: 
        C:\SQLTrainingKitFiles

        * This is not necessary if you are running this script from the 
        Setup.cmd script since it will create the folder for you.
============================================================================*/


-- this is to enable at an engine level
-- NOTE: Filestream must also be configured at an OS level using 
-- SQL Server Configuration Manager (see BOL for details)

--Levels
	--0- disable, 1- Enable, 2- Enables FILESTREAM for Transact-SQL and Win32 streaming access.
	
	
	USE master;
GO
EXEC sp_configure 'show advanced option', '1';

RECONFIGURE;
--to check the exisitng filestream access level 
EXEC sp_configure;
select * from sys.configurations 

EXEC sp_configure 'filestream access level', '2'
RECONFIGURE
GO


use AdventureWorks
go

ALTER DATABASE AdventureWorks2008
 ADD FILEGROUP SQLTrainingKitFiles CONTAINS FILESTREAM
GO

ALTER DATABASE AdventureWorks2008
    ADD FILE
      (
       NAME = Photos,
       FILENAME = 'D:\Photos'
      )
   TO FILEGROUP SQLTrainingKitFiles
GO

CREATE TABLE [Production].[ProductPhotoWithFilestream](
	[ProductPhotoID] [int] IDENTITY(1,1) NOT NULL,
	[LargePhoto] varbinary(max) FILESTREAM NULL,
	[RowGuid] UNIQUEIDENTIFIER NOT NULL  ROWGUIDCOL UNIQUE DEFAULT NEWID(),
CONSTRAINT [PK_ProductPhotoWithFilestream_ProductPhotoID] PRIMARY KEY CLUSTERED 
(
	[ProductPhotoID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
FILESTREAM_ON SQLTrainingKitFiles

GO

SET IDENTITY_INSERT [Production].[ProductPhotoWithFilestream] ON
GO

INSERT INTO [Production].[ProductPhotoWithFilestream] (ProductPhotoID, LargePhoto)
SELECT ProductPhotoID, LargePhoto
FROM [Production].[ProductPhoto]
GO



-----------------------------------------------------------------------------------------
SET QUOTED_IDENTIFIER ON

-- now add an attribute of the file as a persisted computed column
--stores the computed values in the table if they are PERSISTED
ALTER TABLE [Production].[ProductPhotoWithFilestream]
 ADD Photo_Width AS CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING(LargePhoto, 7, 2)))) PERSISTED 
GO

ALTER TABLE [Production].[ProductPhotoWithFilestream]
 ADD Photo_Height AS CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING(LargePhoto, 9, 2)))) PERSISTED 
GO

-- No index allowed on the persisted computed column, though, this fails
-- CREATE INDEX IX_PhotoWidth ON [Production].[ProductPhotoWithFilestream](Photo_Width)

SELECT LargePhoto.PathName(), * FROM [Production].[ProductPhotoWithFilestream]