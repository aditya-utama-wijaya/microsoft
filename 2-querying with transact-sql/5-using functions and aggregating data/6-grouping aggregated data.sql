SELECT c.SalesPerson, ISNULL(SUM(oh.SubTotal), 0.00) AS SalesRevenue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
GROUP BY c.SalesPerson
ORDER BY SalesRevenue DESC;

SELECT c.SalesPerson,
		CONCAT(c.FirstName + ' ', c.LastName) AS Customer,
		ISNULL(SUM(oh.SubTotal), 0.00) AS SalesRevenue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
GROUP BY c.SalesPerson, CONCAT(c.FirstName + ' ', c.LastName)
ORDER BY c.SalesPerson;