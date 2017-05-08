SELECT CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader
ORDER BY CustomerID, OrderDate;

SELECT CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader
WHERE OrderDate = (
	SELECT MAX(OrderDate)
	FROM SalesLT.SalesOrderHeader
	)
ORDER BY CustomerID, OrderDate;

SELECT CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader AS soh1
WHERE OrderDate = (
	SELECT MAX(OrderDate)
	FROM SalesLT.SalesOrderHeader AS soh2
	WHERE soh2.CustomerID = soh1.CustomerID
)
ORDER BY CustomerID;