--DELETE DATABASE
USE master
GO
DROP DATABASE ProjectsUsers

--START THE DATABASE
CREATE DATABASE ProjectsUsers
GO
USE ProjectsUsers

--DELETE ENTITY
--DROP TABLE

CREATE TABLE Users (
	id			INT			NOT NULL	IDENTITY(1, 1),
	name		VARCHAR(45)	NOT NULL,
	userName	VARCHAR(45),
	password	VARCHAR(45)	NULL	DEFAULT ('123mudar'),
	email		VARCHAR(45)	NOT NULL

	PRIMARY KEY(id)
)

GO
CREATE TABLE Projects (
	id			INT			NOT NULL	IDENTITY(10001, 1),
	name		VARCHAR(45)	NOT NULL,
	description	VARCHAR(45),
	date		DATE		NOT NULL	CHECK(date > '20140901')

	PRIMARY KEY(id)
)

GO
CREATE TABLE Users_has_projects (
	users_Id	INT		NOT NULL,
	projects_Id	INT		NOT NULL,
	
	PRIMARY KEY(users_Id, projects_Id),

	FOREIGN KEY(users_Id)
	REFERENCES Users(id),

	FOREIGN KEY(projects_Id)
	REFERENCES Projects(id)
)

GO
ALTER TABLE Users
ALTER COLUMN userName VARCHAR(10) NOT NULL

GO
ALTER TABLE Users
ALTER COLUMN password VARCHAR(8) NULL	

GO
INSERT INTO Users (name, userName, password, email) VALUES
('Maria', 'Rh_maria', DEFAULT, 'maria@empresa.com'),
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana', 'Rh_ana', DEFAULT, 'ana@empresa.com'),
('Clara', 'Ti_clara', DEFAULT, 'clara@empresa.com'),
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

GO
INSERT INTO Projects(name, description, date) VALUES
('Re-folha', 'Refatoração das Folhas', CONVERT(CHAR(10), '05/09/2014', 103)),
('Manutencao PCs', 'Manutencao PCs', CONVERT(CHAR(10), '06/09/2014', 103)),
('Auditoria', NULL, CONVERT(CHAR(10), '07/09/2014', 103))

GO
INSERT INTO Users_has_projects(users_Id, projects_Id) VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)

UPDATE Projects
SET date = CONVERT(CHAR(10), '12/09/2014', 103)
WHERE name LIKE 'Manutencao%'

GO
UPDATE Users
SET userName = 'Rh_cido'
WHERE name LIKE 'Aparecido'

GO
UPDATE Users
SET password = '888@*'
WHERE userName LIKE 'Rh_maria'

GO
DELETE Users_has_projects
WHERE users_Id = 2

EXEC sp_help Users
EXEC sp_help Projects
EXEC sp_help Users_has_projects

SELECT * FROM Users
SELECT * FROM Projects
SELECT * FROM Users_has_projects