--column Constraints
--column to ensure that the data to be entered in the column meets specific conditions.

drop table dbo.ConstraintsMaster 

CREATE TABLE dbo.ConstraintsMaster 
(id INT NOT NULL  IDENTITY(1, 1),
 name VARCHAR(24) NOT NULL,
 salary MONEY NOT NULL
 CONSTRAINT salary_cap CHECK (salary < 100000)
);

-- Valid inserts
INSERT INTO dbo.ConstraintsMaster ([name],[salary]) VALUES ('Joe Brown',65000);
INSERT INTO dbo.ConstraintsMaster ([name],[salary]) VALUES ('Mary Smith',75000);

-- This insert violates the constraint.
INSERT INTO dbo.ConstraintsMaster ([name],[salary]) VALUES ('Pat Jones',105000);

-- Disable the constraint and try again.
ALTER TABLE dbo.ConstraintsMaster NOCHECK CONSTRAINT salary_cap;
INSERT INTO dbo.ConstraintsMaster ([name],[salary]) VALUES ('Pat Jones',105000);

-- Re-enable the constraint and try another insert; this will fail.
ALTER TABLE dbo.ConstraintsMaster CHECK CONSTRAINT salary_cap;
INSERT INTO dbo.ConstraintsMaster ([name],[salary]) VALUES ('Eric James',110000) ;

select * from ConstraintsMaster

---default
ALTER TABLE ConstraintsMaster
ADD  [DateAdded] [datetime] NULL 

ALTER TABLE ConstraintsMaster
ADD CONSTRAINT [DF_CShares_DateAdded] DEFAULT (getdate())for DateAdded;

--testing
INSERT INTO dbo.ConstraintsMaster ([name],[salary]) VALUES ('Elvis May',90000) ;

select * from ConstraintsMaster

--Primary key Constraint
ALTER TABLE ConstraintsMaster
ADD CONSTRAINT PK_CID
PRIMARY KEY CLUSTERED
(id)

select * from ConstraintsMaster

-- Identity
--You can't alter the existing columns for identity. need to add one more

SET IDENTITY_INSERT ConstraintsMaster ON
INSERT INTO dbo.ConstraintsMaster ([id],[name],[salary]) VALUES (5,'Richard Guile',90000) ;
SET IDENTITY_INSERT ConstraintsMaster OFF
INSERT INTO dbo.ConstraintsMaster ([id],[name],[salary]) VALUES (6,'Shimon roase',8000) ;

-- DBCC CHECKIDENT is used to reset identity counter. 
DBCC CHECKIDENT ('[ConstraintsMaster]', RESEED, 10);
INSERT INTO dbo.ConstraintsMaster ([name],[salary]) VALUES ('Shimon roase',8000)

select * from ConstraintsMaster

---add Age column
ALTER TABLE ConstraintsMaster
ADD Age int NULL 

---add CONSTRAINT on Age column
ALTER TABLE ConstraintsMaster
WITH NOCHECK
ADD CONSTRAINT CK_Shares_AmtCheck
CHECK ((Age > 18))

--testing
INSERT INTO dbo.ConstraintsMaster ([name],[salary],[Age]) VALUES ('kelly vincet',12000,11)

------check the existence of the constraints
--in GUI

SELECT constraint_name
FROM information_schema.table_constraints
WHERE table_name = 'ConstraintsMaster'


---computed column
ALTER TABLE constraint_name
ADD FullName as FirstName + ' ' + LastName



