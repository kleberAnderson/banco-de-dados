CREATE DATABASE LocadoraFilme
GO
USE LocadoraFilme
GO
CREATE TABLE Filme(
	id		INT			NOT NULL,
	titulo	VARCHAR(40)	NOT NULL,
	ano		INT			NOT NULL,

	PRIMARY KEY(id)
)
GO
ALTER TABLE Filme
ALTER COLUMN titulo VARCHAR(80), NOT NULL

GO
CREATE TABLE Estrela(
	id			INT			NOT NULL,
	nome		VARCHAR(40)	NOT NULL
	PRIMARY KEY(id)
)
GO
ALTER TABLE Estrela ADD nomeReal	VARCHAR(50)

GO
CREATE TABLE Filme_Estrela(
	filmeId		INT		NOT NULL,
	estrelaId	INT		NOT NULL,

	PRIMARY KEY(filmeId, estrelaId)

	FOREIGN KEY(filmeId)
	REFERENCES Filme(id),

	FOREIGN KEY(estrelaId)
	REFERENCES Estrela(id)
)
GO
CREATE TABLE Dvd(
	num				INT,
	data_Fabricacao	DATE	NOT NULL,
	filmeId			INT
	
	PRIMARY KEY(num)
	
	FOREIGN KEY(filmeId)
	REFERENCES Filme(id)		
)
GO
CREATE TABLE Cliente(
	num_Cadastro	INT,
	nome			VARCHAR(70)		NOT NULL,
	logradouro		VARCHAR(150)	NOT NULL,
	num				INT				NOT NULL	CHECK(num >= 0),
	cep				CHAR(8)			NOT NULL	CHECK(LEN(cep) = 8)	

	PRIMARY KEY(num_Cadastro),
)
GO
CREATLE TABLE Locacao(
	dvdNum				INT,
	clienteNum_Cadastro	INT,
	data_Locacao		DATE	NOT NULL	DEFAULT(GETDATE()),
	data_Devolucao		DATE			NOT NULL,
	valor				DECIMAL(7, 2)	NOT NULL	CHECK(valor >= 0)

	PRIMARY KEY(dvdNum, clienteNum_Cadastro, data_Locacao),

	FOREIGN KEY(dvdNum)
	REFERENCES Dvd(num),

	FOREIGN KEY(clienteNum_Cliente)
	REFERENCES Cliente(num_Cliente)
)
GO
INSERT INTO Filme(titulo, ano) VALUES
('Whiplash', 2015),
('Birdman', 2015),
('Interestelar', 2014),
('A culpa é das estrelas', 2014),
('Alexandre o Dia Terrivel, Horrivel, Espantoso e Horroroso', 2014),
('Sing', 2016)

GO
INSERT INTO Estrela (nome, nomeReal) VALUES	
('Michael Keaton', 'Michael John Douglas'),
('Emma Stone', 'Emily Jean Stone'),
('Miles Teller', NULL),
('Steve Carell', 'Steven John Carell'),
('Jennifer Garner', 'Jennifer Anne Garner')

GO
INSERT INTO Dvd(data_Fabricacao) VALUES
(CONVERT(DATE, '20201202', 112)),
(CONVERT(DATE, '20191018', 112)),
(CONVERT(DATE, '20200403', 112)),
(CONVERT(DATE, '20201202', 112)),
(CONVERT(DATE, '20191018', 112)),
(CONVERT(DATE, '20200403', 112)),
(CONVERT(DATE, '20201202', 112)),
(CONVERT(DATE, '20191018', 112)),
(CONVERT(DATE, '20200403', 112))	

GO
INSERT INTO Locacao	(data_Locacao, data_Devolucao, valor) VALUES
((CONVERT(DATE, '20210218', 112)), (CONVERT(DATE, '20210221', 112)), CAST('3.50' AS DECIMAL(7, 2))),
((CONVERT(DATE, '20210218', 112)), (CONVERT(DATE, '20210221', 112)), CAST('3.50' AS DECIMAL(7, 2))),
((CONVERT(DATE, '20210218', 112)), (CONVERT(DATE, '20210219', 112)), CAST('3.50' AS DECIMAL(7, 2))),
((CONVERT(DATE, '20210220', 112)), (CONVERT(DATE, '20210223', 112)), CAST('3.00' AS DECIMAL(7, 2))),
((CONVERT(DATE, '20210220', 112)), (CONVERT(DATE, '20210223', 112)), CAST('3.00' AS DECIMAL(7, 2))),
((CONVERT(DATE, '20210220', 112)), (CONVERT(DATE, '20210223', 112)), CAST('3.00' AS DECIMAL(7, 2))),
((CONVERT(DATE, '20210224', 112)), (CONVERT(DATE, '20210226', 112)), CAST('3.50' AS DECIMAL(7, 2))),
((CONVERT(DATE, '20210224', 112)), (CONVERT(DATE, '20210226', 112)), CAST('3.50' AS DECIMAL(7, 2)))