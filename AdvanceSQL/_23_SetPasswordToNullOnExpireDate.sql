DECLARE @expireDate AS DATETIME
SET @expireDate = Cast('2010/03/10' as DATETIME) 
UPDATE Users
SET UserPassword = NULL
WHERE LastLoginDate <= @expireDate