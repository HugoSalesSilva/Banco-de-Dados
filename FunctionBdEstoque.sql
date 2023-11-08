--Criar uma função que retorne o dia de semana da venda (no formato segunda,terça, etc) ao lado do código da venda, valor total da venda e sua data
create function fc_diaSemanaVenda (@Data date)
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

select codVenda,valorTotalVenda,dataVenda as 'Data da Venda',
DiaDaSemana=dbo.fc_diaSemanaVenda(dataVenda)
from tbVenda

--Criar uma função que receba o código do cliente e retorne o total de vendas que o cliente já realizou
create function fc_total (@Cliente int)
	returns int as
begin
Declare @Total int


set @Total =(select count(codVenda) From tbVenda Where codCliente = @Cliente)

RETURN @Total
END

select codCliente ,
Total=dbo.fc_total(codCliente)
from tbCliente

--Criar uma função que receba o código de um vendedor e o mês e informe o total de vendas do vendedor no mês informado
create function fc_mesTotal (@codVendedor INT, @mes INT)
	RETURNS INT
AS
	BEGIN
		DECLARE @total INT = (SELECT COUNT(codVenda) FROM tbVenda
						WHERE codVendedor = @codVendedor AND MONTH(dataVenda) = @mes)
		RETURN @total
	END

SELECT nomeVendedor, 'Total de vendas'=dbo.fc_mesTotal(codVendedor, 2) FROM tbVendedor

--Criar uma função que usando o bdEstoque diga se o cpf do cliente é ou não válido

select cpfCliente,Validação=dbo.CPF_VALIDO(cpfCliente) from tbCliente

create Function CPF_VALIDO(@CPF VARCHAR(11))
Returns char(1)
AS
Begin
	declare @INDICE INT,
	@soma INT,
	@Digito1 INT,
	@Digito2 INT,
	@CPF_TEMP VARCHAR(11),
	@DIGITOS_IGUAIS CHAR(1),
	@RESULTADO CHAR(1)

	set @RESULTADO = 'N'
	Set @CPF_TEMP=SUBSTRING(@CPF,1,1)
	set @INDICE=1
	set @DIGITOS_IGUAIS='S'

	while(@INDICE<=11)
	begin
		if SUBSTRING(@CPF,@INDICE,1)<>@CPF_TEMP
		 set @DIGITOS_IGUAIS='N'
		 set @INDICE=@INDICE + 1
	END;

	if @DIGITOS_IGUAIS='N'
	begin
		set @soma = 0
		set @INDICE = 1
		while(@INDICE<=9)
		begin
			set @soma = @soma + CONVERT(INT,SUBSTRING(@CPF,@INDICE,1))*(11-@INDICE);
			set @INDICE=@INDICE + 1
		End

		set @Digito1=11-(@soma%11)

		if @Digito1>9
			set @Digito1=0;

		set @soma = 0
		set @INDICE = 1
		while(@INDICE<=10)
		begin
			set @soma= @soma + CONVERT(INT,SUBSTRING(@CPF,@INDICE,1))*(12-@INDICE);
			set @INDICE = @INDICE + 1
		END

		set @Digito2=11 - (@soma%11)

		if @Digito2>9
			set @Digito2=0;

		if (@Digito1=SUBSTRING(@CPF,LEN(@CPF)-1,1)) and (@Digito2 = SUBSTRING(@CPF,LEN(@CPF),1))
			set @RESULTADO='S'
		else
			set @RESULTADO='N'
			end
		return @RESULTADO
		end