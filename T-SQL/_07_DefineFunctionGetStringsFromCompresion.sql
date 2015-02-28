USE SoftUni
GO

CREATE FUNCTION dbo.udf_DoestItHeveLetters
	(@String NVARCHAR(100), @pattern NVARCHAR(100))
RETURNS INT
AS BEGIN
        DECLARE @Counter INT = 1;
        WHILE (@Counter <= LEN(@String))
        BEGIN
        IF ( @pattern NOT LIKE '%' + SUBSTRING(@String, @Counter, 1) + '%' ) 
		BEGIN  
			RETURN 0
        END

        SET @Counter = @Counter + 1
    END
        RETURN 1
END
GO

CREATE FUNCTION dbo.ufn_GetTableFromPattern(@pattern NVARCHAR(50))
RETURNS  @rtnTable TABLE( String nvarchar(100))
AS
BEGIN
DECLARE @TempTable TABLE (String NVARCHAR(100))

INSERT INTO @TempTable 
	SELECT e.FirstName
	FROM Employees e
	WHERE e.FirstName IS NOT NULL
	UNION
	SELECT e.MiddleName
	FROM Employees e
	WHERE e.MiddleName IS NOT NULL
	UNION
	SELECT e.LastName
	FROM Employees e
	WHERE e.LastName IS NOT NULL
	UNION
	SELECT t.Name
	FROM Towns t
	WHERE t.Name IS NOT NULL
	
	INSERT INTO @rtnTable
	SELECT t.String 
	FROM @TempTable t
	WHERE dbo.udf_DoestItHeveLetters(t.String , @pattern) = 1
	RETURN
END
GO

SELECT * FROM dbo.ufn_GetTableFromPattern('oistmiahf')
