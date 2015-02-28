SELECT mID.TownName AS [Town Name], COUNT(mID.managerId) AS [Managers Count]
FROM (SELECT DISTINCT e.EmployeeID AS managerId, t.Name AS TownName
	  FROM Employees e
		JOIN Employees m
			ON e.EmployeeID = m.ManagerID
			JOIN Addresses a
				ON a.AddressID = e.AddressID
				JOIN Towns t
					ON t.TownID = a.TownID) AS mID
GROUP BY mID.TownName
ORDER BY [Managers Count] DESC