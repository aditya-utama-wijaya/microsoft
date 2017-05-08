SELECT MAX(UnitPrice)
FROM SalesLT.SalesOrderDetail;

SELECT *
FROM SalesLT.Product
WHERE ListPrice > 1466.01;

SELECT *
FROM SalesLT.Product
WHERE ListPrice > (
	SELECT MAX(UnitPrice)
	FROM SalesLT.SalesOrderDetail
	);


SELECT c.CustomerID, c.CompanyName,(
	SELECT COUNT(*)
	FROM SalesLT.SalesOrderHeader AS oh
	WHERE oh.CustomerID = c.CustomerID
	) AS OrderCount
FROM SalesLT.Customer AS c
ORDER BY OrderCount DESC;