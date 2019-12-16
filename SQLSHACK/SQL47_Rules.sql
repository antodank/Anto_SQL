
--  Rules are constraints bound to columns from tables or to user defined data types
-- Used when you want to apply some restriction on customized data type 
-- A rule can be created only in the current database. 
-- After you create a rule, execute sp_bindrule to bind the rule to a column or to alias data type. 
-- A rule must be compatible with the column data type.
create type Zip FROM int

Create table EmpAddress
(
city varchar(20),
zipcode zip,
)

Create rule zip_rule as @zipcode > 400001 and @zipcode < 400999

-- we can use AND OR > < == like in between

sp_bindrule zip_rule, 'Zip'

Insert into EmpAddress values ('Ankit',400002)
Insert into EmpAddress values ('Ankit',401001)

--eg
CREATE RULE rule_PhNo
AS
(@phone='UnknownNumber') 
OR (LEN(@phone)=14 
AND SUBSTRING(@phone,1,1)= '+'
AND SUBSTRING(@phone,4,1)= '-')


-- This feature is in maintenance mode and may be removed in a future version of Microsoft SQL Server. Avoid using this feature in new development work, and plan to modify applications that currently use this feature.