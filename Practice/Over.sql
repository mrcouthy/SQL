--Divide the rows into three divisions
use Practice
select * from Student 
SELECT	name, 
		NTILE(3) OVER (ORDER BY advisorid) AS PercentileHundred
		FROM	Student
