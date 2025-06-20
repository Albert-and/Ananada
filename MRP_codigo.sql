

SELECT
ItemCode,
MinLevel,
MaxLevel,
PlaningSys,
PrcrmntMtd,
ToleranDay,
OrdrIntrvl,
MinOrdrQty,
LeadTime
FROM OITM
Where Series = 3 AND SellItem = 'Y' AND PrchseItem = 'Y'




SELECT
ItemCode,
MinLevel,
MaxLevel,
PlaningSys,
PrcrmntMtd,
ToleranDay,
OrdrIntrvl,
MinOrdrQty,
LeadTime,
Series,
SellItem,
PrchseItem
FROM OITM
Where ItemCode = '50005'






SELECT *
FROM FCT1