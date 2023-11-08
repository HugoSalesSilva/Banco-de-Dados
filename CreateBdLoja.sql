CREATE DATABASE bdLoja

USE bdLoja

CREATE TABLE tbCategoriaProduto(
	codCategoriaProduto INT PRIMARY KEY IDENTITY(1,1)
	, nomeCategoriaProduto VARCHAR(20) NOT NULL
)

CREATE TABLE tbProduto(
	codProduto INT PRIMARY KEY IDENTITY(1,1)
	, nomeProduto VARCHAR(60) NOT NULL
	, precoKiloProduto MONEY NOT NULL
	, codCategoriaProduto INT FOREIGN KEY REFERENCES tbCategoriaProduto(codCategoriaProduto)
)

CREATE TABLE tbCliente(
	codCliente INT PRIMARY KEY IDENTITY(1,1)
	, nomeCliente VARCHAR(60) NOT NULL
	, dataNascimentoCliente DATETIME NOT NULL
	, ruaCliente VARCHAR(30) NOT NULL
	, numCasaCliente VARCHAR(10) NOT NULL
	, cepCliente VARCHAR(15) NOT NULL
	, bairroCliente VARCHAR(15) NOT NULL
	, cidadeCliente VARCHAR(15) NOT NULL
	, estadoCliente CHAR(2) NOT NULL
	, cpfCliente CHAR(14) NOT NULL
	, sexoCliente CHAR(1) NOT NULL
)

CREATE TABLE tbEncomenda(
	codEncomenda INT PRIMARY KEY IDENTITY(1,1)
	, dataEncomenda DATE NOT NULL
	, valorTotalEncomenda SMALLMONEY NOT NULL
	, dataEntregaEncomenda DATE NOT NULL
	, codCliente INT FOREIGN KEY REFERENCES tbCliente(codCliente)
)

CREATE TABLE tbItensEncomenda(
	codItensEncomenda INT PRIMARY KEY IDENTITY(1,1)
	, qtdeKilosItensEncomenda DECIMAL NOT NULL
	, subTotalItensEncomenda MONEY NOT NULL
	, codEncomenda INT FOREIGN KEY REFERENCES tbEncomenda(codEncomenda)
	, codProduto INT FOREIGN KEY REFERENCES tbProduto(codProduto)
)