-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ex_triggers
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ex_triggers` ;

-- -----------------------------------------------------
-- Schema ex_triggers
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ex_triggers` DEFAULT CHARACTER SET utf8 ;
USE `ex_triggers` ;

-- -----------------------------------------------------
-- Table `ex_triggers`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ex_triggers`.`Customer` ;

CREATE TABLE IF NOT EXISTS `ex_triggers`.`Customer` (
  `CustNo` INT NOT NULL AUTO_INCREMENT,
  `CustFirstName` VARCHAR(45) NULL,
  `CustLastName` VARCHAR(45) NULL,
  `CustStreet` VARCHAR(45) NULL,
  `CustCity` VARCHAR(45) NULL,
  `CustState` VARCHAR(45) NULL,
  `CustZip` VARCHAR(45) NULL,
  `CustBal` VARCHAR(45) NULL,
  PRIMARY KEY (`CustNo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex_triggers`.`Employee_1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ex_triggers`.`Employee_1` ;

CREATE TABLE IF NOT EXISTS `ex_triggers`.`Employee_1` (
  `EmpNo` INT NOT NULL AUTO_INCREMENT,
  `EmpFirstName` VARCHAR(45) NULL,
  `EmpLastName` VARCHAR(45) NULL,
  `EmpPhone` VARCHAR(45) NULL,
  `SupEmpNo` VARCHAR(45) NULL,
  `EmpCommRate` VARCHAR(45) NULL,
  PRIMARY KEY (`EmpNo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex_triggers`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ex_triggers`.`Employee` ;

