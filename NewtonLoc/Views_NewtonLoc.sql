/* 3 Agora as perguntas a serem respondidas com o schema todo pronto: Crie 1 View para cada uma das perguntas*/
/*Questao 1 -- Qual o modelo do carro que já foi alugado*/
CREATE OR REPLACE VIEW VEX1 AS
SELECT C.modelo AS Carros_Ja_Alugados
FROM carros C INNER JOIN locacao L ON C.idCarro = L.fk_idCarro GROUP BY C.idCarro;
SELECT * FROM VEX1;

/*Questao 2 -- Qual o nome do cliente que já alugou um carro*/
CREATE OR REPLACE VIEW VEX2 AS
SELECT C.nome AS Cliente_Ja_Alugou
FROM clientes C INNER JOIN locacao L ON C.idCliente = L.fk_idCliente GROUP BY C.idCliente;
SELECT * FROM VEX2;

/*Questao 3 -- Qual o nome do cliente que alugou o carro com a diária mais alta.*/
CREATE OR REPLACE VIEW VEX3 AS
SELECT C.nome AS Cliente_Mais_Caro
FROM clientes C INNER JOIN locacao L ON C.idCliente = L.fk_idCliente WHERE L.valorDiaria = (SELECT MAX(valorDiaria) FROM locacao);
SELECT * FROM VEX3;

/*Questao 4-- Qual a categoria do carro que foi alugado por ultimo*/
CREATE OR REPLACE VIEW VEX4 AS
SELECT C.categoria AS Categoria_Alugada_Por_Ultimo
FROM carros C INNER JOIN locacao L ON C.idCarro = L.fk_idCarro WHERE L.dataLocacao = (SELECT MAX(dataLocacao) FROM locacao);
SELECT * FROM VEX4;

/*Questao 5 -- Qual o nome do fabricante(s) que produziu o carro(s) mais potente(s)*/
CREATE OR REPLACE VIEW VEX5 AS
SELECT C.fabricante AS Fabricante_Mais_Potente
FROM carros C WHERE C.potenciaMotor = (SELECT MAX(potenciaMotor) FROM carros);
SELECT * FROM VEX5;

/*Questao 6 -- Qual a cor da SUV locada no dia 2024-10-22*/
CREATE OR REPLACE VIEW VEX6 AS
SELECT C.cor
FROM carros C INNER JOIN locacao L ON C.idCarro = L.fk_idCarro WHERE L.dataLocacao = '2024-10-22' AND C.categoria = 'SUV' GROUP BY C.idCarro;
SELECT * FROM VEX6;

/*Questao 7 -- Qual o modelo do carro, fabricante, cor que tem a menor diária*/
CREATE OR REPLACE VIEW VEX7 AS
SELECT C.modelo, C.fabricante, C.cor
FROM carros C INNER JOIN locacao L ON C.idCarro = L.fk_idCarro WHERE L.valorDiaria = (SELECT MIN(valorDiaria) FROM locacao);
SELECT * FROM VEX7;

/*Questao 8 -- Qual o modelo do carro e categoria que não foi alugado ainda*/
CREATE OR REPLACE VIEW VEX8 AS
SELECT C.modelo, C.categoria
FROM carros C LEFT JOIN locacao L ON C.idCarro = L.fk_idCarro WHERE L.fk_idCarro IS NULL GROUP BY C.idCarro;
SELECT * FROM VEX8;

/*Questao 9 -- Qual o nome do cliente que nunca alugou um carro do ano de fabricao 2013*/
CREATE OR REPLACE VIEW VEX9 AS
SELECT CL.nome
FROM clientes CL LEFT JOIN locacao L ON CL.idCliente = L.fk_idCliente INNER JOIN carros CA ON L.fk_idCarro = CA.idCarro WHERE CA.anoFabricacao != 2013 OR L.fk_idCliente IS NULL;
SELECT * FROM VEX9;

/*Questao 10 -- Qual o nome do cliente que já alugou um carro SUV*/
CREATE OR REPLACE VIEW VEX10 AS
SELECT CL.nome
FROM clientes CL INNER JOIN locacao L ON CL.idCliente = L.fk_idCliente INNER JOIN carros CA ON L.fk_idCarro = CA.idCarro WHERE CA.categoria = 'SUV';
SELECT * FROM VEX10;

/*Questao 11 -- Qual o nome do cliente que NÃO alugou um carro Sedan*/
CREATE OR REPLACE VIEW VEX11 AS
SELECT CL.nome
FROM clientes CL LEFT JOIN locacao L ON CL.idCliente = L.fk_idCliente INNER JOIN carros CA ON L.fk_idCarro = CA.idCarro WHERE CA.categoria != 'Sedan' OR L.fk_idCliente IS NULL;
SELECT * FROM VEX11;

