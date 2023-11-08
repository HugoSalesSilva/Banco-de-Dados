--1.Crie uma função que informada uma data da matrícula , retorne o dia da semana.
create function fc_diaSemana (@Data date)
	returns varchar (40) as
begin
Declare @DiaSemana varchar(40)
Declare @Dia int
set @Dia= DatePart(dw,@Data)
if
@Dia=1
begin
set @DiaSemana ='DOMINGO'
end
if
@Dia=2
begin
Set @DiaSemana ='SEGUNDA FEIRA'
end
if
@Dia=3
begin
set @DiaSemana ='TERÇA FEIRA'
end
if
@Dia=4
Set @DiaSemana ='QUARTA FEIRA'
if
@Dia=5
begin
set @DiaSemana ='QUINTA FEIRA'
end
if
@Dia=6
begin
set @DiaSemana ='SEXTA FEIRA'
end
if
@Dia=7
begin
set @DiaSemana ='SÁBADO'
end
RETURN @DiaSemana
END

select datamatricula as 'Data da matricula',
DiaDaSemana=dbo.fc_diaSemana(dataMatricula)
from tbMatricula

--2.Crie uma função que de acordo com a carga horária do curso exiba curso rápido ou curso extenso. (Rápido menos de 1000 horas).
create function fc_cargaHoraria (@Carga INT)
	returns varchar (40) as
begin
Declare @cargaHoraria varchar(40)


if
@Carga < 1000
begin
set @cargaHoraria ='Rapido'
end
if
@Carga >= 1000
begin
Set @cargaHoraria ='Extenso'
end

RETURN @cargaHoraria
END

select cargahorarioCurso as 'Carga Horaria',
cargaHoraria=dbo.fc_cargaHoraria(cargahorarioCurso)
from tbCurso

--3.Crie uma função que de acordo com o valor do curso exiba curso caro ou curso barato. (Curso caro acima de 400).
create function fc_valorCurso (@Valor SMALLMONEY)
	returns varchar (40) as
begin
Declare @valorCurso varchar(40)


if
@Valor <= 400
begin
set @valorCurso ='Barato'
end
if
@Valor > 400
begin
Set @valorCurso ='Caro'
end

RETURN @valorCurso
END

select valorCurso as 'Valor Curso',
ValorCurso=dbo.fc_valorCurso(valorCurso)
from tbCurso

--4.Criar uma função que informada a data da matrícula converta a no formato dd/mm/aaaa.
create function fc_formato (@Data Datetime)
	returns varchar (12) as
begin
Declare @Formato varchar(12)


set @Formato =  convert(varchar(12),Format(@data, 'dd/MM/yyyy'))

RETURN @Formato
END

select
Data=dbo.fc_formato(dataMatricula)
from tbMatricula