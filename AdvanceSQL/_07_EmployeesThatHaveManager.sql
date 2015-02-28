SELECT COUNT(e.EmployeeID) AS [Employees that have a nanager]
FROM Employees e
WHERE ManagerID IS NOT NULL
