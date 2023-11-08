USE bdLocadoraVeiculo
--c)  Criar uma stored procedure que receba o cpf do cliente, a placa do veiculoe a data de devolução do mesmo e insira uma nova locação, calculando automaticamente: -a data da locação será a data do dia corrente no formato dd/mm/aaaa -o número de diárias (int) que o veiculo ficarálocadodeverá ser calculada automaticamente. Para tal, usar a função DATEDIFF(day, @date1, @date2) onde @date1 será a data da locação e @date2 a data de devolução do veiculo) A função datediff retornará um inteiro com a diferença de dias, meses ou anos colocados como parâmetro da função (day, month ou year) -o valor total da locação deverá ser calculado multiplicando-se o número de diárias pelo valor da categoria do veículo
Create PROCEDURE spLocacaoVeiculo
@cpfCliente VARCHAR(14),@placaVeiculo VARCHAR(7),@dataDevolucao DATE
AS
 declare @dataLocacao DATE
 SELECT @dataLocacao=dataLocacao FROM tbLocacao WHERE dataDevolucao LIKE @dataDevolucao
	
	Set @dataLocacao=GETDATE()


	
	Declare @modeloVeiculo VARCHAR(60)
	SELECT @modeloVeiculo=modeloVeiculo FROM tbVeiculo Where placaVeiculo LIKE @placaVeiculo
	Declare @nomeCliente VARCHAR(60)
	SELECT @nomeCliente=nomeCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente
	declare @numeroDiarias Int
	SELECT @numeroDiarias=numeroDiarias FROM tbLocacao
	set @numeroDiarias = DATEDIFF(day, @dataLocacao, @dataDevolucao) 

	declare @valorTotal money
	SELECT @valorTotal=valorTotal FROM tbLocacao
	Declare @idVeiculo INT = (Select idVeiculo from tbVeiculo where placaVeiculo Like @placaVeiculo)
	DECLARE @idCliente INT = (SELECT idCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
	declare @idCategoriaVeiculo INT = (Select idCategoriaVeiculo from tbVeiculo where idVeiculo Like @idVeiculo)
	declare @valorDiariaCategoria money
	SELECT @valorDiariaCategoria=valorDiariaCategoria FROM tbCategoriaVeiculo where idCategoriaVeiculo Like @idCategoriaVeiculo
	set @valorTotal= @numeroDiarias * @valorDiariaCategoria
	
	IF NOT EXISTS (select cpfCliente From tbCliente where cpfCliente LIKE @cpfCliente)
	Begin
		PRINT ('Não foi possível cadastra a locação pois o cliente com o cpf '+@cpfCliente+' não está cadastrado')
	End
	Else
	Begin
		Insert Into tbLocacao(dataLocacao ,dataDevolucao,numeroDiarias,valorTotal,idCliente ,idVeiculo)
		VALUES
			 (@dataLocacao, @dataDevolucao, @numeroDiarias, @valorTotal, @idCliente, @idVeiculo)
		 
			PRINT ('O cliente '+ @nomeCliente +' com o Carro '+@modeloVeiculo+' foi cadastrado com sucesso')
		 
			SELECT idLocacao, convert(varchar(12), dataLocacao, 103 ) AS 'Data Locação', convert(varchar(12), dataDevolucao, 103 ) AS 'Data Devolução', numeroDiarias, valorTotal , idCliente , idVeiculo FROM tbLocacao
	End

--d) Após criar a stored procedure, inserir as locações via exec conforme abaixo:
---O cliente Érico alugou uma Hilux até o dia 10/10/2022
Exec spLocacaoVeiculo '12243322222','TRE1224', '10/10/2022'
--A cliente Vanessa alugou um Creta até dia 05/11/2022
Exec spLocacaoVeiculo '12345678900','VCF3333', '05/11/2022'
--A cliente Rosangela alugou uma HRV até dia 12/06/2023
Exec spLocacaoVeiculo '98309933399','ABC1234', '12/06/2023'
--O cliente Erico alugou um ford Ka até o dia 15/12/2022
Exec spLocacaoVeiculo '12243322222','RED3544', '15/12/2022'
--A cliente Vanessa alugou o HB20 S até o dia 20/12/2022
Exec spLocacaoVeiculo '12345678900','WSA3220', '20/12/2022'
--A cliente Rosangela alugou um Ford Ka até31/12/2022
Exec spLocacaoVeiculo '98309933399','RED3544', '31/12/2022'

Select * From tbLocacao

--e) Obter as consultas abaixo:  
--1-Apresentar o nome do cliente ao lado das placas dos veículos que eles locaram 		 
SELECT nomeCliente, placaVeiculo FROM tbCliente
Inner JOIN tbLocacao
ON tbLocacao.idCliente = tbCliente.idCliente
Inner JOIN tbVeiculo
ON tbVeiculo.idVeiculo = tbLocacao.idVeiculo

--2-Apresentar a quantidade de locações por nome do fabricante 
SELECT COUNT(idLocacao) AS 'Quantidade de Locações', nomeFabricante FROM tbFabricante
INNER JOIN tbVeiculo
ON tbVeiculo.idFabricante = tbFabricante.idFabricante
INNER JOIN tbLocacao
ON tbLocacao.idVeiculo = tbVeiculo.idVeiculo
GROUP BY nomeFabricante

--3-Apresentar a quantidade de veículos cuja procedência seja de SP 
SELECT COUNT(idVeiculo) AS 'Quantidade de Veiculos', origemVeiculo FROM tbVeiculo
Where origemVeiculo = 'SP'
Group by origemVeiculo

