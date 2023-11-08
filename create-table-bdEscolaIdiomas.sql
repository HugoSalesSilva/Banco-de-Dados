CREATE DATABASE bdEscolaIdiomas

USE bdEscolaIdiomas

CREATE TABLE tbCurso(

	codCurso INT PRIMARY KEY IDENTITY(1,1)
	, nomeCurso VARCHAR (50) NOT NULL
	, cargahorarioCurso INT NOT NULL
	, valorCurso SMALLMONEY NOT NULL

)

CREATE TABLE tbAluno(

	codAluno INT PRIMARY KEY IDENTITY(1,1)
	, nomeAluno VARCHAR (50) NOT NULL
	, dataNacAluno SMALLDATETIME NOT NULL
	, rgAluno VARCHAR (15) NOT NULL
	, naturalidadeAluno VARCHAR (5) NOT NULL

)

CREATE TABLE tbTurma(

	codTurma INT PRIMARY KEY IDENTITY(1,1)
	, nomeTurma VARCHAR (50) NOT NULL
	, codCurso INT FOREIGN KEY REFERENCES tbCurso(codCurso)
	, horarioTurma SMALLDATETIME NOT NULL

)


CREATE TABLE tbMatricula(
	
	codMatricula INT PRIMARY KEY IDENTITY(1,1)
	, dataMatricula SMALLDATETIME NOT NULL
	, codAluno INT FOREIGN KEY REFERENCES tbAluno(codAluno)
	, codTurma INT FOREIGN KEY REFERENCES tbTurma(codTurma)
)
