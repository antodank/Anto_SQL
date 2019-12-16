CREATE TABLE tbOrganicFoodsList(
	OrganicFoodId SMALLINT NOT NULL,
	OrganicFood VARCHAR(50) NOT NULL
)
 
ALTER TABLE tbOrganicFoodsList ADD CONSTRAINT PK_OrganicFoodId_List PRIMARY KEY CLUSTERED (OrganicFoodId)
 
INSERT INTO tbOrganicFoodsList
VALUES (1,'Broccoli')
	, (2,'Apple')
	, (3,'Fig')
	, (4,'Potato')
	, (5,'Kale')
	, (6,'Cucumber')
 
CREATE TABLE tbOrganicFoodOrders (
	OrderId INT NOT NULL,
	OrganicFoodId SMALLINT NOT NULL
)
 
ALTER TABLE tbOrganicFoodOrders ADD CONSTRAINT FK_OrganicFoodId_Orders FOREIGN KEY (OrganicFoodId) REFERENCES tbOrganicFoodsList (OrganicFoodId)
 
INSERT INTO tbOrganicFoodOrders
VALUES (1,2)
	, (1,3)
	, (2,1)
	, (2,5)
	, (3,6)
	, (3,1)
	, (4,5)
	, (4,6)
	, (5,3)
    , (5,2)