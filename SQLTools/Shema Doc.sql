SELECT
COLUMN_NAME as Name,
DATA_TYPE + case  when  CHARACTER_MAXIMUM_LENGTH is null then '' else '(' + ltrim(str(CHARACTER_MAXIMUM_LENGTH)) + ')' end as Type   ,
COLUMN_DEFAULT [Default],
IS_NULLABLE Nullable 
from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME ='RawTables_Lookup'

