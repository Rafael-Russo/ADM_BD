/*10. Crie 10 procedures com tema livre.*/

/*1. Cadastrar Novo Cliente*/
DELIMITER $$
CREATE PROCEDURE CadastrarCliente(
    IN nome VARCHAR(45),
    IN cpf CHAR(11),
    IN telefone CHAR(11),
    IN email VARCHAR(45),
    IN pontuacao INT,
    IN tipo VARCHAR(45)
)
BEGIN
    INSERT INTO CLIENTES (nome, cpf, telefone, email, pontuacao, tipo)
    VALUES (nome, cpf, telefone, email, pontuacao, tipo);
END$$
DELIMITER ;

/*2. Atualizar Quilometragem do Carro*/

DELIMITER $$
CREATE PROCEDURE AtualizarQuilometragem(
    IN carroId INT,
    IN novaQuilometragem BIGINT
)
BEGIN
    UPDATE CARROS
    SET quilometragem = novaQuilometragem
    WHERE idCarro = carroId;
END$$
DELIMITER ;

/*3. Registrar Nova Locação*/
DELIMITER $$
CREATE PROCEDURE RegistrarLocacao(
    IN clienteId INT,
    IN carroId INT,
    IN dataLoc DATE,
    IN diaria DOUBLE,
    IN quilometragemPermitida BIGINT
)
BEGIN
    INSERT INTO LOCACAO (dataLocacao, valorDiaria, fk_idCliente, fk_idCarro, quilometragemPermitida)
    VALUES (dataLoc, diaria, clienteId, carroId, quilometragemPermitida);
END$$
DELIMITER ;

/*4. Registrar Devolução*/
DELIMITER $$
CREATE PROCEDURE RegistrarDevolucao(
    IN locacaoId INT,
    IN dataDev DATE,
    IN quilometragemFinal BIGINT,
    IN valorExtra DECIMAL(10,2)
)
BEGIN
    INSERT INTO DEVOLUCAO (idLocacao, dataDevolucao, quilometragemFinal, valorExtra)
    VALUES (locacaoId, dataDev, quilometragemFinal, valorExtra);
END$$
DELIMITER ;

/*5. Buscar Clientes Por Tipo*/
DELIMITER $$
CREATE PROCEDURE BuscarClientesPorTipo(
    IN tipoCliente VARCHAR(45)
)
BEGIN
    SELECT idCliente, nome, email, pontuacao
    FROM CLIENTES
    WHERE tipo = tipoCliente;
END$$
DELIMITER ;

/*6. Remover Cliente*/
DELIMITER $$
CREATE PROCEDURE RemoverCliente(
    IN clienteId INT
)
BEGIN
    DELETE FROM CLIENTES
    WHERE idCliente = clienteId;
END$$
DELIMITER ;

/*7. Atualizar Preço da Diária*/
DELIMITER $$
CREATE PROCEDURE AtualizarPrecoDiaria(
    IN locacaoId INT,
    IN novoValor DOUBLE
)
BEGIN
    UPDATE LOCACAO
    SET valorDiaria = novoValor
    WHERE idLocacao = locacaoId;
END$$
DELIMITER ;

/*8. Buscar Carros Por Categoria
DELIMITER $$
CREATE PROCEDURE BuscarCarrosPorCategoria(
    IN categoriaCarro VARCHAR(45)
)
BEGIN
    SELECT idCarro, fabricante, modelo, cor, anoFabricacao
    FROM CARROS
    WHERE categoria = categoriaCarro;
END$$
DELIMITER ;

/*9. Registrar Dimensões do Carro*/
DELIMITER $$
CREATE PROCEDURE RegistrarDimensoes(
    IN carroId INT,
    IN altura DECIMAL(4,3),
    IN largura DECIMAL(4,3),
    IN comprimento DECIMAL(4,3),
    IN peso INT,
    IN tanque INT,
    IN entreEixos DECIMAL(4,3),
    IN portaMala INT,
    IN ocupantes INT
)
BEGIN
    INSERT INTO DIMENSOES (altura_mm, largura_mm, comprimento_mm, peso_kg, tanque_L, entre_eixos_mm, porta_mala_L, ocupante, fk_idCarro)
    VALUES (altura, largura, comprimento, peso, tanque, entreEixos, portaMala, ocupantes, carroId);
END$$
DELIMITER ;

/*10. Calcular Valor Total de Locação por Cliente*/
DELIMITER $$
CREATE PROCEDURE CalcularValorLocacaoPorCliente(
    IN clienteId INT
)
BEGIN
    SELECT SUM(valorDiaria) AS totalValorLocacao
    FROM LOCACAO
    WHERE fk_idCliente = clienteId;
END$$
DELIMITER ;