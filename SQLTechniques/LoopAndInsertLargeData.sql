USE [LargeData]

go

DECLARE @i INT =0

WHILE ( @i < 100000000 )
  BEGIN
      INSERT INTO [dbo].[NAME]
                  ([NAME])
      VALUES      ('test' + Cast( @i AS VARCHAR))

      INSERT INTO [dbo].ADDRESS
                  (NAMEID,
                   ADDRESS)
      VALUES      (@i,
                   'address ' + Cast( @i AS VARCHAR))

      SET @i=@i + 1
  END
--select * from address
--truncate table address

--INSERT INTO [dbo].[NAME]
--                 ([NAME])
--     VALUES      ('test' + Cast( @i AS VARCHAR))
--  Go 100000000