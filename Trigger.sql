Create TRIGGER tgAtualizaVenda on tbItensVenda INSTEAD OF INSERT
AS
	declare @codProduto INT
	SELECT @codProduto=codProduto FROM inserted
	declare @quantidadeItensVenda SMALLINT
	SELECT @quantidadeItensVenda=quantidadeItensVenda FROM inserted
	declare @quantidadeProduto INT
	SELECT @quantidadeProduto=quantidadeProduto FROM tbProduto where codProduto LIKE @codProduto
	declare @codVenda INT
	SELECT @codVenda=codVenda FROM inserted
	Declare @subTotalItensVenda SMALLMONEY
	SELECT @subTotalItensVenda=subTotalItensVenda FROM inserted
	declare @dataVenda SMALLDATETIME
	Select @dataVenda = dataVenda from tbVenda where codVenda LIKE @codVenda
	declare @dataSaidaProduto SMALLDATETIME
	Select @dataSaidaProduto = dataSaidaProduto from tbSaidaProduto
	set @dataSaidaProduto = @dataVenda
	
	IF (@quantidadeItensVenda > @quantidadeProduto)
		BEGIN
			PRINT ('Não Ha produtos o suficiente')
		END
	ELSE
	BEGIN
	INSERT tbItensVenda (codVenda, codProduto, quantidadeItensVenda, subTotalItensVenda)
				VALUES (@codVenda, @codProduto, @quantidadeItensVenda,@subTotalItensVenda)
				Update tbProduto
				set quantidadeProduto = quantidadeProduto - @quantidadeItensVenda 
				where codProduto = @codProduto
				Insert tbSaidaProduto(dataSaidaProduto,codProduto,quantidadeSaidaProduto)
				Values (@dataSaidaProduto, @codProduto, @quantidadeItensVenda)
		END
	
	

INSERT tbItensVenda(codVenda, codProduto, quantidadeItensVenda, subTotalItensVenda)
VALUES (1, 1, 0,1500)

INSERT tbItensVenda(codVenda, codProduto, quantidadeItensVenda, subTotalItensVenda)
VALUES (1, 3, 100,3000)

INSERT tbItensVenda(codVenda, codProduto, quantidadeItensVenda, subTotalItensVenda)
VALUES (1, 2, 0, 3000)

Select * From tbItensVenda
Select * From tbProduto
Select * From tbSaidaProduto
Create TRIGGER tgAtualizaQuantidade on tbEntradaProduto for INSERT
AS
	declare @codProduto INT
	SELECT @codProduto=codProduto FROM inserted
	declare @quantidadeEntradaProduto SMALLINT
	SELECT @quantidadeEntradaProduto=quantidadeEntradaProduto FROM inserted
	Update tbProduto
	set quantidadeProduto = quantidadeProduto + @quantidadeEntradaProduto 
	where codProduto = @codProduto

	INSERT tbEntradaProduto(dataEntradaProduto,codProduto ,quantidadeEntradaProduto)
VALUES ('16/05/2022', 1, '300')

Select * From tbEntradaProduto
Select * From tbProduto


