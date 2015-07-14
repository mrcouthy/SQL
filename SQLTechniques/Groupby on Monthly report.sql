--Group by year and month over a date field
--How to order by in number and varchar mixed mode?
WITH a AS(
SELECT  isnull(convert(VARCHAR,Year([TxDate])),'GRAND TOTAL') AS YEAR,
         CASE
           WHEN YEAR([TxDate]) IS NOT NULL
           THEN isnull(convert(VARCHAR,Month([TxDate])),'YEARLY TOTAL')
           ELSE ''
         END AS MONTH,
       SUM(dr) as dr,
       SUM(cr) as cr
FROM     [Practice].[dbo].[b]
GROUP BY Year([TxDate]),
         Month([TxDate]) WITH ROLLUP
		 )
SELECT * FROM a
ORDER BY YEAR,--number +text mixed order by
        CASE IsNumeric(Month) 
        WHEN 1 THEN Replicate('0', 100 - Len(Month)) + Month
        ELSE Month
		END
