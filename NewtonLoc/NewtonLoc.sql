DROP SCHEMA IF EXISTS `NewtonLoc`;
CREATE SCHEMA `NewtonLoc`;
USE `NewtonLoc`;
-- -----------------------------------------------------
-- Table `lojaCarros`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE `CLIENTES` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `telefone` CHAR(11) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `pontuacao` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `LojaCarros`.`Carros`
-- -----------------------------------------------------
CREATE TABLE`CARROS` (
  `idCarro` INT NOT NULL AUTO_INCREMENT,
  `fabricante` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `cor` VARCHAR(15) NOT NULL,
  `anoFabricacao` YEAR NOT NULL,
  `potenciaMotor` DECIMAL(4,1) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `quilometragem` BIGINT NOT NULL,
  PRIMARY KEY (`idCarro`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `LojaCarros`.`DadosVeiculo`
-- -----------------------------------------------------

CREATE TABLE`DIMENSOES` (
  `idDimensao` INT AUTO_INCREMENT,
  `altura_mm` DECIMAL(4,3) NOT NULL,
  `largura_mm` DECIMAL(4,3) NOT NULL,
  `comprimento_mm` DECIMAL(4,3) NOT NULL,
  `peso_kg` INT NOT NULL,
  `tanque_L` INT NOT NULL,
  `entre_eixos_mm` DECIMAL(4,3) NOT NULL,
  `porta_mala_L` INT NOT NULL,
  `ocupante` INT NOT NULL,
  `fk_idCarro` INT NOT NULL,
  CONSTRAINT `fk_Dimensoes_Carros`
    FOREIGN KEY (`fk_idCarro`)
    REFERENCES `CARROS` (`idCarro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  PRIMARY KEY (`idDimensao`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `LojaCarros`.`Locacao`
-- -----------------------------------------------------
CREATE TABLE `LOCACAO` (
  `idLocacao` INT NOT NULL AUTO_INCREMENT,
  `dataLocacao` DATE NOT NULL,
  `valorDiaria` DOUBLE NOT NULL,
  `fk_idCliente` INT NOT NULL,
  `fk_idCarro` INT NOT NULL,
  PRIMARY KEY (`idLocacao`),
  CONSTRAINT `fk_Locacao_Clientes`
    FOREIGN KEY (`fk_idCliente`)
    REFERENCES `CLIENTES` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Locacao_Carros`
    FOREIGN KEY (`fk_idCarro`)
    REFERENCES `CARROS`(`idCarro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;
    
     INSERT INTO CLIENTES (nome,cpf,telefone,email,pontuacao,tipo) 
				values ('Teclaudio Screen','12341234121','31987655434','te@gmail.com',0,'Basico'),
						('Maria Teclas','12332143445','32987800987','m@gmail.com',100,'Basico'),
						('Jonas Mouse','44489865432','31976533234','mouse@gmail.com',500,'Basico'),
						('Carlos CPU','45609087678','31978900627','cpu@gmail.com',1200,'Intemediario'),
						('Tiana Cooler','67512399900','31976432111','ti@gmail.com',3000,'Intermediario'),
						('Cassandra Pixel','88890097666','31980077654','cas@gmail.com',5600,'Premium');
    
  INSERT INTO CARROS (fabricante,modelo,cor,anoFabricacao,potenciaMotor,categoria,quilometragem) 
			values	('Fiat','Toro Freedom','preto','2022',1.8,'SUV',12000),
					  ('Toyota','Yaris','Branco','2022',1.5,'Sedan',3000),
					  ('Ford','Fiesta','Branco','2021',1.6,'Hatch',566),
					  ('Toyota','Corolla','Branco','2023',2.0,'Sedan',1022),
					  ('Hyundai','Hb20','Vermelho','2023',2.0,'Hatch',300),
					  ('Volksvagen','Gol','Verde','2020',1.6,'Hatch',5059),
					  ('Chevrolet','Onix','preto','2019',1.6,'Hatch',12034);
    
 INSERT INTO locacao(dataLocacao,valorDiaria,fk_idCliente,fk_idCarro) 
			values ('2023-01-10',123,1,1),
					('2023-01-10',183,2,2),
					('2023-01-10',100,3,3),
					('2023-01-10',199,4,4),
					('2023-01-10',99,5,5),
					('2023-02-10',183,2,2);
                    
INSERT INTO dimensoes(altura_mm,largura_mm,comprimento_mm,peso_kg,tanque_L,entre_eixos_mm,porta_mala_L,ocupante,fk_idCarro)
				VALUES (1.475, 1.656, 3.892, 1.020, 55, 2.467, 285, 5, 6),
						(1.480, 1.760, 4.540, 1.230, 60, 2.600, 470, 5, 4),
						(1.673, 1.844, 4.945, 1.650, 55, 2.982, 0, 5, 1),
						(1.487, 1.765, 3.935, 1.084, 54, 2.488, 270, 5, 3),
						(1.490, 1.730, 4.425, 1.130, 45, 2.550, 473, 5, 2),
						(1.470, 1.720, 4.015, 993, 50, 2.530, 300, 5, 5),
						(1.471, 1.731, 4.163, 1.034, 44, 2.551, 303, 5, 7);
                        
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

/*4. Crie uma trigger para monitorar a tabela locação. Ela deve registrar os dados do usuário, 
data de inserção de um registro, e quais foram os dados novos inseridos. Para isso crie uma tabela chamada log.*/

CREATE TABLE LOG(
	idLog INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(45) NOT NULL,
    dadosInseridos TEXT NOT NULL,
    dataInsercao DATETIME NOT NULL
);

DELIMITER $$

CREATE TRIGGER Trigger_Locacao
AFTER INSERT ON locacao
FOR EACH ROW
BEGIN
	DECLARE usuarioAtual VARCHAR(45);
    SET usuarioAtual = USER();
    
    INSERT INTO log (usuario, dadosInseridos, dataInsercao)
    VALUES (
			usuarioAtual, 
            CONCAT('ID Locação: ', NEW.idLocacao, ', ',
				  'Data Locação: ', NEW.dataLocacao, ', ',
				  'Valor Diária: ', NEW.valorDiaria, ', ',
				  'ID Cliente: ', NEW.fk_idCliente, ', ',
				  'ID Carro: ', NEW.fk_idCarro
			  ),
			  NOW()
      );
END$$

DELIMITER ;

/*5. Analise o database e suas tabelas para implementar uma trigger que possa fazer a gestão da
quilometragem dos carros que foram alugados. Exemplo: Aluguei um gol com quilometragem de 2344
 quilômetros e só posso rodar 1000 quilômetros, se ao entregar o carro ele estiver com quilometragem
 de mais que 3344, meu valor do quilometro deve subir pra 30% a mais. Você deve mudar o que for preciso
 para atender a demanda passada. Se achar necessário, use uma tabela pra devolução com os valores extras nela.*/

ALTER TABLE LOCACAO ADD quilometragemPermitida INT NOT NULL DEFAULT 1000;

CREATE TABLE DEVOLUCAO (
  idDevolucao INT AUTO_INCREMENT PRIMARY KEY,
  idLocacao INT NOT NULL,
  quilometragemFinal BIGINT NOT NULL,
  valorExtra DECIMAL(10, 2) DEFAULT 0,
  dataDevolucao DATE NOT NULL,
  FOREIGN KEY (idLocacao) REFERENCES LOCACAO(idLocacao)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

DELIMITER $$

CREATE TRIGGER calcula_valor_extra
AFTER INSERT ON DEVOLUCAO
FOR EACH ROW
BEGIN
  DECLARE kmExcedente BIGINT;
  DECLARE valorDiaria DECIMAL(10,2);
  DECLARE taxaExtra DECIMAL(10,2);

  -- Buscar a quilometragem permitida e o valor da diária
  SELECT quilometragemPermitida, valorDiaria 
  INTO kmExcedente, valorDiaria
  FROM LOCACAO
  WHERE idLocacao = NEW.idLocacao;

  -- Verificar se houve excedente na quilometragem
  SET kmExcedente = NEW.quilometragemFinal - (kmExcedente + (SELECT quilometragem FROM CARROS WHERE idCarro = (SELECT fk_idCarro FROM LOCACAO WHERE id=Locaco)));

END$$

/*6. Crie 10 usuários com senha para acessar (Roles) conforme as restrições abaixo (Você decide quem acessa o que) cada acesso é uma Role*/

/*Acesso1 - Apenas para dar select em todas as tabelas.*/
CREATE USER 'usuario_select1'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT ON NewtonLoc.* TO 'usuario_select1'@'localhost';
CREATE USER 'usuario_select2'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT ON NewtonLoc.* TO 'usuario_select2'@'localhost';

/*Acesso2 - Apenas Select e insert na tabela de carros*/
CREATE USER 'usuario_carros1'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT, INSERT ON NewtonLoc.CARROS TO 'usuario_carros1'@'localhost';
CREATE USER 'usuario_carros2'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT, INSERT ON NewtonLoc.CARROS TO 'usuario_carros2'@'localhost';

/*Acesso3 - Total no Sistema e database.*/
CREATE USER 'admin_total1'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON *.* TO 'admin_total1'@'localhost' WITH GRANT OPTION;
CREATE USER 'admin_total2'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON *.* TO 'admin_total2'@'localhost' WITH GRANT OPTION;

/*Acesso4 - Create, alter e drop em tabelas e schema.*/
CREATE USER 'usuario_ddl1'@'localhost' IDENTIFIED BY 'senha123';
GRANT CREATE, ALTER, DROP ON NewtonLoc.* TO 'usuario_ddl1'@'localhost';
CREATE USER 'usuario_ddl2'@'localhost' IDENTIFIED BY 'senha123';
GRANT CREATE, ALTER, DROP ON NewtonLoc.* TO 'usuario_ddl2'@'localhost';

/*Acesso5 - Total ao schema.*/
CREATE USER 'schema_admin1'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON NewtonLoc.* TO 'schema_admin1'@'localhost';
CREATE USER 'schema_admin2'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON NewtonLoc.* TO 'schema_admin2'@'localhost';

/* 7. Entre os usuários criados acima, altere as permissões de 5. A sua escolha.*/
GRANT INSERT ON NewtonLoc.CLIENTES TO 'usuario_select1'@'localhost';

GRANT UPDATE ON NewtonLoc.CARROS TO 'usuario_carros1'@'localhost';

REVOKE GRANT OPTION ON *.* FROM 'admin_total1'@'localhost';

GRANT SELECT ON NewtonLoc.* TO 'usuario_ddl1'@'localhost';

REVOKE SELECT ON NewtonLoc.* FROM 'schema_admin1'@'localhost';

/*8. Crie um índice para cada uma das tabelas acima.*/
CREATE INDEX idx_cpf ON CLIENTES (cpf);

CREATE INDEX idx_modelo ON CARROS (modelo);

CREATE INDEX idx_porta_mala ON DIMENSOES (porta_mala_L);

CREATE INDEX idx_fk_idCliente ON LOCACAO (fk_idCliente);
CREATE INDEX idx_fk_idCarro ON LOCACAO (fk_idCarro);

CREATE INDEX idx_idLocacao ON DEVOLUCAO (idLocacao);

/* 9. Crie 20 perguntas e 20 respostas onde as respostas devem ser todas com Join.*/

/*1. Quais carros foram alugados por cada cliente?*/
SELECT c.nome, car.modelo
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN CARROS car ON l.fk_idCarro = car.idCarro;

/*2. Quais clientes alugaram carros da categoria "SUV"?*/
SELECT c.nome, car.categoria
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN CARROS car ON l.fk_idCarro = car.idCarro
WHERE car.categoria = 'SUV';

/*3. Quais carros têm devoluções registradas?*/
SELECT car.modelo, d.dataDevolucao
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao;

/*4. Quais clientes devolveram carros com quilometragem acima do permitido?*/
SELECT c.nome, d.quilometragemFinal, l.quilometragemPermitida
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
WHERE d.quilometragemFinal > l.quilometragemPermitida;

/*5. Quais carros possuem devoluções com valor extra?*/
SELECT car.modelo, d.valorExtra
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
WHERE d.valorExtra > 0;

/*6. Quais clientes alugaram carros fabricados pela Toyota?*/
SELECT c.nome, car.fabricante
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN CARROS car ON l.fk_idCarro = car.idCarro
WHERE car.fabricante = 'Toyota';

/*7. Quais carros têm mais de 5 ocupantes e foram alugados?*/
SELECT car.modelo, dim.ocupante
FROM CARROS car
JOIN DIMENSOES dim ON car.idCarro = dim.fk_idCarro
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
WHERE dim.ocupante > 5;

/*8. Quais locações possuem clientes do tipo "Premium"?*/
SELECT l.idLocacao, c.tipo
FROM LOCACAO l
JOIN CLIENTES c ON l.fk_idCliente = c.idCliente
WHERE c.tipo = 'Premium';

/*9. Quais carros brancos foram devolvidos com quilometragem acima do permitido?*/
SELECT car.modelo, d.quilometragemFinal
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
WHERE car.cor = 'Branco' AND d.quilometragemFinal > l.quilometragemPermitida;

/*10. Qual é o valor total das locações por cliente?*/
SELECT c.nome, SUM(l.valorDiaria) AS totalGasto
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
GROUP BY c.nome;

/*11. Quais são os modelos e suas categorias alugados por clientes intermediários?*/
SELECT car.modelo, car.categoria
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
JOIN CLIENTES c ON l.fk_idCliente = c.idCliente
WHERE c.tipo = 'Intermediario';

/*12. Quais carros têm porta-malas maior que 300L e foram alugados?*/
SELECT car.modelo, dim.porta_mala_L
FROM CARROS car
JOIN DIMENSOES dim ON car.idCarro = dim.fk_idCarro
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
WHERE dim.porta_mala_L > 300;

/*13. Quais clientes nunca devolveram carros?*/
SELECT c.nome
FROM CLIENTES c
LEFT JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
LEFT JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
WHERE d.idDevolucao IS NULL;

/*14. Quais são os modelos de carros alugados por mais de um cliente?*/
SELECT car.modelo, COUNT(DISTINCT l.fk_idCliente) AS totalClientes
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
GROUP BY car.modelo
HAVING totalClientes > 1;

/*15. Quais carros foram devolvidos em fevereiro de 2023?*/
SELECT car.modelo, d.dataDevolucao
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
WHERE d.dataDevolucao BETWEEN '2023-02-01' AND '2023-02-28';

/*16. Quais são os clientes e os carros alugados juntos?*/
SELECT c.nome, car.modelo
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN CARROS car ON l.fk_idCarro = car.idCarro;

/*17. Qual é o carro mais alugado?*/
SELECT car.modelo, COUNT(l.idLocacao) AS totalAlugado
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
GROUP BY car.modelo
ORDER BY totalAlugado DESC
LIMIT 1;

/*18. Quais clientes devolveram carros com tanque de combustível acima de 50L?*/
SELECT c.nome, dim.tanque_L
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
JOIN CARROS car ON l.fk_idCarro = car.idCarro
JOIN DIMENSOES dim ON car.idCarro = dim.fk_idCarro
WHERE dim.tanque_L > 50;

/*19. Qual é a soma dos valores extras pagos em devoluções por cliente?*/
SELECT c.nome, SUM(d.valorExtra) AS totalExtra
FROM CLIENTES c
JOIN LOCACAO l ON c.idCliente = l.fk_idCliente
JOIN DEVOLUCAO d ON l.idLocacao = d.idLocacao
GROUP BY c.nome;

/*20. Quais são os carros mais alugados por categoria?*/
SELECT car.categoria, car.modelo, COUNT(l.idLocacao) AS totalAlugado
FROM CARROS car
JOIN LOCACAO l ON car.idCarro = l.fk_idCarro
GROUP BY car.categoria, car.modelo
ORDER BY totalAlugado DESC;

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