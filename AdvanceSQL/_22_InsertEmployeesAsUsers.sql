INSERT INTO	Users(UserName, UserPassword, FullName, LastLoginDate, GroupID)
SELECT 
LOWER(LEFT(FirstName, 1) + LastName) + CAST(EmployeeID AS nvarchar(10)),
LOWER(LEFT(FirstName, 1) + LastName) + '123',
FirstName + ' ' + LastName,
NULL,
14
FROM Employees