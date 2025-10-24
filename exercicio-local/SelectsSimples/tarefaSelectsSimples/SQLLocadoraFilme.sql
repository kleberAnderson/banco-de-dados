CREATE DATABASE LocadoraFilme
GO
USE LoacdoraFilme

GO

CREATE TABLE Filme(
	id		INT			NOT NULL,
	titulo	VARCHAR(40)	NOT NULL,
	ano		INT			NOT NULL,

	PRIMARY KEY(id)
)

GO

CREATE TABLE Estrela(
	id		INT			NOT NULL,
	nome	VARCHAR(50)	NOT NULL,

	PRIMARY KEY(id)
)

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