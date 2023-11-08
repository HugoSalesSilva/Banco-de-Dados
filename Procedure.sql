--a)Criar uma StoredProcedure para inserir as categorias de produto conforme abaixo:
Create PROCEDURE spIsere_Categoriaproduto
	@nomeCategoriaProduto VARCHAR(20)
AS
	
		INSERT INTO tbCategoriaProduto(nomeCategoriaProduto)
		VALUES
		 (@nomeCategoriaProduto)
		 
		 PRINT ('A categoria '+@nomeCategoriaProduto+' foi cadastrada com sucesso')
	

Exec spIsere_Categoriaproduto 'Bolo Festa'
Exec spIsere_Categoriaproduto 'Bolo Simples'
Exec spIsere_Categoriaproduto 'Torta'
Exec spIsere_Categoriaproduto 'Salgado'
Select * FROM tbCategoriaProduto

--b)Criar  uma  Stored Procedure  para  inserir os  produtos abaixo,  sendo  que,  a  procedure  dever� antes de inserir verificar se o nome do produto j� existe, evitando assim que um produto seja duplicado:
Create PROCEDURE spIsere_produtos
	@nomeProduto VARCHAR(60) ,@precoKiloProduto MONEY , @codCategoriaProduto INT
AS
	IF EXISTS (SELECT nomeProduto from tbProduto WHERE nomeProduto LIKE @nomeProduto)
	BEGIN
		PRINT ('N�o foi cadastrado pois o produto '+@nomeProduto+' j� existe')
	END
	ELSE
	BEGIN
		INSERT INTO tbProduto(nomeProduto, precoKiloProduto, codCategoriaProduto)
		VALUES
		 (@nomeProduto, @precoKiloProduto, @codCategoriaProduto)
		 
		 PRINT ('O produto '+@nomeProduto+' foi cadastrado com sucesso')
	END

Exec spIsere_produtos 'Bolo Floresta Negra', '42.00', 1
Exec spIsere_produtos 'Bolo Prestigio', '43.00', 1
Exec spIsere_produtos 'Bolo Nutella', '44.00', 1
Exec spIsere_produtos 'Bolo Formigueiro', '17.00', 2
Exec spIsere_produtos 'Bolo de cenoura', '19.00', 2
Exec spIsere_produtos 'Torta de palmito', '45.00', 3
Exec spIsere_produtos 'Torta de frango e catupiry', '47.00', 3
Exec spIsere_produtos 'Torta de escarola', '44.00', 3
Exec spIsere_produtos 'Coxinha frango', '25.00', 4
Exec spIsere_produtos 'Esfiha carne', '27.00', 4
Exec spIsere_produtos 'Folhado queijo', '31.00', 4
Exec spIsere_produtos 'Risoles misto', '29.00', 4
Select * FROM tbProduto

--c)Criar uma stored procedure para cadastrar os clientes abaixo relacionados, sendo que dever�o ser feitas duas valida��es:-Verificar pelo CPF se o cliente j� existe. Caso j� existaemitir a mensagem: �Cliente cpf XXXXX j� cadastrado�-Verificar se  o  cliente  �  morador  de  Itaquera  ou  Guaianases,  pois  a  confeitaria  n�o  realiza entregas para clientes que residam fora desses bairros. Caso o cliente n�o seja morador desses bairros enviar a mensagem �N�o foi poss�vel cadastrar o cliente XXXX pois o bairro XXXX n�o � atendido pela confeitaria�
Create PROCEDURE spIsere_Clientes
	@nomeCliente VARCHAR(60) ,@dataNascimentoCliente DATETIME , @ruaCliente VARCHAR(30), @numCasaCliente VARCHAR(10), @cepCliente VARCHAR(15), @bairroCliente VARCHAR(15), @cidadeCliente VARCHAR(15), @estadoCliente CHAR(2), @cpfCliente CHAR(14), @sexoCliente CHAR(1)
AS
	IF EXISTS (SELECT cpfCliente from tbCliente WHERE cpfCliente LIKE @cpfCliente)
	BEGIN
		PRINT ('Cliente cpf '+@cpfCliente+'j� cadastrado')
	END
	Else IF NOT (@bairroCliente LIKE 'Guainases' or @bairroCliente LIKE 'Itaquera')
		PRINT ('N�o foi poss�vel cadastrar o cliente '+@nomeCliente+' pois o bairro '+@bairroCliente+' n�o � atendido pela confeitaria')
	ELSE
	BEGIN
		INSERT INTO tbCliente(nomeCliente, dataNascimentoCliente, ruaCliente, numCasaCliente, cepCliente, bairroCliente, cidadeCliente, estadoCliente, cpfCliente, sexoCliente)
		VALUES
		 (@nomeCliente, @dataNascimentoCliente, @ruaCliente, @numCasaCliente, @cepCliente, @bairroCliente, @cidadeCliente, @estadoCliente, @cpfCliente, @sexoCliente)
		 
		 PRINT ('O cliente '+@nomeCliente+' foi cadastrado com sucesso')

	END

