

SELECT 
    d.ItemCode AS product_id, 
    c.CardCode AS customer_tpartner_id, 
    d.Quantity AS final_quantity_requested, 
    FORMAT(c.DocDueDate, 'yy-MM-dd') AS requested_delivery_date, 
    FORMAT(c.DocDate, 'yy-MM-dd') AS order_date, 
    FORMAT(c.DocDueDate,'yy-MM-dd') AS actual_delivery_date, 
    FORMAT(c.DocDueDate, 'yy-MM-dd') AS promised_delivery_date, 
    c.DocStatus AS status, 
    c.DocNum AS id, 
    c.DocNum AS cust_order_id 
FROM  
    ANANDA_MAYOREO.dbo.OINV c  
INNER JOIN INV1 d ON d.DocEntry = c.DocEntry
INNER JOIN OITM p ON p.ItemCode = d.Itemcode
WHERE d.ItemCode IN 
(SELECT T1.ItemCode
FROM ANANDA_BD.dbo.OITM AS T1
WHERE T1.ItmsGrpCod IN (104, 105)
  and T1.ItemCode NOT LIKE 'E%' and T1.ItemCode NOT LIKE 'G%' and T1.ItemCode NOT LIKE 'T%')



SELECT T1.ItemCode
FROM ANANDA_BD.dbo.OITM AS T1
WHERE T1.ItmsGrpCod IN (104, 105)
  and T1.ItemCode NOT LIKE 'E%' and T1.ItemCode NOT LIKE 'G%' and T1.ItemCode NOT LIKE 'T%'




SELECT T1.ItemCode
INTO #FilteredItems
FROM ANANDA_BD.dbo.OITM AS T1
WHERE T1.ItmsGrpCod IN (104, 105)
  AND T1.ItemCode NOT LIKE 'E%' 
  AND T1.ItemCode NOT LIKE 'G%' 
  AND T1.ItemCode NOT LIKE 'T%';

SELECT 
    d.ItemCode AS product_id, 
    c.CardCode AS customer_tpartner_id, 
    d.Quantity AS final_quantity_requested, 
    FORMAT(c.DocDueDate, 'yy-MM-dd') AS requested_delivery_date, 
    FORMAT(c.DocDate, 'yy-MM-dd') AS order_date, 
    FORMAT(c.DocDueDate, 'yy-MM-dd') AS actual_delivery_date, 
    FORMAT(c.DocDueDate, 'yy-MM-dd') AS promised_delivery_date, 
    c.DocStatus AS status, 
    c.DocNum AS id, 
    c.DocNum AS cust_order_id 
FROM  
    ANANDA_MAYOREO.dbo.OINV c  
INNER JOIN ANANDA_MAYOREO.dbo.INV1 d ON d.DocEntry = c.DocEntry
INNER JOIN ANANDA_MAYOREO.dbo.OITM p ON p.ItemCode = d.ItemCode
WHERE d.ItemCode IN (SELECT ItemCode FROM #FilteredItems);