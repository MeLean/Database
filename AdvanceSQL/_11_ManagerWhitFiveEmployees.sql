SELECT m.FirstName + ' ' + m.LastName AS [Manager Name], COUNT(e.EmployeeID) AS [Managing Employees Count]
FROM Employees e, Employees m
WHERE m.EmployeeID = e.ManagerID
GROUP BY  m.FirstName, m.LastName
HAVING COUNT(e.EmployeeID) = 5