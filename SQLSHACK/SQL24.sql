DECLARE @Cars TABLE 
   ( 
   Car_id int NOT NULL, 
   ColorCode varchar(10), 
   ModelName varchar(20), 
   Code int , 
   DateEntered datetime 
   ) 

INSERT INTO @Cars (Car_id, ColorCode, ModelName, Code, DateEntered) 
VALUES (1,'BlueGreen', 'Austen', 200801, GETDATE()) 
--GO
SELECT Car_id, ColorCode, ModelName, Code, DateEntered FROM @Cars