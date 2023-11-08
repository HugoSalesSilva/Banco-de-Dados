Create Database bdBanco

USE bdBanco

CREATE TABLE tbCliente(
    codCliente INT PRIMARY KEY IDENTITY(1,1)
    ,nomeCliente VARCHAR(50)
    ,cpfCliente CHAR(14) NOT NULL
    )


Create table tbContaCorrente(
	numConta INT PRIMARY KEY IDENTITY(1,1)
	,saldoConta MONEY
	,codCliente INT FOREIGN KEY REFERENCES tbCliente(codCliente)
)

Create table tbDeposito(
	codDeposito INT PRIMARY KEY IDENTITY(1,1)
	, valorDeposito MONEY
	, numConta INT FOREIGN KEY REFERENCES tbContaCorrente(numConta)
	, dataDeposito DateTime
	, horaDeposito DateTime

)

Create table tbSaque(
	codSaque INT PRIMARY KEY IDENTITY(1,1)
	, valorSaque Money
	, numConta INT FOREIGN KEY REFERENCES tbContaCorrente(numConta)
	, dataSaque DateTime
	, horaSaque DateTime
)