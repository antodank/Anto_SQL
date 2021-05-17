 select iif(1=1,'a','b')

 select choose(3,'hello','friend','ghost')

 declare @var1 varchar(10),@var2 varchar(10)
 set @var1='Best'
 set @var2=null
 select @var1 + ' ' + @var2
 select concat(@var1,' ',@var2)


Select Substr('TANAY',Level,1) From Dual
Connect By Level<= Length('TANAY');