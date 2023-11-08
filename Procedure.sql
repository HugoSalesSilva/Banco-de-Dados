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

--b)Criar  uma  Stored Procedure  para  inserir os  produtos abaixo,  sendo  que,  a  procedure  deverá antes de inserir verificar se o nome do produto já existe, evitando assim que um produto seja duplicado:
Create PROCEDURE spIsere_produtos
	@nomeProduto VARCHAR(60) ,@precoKiloProduto MONEY , @codCategoriaProduto INT
AS
	IF EXISTS (SELECT nomeProduto from tbProduto WHERE nomeProduto LIKE @nomeProduto)
	BEGIN
		PRINT ('Não foi cadastrado pois o produto '+@nomeProduto+' já existe')
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

--c)Criar uma stored procedure para cadastrar os clientes abaixo relacionados, sendo que deverão ser feitas duas validações:-Verificar pelo CPF se o cliente já existe. Caso já existaemitir a mensagem: “Cliente cpf XXXXX já cadastrado”-Verificar se  o  cliente  é  morador  de  Itaquera  ou  Guaianases,  pois  a  confeitaria  não  realiza entregas para clientes que residam fora desses bairros. Caso o cliente não seja morador desses bairros enviar a mensagem “Não foi possível cadastrar o cliente XXXX pois o bairro XXXX não é atendido pela confeitaria”
Create PROCEDURE spIsere_Clientes
	@nomeCliente VARCHAR(60) ,@dataNascimentoCliente DATETIME , @ruaCliente VARCHAR(30), @numCasaCliente VARCHAR(10), @cepCliente VARCHAR(15), @bairroCliente VARCHAR(15), @cidadeCliente VARCHAR(15), @estadoCliente CHAR(2), @cpfCliente CHAR(14), @sexoCliente CHAR(1)
AS
	IF EXISTS (SELECT cpfCliente from tbCliente WHERE cpfCliente LIKE @cpfCliente)
	BEGIN
		PRINT ('Cliente cpf '+@cpfCliente+'já cadastrado')
	END
	Else IF NOT (@bairroCliente LIKE 'Guainases' or @bairroCliente LIKE 'Itaquera')
		PRINT ('Não foi possível cadastrar o cliente '+@nomeCliente+' pois o bairro '+@bairroCliente+' não é atendido pela confeitaria')
	ELSE
	BEGIN
		INSERT INTO tbCliente(nomeCliente, dataNascimentoCliente, ruaCliente, numCasaCliente, cepCliente, bairroCliente, cidadeCliente, estadoCliente, cpfCliente, sexoCliente)
		VALUES
		 (@nomeCliente, @dataNascimentoCliente, @ruaCliente, @numCasaCliente, @cepCliente, @bairroCliente, @cidadeCliente, @estadoCliente, @cpfCliente, @sexoCliente)
		 
		 PRINT ('O cliente '+@nomeCliente+' foi cadastrado com sucesso')

	END

Exec spIsere_Clientes 'Samira Fatah', '05/05/1990', 'Rua Aguapeí', '1000', '08.090-000','Guainases','SÂO PAULO', 'SP', '83.282.122-0', 'F'
Exec spIsere_Clientes 'Ceila Nogueira', '06/06/1992', 'Rua Andes', '234', '08.456-090','Guainases','SÂO PAULO', 'SP', '83.292.122-0', 'F'
Exec spIsere_Clientes 'Paulo Cesar Siqueira', '04/04/1984', 'Rua Castelo do Piauí', '232', '08.109-000','Itaquera','SÂO PAULO', 'SP', '84.292.122-0', 'M'
Exec spIsere_Clientes 'Rodrigo Favaroni', '09/04/1991', 'Rua Sansão Castelo Branco', '10', '08.431-090','Guainases','SÂO PAULO', 'SP', '84.292.142-0', 'M'
Exec spIsere_Clientes 'Flávia Regina Brito', '22/04/1992', 'Rua Mariano Moro', '300', '08.200-123','Itaquera','SÂO PAULO', 'SP', '94.292.122-0', 'F'
Exec spIsere_Clientes 'Flávia Regina Brito', '22/04/1992', 'Rua Mariano Moro', '300', '08.200-123','Itaquera','SÂO PAULO', 'SP', '94.212.122-0', 'F'
Select * FROM tbCliente

--d)Criar via stored procedureas encomendas abaixo relacionadas, fazendo as verificações abaixo:-No  momento  da  encomenda  o  cliente  irá  fornecer  o  seu  cpf.  Caso  ele  não  tenha  sido cadastrado enviar a mensagem “não foi possível efetivar a encomenda pois o cliente xxxx não está cadastrado”-Verificar  se  a  data  de  entrega  daencomenda  não anterior  àdata  atual.  Caso  seja  enviar  a mensagem “não é possível efetuar uma encomenda numa data anterior à data atual”-Caso tudo esteja correto, efetuar a encomenda e emitir a mensagem: “Encomenda XXX para  o cliente YYY efetuada com sucesso” sendo que no lugar de XXX deverá aparecer o número da encomenda e no YYY deverá aparecer o nome do cliente;
CREATE PROCEDURE spInsere_Encomendas

 @cpfCliente CHAR(14), @valorTotalEncomenda SMALLMONEY, @dataEntregaEncomenda DATE, @dataEncomenda DATE
AS
	IF NOT EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
		BEGIN
	PRINT ('Não foi possível efetivar a encomenda pois o cliente com o CPF: '+@cpfCliente+' não está cadastrado')
		END
	ELSE IF (@dataEntregaEncomenda > GETDATE())
		BEGIN
			PRINT ('não é possível efetuar uma encomenda numa data anterior à data atual')
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

--f)Após todos os cadastros, criar Storedprocedurespara alterar o que se pede:1-O preço dos produtos da categoria “Bolo festa” sofreram um aumento de 10%2-O preço dos produtos categoria “Bolo simples” estão em promoção e terão um desconto de 20%;3-O preço dos produtos categoria “Torta” aumentaram 25%4-O preçodos produtos categoria “Salgado”, com exceção da esfiha de carne, sofreram um aumento de 20%
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

--g)Criar uma procedure para excluir clientes pelo CPF sendo que:1-Caso o cliente possua encomendas emitir a mensagem “Impossivel remover esse cliente pois o cliente XXXXX possui encomendas; onde XXXXX é o nome do cliente.2-Caso o cliente não possua encomendas realizar a remoção e emitir a mensagem “Cliente XXXX removido com sucesso”, onde XXXX é o nome do cliente;
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
			PRINT('Não foi possivel remover o cliente '+@nomeCliente+ ', pois o cliente possui encomendas a serem realizadas')
		END
EXEC spExcluir_Clientes '83.282.122-0'
Select * FROM tbCliente
Select * FROM tbEncomenda

--h)Criar  uma  procedure  que  permita excluirqualquer  item de  uma  encomenda  cuja  data  de entrega seja menor que a data atual. Para tal o cliente deverá fornecer o código da encomenda e o código do produto que será excluído da encomenda. A procedure deverá remover o item e atualizar  o  valor  total  da  encomenda,  do  qual  deverá  ser  subtraído  o  valor  do  item  a  ser removido. A procedure poderá remover apenas um item da encomenda de cada vez.
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