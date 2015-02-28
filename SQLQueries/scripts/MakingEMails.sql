SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], 
REPLACE(e.FirstName, ' ', '') + '.' +  REPLACE(e.LastName, ' ', '')
 + '@softuni.bg' AS [Full Email Address]
FROM Employees e
ORDER BY e.FirstName