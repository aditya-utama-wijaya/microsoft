-- window functions
SELECT TOP(100) ProductID, Name, ListPrice,
	RANK() OVER(ORDER BY ListPrice DESC) AS RankByPrice
FROM SalesLT.Product
ORDER BY RankByPrice;

SELECT pc.Name AS Category, p.Name AS ProductName, p.ListPrice,
	RANK() OVER(PARTITION BY pc.Name ORDER BY p.ListPrice DESC) AS RankByPrice
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS pc
ON p.ProductCategoryID = pc.ProductCategoryID
ORDER BY Category, RankByPrice;