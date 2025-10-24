CREATE DATABASE ProjectsUsers
GO
USE ProjectsUsers

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

CREATE TABLE Projects (
	id			INT			NOT NULL	IDENTITY(10001, 1),
	name		VARCHAR(45)	NOT NULL,
	description	VARCHAR(45)	NOT NULL,
	date		DATE		NOT NULL	CHECK(CONVERT(CHAR(10), (DATE), 103) > 01/09/2014)

	PRIMARY KEY(id)
)

GO

CREATE TABLE Users (
	id			INT			NOT NULL	IDENTITY(1, 1),
	name		VARCHAR(45)	NOT NULL,
	userName	VARCHAR(45)	NOT NULL	UNIQUE,
	password	VARCHAR(45)	NOT NULL	DEFAULT('123mudar'),
	email		VARCHAR(45)	NOT NULL

	PRIMARY KEY(id)
)