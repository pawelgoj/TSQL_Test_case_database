--How many, tester and employees in other positions
USE TestCases
GO

SELECT position, COUNT(*) AS Liczba, email
FROM Emp.Employee
WHERE position IN ('QA', 'tester', 'kierownik testów')
GROUP BY rollup (position, email)
HAVING position IN ('QA', 'tester')
ORDER BY position desc
GO

SELECT position, COUNT(*) AS Liczba, email
FROM Emp.Employee
GROUP BY
	GROUPING SETS (
	position,
	email,
	(position, email)
	);
GO

SELECT pos.name, pos.email, [QA], [tester]
FROM emp.Employee
PIVOT (
	COUNT(position)
	FOR position IN ([QA], [tester])) AS pos
ORDER BY pos.email;
GO


SELECT Un.position, COUNT(*) AS Number
FROM (SELECT pos.name, pos.email, [QA], [tester]
	FROM emp.Employee
	PIVOT (
		COUNT(position)
		FOR position IN ([QA], [tester])) AS pos) As New
	UNPIVOT (
		TOTAL
		FOR	position IN ([QA], [tester])) As Un
	WHERE Un.TOTAL != 0
GROUP BY Un.position
GO

SELECT Un.new, Un.TOTAL
FROM Emp.Employee
	UNPIVOT (
		TOTAL
		FOR	new In ([email], [position])) As Un;
GO

SELECT name, surname, position, COUNT(position) 
OVER(PARTITION BY position ORDER BY name) AS iloœæ 
FROM Emp.Employee
GO

SELECT test_casse_id, employee_id, COUNT(*)
OVER( PARTITION BY test_casse_id) 
AS Number_of_the_same_test_cases
FROM Test.Test_Harmonogram
GO

SELECT TOP 10 EME.name, EME.surname, TS.category, TS.creation_date, 
TS.Title, TS.type, TS.preconditions, TS.priority, TS.severity, TS.steps 
FROM Test.Test_Cases_View AS TS
INNER JOIN Emp.Employee AS EME
ON TS.author_id = EME.id
ORDER BY EME.surname ASC
GO

WITH CTE AS (SELECT title, author_id
FROM Test.Test_Cases
WHERE severity LIKE 'œr%')

SELECT Emp.Employee.name, Emp.Employee.surname, CTE.title
FROM CTE
LEFT JOIN EMP.Employee
ON EMP.Employee.ID = CTE.author_id
ORDER BY Emp.Employee.surname asc
GO

--SELF JOIN
SELECT *
FROM Emp.Employee As A, Emp.Employee As B
WHERE A.position = B.position
GO

SELECT TOP 10 *
FROM Env.Browser
WHERE id  = ANY (SELECT browser_id
				FROM Env.Enviroment
				WHERE id = ANY (SELECT enviroment_id
								FROM Test.Test_Cases))
GO

SELECT DISTINCT TOP 2 title 
FROM Test.Test_Cases
GO


CREATE FUNCTION FUN(@ID int, @NUMBER int)
RETURNS TABLE
AS
RETURN SELECT TOP (@NUMBER) *
FROM Env.Browser
WHERE Env.Browser.ID  = @ID;
GO


SELECT *
FROM Env.Enviroment
CROSS APPLY FUN(Env.Enviroment.browser_id, 2) AS T
WHERE Env.Enviroment.browser_id BETWEEN 1 and 4;
GO