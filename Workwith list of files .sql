if object_id('tempdb..#A') is not null--here tempdb reqd
drop table #A

CREATE TABLE #A(NAMES VARCHAR(90))
INSERT INTO #A EXEC xp_cmdshell 'dir c:\*.* /b'--here execute dos
delete from #A where names is null

Declare @file   varchar(100)
Declare @sqlToRun varchar (1000)
WHILE   ( (select count(*) from #A) > 0)
BEGIN
	select @file=(select   top 1 Names from #a)--here () reqd
	delete from #A where Names = (select top 1 Names from #a)
	--select @file,right(left(@file,2),1) as s
	--All requred variables
	set @sqlToRun ='select * from sys.tables'
	exec (@sqlToRun)-- here () reqd
END
 
 

--WHILE   exists( select count(*) from #A )
--BEGIN
--select * from a# where TestID = @intFlag
--PRINT @intFlag
--SET @intFlag = @intFlag + 1
--IF @intFlag = 4
--BREAK;
--END



