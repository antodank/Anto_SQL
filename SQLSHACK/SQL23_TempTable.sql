CREATE TABLE dbo.#Cars 
   ( 
   Car_id int NOT NULL, 
   ColorCode varchar(10), 
   ModelName varchar(20), 
   Code int, 
   DateEntered datetime 
   ) 

INSERT INTO dbo.#Cars (Car_id, ColorCode, ModelName, Code, DateEntered) 
VALUES (1,'BlueGreen', 'Austen', 200801, GETDATE()) 

SELECT Car_id, ColorCode, ModelName, Code, DateEntered FROM dbo.#Cars 

DROP TABLE dbo.[#Cars]


