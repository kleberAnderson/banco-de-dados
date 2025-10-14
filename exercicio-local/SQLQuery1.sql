CREATE DATABASE aulaconstraints1

USE aulaconstraints1

/*



- Só são cadastrados livros de autores do Brasil, Estados Unidos, Inglaterra e Alemanha
*/

CREATE TABLE livro (
codigo			INT				NOT NULL				IDENTITY(100001,100),
nome			VARCHAR(200)	NOT NULL,
lingua			VARCHAR(10)		NULL	DEFAULT('PT-BR'),
ano				INT				NOT NULL CHECK(ano >= 1990)
PRIMARY KEY(codigo)
)

GO

CREATE TABLE autor (
id_autor		INT				NOT NULL				IDENTITY(2351, 1),
nome			VARCHAR(100)	NOT NULL	UNIQUE,
data_nasc		DATE			NOT NULL,
pais_nasc		DATE			NOT NULL	CHECK(UPPER(pais_nasc) = 'BRASIL' OR UPPER(pais_nasc) = 'ESTADOS UNIDOS'
													OR UPPER(pais_nasc) = 'INGLATERRA' OR UPPER(pais_nasc) = 'ALEMANHA'),
biografia		VARCHAR(255)

PRIMARY KEY(id_autor)
)

GO

CREATE TABLE editora (
id_editora		INT				NOT NULL				IDENTITY(491, 16),
nome			VARCHAR(70)		NOT NULL	UNIQUE,
telefone		VARCHAR(11)		NOT NULL	CHECK(LEN(telefone) = 11),
log_endereco	VARCHAR(200)	NOT NULL,
num_endereco	INT				NOT NULL	CHECK(num_endereco >= 0),
cep_endereco	CHAR(8)			NOT NULL	CHECK(LEN(cep_endereco) = 8),
complemento		VARCHAR(255)

PRIMARY KEY(id_editora)
)

GO

CREATE TABLE edicao (
ISBN			CHAR(13)		NOT NULL	CHECK(LEN(ISBN) = 13),
preco			DECIMAL(4, 2)	NOT NULL	CHECK(preco >= 0),
ano				INT				NOT NULL	CHECK(ano >= 1993),
num_pagina		INT				NOT NULL	CHECK(num_pagina >= 15),
qtd_estoque		INT				NOT NULL

PRIMARY KEY(ISBN)
)

GO

CREATE TABLE livro_autor (
livro_codigo	INT				NOT NULL,
autor_ident		INT				NOT NULL

FOREIGN KEY(livro_codigo)	REFERENCES livro(codigo),
FOREIGN KEY(autor_ident)		REFERENCES autor(id_autor)
)

GO

CREATE TABLE editora_edicao_livro (
editora_idEditora	INT				NOT NULL,
edicao_ISBN			CHAR(13)		NOT NULL,
livro_codigo		INT				NOT NULL

FOREIGN KEY(editora_idEditora) REFERENCES editora(id_editora),
FOREIGN KEY(edicao_ISBN)	 REFERENCES edicao(ISBN),
FOREIGN KEY(livro_codigo) REFERENCES livro(codigo)
)

EXEC sp_help livro
EXEC sp_help autor
EXEC sp_help editora
EXEC sp_help edicao
EXEC sp_help livro_autor
EXEC sp_help editora_edicao_livro

