-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SalesOrders
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `SalesOrders` ;

-- -----------------------------------------------------
-- Schema SalesOrders
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SalesOrders` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `SalesOrders` ;

-- -----------------------------------------------------
-- Table `SalesOrders`.`CustomerType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SalesOrders`.`CustomerType` ;

CREATE TABLE IF NOT EXISTS `SalesOrders`.`CustomerType` (
  `custTypeID` CHAR(1) NOT NULL COMMENT '',
  `typeName` VARCHAR(20) NULL COMMENT '',
  PRIMARY KEY (`custTypeID`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SalesOrders`.`Customer` ;

CREATE TABLE IF NOT EXISTS `SalesOrders`.`Customer` (
  `customerID` INT NOT NULL COMMENT '',
  `name` VARCHAR(50) NULL COMMENT '',
  `addr1` VARCHAR(50) NULL COMMENT '',
  `addr2` VARCHAR(50) NULL COMMENT '',
  `city` VARCHAR(30) NULL COMMENT '',
  `state` CHAR(2) NULL COMMENT '',
  `zip` CHAR(5) NULL COMMENT '',
  `custTypeID` CHAR(1) NOT NULL COMMENT '',
  PRIMARY KEY (`customerID`)  COMMENT '',
  INDEX `fk_customer_customerType_idx` (`custTypeID` ASC)  COMMENT '',
  CONSTRAINT `fk_customer_customerType`
    FOREIGN KEY (`custTypeID`)
    REFERENCES `SalesOrders`.`CustomerType` (`custTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders`.`BusinessUnit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SalesOrders`.`BusinessUnit` ;

CREATE TABLE IF NOT EXISTS `SalesOrders`.`BusinessUnit` (
  `buID` CHAR(1) NOT NULL COMMENT '',
  `name` VARCHAR(25) NULL COMMENT '',
  `abbrev` VARCHAR(10) NULL COMMENT '',
  PRIMARY KEY (`buID`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders`.`ProdType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SalesOrders`.`ProdType` ;

CREATE TABLE IF NOT EXISTS `SalesOrders`.`ProdType` (
  `prodTypeID` INT NOT NULL COMMENT '',
  `typeDescription` VARCHAR(25) NULL COMMENT '',
  `buID` CHAR(1) NULL COMMENT '',
  PRIMARY KEY (`prodTypeID`)  COMMENT '',
  INDEX `fk_prodType_businessUnit_idx` (`buID` ASC)  COMMENT '',
  CONSTRAINT `fk_prodType_businessUnit`
    FOREIGN KEY (`buID`)
    REFERENCES `SalesOrders`.`BusinessUnit` (`buID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SalesOrders`.`Supplier` ;

CREATE TABLE IF NOT EXISTS `SalesOrders`.`Supplier` (
  `supplierID` INT NOT NULL COMMENT '',
  `name` VARCHAR(50) NULL COMMENT '',
  `addr1` VARCHAR(50) NULL COMMENT '',
  `addr2` VARCHAR(50) NULL COMMENT '',
  `city` VARCHAR(20) NULL COMMENT '',
  `state` CHAR(2) NULL COMMENT '',
  `zip` CHAR(5) NULL COMMENT '',
  PRIMARY KEY (`supplierID`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders`.`InvoiceHdr`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SalesOrders`.`InvoiceHdr` ;

CREATE TABLE IF NOT EXISTS `SalesOrders`.`InvoiceHdr` (
  `invoiceID` INT NOT NULL COMMENT '',
  `customerID` INT NOT NULL COMMENT '',
  `saleDate` DATE NULL COMMENT '',
  PRIMARY KEY (`invoiceID`)  COMMENT '',
  INDEX `fk_invoiceHdr_customer_idx` (`customerID` ASC)  COMMENT '',
  CONSTRAINT `fk_invoiceHdr_customer`
    FOREIGN KEY (`customerID`)
    REFERENCES `SalesOrders`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SalesOrders`.`Product` ;

CREATE TABLE IF NOT EXISTS `SalesOrders`.`Product` (
  `prodID` INT NOT NULL COMMENT '',
  `description` VARCHAR(50) NULL COMMENT '',
  `price1` DECIMAL(10,2) NULL COMMENT '',
  `price2` DECIMAL(10,2) NULL COMMENT '',
  `prodTypeID` INT NULL COMMENT '',
  `unitCost` DECIMAL(10,2) NULL COMMENT '',
  `supplierID` INT NULL COMMENT '',
  PRIMARY KEY (`prodID`)  COMMENT '',
  INDEX `fk_product_supplier_idx` (`supplierID` ASC)  COMMENT '',
  INDEX `fk_product_prodType_idx` (`prodTypeID` ASC)  COMMENT '',
  CONSTRAINT `fk_product_supplier`
    FOREIGN KEY (`supplierID`)
    REFERENCES `SalesOrders`.`Supplier` (`supplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_prodType`
    FOREIGN KEY (`prodTypeID`)
    REFERENCES `SalesOrders`.`ProdType` (`prodTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders`.`InvoiceDtl`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SalesOrders`.`InvoiceDtl` ;

CREATE TABLE IF NOT EXISTS `SalesOrders`.`InvoiceDtl` (
  `invoiceID` INT NOT NULL COMMENT '',
  `prodID` INT NOT NULL COMMENT '',
  `amt` DECIMAL(10,2) NULL COMMENT '',
  `qty` DECIMAL(8,2) NULL COMMENT '',
  `discounted` INT NULL COMMENT '',
  PRIMARY KEY (`invoiceID`, `prodID`)  COMMENT '',
  INDEX `fk_invoiceDtl_product_idx` (`prodID` ASC)  COMMENT '',
  CONSTRAINT `fk_invoiceDtl_invoiceHdr`
    FOREIGN KEY (`invoiceID`)
    REFERENCES `SalesOrders`.`InvoiceHdr` (`invoiceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoiceDtl_product`
    FOREIGN KEY (`prodID`)
    REFERENCES `SalesOrders`.`Product` (`prodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
