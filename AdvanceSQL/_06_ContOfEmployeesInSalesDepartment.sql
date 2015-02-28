SELECT d.Name AS [Department name], COUNT(e.EmployeeID) AS [Employee Count]
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
GROUP BY d.Name