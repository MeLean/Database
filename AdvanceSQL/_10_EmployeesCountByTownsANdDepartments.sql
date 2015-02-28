SELECT t.Name AS [Town Name], d.Name AS [Department Name], COUNT(e.EmployeeID) AS [Employees Count]
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
		JOIN Addresses a
			ON e.AddressID = a.AddressID
				JOIN Towns t
					ON a.TownID = t.TownID
GROUP BY t.Name, d.Name
ORDER BY d.Name
