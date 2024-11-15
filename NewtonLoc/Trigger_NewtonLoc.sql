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