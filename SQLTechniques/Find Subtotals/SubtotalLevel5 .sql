with pureQuery (City,StateProvinceID,PostalCode,AddressLine1,rgg)
AS(
SELECT  
[City],StateProvinceID,PostalCode,AddressLine1,
SUM ( [AdventureWorks].[Person].[Address].[AddressID] ) AS [rgg] 
FROM [AdventureWorks].[Person].[Address] 
GROUP BY City ,StateProvinceID,PostalCode,AddressLine1
) , rcntQuery  (rcnt,City,StateProvinceID,PostalCode,AddressLine1,rgg)
AS
(
Select ROW_NUMBER() over (order by City) as rcnt ,* from pureQuery
)
SELECT  
max(rcnt) as Sno,
GROUPING(City) gc ,GROUPING(StateProvinceID) gs,GROUPING(PostalCode) gp,  GROUPING(AddressLine1) ga,
GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) as [Grouping] ,
case WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 0 THEN [City]
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 1 THEN ''
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 3 THEN ''
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 7 THEN City + ' Total' End as City,

case WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 0 THEN  cast( StateProvinceID as varchar)
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 1 THEN ''  
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 3 THEN cast( StateProvinceID as varchar)+ ' Total'  
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 7 THEN '' End as StateProvinceID,

case WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 0 THEN  cast( PostalCode as varchar)
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 1 THEN cast( PostalCode as varchar)+ ' Total'  
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 3 THEN ''  
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 7 THEN '' End as PostalCode,
 
case WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 0 THEN  cast( AddressLine1 as varchar)
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 1 THEN ''
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 3 THEN ''  
WHEN GROUPING_ID([City],StateProvinceID,PostalCode,AddressLine1) = 7 THEN '' End as AddressLine1,

SUM (rgg ) AS Totals 
FROM rcntQuery
GROUP BY City ,StateProvinceID
,PostalCode,AddressLine1
with rollup 