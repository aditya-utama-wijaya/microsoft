-- Catch an error
BEGIN TRY
	UPDATE SalesLT.Product
	SET ProductNumber = ProductID / ISNULL(Weight, 0);
END TRY
BEGIN CATCH
	PRINT 'The following error occurred: ';
	PRINT ERROR_MESSAGE();
END CATCH

-- Catch and re-throw
BEGIN TRY
	UPDATE SalesLT.Product
	SET ProductNumber = ProductID / ISNULL(Weight, 0);
END TRY
BEGIN CATCH
	PRINT 'The following error occurred: ';
	PRINT ERROR_MESSAGE();
	THROW;
END CATCH

-- Catch, log, and throw a custom error
BEGIN TRY
	UPDATE SalesLT.Product
	SET ProductNumber = ProductID / ISNULL(Weight, 0);
END TRY
BEGIN CATCH
	DECLARE @ErrorLogID AS int, @ErrorMsg AS varchar(250);
	EXEC dbo.uspLogError @ErrorLogID OUTPUT;
	SET @ErrorMsg = 'The update failed because of an error. View error #' + CONVERT(varchar, @ErrorLogID) + ' in the error log for details.';
	THROW 50001, @ErrorMsg, 0;
END CATCH

SELECT * FROM dbo.ErrorLog;