SELECT e.FirstName + ' ' + e.LastName AS [Employee], a.AddressText, m.FirstName + ' ' + m.LastName AS [Manager]
FROM Employees e, Employees m, Addresses a
WHERE e.ManagerID = m.EmployeeID AND e.AddressID = a.AddressID
ORDER BY e.FirstName