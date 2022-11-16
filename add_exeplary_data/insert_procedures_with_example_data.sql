USE TestCases
GO

CREATE PROCEDURE Add_Employess 
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO Emp.Employee (name, surname, email, position)
		VALUES ( 'Adam' , 'Nowak', 'adam@mail.com', 'tester')

		INSERT INTO Emp.Employee (name, surname, email, position)
		VALUES ( 'Kamil' , 'Urban', 'urban@mail.com', 'tester')

		INSERT INTO Emp.Employee (name, surname, email, position)
		VALUES ( 'Agnieszka' , 'Nowak', 'anow@mail.com', 'QA')

		INSERT INTO Emp.Employee (name, surname, email, position)
		VALUES ( 'Ewa' , 'Wu', 'ew@mail.com', 'kierownik testów')

		INSERT INTO Emp.Employee (name, surname, email, position)
		VALUES ( 'ala' , 'stró¿', 'ala@mail.com', 'tester')

		INSERT INTO Emp.Employee (name, surname, email, position)
		VALUES ( 'Tomasz' , 'Dawid', 'Dawla@mail.com', 'tester')

		INSERT INTO Emp.Employee (name, surname, email, position)
		VALUES ( 'Bartosz' , 'Konrad', 'Ba.Kon@mail.com', 'QA')

		COMMIT TRANSACTION;

	END TRY 
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT 'Something went wrong in Add_employes !!!'
	END CATCH
END;
GO

CREATE PROCEDURE Add_Browsers 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO Env.Browser(browser)
		VALUES ( 'google chrome' )

		INSERT INTO Env.Browser(browser)
		VALUES ( 'firefox' )

		INSERT INTO Env.Browser(browser)
		VALUES ( 'opera' )

		COMMIT TRANSACTION;

	END TRY 
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT 'Something went wrong in Add_Browsers !!!'
	END CATCH
END;
GO

CREATE PROCEDURE Add_Device 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO Env.Device(device_name, device_type, operating_system)
		VALUES ( 'Super_PC', 'PC', 'Windows' )

		INSERT INTO Env.Device(device_name, device_type, operating_system)
		VALUES ( 'Medium_PC', 'PC', 'Linux' )

		INSERT INTO Env.Device(device_name, device_type, operating_system)
		VALUES ( 'Xiaomi redmi note 11', 'mobile', 'Android' )

		COMMIT TRANSACTION;

	END TRY 
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT 'Something went wrong in Add_Device !!!'
	END CATCH
END;
GO

CREATE PROCEDURE Add_Enviroment 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO Env.Enviroment(device_id, browser_id)
		VALUES ( 1, 1 )

		INSERT INTO Env.Enviroment(device_id, browser_id)
		VALUES ( 1, 2 )

		INSERT INTO Env.Enviroment(device_id, browser_id)
		VALUES ( 3, 2 )

		INSERT INTO Env.Enviroment(device_id, browser_id)
		VALUES ( 2, 3)

		COMMIT TRANSACTION;

	END TRY 
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT 'Something went wrong in Add_Device !!!'
	END CATCH
END;
GO

