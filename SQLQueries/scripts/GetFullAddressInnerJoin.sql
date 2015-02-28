SELECT e.FirstName + ' ' + e.LastName AS [Name], t.Name AS [Town], a.AddressText AS [Address]
FROM Employees e
JOIN Addresses a
	ON e.AddressID = a.AddressID
	JOIN Towns t
		ON a.TownID = t.TownID
ORDER BY e.FirstName

	 
