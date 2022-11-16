USE MASTER
GO

--create new database
CREATE DATABASE TestCases
GO

USE TestCases
GO

--create schemas 
CREATE SCHEMA Env;
GO

CREATE SCHEMA Test;
GO

CREATE SCHEMA Emp;
GO

--function upper a first letter in word 
CREATE FUNCTION FIRST_UPPER_LETTER (@arg varchar(500))
RETURNS varchar(500) AS
BEGIN 
	DECLARE @word varchar(500);
	SET @word = UPPER(LEFT(@arg,1))+LOWER(SUBSTRING(@arg,2,LEN(@arg)));
	RETURN @word
END
GO

--make tables in database 
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION
	CREATE TABLE Emp.Employee (
		id	INT NOT NULL IDENTITY(1,1),
		name varchar(50),
		surname varchar(50),
		email varchar(50) CHECK (email LIKE '%@%' AND email LIKE '%.com'),
		position varchar(50),
		
		PRIMARY KEY (id),
	);

	CREATE UNIQUE INDEX idex_employee
	ON Emp.Employee(name, surname, email, position)



	CREATE TABLE Env.Device (
		id int NOT NULL IDENTITY(1,1),
		device_name varchar(100),
		device_type varchar(50),
		operating_system varchar(100),
		
		PRIMARY KEY (id)
	);

	CREATE UNIQUE INDEX idex_Device
	ON Env.Device(device_name, device_type, operating_system)

	CREATE TABLE Env.Browser (
		id int NOT NULL IDENTITY(1,1),
		browser varchar(100),
		
		PRIMARY KEY (id)
	);

	CREATE UNIQUE INDEX idex_Browser
	ON Env.Browser(browser)

	CREATE TABLE Env.Enviroment (
		id int NOT NULL IDENTITY(1,1),
		device_id int,
		browser_id int,
		
		PRIMARY KEY (id),
		
		FOREIGN KEY (device_id)
		REFERENCES Env.Device(id)
		ON UPDATE CASCADE --cascade actualization of foreign key
		ON DELETE SET NULL, --cascade DELETE of foreign key, SET NULL IN TABLE
		
		FOREIGN KEY (browser_id)
		REFERENCES Env.Browser(id)
		ON UPDATE CASCADE --cascade actualization of foreign key
		ON DELETE SET NULL, --cascade DELETE of foreign key, SET NULL IN TABLE
	);

	CREATE UNIQUE INDEX idex_Enviroment
	ON Env.Enviroment(device_id, browser_id)

	CREATE TABLE Test.Test_Cases (
		id int NOT NULL IDENTITY(1,1),
		title varchar(200),
		steps text,
		author_id int, 
		preconditions varchar(500),
		enviroment_id int,
		type varchar(50),
		category varchar(50),
		priority varchar(30),
		severity varchar(30),
		creation_date date DEFAULT GETDATE(),
		
		PRIMARY KEY (id),
		
		FOREIGN KEY (author_id)
		REFERENCES Emp.Employee(id)
		ON UPDATE CASCADE --cascade actualization of foreign key
		ON DELETE SET NULL, --cascade DELETE of foreign key, SET NULL IN TABLE
		
		FOREIGN KEY (enviroment_id)
		REFERENCES Env.Enviroment(id)
		ON UPDATE CASCADE
		ON DELETE SET NULL
	);

	CREATE UNIQUE INDEX idex_Test_Cases
	ON Test.Test_Cases(title, author_id, preconditions, enviroment_id,
	type, category, priority, severity, creation_date)

	CREATE TABLE Test.Test_Harmonogram (
		id int NOT NULL IDENTITY(1,1),
		test_casse_id int,
		date date NOT NULL,
		employee_id int,
		status varchar(20)
		
		PRIMARY KEY (Id),
		
		FOREIGN KEY (employee_id)
		REFERENCES Emp.Employee(id)
		ON UPDATE CASCADE --cascade actualization of foreign key
		ON DELETE SET NULL, --cascade DELETE of foreign key, SET NULL IN TABLE
		
		FOREIGN KEY (test_casse_id)
		REFERENCES Test.Test_Cases(id)
	);

	CREATE UNIQUE INDEX idex_Test_Harmonogram
	ON Test.Test_Harmonogram(test_casse_id, date, employee_id,
	status)

COMMIT TRANSACTION;
GO

--make view of join tables Test_Cases + Enviroment + Device + Browser
CREATE VIEW Test.Test_Cases_View AS

	SELECT TS.id, TS.author_id, TS.category, TS.creation_date, 
	TS.preconditions, TS.priority, TS.severity, TS.steps, TS.title,
	TS.type, device_name, device_type, operating_system, browser
	FROM Env.Enviroment
	INNER JOIN Env.Device
	ON  Env.Device.id = Env.Enviroment.device_id
	INNER JOIN Env.Browser
	ON Env.Browser.id = Env.Enviroment.browser_id
	RIGHT JOIN Test.Test_Cases AS TS
	ON TS.enviroment_id = Env.Enviroment.id

GO


/* make trigger which upper a first letter in name and surname 
in table: Employee */
CREATE TRIGGER insert_emp_allert
ON Emp.Employee
AFTER INSERT
AS
BEGIN 

	DECLARE @name varchar(50)
	DECLARE @surname varchar(50)
	DECLARE @max_id int

	SET @max_id = (SELECT MAX(id) 
				   FROM Emp.Employee);

	SET @name = (SELECT name 
				 FROM Emp.Employee
				 WHERE @max_id = id);

	SET @surname = (SELECT surname 
			        FROM Emp.Employee
			        WHERE @max_id = id);

	UPDATE Emp.Employee
	SET name = dbo.FIRST_UPPER_LETTER(@name),
	    surname = dbo.FIRST_UPPER_LETTER(@surname)
	WHERE id = @max_id

	SELECT 'Employee was inserted!'
END
GO

CREATE TRIGGER insert_test_case_allert
ON Test.Test_cases
AFTER INSERT
AS
BEGIN 
	SELECT 'Test case was inserted!'
END
GO