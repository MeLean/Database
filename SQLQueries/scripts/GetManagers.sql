SELECT e.FirstName + ' ' + e.LastName AS [Employee], m.FirstName + ' ' + m.LastName AS [Manager]
FROM Employees e, Employees m
WHERE e.ManagerID = m.EmployeeID 
ORDER BY e.FirstName