USE bdLocadoraVeiculo
--b) Inserir os dados conforme abaixo:
INSERT tbCategoriaVeiculo(descricaoCategoriaVeiculo ,valorDiariaCategoria)
VALUES ('Passeio Simples', '200')
		, ('Passeio Intermediario', '300')
		, ('Utilitario Peq', '300')
		, ('Utilitario Gran', '700')
		, ('SUV', '700')

INSERT tbFabricante(nomeFabricante, cnpjFabricante)
VALUES ('Ford', '89434343000121')
		, ('GM', '33873233000122')
		, ('Honda', '73222323000192')
		, ('Hyandai', '83222323000109')
		, ('Toyota', '23234983000199')

INSERT tbTipoCombustivel (descricaoTipoCombustivel)
VALUES ('Alcool')
		, ('Diesel')
		, ('Gasolina')
		, ('GNV')
		, ('Flex')
		

INSERT tbCliente (nomeCliente, dataNascCliente, cpfCliente, idade)
VALUES ('Vanessa Ferraz', '18/11/1984' , '12345678900', '35')
	, ('Rosangela Freire', '03/06/1984' , '98309933399', '36')
	, ('Erico Veriscimo', '16/04/1990' , '12243322222', '29')
	, ('Junior Santos', '14/07/1985' , '33322255593', '35')

INSERT tbVeiculo (modeloVeiculo, placaVeiculo,origemVeiculo,idFabricante, idTipoCombustivel, idCategoriaVeiculo, kmVeiculo)
Values ('HRV', 'ABC1234', 'SP', 3, 5, 5, '10000')
	, ('Prisma LTZ', 'FGR1222', 'SP', 2, 5, 1, '5000')
	, ('Hilux', 'TRE1224', 'SP', 5, 2, 4, '1800')
	, ('HB20 S', 'WSA3220', 'RJ', 4, 5, 2, '2000')
	, ('Ford Ka', 'RED3544', 'RJ', 1, 5, 1, '12300')
	, ('Ford Edge', 'TPO9000', 'SP', 1, 2, 4, '1500')
	, ('Creta', 'VCF3333', 'RJ', 4, 5, 2, '2000')
	, ('Onix', 'BSE5444', 'SP', 2, 5, 1, '2300')