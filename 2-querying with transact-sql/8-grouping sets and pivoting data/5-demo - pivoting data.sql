SELECT * FROM (
	SELECT p.ProductID, pc.Name, ISNULL(p.Color, 'Uncolored') AS Color
	FROM SalesLT.ProductCategory AS pc
	JOIN SalesLT.Product AS p
	ON pc.ProductCategoryID = p.ProductCategoryID
) AS ppc
PIVOT(COUNT(ProductID) FOR Color IN ([Red], [Blue], [Black], [Silver], [Yellow], [Grey], [Multi], [Uncolored])) AS pvt
ORDER BY Name;

-- Unpivot
CREATE TABLE #ProductColorPivot
(Name varchar(50), Red int, Blue int, Black int, Silver int, Yellow int, Grey int, Multi int, Uncolored int)

INSERT INTO #ProductColorPivot
SELECT * FROM (
	SELECT p.ProductID, pc.Name, ISNULL(p.Color, 'Uncolored') AS Color
	FROM SalesLT.Product AS p
	JOIN SalesLT.ProductCategory AS pc
	ON p.ProductCategoryID = pc.ProductCategoryID
) AS ppc
PIVOT(COUNT(ProductID) FOR Color IN ([Red], [Blue], [Black], [Silver], [Yellow], [Grey], [Multi], [Uncolored])) AS pvt
ORDER BY Name;

SELECT Name, Color, ProductCount
FROM (
	SELECT Name, [Red], [Blue], [Black], [Silver], [Yellow], [Grey], [Multi], [Uncolored]
	FROM #ProductColorPivot
) AS pcp
UNPIVOT(ProductCount FOR Color IN ([Red], [Blue], [Black], [Silver], [Yellow], [Grey], [Multi], [Uncolored])) AS ProductCounts;

--
SELECT * FROM (
	SELECT CustomerID, TotalDue, MONTH(OrderDate) AS OrderMonth
	FROM SalesLT.SalesOrderHeader
) AS SalesByMonth
PIVOT(SUM(TotalDue) FOR OrderMonth IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) AS pvt
ORDER BY CustomerID;