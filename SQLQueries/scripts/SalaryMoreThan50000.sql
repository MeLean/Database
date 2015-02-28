SELECT e.FirstName + ' ' + e.LastName AS [Name], e.Salary
FROM Employees e
WHERE e.Salary >= 50000
ORDER BY e.Salary DESC