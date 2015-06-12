 use AdventureWorks
if OBJECT_ID('tempdb..#TableSizes') is not null
drop table #TableSizes
CREATE TABLE  #TableSizes
        (
			TableName VARCHAR(200)
			,RowCnt VARCHAR(50)
			,Reserved VARCHAR(50)
			,Data VARCHAR(50)
			,IndexSize VARCHAR(50)
			,Unused VARCHAR(50)
	)

DECLARE @TableName VARCHAR(100)
DECLARE TableCursor CURSOR FOR
			
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
AND TABLE_SCHEMA = 'dbo'
--AND (TABLE_NAME LIKE '%XYZ%20150505%')

OPEN TableCursor
FETCH NEXT FROM TableCursor INTO @TableName
WHILE @@FETCH_STATUS != -1
BEGIN
            INSERT INTO #TableSizes EXEC sp_spaceused @TableName
            FETCH NEXT FROM TableCursor INTO @TableName
END

CLOSE TableCursor
DEALLOCATE TableCursor
SELECT 
	TableName
  	, RowCnt
	, CAST(REPLACE(Reserved, 'KB', ' ') AS NUMERIC) 'Reserved(KB)'
	, CAST(REPLACE(Data, 'KB', ' ') AS NUMERIC) 'Data(KB)'
	, CAST(REPLACE(IndexSize, 'KB', ' ') AS NUMERIC) 'IndexSize(KB)'
	, CAST(REPLACE(UnUsed, 'KB', ' ') AS NUMERIC) 'UnUsed(KB)'
FROM #TableSizes
WHERE TableName <> 'TableSizes'
ORDER BY TableName

DROP TABLE #TableSizes
GO
 
 
  