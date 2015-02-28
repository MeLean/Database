SELECT e.FirstName + ' ' + e.LastName AS [Name], e.Salary AS [Salary in range 20000 - 30000]
FROM Employees e
WHERE e.Salary BETWEEN 20000 AND 30000
ORDER BY e.Salary DESC