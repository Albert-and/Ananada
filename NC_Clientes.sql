
SELECT
DocNum,
DocDate,
CardCode,
NumAtCard,
DocTotal,
Comments,
JrnlMemo
FROM ORIN
Where CANCELED = 'N'