--4-Apresentar a quantidade de veículos por nome do fabricante 
SELECT COUNT(idVeiculo) AS 'Quantidade de Veiculos', nomeFabricante FROM tbFabricante
INNER JOIN tbVeiculo
ON tbVeiculo.idFabricante = tbFabricante.idFabricante
Group by nomeFabricante

--5-Apresentar a média de preço da diária por nome do fabricante 
SELECT AVG(valorDiariaCategoria) AS 'Media de preço da diária', nomeFabricante FROM tbFabricante
INNER JOIN tbVeiculo
ON tbFabricante.idFabricante = tbVeiculo.idFabricante
INNER JOIN tbCategoriaVeiculo
ON tbVeiculo.idCategoriaVeiculo = tbCategoriaVeiculo.idCategoriaVeiculo
Group by nomeFabricante

--6-Apresentar a quantidade de locações por nome do fabricante 
SELECT COUNT(idLocacao) AS 'Quantidade de Locações', nomeFabricante FROM tbFabricante
INNER JOIN tbVeiculo
ON tbVeiculo.idFabricante = tbFabricante.idFabricante
INNER JOIN tbLocacao
ON tbLocacao.idVeiculo = tbVeiculo.idVeiculo
GROUP BY nomeFabricante

--7-Apresentar a quantidade de locações por nome do cliente 
SELECT COUNT(idLocacao) AS 'Quantidade de Locações', nomeCliente FROM tbCliente
Inner JOIN tbLocacao
ON tbLocacao.idCliente = tbCliente.idCliente
GROUP BY nomeCliente

--8-Apresentar o nome do cliente que teve a locação mais cara
Select valorTotal AS 'locação mais cara', nomeCliente FROM tbCliente
Inner JOIN tbLocacao
ON tbLocacao.idCliente = tbCliente.idCliente
WHERE valorTotal = (SELECT MAX(valorTotal) From tbLocacao)
GROUP BY nomeCliente, valorTotal

--9-Apresentar as placas e modelos dos veículos que não foram locados 
SELECT placaVeiculo, modeloVeiculo FROM tbVeiculo
Full JOIN tbLocacao
ON tbLocacao.idVeiculo = tbVeiculo.idVeiculo
Where idLocacao is Null
GROUP BY placaVeiculo, modeloVeiculo

--10-Apresentar a quantidade de veículos locados por procedência
SELECT COUNT(idVeiculo) AS 'Quantidade de veículos', origemVeiculo FROM tbVeiculo
GROUP BY origemVeiculo

--11-Apresentar os nomes dos clientes que ainda não fizeram locações 
SELECT nomeCliente FROM tbCliente
Full JOIN tbLocacao
ON tbLocacao.idCliente = tbCliente.idCliente
Where idLocacao is Null
GROUP BY nomeCliente

--12-Apresentar a média da quilometragem dos veículos
SELECT AVG(kmVeiculo) AS 'Media da quilometragem dos veículos', modeloVeiculo FROM tbVeiculo
Group by modeloVeiculo

--13-Apresentar a média da quilometragem dos veículos por fabricante 
SELECT AVG(kmVeiculo) AS 'Media da quilometragem dos veículos',nomeFabricante FROM tbFabricante
INNER JOIN tbVeiculo
ON tbVeiculo.idFabricante = tbFabricante.idFabricante
Group by nomeFabricante

--14-Apresentar o modelo dos veículos ao lado da descrição do tipo de combustível 
SELECT modeloVeiculo, descricaoCategoriaVeiculo FROM tbVeiculo
Full JOIN tbCategoriaVeiculo
ON tbVeiculo.idCategoriaVeiculo = tbCategoriaVeiculo.idCategoriaVeiculo
GROUP BY modeloVeiculo, descricaoCategoriaVeiculo

--15-Apresentar os nomes dos tipos de combustível para os quais não foram cadastrados quaisquer veículo
Select descricaoCategoriaVeiculo From tbVeiculo
Full JOIN tbCategoriaVeiculo
ON tbVeiculo.idCategoriaVeiculo = tbCategoriaVeiculo.idCategoriaVeiculo
Where idVeiculo is Null
GROUP BY descricaoCategoriaVeiculo

--16-Apresentar a placa do veículo que possui a quilometragem mais baixa
Select kmVeiculo AS 'quilometragem mais baixa', placaVeiculo FROM tbVeiculo
WHERE kmVeiculo = (SELECT MIN(kmVeiculo) From tbVeiculo)
GROUP BY placaVeiculo, kmVeiculo

--17-Apresentar o nome e a idade do motorista mais velho
Select nomeCliente, idade AS 'motorista mais velho' FROM tbCliente
WHERE idade = (SELECT MAX(idade) From tbCliente)
GROUP BY nomeCliente, idade

--18-Apresentar o nome do cliente que fez a locação mais cara
Select valorTotal AS 'locação mais cara', nomeCliente FROM tbCliente
Inner JOIN tbLocacao
ON tbLocacao.idCliente = tbCliente.idCliente
WHERE valorTotal = (SELECT MAX(valorTotal) From tbLocacao)
GROUP BY nomeCliente, valorTotal 

--19-Apresentar a somatória da km dos veículos que não são de SP
Select SUM(kmVeiculo) AS 'km Veiculos', origemVeiculo From tbVeiculo
Where not origemVeiculo LIKE 'SP'
GROUP BY origemVeiculo

--20-Apresentar apenas os nomes dos fabricantes cujo CNPJ termine com 2
Select nomeFabricante , cnpjFabricante FROM tbFabricante
WHERE cnpjFabricante LIKE '%2'
Group by nomeFabricante, cnpjFabricante