Exec spIsere_Clientes 'Samira Fatah', '05/05/1990', 'Rua Aguape�', '1000', '08.090-000','Guainases','S�O PAULO', 'SP', '83.282.122-0', 'F'
Exec spIsere_Clientes 'Ceila Nogueira', '06/06/1992', 'Rua Andes', '234', '08.456-090','Guainases','S�O PAULO', 'SP', '83.292.122-0', 'F'
Exec spIsere_Clientes 'Paulo Cesar Siqueira', '04/04/1984', 'Rua Castelo do Piau�', '232', '08.109-000','Itaquera','S�O PAULO', 'SP', '84.292.122-0', 'M'
Exec spIsere_Clientes 'Rodrigo Favaroni', '09/04/1991', 'Rua Sans�o Castelo Branco', '10', '08.431-090','Guainases','S�O PAULO', 'SP', '84.292.142-0', 'M'
Exec spIsere_Clientes 'Fl�via Regina Brito', '22/04/1992', 'Rua Mariano Moro', '300', '08.200-123','Itaquera','S�O PAULO', 'SP', '94.292.122-0', 'F'
Exec spIsere_Clientes 'Fl�via Regina Brito', '22/04/1992', 'Rua Mariano Moro', '300', '08.200-123','Itaquera','S�O PAULO', 'SP', '94.212.122-0', 'F'
Select * FROM tbCliente

--d)Criar via stored procedureas encomendas abaixo relacionadas, fazendo as verifica��es abaixo:-No  momento  da  encomenda  o  cliente  ir�  fornecer  o  seu  cpf.  Caso  ele  n�o  tenha  sido cadastrado enviar a mensagem �n�o foi poss�vel efetivar a encomenda pois o cliente xxxx n�o est� cadastrado�-Verificar  se  a  data  de  entrega  daencomenda  n�o anterior  �data  atual.  Caso  seja  enviar  a mensagem �n�o � poss�vel efetuar uma encomenda numa data anterior � data atual�-Caso tudo esteja correto, efetuar a encomenda e emitir a mensagem: �Encomenda XXX para  o cliente YYY efetuada com sucesso� sendo que no lugar de XXX dever� aparecer o n�mero da encomenda e no YYY dever� aparecer o nome do cliente;
CREATE PROCEDURE spInsere_Encomendas

 @cpfCliente CHAR(14), @valorTotalEncomenda SMALLMONEY, @dataEntregaEncomenda DATE, @dataEncomenda DATE
AS
	IF NOT EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
		BEGIN
	PRINT ('N�o foi poss�vel efetivar a encomenda pois o cliente com o CPF: '+@cpfCliente+' n�o est� cadastrado')
		END
	ELSE IF (@dataEntregaEncomenda > GETDATE())
		BEGIN
			PRINT ('n�o � poss�vel efetuar uma encomenda numa data anterior � data atual')
			END
		
	ELSE
		BEGIN
			DECLARE @codCliente INT, @nomeCliente VARCHAR(50)
			SELECT @codCliente=codCliente, @nomeCliente=nomeCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente

			INSERT INTO tbEncomenda (dataEncomenda, codCliente, valorTotalEncomenda, dataEntregaEncomenda) 
			VALUES (@dataEncomenda, @codCliente, @valorTotalEncomenda, @dataEntregaEncomenda)

			DECLARE @codEncomenda INT
			SELECT @codEncomenda = MAX(codEncomenda) FROM tbEncomenda 
			PRINT('Encomenda '+ CONVERT(VARCHAR(6), @codEncomenda) +' para o cliente '+ @nomeCliente +' feita com sucesso')
		END

    EXEC spInsere_Encomendas  '83.282.122-0', 450.00, '15/08/2015', '08/08/2015'
	EXEC spInsere_Encomendas  '83.292.122-0', 200.00, '15/10/2015', '10/10/2015'
	EXEC spInsere_Encomendas  '84.292.122-0', 150.00, '10/12/2015', '10/10/2015'
	EXEC spInsere_Encomendas  '83.282.122-0', 250.00, '12/10/2015', '06/10/2015'
	EXEC spInsere_Encomendas  '84.292.142-0', 150.00, '12/10/2015', '05/10/2015'

	SELECT * FROM tbEncomenda 

--e)Ao adicionar a encomenda, criar uma Storedprocedure, para que sejam inseridos os itens da encomenda conforme tabela a seguir.
Create PROCEDURE spIsere_ItensEncomendas
	@qtdeKilosItensEncomenda DECIMAL, @subTotalItensEncomenda MONEY, @codEncomenda INT, @codProduto INT
AS
		DECLARE @nomeProduto VARCHAR(60) = (SELECT nomeProduto FROM tbProduto WHERE @codProduto = codProduto)
		INSERT INTO tbItensEncomenda(qtdeKilosItensEncomenda, subTotalItensEncomenda, codEncomenda, codProduto)
		VALUES
		 (@qtdeKilosItensEncomenda, @subTotalItensEncomenda, @codEncomenda, @codProduto)
		 
		

		 PRINT ('O produto '+@nomeProduto+' da encomenda numero '+CONVERT (VARCHAR(6), @codEncomenda)+' foi cadastrada com sucesso')
	
