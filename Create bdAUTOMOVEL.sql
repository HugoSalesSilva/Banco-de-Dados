CREATE DATABASE bdAutomovel

USE bdAutomovel

CREATE TABLE tbMotorista(
    idMotorista INT PRIMARY KEY IDENTITY(1,1)
    ,nomeMotorista VARCHAR(50)
    ,dataNascimento SMALLDATETIME NOT NULL
    ,cpfMotorista CHAR(14) NOT NULL
    ,CNHMotorista CHAR(11) NOT NULL
    ,pontuacaoAcumulada SMALLINT NOT NULL
    )

CREATE TABLE tbVeiculo(
    idVeiculo INT PRIMARY KEY IDENTITY(1,1)
    ,modeloVeiculo VARCHAR(50) NOT NULL
    ,placaVeiculo CHAR(07) NOT NULL
    ,renavamVeiculo CHAR(11) NOT NULL
    ,anoVeiculo SMALLDATETIME NOT NULL
    ,idMotorista INT FOREIGN KEY REFERENCES tbMotorista(idMotorista)
    )

CREATE TABLE tbMultas(
    idMultas INT PRIMARY KEY IDENTITY(1,1)
    ,dataMultas SMALLDATETIME NOT NULL
    ,horaMultas DateTime NOT NULL
    ,pontosMultas SMALLINT NOT NULL
    ,idVeiculo INT FOREIGN KEY REFERENCES tbVeiculo(idVeiculo)
    )
