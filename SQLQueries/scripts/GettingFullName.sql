SELECT e.FirstName + ' ' + e.LastName AS [Employee Full Name]
FROM Employees e
WHERE e.MiddleName IS NULL

UNION

SELECT e.FirstName + ' ' + e.MiddleName + ' ' + e.LastName AS [Employee Full Name]
FROM Employees e
WHERE e.MiddleName IS NOT NULL