EXEC spIsere_ItensEncomendas '2.5', '105.00', 1, 1
EXEC spIsere_ItensEncomendas '2.6', '70.00', 1, 10
EXEC spIsere_ItensEncomendas '6', '150.00', 1, 9
EXEC spIsere_ItensEncomendas '4.3', '125.00', 1, 12
EXEC spIsere_ItensEncomendas '8', '200.00', 2, 9
EXEC spIsere_ItensEncomendas '3.2', '100.00', 3, 11
EXEC spIsere_ItensEncomendas '2', '50.00', 3, 9
EXEC spIsere_ItensEncomendas '3.5', '150.00', 4, 2
EXEC spIsere_ItensEncomendas '2.2', '100.00', 4, 3
EXEC spIsere_ItensEncomendas '3.4', '150.00', 5, 6
Select * From tbItensEncomenda

--f)Ap�s todos os cadastros, criar Storedprocedurespara alterar o que se pede:1-O pre�o dos produtos da categoria �Bolo festa� sofreram um aumento de 10%2-O pre�o dos produtos categoria �Bolo simples� est�o em promo��o e ter�o um desconto de 20%;3-O pre�o dos produtos categoria �Torta� aumentaram 25%4-O pre�odos produtos categoria �Salgado�, com exce��o da esfiha de carne, sofreram um aumento de 20%
Create PROCEDURE spAlterar_Produtos
AS
	Update tbProduto
	Set precoKiloProduto = precoKiloProduto * 1.1
	WHERE codCategoriaProduto = 1

	Update tbProduto
	Set precoKiloProduto = precoKiloProduto * 1.2
	WHERE codCategoriaProduto = 2

	Update tbProduto
	Set precoKiloProduto = precoKiloProduto * 1.25
	WHERE codCategoriaProduto = 3

	Update tbProduto
	Set precoKiloProduto = precoKiloProduto * 1.2 
	WHERE codCategoriaProduto = 4 and  NOT codProduto = 10

EXEC spAlterar_Produtos
Select * From tbProduto

--g)Criar uma procedure para excluir clientes pelo CPF sendo que:1-Caso o cliente possua encomendas emitir a mensagem �Impossivel remover esse cliente pois o cliente XXXXX possui encomendas; onde XXXXX � o nome do cliente.2-Caso o cliente n�o possua encomendas realizar a remo��o e emitir a mensagem �Cliente XXXX removido com sucesso�, onde XXXX � o nome do cliente;
Create PROCEDURE spExcluir_Clientes
@cpfCliente CHAR(14)
AS
	DECLARE @nomeCliente VARCHAR(60) = (SELECT nomeCliente FROM tbCliente WHERE @cpfCliente = cpfCliente)
	DECLARE @codCliente INT = (SELECT codCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
	SELECT @nomeCliente = nomeCliente FROM  tbCliente WHERE  codCliente LIKE @cpfCliente

	IF NOT EXISTS (SELECT codCliente FROM tbEncomenda WHERE codCliente LIKE  @codCliente)
	BEGIN
			DELETE FROM tbCliente
			WHERE cpfCliente LIKE @cpfCliente
			PRINT ('O Cliente '+@nomeCliente+ ' removido com sucesso!')
		END 
		ELSE
		BEGIN
			PRINT('N�o foi possivel remover o cliente '+@nomeCliente+ ', pois o cliente possui encomendas a serem realizadas')
		END
EXEC spExcluir_Clientes '83.282.122-0'
Select * FROM tbCliente
Select * FROM tbEncomenda

--h)Criar  uma  procedure  que  permita excluirqualquer  item de  uma  encomenda  cuja  data  de entrega seja menor que a data atual. Para tal o cliente dever� fornecer o c�digo da encomenda e o c�digo do produto que ser� exclu�do da encomenda. A procedure dever� remover o item e atualizar  o  valor  total  da  encomenda,  do  qual  dever�  ser  subtra�do  o  valor  do  item  a  ser removido. A procedure poder� remover apenas um item da encomenda de cada vez.
Create PROCEDURE spExcluir_Itens
@codEncomenda INT, @codProduto INT
AS
	DECLARE @nomeProduto VARCHAR(60) = (SELECT nomeProduto FROM tbProduto WHERE @codProduto = codProduto)

	DECLARE @precoProduto SMALLMONEY = (SELECT subTotalItensEncomenda FROM tbItensEncomenda WHERE codProduto = @codProduto)
	DECLARE @dataEntregaEncomenda SMALLDATETIME = (SELECT dataEntregaEncomenda FROM tbEncomenda WHERE codEncomenda = @codEncomenda)
	IF (@dataEntregaEncomenda < GETDATE())
		BEGIN
			DELETE FROM tbItensEncomenda
			WHERE codEncomenda = @codEncomenda AND codProduto = @codProduto
			PRINT ('produto '+@nomeProduto+' foi removido com sucesso')

			UPDATE tbEncomenda
			SET valortotalEncomenda = valortotalEncomenda - @precoProduto
			WHERE codEncomenda LIKE @codEncomenda 
		END

		EXEC spExcluir_Itens '4', '2'
		Select * FROM tbItensEncomenda