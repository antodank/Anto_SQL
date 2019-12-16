USE TPCentralDB;
BEGIN
SELECT lRetailStoreID, ROW_NUMBER() OVER (ORDER BY lRetailStoreID) as rowNumb into #temp1 from RetailStore where szStoreTypeCode='RetailStore'

DECLARE @storeCount INT = (SELECT COUNT(*) FROM #temp1)
DECLARE @rowNumb INT = 1
DECLARE @StoreID INT
DECLARE @lMediaNmbr INT     

While (@storeCount > 0)
BEGIN
	SET @StoreID = (Select lRetailStoreID from #temp1 where rowNumb = @rowNumb)

	IF NOT EXISTS(SELECT * FROM Parameter
	WHERE lRetailStoreID = @StoreID and szWorkstationGroupID = N'MOBILE_SG' and szObject = N'ModSignOn' and szDllName = N'StPosMod' and szKey = N'SHOWFLOAT')
	BEGIN
		INSERT INTO [dbo].[Parameter]
           ([lRetailStoreID],[szWorkstationGroupID],[szObject],[szDllName],[szKey],[szContents],[lTechLayerAccessID])
     VALUES
			(@StoreID,'MOBILE_SG','ModSignOn','StPosMod','SHOWFLOAT','N',0)
	END
	ELSE
	BEGIN
		UPDATE [dbo].[Parameter]
		SET [lRetailStoreID] = @StoreID
      ,[szWorkstationGroupID] = 'MOBILE_SG'
      ,[szObject] = 'ModSignOn'
      ,[szDllName] = 'StPosMod'
      ,[szKey] = 'SHOWFLOAT'
      ,[szContents] = 'N'
      ,[lTechLayerAccessID] = 0
	WHERE lRetailStoreID = @StoreID and szWorkstationGroupID = N'MOBILE_SG' and szObject = N'ModSignOn' and szDllName = N'StPosMod' and szKey = N'SHOWFLOAT'
	END

	IF NOT EXISTS(SELECT * FROM Parameter
	WHERE lRetailStoreID = @StoreID and szWorkstationGroupID = N'MOBILE_SG' and szObject = N'ModSignOn' and szDllName = N'StPosMod' and szKey = N'ENTERFLOAT')
	BEGIN
		INSERT INTO [dbo].[Parameter]
           ([lRetailStoreID],[szWorkstationGroupID],[szObject],[szDllName],[szKey],[szContents],[lTechLayerAccessID])
     VALUES
			(@StoreID,'MOBILE_SG','ModSignOn','StPosMod','ENTERFLOAT','N',0)
	END
	ELSE
	BEGIN
		UPDATE [dbo].[Parameter]
		SET [lRetailStoreID] = @StoreID
      ,[szWorkstationGroupID] = 'MOBILE_SG'
      ,[szObject] = 'ModSignOn'
      ,[szDllName] = 'StPosMod'
      ,[szKey] = 'ENTERFLOAT'
      ,[szContents] = 'N'
      ,[lTechLayerAccessID] = 0
	WHERE lRetailStoreID = @StoreID and szWorkstationGroupID = N'MOBILE_SG' and szObject = N'ModSignOn' and szDllName = N'StPosMod' and szKey = N'ENTERFLOAT'
	END

	SET @rowNumb = @rowNumb + 1 
	SET @storeCount = @storeCount-1

	END
	
	DROP TABLE #temp1 
END
GO


