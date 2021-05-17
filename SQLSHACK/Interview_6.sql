DECLARE @name1 VARCHAR(10)
DECLARE @inum1 int

BEGIN TRY  
     --code to try 
	 -- set @inum1= 10 / 0;

	 set @inum1 = 'ABCDEFGHIJKLMNOP'

	 set @name1 = 'ABCDEFGHIJKLMNOP'
	 print @name1
END TRY  
BEGIN CATCH  
     --code to run if an error occurs
	 --is generated in try
	 SELECT ERROR_NUMBER() AS ErrorNumber,
	 ERROR_MESSAGE() AS ErrorMessage;
END CATCH