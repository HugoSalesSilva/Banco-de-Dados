--Criar 2 triggers que: a-Ao ser feito um depósito atualize o saldo da conta corrente somando a quantia depositada
CREATE TRIGGER tgAtualizarSaldo ON tbDeposito FOR INSERT AS

	Declare @saldoConta Money
	Select @saldoConta = saldoConta from tbContaCorrente
	Declare @valorDeposito MONEY
	Select @valorDeposito = valorDeposito from tbDeposito
	Declare @numConta INT
	Select @numConta = numConta from tbDeposito


	UPDATE tbContaCorrente
	SET saldoConta = saldoConta + @valorDeposito
	WHERE numConta = @numConta


Insert tbCliente(nomeCliente,cpfCliente)
Values ('Hugo Sales', '572.196.150-35')

Select * FROM tbCliente

Insert tbContaCorrente(saldoConta,codCliente)
Values (200, 1)

Select * FROM tbContaCorrente

Insert tbDeposito(valorDeposito,numConta,dataDeposito,horaDeposito)
Values (200, 1, '06/02/2020 15:00:00', '15:00')


SELECT codDeposito,valorDeposito,numConta, convert(varchar(12), dataDeposito, 103 ) AS 'Data Deposito', convert(varchar(12), horaDeposito, 108 ) AS 'Hora Deposito'FROM tbDeposito
Select * FROM tbContaCorrente
Select * FROM tbCliente
--b-Ao ser feito um saque atualize o saldo da conta corrente descontando o valor caso tenha saldo suficiente

Create TRIGGER tgAtualizaSque on tbSaque INSTEAD OF INSERT
AS
	declare @valorSaque Money
	SELECT @valorSaque=valorSaque FROM inserted
	declare @numConta INT
	SELECT @numConta=numConta FROM inserted
	declare @dataSaque DateTime
	SELECT @dataSaque = dataSaque FROM inserted
	declare @codSaque INT
	SELECT @codSaque=codSaque FROM inserted
	Declare @horaSaque DateTime
	SELECT @horaSaque=horaSaque FROM inserted
	
	Declare @saldoConta Money
	Select @saldoConta = saldoConta from tbContaCorrente
	
	IF (@valorSaque > @saldoConta)
		BEGIN
			PRINT ('Não há saldo o suficiente')
		END
	ELSE
	BEGIN
	INSERT tbSaque(valorSaque, numConta, dataSaque, horaSaque)
				VALUES (@valorSaque, @numConta, @dataSaque,@horaSaque)
				UPDATE tbContaCorrente
					SET saldoConta = saldoConta - @valorSaque
					WHERE numConta = @numConta 
				
		END
	
Insert tbSaque(valorSaque, numConta, dataSaque, horaSaque)
		VALUES (200, 1, '08/01/2024 20:00:00', '08/01/2024 20:00')

SELECT codSaque,valorSaque,numConta, convert(varchar(12), dataSaque, 103 ) AS 'Data Saque', convert(varchar(12), horaSaque, 108 ) AS 'Hora Saque'FROM tbSaque

Select * From tbContaCorrente