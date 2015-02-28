SELECT TOP 5 e.Salary, e.FirstName + ' ' + e.LastName AS [Name]
FROM Employees e
ORDER BY e.Salary DESC