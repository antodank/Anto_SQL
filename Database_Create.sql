USE master;
GO
IF DB_ID (N'mytest') IS NOT NULL
DROP DATABASE mytest;
GO
CREATE DATABASE mytest;
GO
-- Verify the database files and sizes
SELECT name, size, size*1.0/128 AS [Size in MBs] 
FROM sys.master_files
WHERE name = N'mytest';
GO


-----
CREATE DATABASE Sales
ON 
( NAME = Sales_dat,
    FILENAME = 'saledat.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Sales_log,
    FILENAME = 'salelog.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB );

GO

--
CREATE DATABASE Archive 
ON
PRIMARY  
    (NAME = Arch1,
    FILENAME =  'archdat1.mdf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
    
    ( NAME = Arch2,
    FILENAME =  'archdat2.ndf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
    
    ( NAME = Arch3,
    FILENAME = 'archdat3.ndf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20)
LOG ON 
   (NAME = Archlog1,
    FILENAME =  'archlog1.ldf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
   (
   NAME = Archlog2,
    FILENAME =  'archlog2.ldf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20);

GO

----
USE master;
GO
IF DB_ID (N'Archive') IS NOT NULL
DROP DATABASE Archive;
GO
-- Get the SQL Server data path
DECLARE @data_path nvarchar(256);
SET @data_path = (SELECT SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
                  FROM master.sys.master_files
                  WHERE database_id = 1 AND file_id = 1);

-- execute the CREATE DATABASE statement 
EXECUTE ('CREATE DATABASE Archive 
ON
PRIMARY  
    (NAME = Arch1,
    FILENAME = '''+ @data_path + 'archdat1.mdf'',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
    ( NAME = Arch2,
    FILENAME = '''+ @data_path + 'archdat2.ndf'',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
    ( NAME = Arch3,
    FILENAME = '''+ @data_path + 'archdat3.ndf'',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20)
LOG ON 
   (NAME = Archlog1,
    FILENAME = '''+ @data_path + 'archlog1.ldf'',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
   (NAME = Archlog2,
    FILENAME = '''+ @data_path + 'archlog2.ldf'',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20)'
);
GO

--------------FileGroup
USE master;
GO
IF DB_ID (N'Sales') IS NOT NULL
DROP DATABASE Sales;
GO
-- Get the SQL Server data path
DECLARE @data_path nvarchar(256);
SET @data_path = (SELECT SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
                  FROM master.sys.master_files
                  WHERE database_id = 1 AND file_id = 1);

-- execute the CREATE DATABASE statement 
EXECUTE ('CREATE DATABASE  Sales
ON PRIMARY
( NAME = SPri1_dat,
    FILENAME = '''+ @data_path + 'SPri1dat.mdf'',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 15% ),
( NAME = SPri2_dat,
    FILENAME = '''+ @data_path + 'SPri2dt.ndf'',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 15% ),
FILEGROUP SalesGroup1
( NAME = SGrp1Fi1_dat,
    FILENAME = '''+ @data_path + 'SG1Fi1dt.ndf'',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 ),
( NAME = SGrp1Fi2_dat,
    FILENAME = '''+ @data_path + 'SG1Fi2dt.ndf'',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 ),
FILEGROUP SalesGroup2
( NAME = SGrp2Fi1_dat,
    FILENAME = '''+ @data_path + 'SG2Fi1dt.ndf'',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 ),
( NAME = SGrp2Fi2_dat,
    FILENAME = '''+ @data_path + 'SG2Fi2dt.ndf'',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Sales_log,
    FILENAME = '''+ @data_path + 'salelog.ldf'',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB )'
);
GO

