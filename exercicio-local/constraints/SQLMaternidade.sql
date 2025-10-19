CREATE DATABASE Maternidade
GO
USE Maternidade

CREATE TABLE Mae (
	id_Mae					INT				NOT NULL	IDENTITY(1001, 1),
	nome					VARCHAR(60)		NOT NULL,
	logradouro_Endereco		VARCHAR(100)	NOT NULL,
	numero_Endereco			INT				NOT NULL	CHECK(numero_Endereco >= 0),
	cep_Endereco			CHAR(8)			NOT NULL	CHECK(LEN(cep_Endereco) = 8),
	complemento_Endereco	VARCHAR(200),
	telefone				CHAR(10)					CHECK(LEN(telefone) = 10),					
	data_Nasc				DATE			NOT NULL
	
	PRIMARY KEY(id_Mae),
)

GO

CREATE TABLE Bebe (
	id_Bebe			INT				NOT NULL	IDENTITY(1, 1),
	nome			VARCHAR(60)		NOT NULL,
	data_Nascimento	DATE			NOT NULL	DEFAULT(GETDATE()),
	altura			DECIMAL(7, 2)	NOT NULL	CHECK(altura > 0.0),
	peso			DECIMAL(4, 3)	NOT NULL	CHECK(peso > 0.0),
	maeId_Mae		INT				NOT NULL,

	PRIMARY KEY(id_Bebe),

	FOREIGN KEY(maeId_Mae)
	REFERENCES Mae(id_Mae),
)

GO

CREATE TABLE Medico (
	crm_Numero			INT				NOT NULL,
	crm_UF				CHAR(2)			NOT NULL,
	nome				VARCHAR(60)		NOT NULL,
	telefone_Celular	CHAR(11)		NOT NULL UNIQUE	CHECK(LEN(telefone_Celular) = 11),
	especialidade		VARCHAR(30)		NOT NULL,

	PRIMARY KEY(crm_Numero, crm_UF)
)

GO

CREATE TABLE Bebe_Medico (
	bebeid_Bebe			INT				NOT NULL,
	medicocrm_Numero	INT				NOT NULL,
	medicocrm_UF		CHAR(2)			NOT NULL

	PRIMARY KEY(bebeid_Bebe, medicocrm_Numero, medicocrm_UF)

	FOREIGN KEY(bebeid_Bebe)
	REFERENCES Bebe(id_Bebe)
	ON UPDATE CASCADE
	ON DELETE CASCADE,

	FOREIGN KEY(medicocrm_Numero, medicocrm_UF)
	REFERENCES Medico(crm_Numero, crm_UF)
	ON UPDATE CASCADE
	ON DELETE CASCADE
)

EXEC sp_help Mae
EXEC sp_help Bebe
EXEC sp_help Medico
EXEC sp_help Bebe_Medico
