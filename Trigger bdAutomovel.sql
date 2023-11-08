--1-Criar umtrigger que ao veículo tomar uma multa os pontosda multa sejam  atualizados na tabela do motorista no campo pontuacaoAcumulada. Caso o motorista alcance 20 pontos informar via mensagem que o mesmo poderá ter sua habilitação suspensa.
Create TRIGGER tgSuspensao ON tbMultas FOR INSERT AS
BEGIN
	DECLARE @pontosMulta SMALLINT
	SELECT @pontosMulta = pontosMultas FROM inserted
	DECLARE @idVeiculo INT
	select @idVeiculo = idVeiculo From inserted
	DECLARE @idMotorista INT
	SELECT @idMotorista = idMotorista FROM tbVeiculo WHere idVeiculo Like @idVeiculo
	DECLARE @pontuacaoAcumulada SMALLINT
	SELECT @pontuacaoAcumulada = pontuacaoAcumulada FROM tbMotorista
	UPDATE tbMotorista
			SET pontuacaoAcumulada = pontuacaoAcumulada + @pontosMulta
			WHERE idMotorista = @idMotorista
	SELECT @pontuacaoAcumulada = pontuacaoAcumulada FROM tbMotorista
	IF (@pontuacaoAcumulada > 19 )
		BEGIN
			PRINT ('O motorista pode ter sua habilitação suspensa')
			

		END

	End
	
	

	INSERT tbMotorista(nomeMotorista, dataNascimento, cpfMotorista, CNHMotorista,pontuacaoAcumulada)
VALUES ('Hugo Sales', 06/01/2006, '082.051.040-85','12520849680', 2)





Insert tbVeiculo(modeloVeiculo,placaVeiculo,renavamVeiculo,anoVeiculo,idMotorista)
Values ('Subaru','FXK9156','25501238285','2000',1)



Insert tbMultas(dataMultas,horaMultas,pontosMultas,idVeiculo)
Values ('20/02/2022' , '14:00',  20, 1)
SELECT idMultas, convert(varchar(12), dataMultas, 103 ) AS 'Data Multas', convert(varchar(12), horaMultas, 108 ) AS 'Hora Multas', pontosMultas, idVeiculo FROM tbMultas
Select * From tbMotorista
Select * From tbVeiculo
