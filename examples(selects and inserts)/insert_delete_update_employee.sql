USE TestCases
GO

DECLARE @name varchar(50)
DECLARE @surname varchar(50)
DECLARE @email varchar(50)
DECLARE @position varchar(50)
DECLARE @operation_type int 

SET @operation_type = 0 -- 0 -INSERT, 1- UPPDATE, 2-DELETE

SET @name = 'Adam'
SET @surname = 'Kolec'
SET @email = 'AKol@mail.com'
SET @position = 'tester'


IF @operation_type = 0 
	INSERT INTO Emp.Employee(name, surname, email, position)
	VALUES (@name, @surname, @email, @position);

ELSE IF @operation_type = 1
	UPDATE Emp.Employee
	SET name = @name, surname =@surname
	WHERE name = @name AND surname = @surname AND email = @email
		AND position = @position;

ELSE IF @operation_type = 2 
	DELETE FROM Emp.Employee 
	WHERE name = @name AND surname = @surname AND email = @email
		AND position = @position;

ELSE 
	SELECT 'INCORRECT VALUE OF @operation_type = ' + CONVERT(VARCHAR(50), @operation_type);
GO