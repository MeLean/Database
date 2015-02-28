SELECT e.FirstName + ' ' + e.LastName AS [Name], e.ManagerID, e.Salary
FROM Employees e
WHERE e.ManagerID IS NULL
ORDER BY e.Salary DESC