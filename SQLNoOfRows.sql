/****** Script for SelectTopNRows command from SSMS  ******/

sp_helpindex 'NameList'

SELECT [ID]
      ,[firstName]
      ,[lastName]
  FROM [dbSample].[dbo].[NameList] where [firstName] = 'cole'

  create nonclustered index ncllname on [dbo].[NameList]([lastName])

  SELECT [ID]
      ,[firstName]
      ,[lastName]
  FROM [dbSample].[dbo].[NameList] where [firstName] = 'cole'