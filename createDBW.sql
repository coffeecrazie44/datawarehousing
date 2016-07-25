-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema financedw
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `financedw` ;

-- -----------------------------------------------------
-- Schema financedw
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `financedw` DEFAULT CHARACTER SET utf8 ;
USE `financedw` ;

-- -----------------------------------------------------
-- Table `financedw`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financedw`.`customer` ;

CREATE TABLE IF NOT EXISTS `financedw`.`customer` (
  `custSK` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `custID` INT(11) NULL DEFAULT NULL COMMENT '',
  `custName` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `custAddr1` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `custAddr2` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `custCity` VARCHAR(25) NULL DEFAULT NULL COMMENT '',
  `custState` CHAR(2) NULL DEFAULT NULL COMMENT '',
  `custZip` CHAR(5) NULL DEFAULT NULL COMMENT '',
  `custTypeID` CHAR(1) NULL DEFAULT NULL COMMENT '',
  `custTypeName` VARCHAR(20) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`custSK`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financedw`.`date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financedw`.`date` ;

CREATE TABLE IF NOT EXISTS `financedw`.`date` (
  `dateSK` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `date` DATE NULL DEFAULT NULL COMMENT '',
  `calenderMonth` VARCHAR(15) NULL DEFAULT NULL COMMENT '',
  `calenderMonthNo` CHAR(2) NULL COMMENT '',
  `calenderQuarter` CHAR(1) NULL DEFAULT NULL COMMENT '',
  `calenderYear` CHAR(4) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`dateSK`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financedw`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financedw`.`product` ;

CREATE TABLE IF NOT EXISTS `financedw`.`product` (
  `prodSK` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `prodID` INT(11) NULL DEFAULT NULL COMMENT '',
  `prodDesc` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `price1` DECIMAL(10,2) NULL DEFAULT NULL COMMENT '',
  `price2` DECIMAL(10,2) NULL DEFAULT NULL COMMENT '',
  `prodTypeID` INT(11) NULL DEFAULT NULL COMMENT '',
  `typeDesc` VARCHAR(25) NULL DEFAULT NULL COMMENT '',
  `buID` CHAR(1) NULL DEFAULT NULL COMMENT '',
  `buName` VARCHAR(25) NULL DEFAULT NULL COMMENT '',
  `buAbbrev` VARCHAR(10) NULL DEFAULT NULL COMMENT '',
  `unitCost` DECIMAL(10,2) NULL DEFAULT NULL COMMENT '',
  `supplierID` INT(11) NULL DEFAULT NULL COMMENT '',
  `supplierName` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `supplierAddr1` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `supplierAddr2` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `supplierCity` VARCHAR(20) NULL DEFAULT NULL COMMENT '',
  `supplierState` CHAR(2) NULL DEFAULT NULL COMMENT '',
  `supplierZip` CHAR(5) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`prodSK`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financedw`.`salesFact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financedw`.`salesFact` ;

CREATE TABLE IF NOT EXISTS `financedw`.`salesFact` (
  `salesDateSK` INT(11) NOT NULL COMMENT '',
  `custSK` INT(11) NOT NULL COMMENT '',
  `prodSK` INT(11) NOT NULL COMMENT '',
  `invoiceID` INT(11) NULL DEFAULT NULL COMMENT '',
  `quantity` INT(11) NULL DEFAULT NULL COMMENT '',
  `salesAmount` DECIMAL(10,2) NULL DEFAULT NULL COMMENT '',
  `costAmount` DECIMAL(10,2) NULL DEFAULT NULL COMMENT '',
  `daysToComplete` INT(11) NULL DEFAULT NULL COMMENT '',
  `division` VARCHAR(5) NULL DEFAULT NULL COMMENT '',
  `discounted` INT NULL COMMENT '',
  PRIMARY KEY (`salesDateSK`, `custSK`, `prodSK`)  COMMENT '',
  INDEX `custSK` (`custSK` ASC)  COMMENT '',
  INDEX `prodSK` (`prodSK` ASC)  COMMENT '',
  INDEX `salesDateSK` (`salesDateSK` ASC)  COMMENT '',
  CONSTRAINT `fact_cust_fk`
    FOREIGN KEY (`custSK`)
    REFERENCES `financedw`.`customer` (`custSK`),
  CONSTRAINT `fact_prod_fk`
    FOREIGN KEY (`prodSK`)
    REFERENCES `financedw`.`product` (`prodSK`),
  CONSTRAINT `fact_salesDate_fk`
    FOREIGN KEY (`salesDateSK`)
    REFERENCES `financedw`.`date` (`dateSK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financedw`.`staging`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financedw`.`staging` ;

CREATE TABLE IF NOT EXISTS `financedw`.`staging` (
  `salesDate` DATE NULL COMMENT '',
  `custID` INT(11) NULL DEFAULT NULL COMMENT '',
  `prodID` INT(11) NULL COMMENT '',
  `custName` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `custAddr1` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `custAddr2` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `custCity` VARCHAR(25) NULL DEFAULT NULL COMMENT '',
  `custState` CHAR(2) NULL DEFAULT NULL COMMENT '',
  `custZip` CHAR(5) NULL DEFAULT NULL COMMENT '',
  `custTypeID` CHAR(1) NULL DEFAULT NULL COMMENT '',
  `custTypeName` VARCHAR(20) NULL DEFAULT NULL COMMENT '',
  `prodDesc` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `price1` DECIMAL(10,2) NULL DEFAULT NULL COMMENT '',
  `price2` DECIMAL(10,2) NULL DEFAULT NULL COMMENT '',
  `prodTypeID` INT(11) NULL DEFAULT NULL COMMENT '',
  `typeDesc` VARCHAR(25) NULL DEFAULT NULL COMMENT '',
  `buID` CHAR(1) NULL DEFAULT NULL COMMENT '',
  `buName` VARCHAR(25) NULL DEFAULT NULL COMMENT '',
  `buAbbrev` VARCHAR(10) NULL DEFAULT NULL COMMENT '',
  `unitCost` DECIMAL(10,2) NULL DEFAULT NULL COMMENT '',
  `supplierID` INT(11) NULL DEFAULT NULL COMMENT '',
  `supplierName` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `supplierAddr1` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `supplierAddr2` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `supplierCity` VARCHAR(20) NULL DEFAULT NULL COMMENT '',
  `supplierState` CHAR(2) NULL DEFAULT NULL COMMENT '',
  `supplierZip` CHAR(5) NULL DEFAULT NULL COMMENT '',
  `invoiceID` INT(11) NULL DEFAULT NULL COMMENT '',
  `quantity` INT(11) NULL COMMENT '',
  `salesAmount` DECIMAL(10,2) NULL COMMENT '',
  `costAmount` DECIMAL(10,2) NULL DEFAULT NULL COMMENT '',
  `division` VARCHAR(5) NULL DEFAULT NULL COMMENT '',
  `discounted` INT NULL DEFAULT NULL COMMENT '')
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
