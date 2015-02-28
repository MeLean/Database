use ads
GO
--2 Between
Select Title, [Date] 
From Ads
Where [Date] BETWEEN CONVERT(DATETIME, '2014-12-26 00:00:00') AND CONVERT(DATETIME,'2015-01-01 23:59:59')
ORDER BY [Date]

--3 CASE (Switch)
Select Title, [Date], 
CASE
	WHEN ImageDataURL IS NOT NULL THEN 'no'
	WHEN ImageDataURL IS NULL THEN 'yes'
END
 AS [Has Image]
From Ads
ORDER BY Id

--4 OR
select *
From Ads
where TownId IS NULL OR CategoryId IS NULL OR ImageDataURL IS NULL
order by Id

--5 Left Join 
select a.Title, t.Name as [Town]
from Ads a
	LEFT join Towns t
		on a.TownId = t.Id
order by a.Id

--6 multiple joins 
select a.Title, c.Name as [CategoryName], t.Name as [TownName], st.Status as [Status]
from Ads a
	left join Towns t
		on a.TownId = t.Id
		left join Categories c
			on a.CategoryId = c.Id
			join AdStatuses st
				on a.StatusId =st.Id
order by a.Id

--6 multiple joins whit multiple filters
select a.Title, c.Name as [CategoryName], t.Name as [TownName], st.Status as [Status]
from Ads a
	left join Towns t
		on a.TownId = t.Id
		left join Categories c
			on a.CategoryId = c.Id
			join AdStatuses st
				on a.StatusId =st.Id
Where t.name in ('Sofia', 'Blagoevgrad','Stara Zagora')
AND st.Status = 'Published'
order by a.Title

--8 min max functions
Select MIN([Date]) AS [MinDate], MAX([Date]) AS [MaxDate]
From Ads

--9 use top
Select top 10 a.Title, a.Date, s.Status
From Ads a
	join AdStatuses s
		on a.StatusId = s.Id
order by a.Date desc 

-- 10 nested selects

Select  a.Id, a.Title, a.Date, s.Status
From Ads a
	Join AdStatuses s
	on a.StatusId = s.Id
Where s.Status <> 'Published' AND
YEAR(a.Date) = (SELECT YEAR(Min(Date)) from Ads) AND 
Month(a.Date) = (SELECT MONTH(Min(Date)) from Ads)

-- 11 Agregate function Count
Select s.Status, COUNT(s.Status) AS [Count]
From Ads a
	join AdStatuses s
		on a.StatusId = s.Id
GROUP BY s.Status
order by s.Status

-- 12 Nested order By
Select t.Name AS [Town Name], s.Status, COUNT(s.Status) AS [Count]
From Ads a
	join AdStatuses s
		on a.StatusId = s.Id
		join Towns t
			on a.TownId = t.Id
GROUP BY t.Name, s.Status
ORDER BY t.Name, s.Status

-- 13 Complecs join many to many and case else
Select u.UserName, COUNT(a.Id) AS [AdsCount], 
CASE
	WHEN r.Name = 'Administrator' THEN 'yes'
	ELSE  'no'
END
AS [isAdministrator]
FROM AspNetUsers u

	left join Ads a
		on u.Id = a.OwnerId
		left join AspNetUserRoles ur
		on u.Id = ur.UserId
			left join AspNetRoles r
				on ur.RoleId = r.Id		
GROUP BY u.UserName,
CASE
	WHEN r.Name = 'Administrator' THEN 'yes'
	ELSE  'no'
END
ORDER BY u.UserName

-- 14 change if it is null
Select Count(a.Id) as AdsCount, isnull(t.Name, '(no town)') as Town
From Ads a
	left join Towns t
		on t.Id = a.TownId
Group by t.Name
Having Count(a.Id) IN (2, 3)
Order BY t.Name

--15 adddate dates
Select Afirst.Date As FirstDate, Aseacond.Date As SecondDate
From Ads Afirst, Ads Aseacond
WHERE (Afirst.Date < Aseacond.Date AND Aseacond.Date <  DATEADD(HOUR, 12, Afirst.Date))
ORDER BY Afirst.Date, Aseacond.Date

--16 Update 

UPDATE Towns
SET Name = 'Paris'
WHERE datename(WEEKDAY, Ads.Date) = 'Friday'

-- delete
DELETE FROM Ads
FROM Ads a
  JOIN AspNetUsers u ON a.OwnerId = u.Id
  JOIN AspNetUserRoles ur ON u.Id = ur.UserId
  JOIN AspNetRoles r ON r.Id = ur.RoleId
  WHERE r.Name = 'Partner'

  
-- INSERT Title="Free Book", Text="Free C# Book", Date={current date and time}, Owner="nakov", Status="Waiting Approval".
Insert INTO Ads(Title, Text, Date, OwnerID, StatusID)
VALUES 
(
	'Free Book', 
	'Free C# Book', 
	GETDATE(), 
	(SELECT Id From AspNetUsers where Name = 'nakov'),
	(SELECT Id From AdStatuses where Status = 'Waiting Approval')
)

-- FULL AUTER JOIN -- Prints all null values and combinnations
SELECT
  t.Name as Town,
  c.Name as Country,
  COUNT(a.Id) as AdsCount
FROM
  Ads a
  FULL OUTER JOIN Towns t ON a.TownId = t.Id
  FULL OUTER JOIN Countries c ON t.CountryId = c.Id
GROUP BY t.Name, c.Name
ORDER BY t.Name, c.Name

-- create functions and view

CREATE VIEW AllAds
AS
SELECT 
  a.Id,
  a.Title, 
  u.UserName AS Author,
  a.Date,
  t.Name AS Town, 
  c.Name AS Category,
  s.Status AS Status
FROM
  Ads a
  LEFT JOIN Towns t on a.TownId = t.Id
  LEFT JOIN Categories c on a.CategoryId = c.Id
  LEFT JOIN AdStatuses s on a.StatusId = s.Id
  LEFT JOIN AspNetUsers u on u.Id = a.OwnerId

-- create a function
IF (object_id(N'fn_ListUsersAds') IS NOT NULL)
DROP FUNCTION fn_ListUsersAds
GO

CREATE FUNCTION fn_ListUsersAds()
	RETURNS @tbl_UsersAds TABLE(
		UserName NVARCHAR(MAX),
		AdDates NVARCHAR(MAX)
	)
AS
BEGIN
	-- declaring cursor
	DECLARE UsersCursor CURSOR FOR
		SELECT UserName FROM AspNetUsers
		ORDER BY UserName DESC; -- users descriating order
	OPEN UsersCursor;
	DECLARE @username NVARCHAR(MAX);
	FETCH NEXT FROM UsersCursor INTO @username;	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @ads NVARCHAR(MAX) = NULL;

		SELECT
			@ads = CASE
				WHEN @ads IS NULL THEN CONVERT(NVARCHAR(MAX), Date, 112)
				ELSE @ads + '; ' + CONVERT(NVARCHAR(MAX), Date, 112)
			END
		FROM AllAds -- uses view
		WHERE Author = @username
		ORDER BY Date;

		INSERT INTO @tbl_UsersAds
		VALUES(@username, @ads)
		
		FETCH NEXT FROM UsersCursor INTO @username;
	END;
	CLOSE UsersCursor;
	DEALLOCATE UsersCursor;
	RETURN;
END
GO

SELECT * FROM fn_ListUsersAds()




