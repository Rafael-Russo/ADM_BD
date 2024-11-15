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