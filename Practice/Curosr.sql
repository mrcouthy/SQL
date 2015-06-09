use Practice
declare @name varchar(40)
declare fixer cursor 
for
select Name from Student 

open fixer
fetch next  from fixer into @name
WHILE @@FETCH_STATUS <> -1
BEGIN
print @name
fetch next  from fixer into @name
end
close fixer
deallocate fixer

 