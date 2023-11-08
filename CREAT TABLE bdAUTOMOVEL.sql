Create database bdAutomovel

USE bdAutomovel

Create table tbMotorista(
	idMotorista INT PRIMARY KEY IDENTITY(1,1),	
	nomeMotorista VARCHAR(60) NOT NULL,
	dataMotorista DATE NOT NULL,
	cpfMotorista VARCHAR (14) NOT NULL,
	CNHMotorista CHAR(11) NOT NULL,
	pontuacaoAcumulada INT NOT NULL
)

