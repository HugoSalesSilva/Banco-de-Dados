CREATE DATABASE bdLocadoraVeiculo

USE bdLocadoraVeiculo
--a) Criar o banco de dados bdLocadoraVeiculo conforme diagrama abaixo
CREATE TABLE tbCategoriaVeiculo(
	idCategoriaVeiculo INT PRIMARY KEY IDENTITY(1,1)
	, descricaoCategoriaVeiculo VARCHAR(40) NOT NULL
	,valorDiariaCategoria MONEY NOT NULL
)

CREATE TABLE tbFabricante(
	idFabricante INT PRIMARY KEY IDENTITY(1,1)
	, nomeFabricante VARCHAR(60) NOT NULL
	, cnpjFabricante CHAR (14) NOT NULL
)

CREATE TABLE tbTipoCombustivel(
	idTipoCombustivel INT PRIMARY KEY IDENTITY(1,1)
	, descricaoTipoCombustivel VARCHAR(60) NOT NULL
	
)

CREATE TABLE tbCliente(
	idCliente INT PRIMARY KEY IDENTITY(1,1)
	, nomeCliente VARCHAR (60) NOT NULL
	, dataNascCliente DATE NOT NULL 
	, cpfCliente VARCHAR (14) NOT NULL
	, idade int not null
)

CREATE TABLE tbVeiculo(
	idVeiculo INT PRIMARY KEY IDENTITY(1,1)
	, modeloVeiculo VARCHAR (60) NOT NULL
	, placaVeiculo VARCHAR (7) NOT NULL
	, idFabricante INT FOREIGN KEY REFERENCES tbFabricante(idFabricante)
	, idCategoriaVeiculo INT FOREIGN KEY REFERENCES tbCategoriaVeiculo(idCategoriaVeiculo)
	, idTipoCombustivel INT FOREIGN KEY REFERENCES tbTipoCombustivel(idTipoCombustivel)
	, kmVeiculo INT Not NULL
	, origemVeiculo VARCHAR (4) Not NULL
)

CREATE TABLE tbLocacao(
	idLocacao INT PRIMARY KEY IDENTITY(1,1)
	, dataLocacao DATE NOT NULL
	, dataDevolucao DATE NOT NULL
	, numeroDiarias VARCHAR (10) NOT NULL
	, valorTotal MONEY NOT NULL
	, idCliente INT FOREIGN KEY REFERENCES tbCliente(idCliente)
	, idVeiculo INT FOREIGN KEY REFERENCES tbVeiculo(idVeiculo)
)