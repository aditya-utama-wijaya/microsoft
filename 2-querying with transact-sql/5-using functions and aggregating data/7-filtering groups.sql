SELECT od.ProductID, SUM(od.OrderQty) AS Quantity
FROM SalesLT.SalesOrderDetail AS od
JOIN SalesLT.SalesOrderHeader AS oh
ON od.SalesOrderID = oh.SalesOrderID
WHERE YEAR(oh.OrderDate) = 2008
GROUP BY od.ProductID
HAVING SUM(od.OrderQty) > 50
ORDER BY Quantity DESC;