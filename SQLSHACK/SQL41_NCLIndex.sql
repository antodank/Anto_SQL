/****** 

Indexes that are created as the result of creating PRIMARY KEY or UNIQUE constraints cannot be dropped by using DROP INDEX. 
They are dropped using the ALTER TABLE DROP CONSTRAINT statement

  ******/

sp_helpindex 'NameList'

SELECT [ID]
      ,[firstName]
      ,[lastName]
  FROM [dbSample].[dbo].[NameList] where [firstName] = 'cole'

  create nonclustered index ncllname on [dbo].[NameList]([lastName])

  DROP INDEX ncllname   
    ON [dbo].[NameList]

  SELECT [ID]
      ,[firstName]
      ,[lastName]
  FROM [dbSample].[dbo].[NameList] where [firstName] = 'cole'

/* ONLINE = ON | OFF 
ON - This allows queries or updates to the underlying table to continue.
OFF - Table locks are applied and the table is unavailable
*/
ALTER TABLE Production.TransactionHistoryArchive  
DROP CONSTRAINT PK_TransactionHistoryArchive_TransactionID  
WITH (ONLINE = ON);  