CREATE PROCEDURE Add_Test_Cases
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO Test.Test_Cases(title, steps, preconditions, type, category, 
		priority, severity, author_id, enviroment_id)
		VALUES ('[TableMaker][Strona G³ówna] Responsywnoœæ - zachowanie siê tekstu', 
		'1. Kliknij w pole dodaj now¹ kolumnê. 
		2. Wpisz nazwê kolumny "nowa". 
		Oczekiwany wynik: Kolumna "nowa" pojawia siê jako ostatnia po prawej stronie.',
		'U¿ytkownik ma otwart¹ przegl¹darkê i zanjduje siê na stronie domowej alikaci TableMaker',
		'pozytywny przypadek testowy',
		'Funkcjonalnoœæ',
		'œrednie',
		'œrednie', 
		1, 
		1)
		INSERT INTO Test.Test_Cases(title, steps, preconditions, type, category, 
		priority, severity, author_id, enviroment_id)
		VALUES ('[TableMaker][Strona G³ówna] Czy wszystkie grafiki ³aduj¹ siê na stronie ', 
		'1. Krok1. 
		2. Krok2. 
		Oczekiwany wynik: Dziej¹ siê rzeczy',
		'U¿ytkownik ma otwart¹ przegl¹darkê i znajduje siê na stronie domowej alikaci TableMaker',
		'pozytywny przypadek testowy',
		'Funkcjonalnoœæ',
		'niskie',
		'niskie', 
		5, 
		1)
		INSERT INTO Test.Test_Cases(title, steps, preconditions, type, category, 
		priority, severity, author_id, enviroment_id)
		VALUES ('[TableMaker][/wyszukiwanie] Sprawdzenie wyszukiwania', 
		'1. Krok1. 
		2. Krok2. 
		Oczekiwany wynik: Dziej¹ siê rzeczy',
		'U¿ytkownik ma otwart¹ przegl¹darkê i znajduje siê na stronie TableMaker/wyszukiwanie',
		'pozytywny przypadek testowy',
		'Funkcjonalnoœæ',
		'wysokie',
		'œrednie', 
		3, 
		1)
		INSERT INTO Test.Test_Cases(title, steps, preconditions, type, category, 
		priority, severity, author_id, enviroment_id)
		VALUES ('[TableMaker][Strona G³ówna] Sprawdzenie walidatora loginu i has³a -nieporawny login i has³o', 
		'1. Krok1. 
		2. Krok2. 
		Oczekiwany wynik: Dziej¹ siê rzeczy',
		'U¿ytkownik ma otwart¹ przegl¹darkê i znajduje siê na stronie domowej alikaci TableMaker',
		'negatywny przypadek testowy',
		'Funkcjonalnoœæ',
		'œrednie',
		'wysokie', 
		2, 
		1)
		INSERT INTO Test.Test_Cases(title, steps, preconditions, type, category, 
		priority, severity, author_id, enviroment_id)
		VALUES ('[TableMaker][Strona G³ówna] Sprawdzenie walidatora loginu i has³a -poprawny login i has³o', 
		'1. Krok1. 
		2. Krok2. 
		Oczekiwany wynik: Dziej¹ siê rzeczy',
		'U¿ytkownik ma otwart¹ przegl¹darkê i znajduje siê na stronie domowej alikaci TableMaker',
		'pozytywny przypadek testowy',
		'Funkcjonalnoœæ',
		'wysokie',
		'wysokie', 
		1, 
		2)


		COMMIT TRANSACTION;

	END TRY 
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT 'Something went wrong in Add_Test_Cases !!!'
	END CATCH
END;
GO

CREATE PROCEDURE Add_Test_Harmoogram
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @employee_id INT
		DECLARE @test_casse_id INT
		DECLARE @DAY INT
		DECLARE @i INT
		DECLARE @reverse_employee_id BIT
		DECLARE @reverse_test_casse_id BIT

		SET @employee_id = 1
		SET @test_casse_id = 5
		SET @DAY = 1
		SET @i = 0
		SET @reverse_employee_id =	0
		SET @reverse_test_casse_id = 0

		WHILE @i < 9
		BEGIN 
			INSERT INTO Test.Test_Harmonogram(date, status, test_casse_id, employee_id)
			VALUES (
				CASE 
					WHEN @DAY > 9 THEN 
						'2023-03-' + CONVERT(varchar, @DAY)
					ELSE 
						'2023-03-0' + CONVERT(varchar, @DAY)
				END,
				'Ready to test',
				@test_casse_id,
				@employee_id
			)

			SET @DAY = @DAY + 1
			SET @i = @i + 1

			IF (@employee_id < 7 AND @reverse_employee_id =	0)
				SET @employee_id = @employee_id + 1;
			ELSE IF (@employee_id = 1 AND @reverse_employee_id = 1)
				BREAK; 
			ELSE 
				BEGIN
				SET @employee_id = @employee_id - 1
				SET @reverse_employee_id =	1
				END;

			IF (@test_casse_id > 1 AND @reverse_test_casse_id = 0)
				SET @test_casse_id = @test_casse_id - 1;
			ELSE IF (@test_casse_id = 5 AND @reverse_test_casse_id = 1)
				BREAK; 
			ELSE 
				BEGIN
				SET @test_casse_id = @test_casse_id + 1
				SET @reverse_test_casse_id = 1;
				END;
		END
		COMMIT TRANSACTION;

	END TRY 
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT 'Something went wrong in Add_Test_Harmoogram !!!'
	END CATCH
END;
GO