CREATE TABLE IF NOT EXISTS `ex_triggers`.`Employee` (
  `EmpNo` INT NOT NULL AUTO_INCREMENT,
  `EmpFirstName` VARCHAR(45) NULL,
  `EmpLastName` VARCHAR(45) NULL,
  `EmpPhone` VARCHAR(45) NULL,
  `fk_EmpNo` INT NOT NULL,
  `EmpCommRate` VARCHAR(45) NULL,
  PRIMARY KEY (`EmpNo`),
  INDEX `fk_Employee_Employee_11_idx` (`fk_EmpNo` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Employee_11`
    FOREIGN KEY (`fk_EmpNo`)
    REFERENCES `ex_triggers`.`Employee_1` (`EmpNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex_triggers`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ex_triggers`.`Supplier` ;

CREATE TABLE IF NOT EXISTS `ex_triggers`.`Supplier` (
  `SuppNo` INT NOT NULL AUTO_INCREMENT,
  `SuppName` VARCHAR(45) NULL,
  `SuppEmail` VARCHAR(45) NULL,
  `SuppPhone` VARCHAR(45) NULL,
  `SuppURL` VARCHAR(45) NULL,
  `SuppDiscount` VARCHAR(45) NULL,
  PRIMARY KEY (`SuppNo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex_triggers`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ex_triggers`.`Product` ;

CREATE TABLE IF NOT EXISTS `ex_triggers`.`Product` (
  `ProdNo` INT NOT NULL AUTO_INCREMENT,
  `ProdName` VARCHAR(45) NULL,
  `fk_SuppNo` INT NOT NULL,
  `ProdQOH` VARCHAR(45) NULL,
  `ProdPrice` DOUBLE NULL,
  `ProdNextShipDate` DATETIME NULL,
  PRIMARY KEY (`ProdNo`),
  INDEX `fk_Prdouct_Supplier1_idx` (`fk_SuppNo` ASC) VISIBLE,
  CONSTRAINT `fk_Prdouct_Supplier1`
    FOREIGN KEY (`fk_SuppNo`)
    REFERENCES `ex_triggers`.`Supplier` (`SuppNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex_triggers`.`Purchase`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ex_triggers`.`Purchase` ;

CREATE TABLE IF NOT EXISTS `ex_triggers`.`Purchase` (
  `PurchNo` INT NOT NULL AUTO_INCREMENT,
  `PurchDate` DATETIME NULL,
  `fk_SuppNo` INT NOT NULL,
  `PurchPayMethod` VARCHAR(45) NULL,
  `PurchDelDate` DATETIME NULL,
  PRIMARY KEY (`PurchNo`),
  INDEX `fk_Purchase_Supplier1_idx` (`fk_SuppNo` ASC) VISIBLE,
  CONSTRAINT `fk_Purchase_Supplier1`
    FOREIGN KEY (`fk_SuppNo`)
    REFERENCES `ex_triggers`.`Supplier` (`SuppNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex_triggers`.`OrderTbl`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ex_triggers`.`OrderTbl` ;

CREATE TABLE IF NOT EXISTS `ex_triggers`.`OrderTbl` (
  `OrdNo` INT NOT NULL AUTO_INCREMENT,
  `OrdDate` DATETIME NULL,
  `fk_CustNo` INT NOT NULL,
  `fk_EmpNo` INT NOT NULL,
  `OrdName` VARCHAR(45) NULL,
  `OrdStreet` VARCHAR(45) NULL,
  `OrdCity` VARCHAR(45) NULL,
  `OrdState` VARCHAR(45) NULL,
  `OrdZip` VARCHAR(45) NULL,
  PRIMARY KEY (`OrdNo`),
  INDEX `fk_OrderTbl_Customer_idx` (`fk_CustNo` ASC) VISIBLE,
  INDEX `fk_OrderTbl_Employee1_idx` (`fk_EmpNo` ASC) VISIBLE,
  CONSTRAINT `fk_OrderTbl_Customer`
    FOREIGN KEY (`fk_CustNo`)
    REFERENCES `ex_triggers`.`Customer` (`CustNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderTbl_Employee1`
    FOREIGN KEY (`fk_EmpNo`)
    REFERENCES `ex_triggers`.`Employee` (`EmpNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex_triggers`.`OrdLine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ex_triggers`.`OrdLine` ;

CREATE TABLE IF NOT EXISTS `ex_triggers`.`OrdLine` (
  `fk_OrdNo` INT NOT NULL,
  `fk_ProdNo` INT NOT NULL,
  `Qty` INT NULL,
  INDEX `fk_OrderTbl_has_Prdouct_Prdouct1_idx` (`fk_ProdNo` ASC) VISIBLE,
  INDEX `fk_OrderTbl_has_Prdouct_OrderTbl1_idx` (`fk_OrdNo` ASC) VISIBLE,
  PRIMARY KEY (`fk_OrdNo`, `fk_ProdNo`),
  CONSTRAINT `fk_OrderTbl_has_Prdouct_OrderTbl1`
    FOREIGN KEY (`fk_OrdNo`)
    REFERENCES `ex_triggers`.`OrderTbl` (`OrdNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderTbl_has_Prdouct_Prdouct1`
    FOREIGN KEY (`fk_ProdNo`)
    REFERENCES `ex_triggers`.`Product` (`ProdNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex_triggers`.`PurchLine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ex_triggers`.`PurchLine` ;

CREATE TABLE IF NOT EXISTS `ex_triggers`.`PurchLine` (
  `fk_ProdNo` INT NOT NULL,
  `fk_PurchNo` INT NOT NULL,
  `PurchQty` INT NULL,
  `PurchUnitCost` DOUBLE NULL,
  PRIMARY KEY (`fk_ProdNo`, `fk_PurchNo`),
  INDEX `fk_Prdouct_has_Purchase_Purchase1_idx` (`fk_PurchNo` ASC) VISIBLE,
  INDEX `fk_Prdouct_has_Purchase_Prdouct1_idx` (`fk_ProdNo` ASC) VISIBLE,
  CONSTRAINT `fk_Prdouct_has_Purchase_Prdouct1`
    FOREIGN KEY (`fk_ProdNo`)
    REFERENCES `ex_triggers`.`Product` (`ProdNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prdouct_has_Purchase_Purchase1`
    FOREIGN KEY (`fk_PurchNo`)
    REFERENCES `ex_triggers`.`Purchase` (`PurchNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
