CREATE DATABASE Mecanica
GO
USE Constraints

CREATE TABLE Cliente (
	id				INT				NOT NULL	IDENTITY(3401, 15),
	nome			VARCHAR(100)	NOT NULL,
	logradouro		VARCHAR(200)	NOT NULL,
	numero			INT				NOT NULL	CHECK(numero >= 0),
	cep				CHAR(8)			NOT NULL	CHECK(LEN(cep) = 8),
	complemento		VARCHAR(255)	NOT NULL
    
	PRIMARY KEY (id)		
)

GO

CREATE TABLE Telefone_Cliente (
	clienteId		INT				NOT NULL,
	telefone		VARCHAR(11)		NOT NULL	CHECK(LEN(telefone) = 10 OR LEN(telefone) = 11)
	
	PRIMARY KEY(clienteId, telefone)

	FOREIGN KEY(clienteId)
	REFERENCES Cliente(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
)

GO

CREATE TABLE Veiculo (
	placa			CHAR(7)			NOT NULL	CHECK(LEN(placa) = 7),
	marca			VARCHAR(30)		NOT NULL,
	modelo			VARCHAR(30)		NOT NULL,
	ano_Fabricacao	INT				NOT NULL	CHECK(ano_Fabricacao > 1997),
	ano_Modelo		INT				NOT NULL	CHECK(ano_Modelo > 1997),
	data_Aquisicao	DATE			NOT NULL,
	clienteId		INT

	PRIMARY KEY (placa)
	
	FOREIGN KEY(clienteId)
	REFERENCES Cliente(id)
	ON UPDATE CASCADE,

	CONSTRAINT chk_sx_alt CHECK(
		(ano_Modelo = ano_Fabricacao) OR
		(ano_Modelo = (ano_Fabricacao + 1))
	)
)

GO

CREATE TABLE Peca (
	id				INT				NOT NULL	IDENTITY(3411, 7)	UNIQUE,
	nome			VARCHAR(30)		NOT NULL	UNIQUE,
	preco			DECIMAL(4,2)	NOT NULL	CHECK(preco >= 0),
	estoque			INT				NOT NULL	CHECK(estoque >= 10)

	PRIMARY KEY(id)
)

GO

CREATE TABLE Categoria (
	id				INT				NOT NULL	IDENTITY(1, 1),
	categoria		VARCHAR(10)		NOT NULL	CHECK(UPPER(categoria) IN ('ESTAGIARIO',
																		   'NIVEL 1',
																		   'NIVEL 2', 
																		   'NIVEL 3')),
	valor_Hora		DECIMAL(4, 2)	NOT NULL,

	PRIMARY KEY(id)
)

GO

INSERT INTO Categoria(categoria, valor_Hora) VALUES
('ESTAGIARIO', 15.00),
('NIVEL 1', 25.00),
('NIVEL 2', 35.00),
('NIVEL 3', 50.00);

GO

CREATE TABLE Funcionario(
	id						INT				NOT NULL	IDENTITY(101, 1),
	nome					VARCHAR(100)	NOT NULL,
	logradouro				VARCHAR(200)	NOT NULL,
	numero					INT				NOT NULL	CHECK(numero >= 0),
	telefone				CHAR(11)		NOT NULL	CHECK(telefone = 10 OR telefone = 11),
	categoria_Habilitacao	VARCHAR(2)		NOT NULL	CHECK(UPPER(categoria_Habilitacao) = 'A' OR 
															  UPPER(categoria_Habilitacao) = 'B' OR 
															  UPPER(categoria_Habilitacao) = 'C' OR 
															  UPPER(categoria_Habilitacao) = 'D' OR 
															  UPPER(categoria_Habilitacao) = 'E'),
	categoriaId				INT				NOT NULL


	PRIMARY KEY(id),

	FOREIGN KEY(categoriaId)
	REFERENCES Categoria(id)
	ON UPDATE CASCADE,
)

GO

CREATE TABLE Reparo (
	veiculoPlaca			CHAR(7)			NOT NULL,
	funcionarioId			INT				NOT NULL,
	pecaId					INT				NOT NULL,
	data_Reparo				DATE			NOT NULL	DEFAULT(GETDATE()),
	custo_Total				DECIMAL(4, 2)	NOT NULL	CHECK(custo_Total >= 0),
	tempo					INT				NOT NULL	CHECK(tempo >= 0)

	PRIMARY KEY(data_Reparo, veiculoPlaca, funcionarioId,
				pecaId),
	FOREIGN KEY(veiculoPlaca)
	REFERENCES Veiculo(placa)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

	FOREIGN KEY(funcionarioId)
	REFERENCES Funcionario(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

	FOREIGN KEY(pecaId)
	REFERENCES Peca(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
)

EXEC sp_help Cliente
EXEC sp_help Telefone_Cliente
EXEC sp_help Veiculo
EXEC sp_help Peca
EXEC sp_help Categoria
EXEC sp_help Funcionario
EXEC sp_help Reparo
