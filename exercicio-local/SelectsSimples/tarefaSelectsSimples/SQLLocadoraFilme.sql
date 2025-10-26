--DELETE DATABASE
USE master
GO
DROP DATABASE LocadoraFilme

--START THE DATABASE
CREATE DATABASE LocadoraFilme
GO
USE LocadoraFilme

--DELETE ENTITY
--DROP TABLE

GO
CREATE TABLE Filme(
	id		INT		IDENTITY(1001, 1),
	titulo	VARCHAR(40)	NOT NULL,
	ano		INT			NOT NULL

	PRIMARY KEY(id)
)
GO
ALTER TABLE Filme
ALTER COLUMN titulo VARCHAR(80) NOT NULL

GO
CREATE TABLE Estrela(
	id			INT			NOT NULL	IDENTITY(9901, 1),
	nome		VARCHAR(40)	NOT NULL
	PRIMARY KEY(id)
)
GO
ALTER TABLE Estrela ADD nomeReal VARCHAR(50)

GO
CREATE TABLE Filme_Estrela(
	filmeId		INT,
	estrelaId	INT		NOT NULL,

	PRIMARY KEY(filmeId, estrelaId),

	FOREIGN KEY(filmeId)
	REFERENCES Filme(id),

	FOREIGN KEY(estrelaId)
	REFERENCES Estrela(id)
)
GO
CREATE TABLE Dvd(
	num				INT	IDENTITY(10001, 1),
	data_Fabricacao	DATE	NOT NULL,
	filmeId			INT
	
	PRIMARY KEY(num)
	
	FOREIGN KEY(filmeId)
	REFERENCES Filme(id)		
)
GO
CREATE TABLE Cliente(
	num_Cadastro	INT	IDENTITY(5501, 1),
	nome			VARCHAR(70)		NOT NULL,
	logradouro		VARCHAR(150)	NOT NULL,
	num				INT				NOT NULL	CHECK(num >= 0),
	cep				CHAR(8)			NULL	CHECK(LEN(cep) = 8)	

	PRIMARY KEY(num_Cadastro),
)
GO
CREATE TABLE Locacao(
	dvdNum				INT,
	clienteNum_Cadastro	INT,
	data_Locacao		DATE	NOT NULL	DEFAULT(GETDATE()),
	data_Devolucao		DATE			NOT NULL,
	valor				DECIMAL(7, 2)	NOT NULL	CHECK(valor >= 0)

	PRIMARY KEY(data_Locacao, dvdNum, clienteNum_Cadastro),

	FOREIGN KEY(dvdNum)
	REFERENCES Dvd(num),

	FOREIGN KEY(clienteNum_Cadastro)
	REFERENCES Cliente(num_Cadastro)
)
GO
INSERT INTO Filme(titulo, ano) VALUES
('Whiplash', 2015),
('Birdman', 2015),
('Interestelar', 2014),
('A culpa � das estrelas', 2014),
('Alexandre o Dia Terrivel, Horrivel, Espantoso e Horroroso', 2014),
('Sing', 2016)

GO
INSERT INTO Estrela (nome, nomeReal) VALUES	
('Michael Keaton', 'Michael John Douglas'),
('Emma Stone', 'Emily Jean Stone'),
('Miles Teller', NULL),
('Steve Carell', 'Steven John Carell'),
('Jennifer Garner', 'Jennifer Anne Garner')

INSERT INTO Filme_Estrela(filmeId, estrelaId) VALUES
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)

GO
INSERT INTO Dvd(data_Fabricacao, filmeId) VALUES
(CONVERT(DATE, '2020/12/02', 102), 1001),
(CONVERT(DATE, '2019/10/18', 102), 1002),
(CONVERT(DATE, '2020/04/03', 102), 1003),
(CONVERT(DATE, '2020/12/02', 102), 1001),
(CONVERT(DATE, '2019/10/18', 102), 1004),
(CONVERT(DATE, '2020/04/03', 102), 1002),
(CONVERT(DATE, '2020/12/02', 102), 1005),
(CONVERT(DATE, '2019/10/18', 102), 1002),
(CONVERT(DATE, '2020/04/03', 102), 1003)	

