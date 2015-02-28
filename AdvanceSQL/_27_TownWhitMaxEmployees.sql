-- if only one results is posible
SELECT TOP 1 tw.Name AS [Town Name], COUNT(em.EmployeeID) AS [Employe Count]
FROM Employees em
 JOIN Addresses ad
  ON em.AddressID = ad.AddressID
  JOIN Towns tw
   ON ad.TownID = tw.TownID  
GROUP BY tw.TownID, tw.Name
ORDER BY COUNT(em.EmployeeID) DESC

-- if one or more than one results are posible
DECLARE @maxEmployees AS INT
SET @maxEmployees = 
(SELECT MAX(EmployeCount)
FROM (SELECT COUNT(em.EmployeeID) AS EmployeCount
FROM Employees em
 JOIN Addresses ad
  ON em.AddressID = ad.AddressID
  JOIN Towns tw
   ON ad.TownID = tw.TownID  
GROUP BY tw.TownID) s)

SELECT t.Name AS [Town Name], COUNT(e.EmployeeID) AS [Employe Count]
FROM Employees e
JOIN Addresses a
	ON e.AddressID = a.AddressID
	JOIN Towns t
		ON a.TownID = t.TownID
GROUP BY t.Name
HAVING  COUNT(e.EmployeeID) = @maxEmployees