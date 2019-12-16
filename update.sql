use Test
select * from ShareDetails.Shares;

update ShareDetails.Shares set ShareDesc='Modified Description'
where ShareId=4



DECLARE @Desc VARCHAR(20)
SET @Desc = '2.0'
update ShareDetails.Shares set ShareDesc=@Desc
where ShareId=3

