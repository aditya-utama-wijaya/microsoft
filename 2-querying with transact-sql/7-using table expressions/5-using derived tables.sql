SELECT Category, COUNT(ProductID) AS Products
FROM (
	SELECT p.ProductID, p.Name AS ProductName, pc.Name AS Category
	FROM SalesLT.Product AS p
	JOIN SalesLT.ProductCategory AS pc
	ON p.ProductCategoryID = pc.ProductCategoryID
) AS ProdCats
GROUP BY Category
ORDER BY Category;


SELECT pc.Name AS Category, prd_counts.ProductCount
FROM SalesLT.ProductCategory AS pc
JOIN (
	SELECT p.ProductCategoryID, COUNT(p.ProductID) AS ProductCount
	FROM SalesLT.Product AS p
	GROUP BY p.ProductCategoryID
) AS prd_counts
ON pc.ProductCategoryID = prd_counts.ProductCategoryID
ORDER BY Category;