INSERT INTO Cliente(nome, logradouro, num, cep) VALUES
('Matilde Luz', 'Rua S�ria', 150, '03086040'),
('Carlos Carreiro', 'Rua Bartollomeu', 1250, '04419110'),
('Matilde Luz', 'Rua Itajutiba', 169, NULL),
('Matilde Luz', 'Rua Jayme Von Rosenburg', 36, NULL),
('Matilde Luz', 'Rua Arnaldo Simoes Pinto', 235, '02917110')

GO
INSERT INTO Locacao	(dvdNum, clienteNum_Cadastro, data_Locacao, data_Devolucao, valor) VALUES
(10001, 5502,(CONVERT(DATE, '20210218', 102)), (CONVERT(DATE, '20210221', 102)), CAST('3.50' AS DECIMAL(7, 2))),
(10009, 5502, (CONVERT(DATE, '20210218', 102)), (CONVERT(DATE, '20210221', 102)), CAST('3.50' AS DECIMAL(7, 2))),
(10002, 5503,(CONVERT(DATE, '20210218', 102)), (CONVERT(DATE, '20210219', 102)), CAST('3.50' AS DECIMAL(7, 2))),
(10002, 5505,(CONVERT(DATE, '20210220', 102)), (CONVERT(DATE, '20210223', 102)), CAST('3.00' AS DECIMAL(7, 2))),
(10004, 5505,(CONVERT(DATE, '20210220', 102)), (CONVERT(DATE, '20210223', 102)), CAST('3.00' AS DECIMAL(7, 2))),
(10005, 5505,(CONVERT(DATE, '20210220', 102)), (CONVERT(DATE, '20210223', 102)), CAST('3.00' AS DECIMAL(7, 2))),
(10001, 5501,(CONVERT(DATE, '20210224', 102)), (CONVERT(DATE, '20210226', 102)), CAST('3.50' AS DECIMAL(7, 2))),
(10008, 5501,(CONVERT(DATE, '20210224', 102)), (CONVERT(DATE, '20210226', 102)), CAST('3.50' AS DECIMAL(7, 2)))

--OPERATION
GO
UPDATE Cliente
SET cep = '08411150'
WHERE num_Cadastro = 5503

GO
UPDATE Cliente
SET cep = '02918190'
WHERE num_Cadastro = 5504

GO
UPDATE Locacao
SET valor = 3.25
WHERE data_Locacao = '2021-02-18' AND clienteNum_Cadastro = 5502

GO
UPDATE Locacao
SET valor = 3.10
WHERE data_Locacao = '2021-02-24' AND clienteNum_Cadastro = 5501

GO
UPDATE Dvd
SET data_Fabricacao = '2019-07-14'
WHERE num = 10005

GO
UPDATE Estrela
SET nomeReal = 'Miles Alexander Teller'
WHERE nome LIKE 'Miles Teller'

--CONSULTATION
GO
SELECT titulo AS titulo_Filme
FROM Filme
WHERE ano = 2014

GO
SELECT id, ano
FROM Filme
WHERE titulo = 'Birdman'

GO
SELECT id, ano
FROM Filme
WHERE titulo LIKE '%plash'

GO
SELECT id, nome, nomeReal
FROM Estrela
WHERE nome LIKE 'Steve%'

GO
SELECT filmeId, CONVERT(VARCHAR(10), data_Fabricacao, 103) AS fab
FROM Dvd
WHERE data_Fabricacao >= '2020/01/01'
ORDER BY data_Fabricacao ASC

GO
SELECT dvdNum, data_Locacao, data_Devolucao, valor, (valor + 2.00) AS 'multa'
FROM Locacao
WHERE clienteNum_Cadastro = 5505

GO
SELECT logradouro, num, cep
FROM Cliente
WHERE nome = 'Matilde Luz'

GO
SELECT nomeReal
FROM Estrela
WHERE nome = 'Michael Keaton'

GO
SELECT num_Cadastro, nome, logradouro + ' ' + CAST(num AS VARCHAR(10)) + ' ' + cep AS 'end_comp'
FROM Cliente
WHERE num_Cadastro >= 5503 

EXEC sp_help Users
EXEC sp_help Projects
EXEC sp_help Users_has_projects

SELECT * FROM Filme
SELECT * FROM Estrela
SELECT * FROM Filme_Estrela
SELECT * FROM Dvd
SELECT * FROM Cliente
SELECT * FROM Locacao
