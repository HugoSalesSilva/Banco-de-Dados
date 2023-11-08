CREATE DATABASE bdEstoque
GO

Use bdEstoque
go
CREATE TABLE tbCliente(
	
	codCliente INT PRIMARY KEY IDENTITY(1,1)
	, nomeCliente VARCHAR(50) NOT NULL
	, cpfCliente CHAR(14)
	, emailCliente VARCHAR(40) NOT NULL
	, sexoCliente VARCHAR(15) NOT NULL
	, dataNascimentoCliente SMALLDATETIME NOT NULL
)
go
CREATE TABLE tbVendedor(

	codVendedor INT PRIMARY KEY IDENTITY(1,1)
	, nomeVendedor VARCHAR(50) NOT NULL
)
go
CREATE TABLE tbFornecedor(
	
	codFornecedor INT PRIMARY KEY IDENTITY(1,1)
	, nomeFornecedor VARCHAR(50) NOT NULL
	, contatoFornecedor VARCHAR(50) NOT NULL
)
go
CREATE TABLE tbFabricante(
	
	codFabricante INT PRIMARY KEY IDENTITY(1,1)
	, nomeFabricante VARCHAR(50) NOT NULL
)
go
CREATE TABLE tbVenda(
	
	codVenda INT PRIMARY KEY IDENTITY(1,1)
	, dataVenda SMALLDATETIME NOT NULL
	, valorTotalVenda SMALLMONEY NOT NULL
	, codCliente INT FOREIGN KEY REFERENCES tbCliente(codCliente)
	, codVendedor INT FOREIGN KEY REFERENCES tbVendedor(codVendedor)
)
go
CREATE TABLE tbProduto(
	
	codProduto INT PRIMARY KEY IDENTITY(1,1)
	, descricaoProduto VARCHAR(50)
	, valorProduto SMALLMONEY NOT NULL
	, quantidadeProduto SMALLINT NOT NULL
	, codFabricante INT FOREIGN KEY REFERENCES tbFabricante(codFabricante)
	, codFornecedor INT FOREIGN KEY REFERENCES tbFornecedor(codFornecedor)
)
go
CREATE TABLE tbItensVenda(
	
	codItensVenda INT PRIMARY KEY IDENTITY(1,1)
	, codVenda INT FOREIGN KEY REFERENCES tbVenda(codVenda)
	, codProduto INT FOREIGN KEY REFERENCES tbProduto(codProduto)
	, quantidadeItensVenda SMALLINT NOT NULL
	, subTotalItensVenda SMALLMONEY NOT NULL
)
go
Create Table tbEntradaProduto(

	codEntrada INT PRIMARY KEY IDENTITY(1,1)
	,dataEntradaProduto SMALLDATETIME NOT NULL
	,codProduto INT FOREIGN KEY REFERENCES tbProduto(codProduto)
	,quantidadeEntradaProduto SMALLINT NOT NULL
	
)
go
CREATE TABLE tbSaidaProduto(

	codSaidaProduto INT PRIMARY KEY IDENTITY(1,1)
	,dataSaidaProduto SMALLDATETIME NOT NULL
	,codProduto INT FOREIGN KEY REFERENCES tbProduto(codProduto)
	,quantidadeSaidaProduto SMALLINT
)
go