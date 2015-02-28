SELECT e.FirstName + ' ' + e.LastName AS [Name], t.Name AS [Town], a.AddressText AS [Address]
FROM Employees e, Addresses a, Towns t
WHERE e.AddressID = a.AddressID AND a.TownID = t.TownID
ORDER BY e.FirstName