/*Questao 12 -- Qual a categoria do cliente que já alugou um carro com mais de 3000 quilômetros rodados*/
CREATE OR REPLACE VIEW VEX12 AS
SELECT CL.tipo
FROM clientes CL INNER JOIN locacao L ON CL.idCliente = L.fk_idCliente INNER JOIN carros CA ON L.fk_idCarro = CA.idCarro WHERE CA.quilometragem > 3000 GROUP BY CL.tipo;
SELECT * FROM VEX12;

/*Questao 13 -- Qual o modelo do carro que tem a menor altura.*/
CREATE OR REPLACE VIEW VEX13 AS
SELECT C.modelo
FROM carros C INNER JOIN dimensoes D ON C.idCarro = D.fk_idCarro WHERE D.altura_mm = (SELECT MAX(altura_mm) FROM dimensoes);
SELECT * FROM VEX13;

/*Questao 14 -- Qual o tamanho do porta mala do carro que é da categoria Hatch*/
CREATE OR REPLACE VIEW VEX14 AS
SELECT D.porta_mala_L
FROM dimensoes D INNER JOIN carros C ON D.fk_idCarro = C.idCarro WHERE C.categoria = 'Hatch';
SELECT * FROM VEX14;

/* Questao 15 -- Qual o nome do cliente que já alugou o maior número de carros */
CREATE OR REPLACE VIEW VEX15 AS
SELECT CL.nome AS Cliente_Mais_Alugou
FROM clientes CL INNER JOIN locacao L ON CL.idCliente = L.fk_idCliente
GROUP BY CL.idCliente
ORDER BY COUNT(L.idLocacao) DESC
LIMIT 1;
SELECT * FROM VEX15;

/* O modelo do carro mais leve */
CREATE OR REPLACE VIEW VEX16 AS
SELECT C.modelo AS Modelo_Mais_Leve
FROM carros C INNER JOIN dimensoes D ON C.idCarro = D.fk_idCarro
WHERE D.peso_kg = (SELECT MIN(peso_kg) FROM dimensoes);
SELECT * FROM VEX16;

/* Nome do cliente que alugou carros com tanque acima de 50L */
CREATE OR REPLACE VIEW VEX17 AS
SELECT DISTINCT CL.nome AS Cliente_Tanque_Acima_50L
FROM clientes CL INNER JOIN locacao L ON CL.idCliente = L.fk_idCliente
INNER JOIN dimensoes D ON L.fk_idCarro = D.fk_idCarro
WHERE D.tanque_L > 50;
SELECT * FROM VEX17;

/* Categoria dos carros alugados no último mês */
CREATE OR REPLACE VIEW VEX18 AS
SELECT DISTINCT C.categoria AS Categoria_Ultimo_Mes
FROM carros C INNER JOIN locacao L ON C.idCarro = L.fk_idCarro
WHERE L.dataLocacao >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
SELECT * FROM VEX18;

/* Modelo e o ano do carro com maior espaço no porta-malas */
CREATE OR REPLACE VIEW VEX19 AS
SELECT C.modelo, C.anoFabricacao
FROM carros C INNER JOIN dimensoes D ON C.idCarro = D.fk_idCarro
WHERE D.porta_mala_L = (SELECT MAX(porta_mala_L) FROM dimensoes);
SELECT * FROM VEX19;

/* Cor do carro com menor quilometragem */
CREATE OR REPLACE VIEW VEX20 AS
SELECT C.cor
FROM carros C
WHERE C.quilometragem = (SELECT MIN(quilometragem) FROM carros);
SELECT * FROM VEX20;

/* Nome do cliente que nunca alugou carros acima de 200 cavalos */
CREATE OR REPLACE VIEW VEX21 AS
SELECT CL.nome
FROM clientes CL LEFT JOIN locacao L ON CL.idCliente = L.fk_idCliente
INNER JOIN carros CA ON L.fk_idCarro = CA.idCarro
WHERE CA.potenciaMotor <= 200 OR L.fk_idCliente IS NULL;
SELECT * FROM VEX21;

/* Carro mais alugado de cada categoria */
CREATE OR REPLACE VIEW VEX22 AS
SELECT C.categoria, C.modelo, COUNT(L.idLocacao) AS Total_Alugado
FROM carros C INNER JOIN locacao L ON C.idCarro = L.fk_idCarro
GROUP BY C.categoria, C.idCarro
ORDER BY C.categoria, Total_Alugado DESC;
SELECT * FROM VEX22;

/* Potência média dos carros alugados */
CREATE OR REPLACE VIEW VEX23 AS
SELECT AVG(C.potenciaMotor) AS Potencia_Media
FROM carros C INNER JOIN locacao L ON C.idCarro = L.fk_idCarro;
SELECT * FROM VEX23;

/* Nome dos clientes com pontuação acima de 500 que já alugaram carros */
CREATE OR REPLACE VIEW VEX24 AS
SELECT DISTINCT CL.nome
FROM clientes CL INNER JOIN locacao L ON CL.idCliente = L.fk_idCliente
WHERE CL.pontuacao > 500;
SELECT * FROM VEX24;
