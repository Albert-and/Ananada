


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
 
    OINV c  
INNER JOIN INV1 d ON d.DocEntry = c.DocEntry
INNER JOIN OITM p ON p.ItemCode = d.Itemcode
WHERE  
 
    c.CANCELED <> 'Y'  AND p.ItmsGrpCod in (104,105) and p.ItemCode NOT LIKE 'E%' and p.ItemCode NOT LIKE 'G%' and p.ItemCode NOT LIKE 'T%'
	AND c.DocDate >= '2022-07-01'