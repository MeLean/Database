SELECT COUNT(e.EmployeeID) AS [Employees that have no nanager]
FROM Employees e
WHERE ManagerID IS NULL
