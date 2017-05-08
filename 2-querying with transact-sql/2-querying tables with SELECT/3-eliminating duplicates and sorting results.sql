-- Display a list of product colors
SELECT DISTINCT ISNULL(Color, 'None')
FROM SalesLT.Product;

-- Display a list of product colors sorted by color
SELECT DISTINCT ISNULL(Color, 'None') AS Color
FROM SalesLT.Product
ORDER BY Color;

-- Display a list of product colors and sizes sorted by color
SELECT DISTINCT ISNULL(Color, 'None') AS Color,
				ISNULL(Size, '-') AS Size
FROM SalesLT.Product
ORDER BY Color;

-- Display the top 100 products by list price
SELECT TOP 100 Name, ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;

-- Display the first 10 products by product number
SELECT Name, ListPrice
FROM SalesLT.Product
ORDER BY ProductNumber
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;

-- Display the next 10 products by product number
SELECT Name, ListPrice
FROM SalesLT.Product
ORDER BY ProductNumber
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;