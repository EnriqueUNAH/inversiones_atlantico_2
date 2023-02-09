-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_inversiones_atlantico
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_inversiones_atlantico
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_inversiones_atlantico` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema db_inversiones_atlantico
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_inversiones_atlantico
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_inversiones_atlantico` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db_inversiones_atlantico` ;

-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_GENERO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_GENERO` (
  `COD_GENERO` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE_GENERO` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`COD_GENERO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_CLIENTE` (
  `COD_CLIENTE` INT NOT NULL AUTO_INCREMENT,
  `RTN` VARCHAR(14) NULL,
  `NOMBRE_COMPLETO` VARCHAR(100) NOT NULL,
  `TELEFONO` INT NULL DEFAULT NULL,
  `CORREO_ELECTRONICO` VARCHAR(30) NULL DEFAULT NULL,
  `DIRECCION` VARCHAR(255) NULL DEFAULT NULL,
  `FECHA_REGISTRO` DATETIME NULL DEFAULT NULL,
  `COD_GENERO` INT NULL DEFAULT NULL,
  `ID_USUARIO` INT NULL,
  `ESTADO` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`COD_CLIENTE`),
  INDEX `tbl_Genero_Cod_Genero_idx` (`COD_GENERO` ASC) VISIBLE,
  CONSTRAINT `Cliente_CodGenero`
    FOREIGN KEY (`COD_GENERO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_GENERO` (`COD_GENERO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_PROVEEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_PROVEEDOR` (
  `COD_PROVEEDOR` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE_EMPRESA` VARCHAR(100) NULL DEFAULT NULL,
  `RTN` VARCHAR(14) NULL DEFAULT NULL,
  `NOMBRE_REPRESENTANTE` VARCHAR(100) NULL DEFAULT NULL,
  `TELEFONO` BIGINT NULL,
  `DIRECCION` TEXT NULL,
  `FECHA` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `ID_USUARIO` INT NULL,
  `ESTADO` INT NULL DEFAULT '1',
  PRIMARY KEY (`COD_PROVEEDOR`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_COMPRA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_COMPRA` (
  `COD_COMPRA` INT NOT NULL AUTO_INCREMENT,
  `TOTAL_PAGADO` DECIMAL(8,2) NULL DEFAULT NULL,
  `FECHA` DATETIME NULL DEFAULT NULL,
  `ISV` DECIMAL(8,2) NULL DEFAULT NULL,
  `COD_PROVEEDOR` INT NULL DEFAULT NULL,
  PRIMARY KEY (`COD_COMPRA`),
  INDEX `TBL_PROVEEDOR_COD_PROVEEDOR_idx` (`COD_PROVEEDOR` ASC) VISIBLE,
  CONSTRAINT `Compra_CodProveedor`
    FOREIGN KEY (`COD_PROVEEDOR`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PROVEEDOR` (`COD_PROVEEDOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_CONFIGURACION_CAI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_CONFIGURACION_CAI` (
  `COD_TALONARIO` INT NOT NULL AUTO_INCREMENT,
  `RANGO_INICIAL` INT NULL DEFAULT NULL,
  `RANGO_FINAL` INT NULL DEFAULT NULL,
  `RANGO_ACTUAL` INT NULL DEFAULT NULL,
  `NUMERO_CAI` VARCHAR(40) NULL DEFAULT NULL,
  `FECHA_VENCIMIENTO` DATETIME NULL DEFAULT NULL,
  `ID_USUARIO` INT NULL DEFAULT NULL,
  PRIMARY KEY (`COD_TALONARIO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_DESCUENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_DESCUENTO` (
  `COD_DESCUENTO` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE_DESCUENTO` VARCHAR(20) NULL DEFAULT NULL,
  `PORCENTAJE_DESCUENTO` DECIMAL(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`COD_DESCUENTO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_TIPO_PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_TIPO_PRODUCTO` (
  `COD_TIPO_PRODUCTO` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE_TIPO_PRODUCTO` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`COD_TIPO_PRODUCTO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_PRODUCTO` (
  `COD_PRODUCTO` INT NOT NULL AUTO_INCREMENT,
  `Nombre_PRODUCTO` VARCHAR(30) NULL DEFAULT NULL,
  `DESCRIPCION` VARCHAR(255) NULL DEFAULT NULL,
  `CANTIDAD_MINIMA` INT NULL DEFAULT NULL,
  `CANTIDAD_MAXIMA` INT NULL DEFAULT NULL,
  `COD_TIPO_PRODUCTO` INT NULL DEFAULT NULL,
  `COD_PROVEEDOR` INT NULL,
  `PRECIO_VENTA` DECIMAL(8,2) NULL DEFAULT NULL,
  `EXISTENCIA` INT NULL,
  `FECHA` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `ID_USUARIO` INT NULL,
  `ESTADO` INT NULL DEFAULT '1',
  `FOTO` TEXT NULL,
  PRIMARY KEY (`COD_PRODUCTO`),
  INDEX `TBL_TIPO_PRODUCTO_COD_TIPO_PRODUCTO_idx` (`COD_TIPO_PRODUCTO` ASC) VISIBLE,
  INDEX `Producto_CodProveedor_idx` (`COD_PROVEEDOR` ASC) VISIBLE,
  CONSTRAINT `Producto_CodTipoProducto`
    FOREIGN KEY (`COD_TIPO_PRODUCTO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_TIPO_PRODUCTO` (`COD_TIPO_PRODUCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Producto_CodProveedor`
    FOREIGN KEY (`COD_PROVEEDOR`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PROVEEDOR` (`COD_PROVEEDOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_DETALLE_COMPRA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_DETALLE_COMPRA` (
  `COD_DETALLE_COMPRA` INT NOT NULL AUTO_INCREMENT,
  `PRECIO_COMPRA` DECIMAL(8,2) NULL DEFAULT NULL,
  `CANTIDAD` INT NULL DEFAULT NULL,
  `COD_PRODUCTO` INT NULL DEFAULT NULL,
  `COD_COMPRA` INT NULL DEFAULT NULL,
  PRIMARY KEY (`COD_DETALLE_COMPRA`),
  INDEX `TBL_PRODUCTO_COD_PRODUCTO_idx` (`COD_PRODUCTO` ASC) VISIBLE,
  INDEX `TBL_COMPRA_COD_COMPRA_idx` (`COD_COMPRA` ASC) VISIBLE,
  CONSTRAINT `DetalleCompra_CodProducto`
    FOREIGN KEY (`COD_PRODUCTO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PRODUCTO` (`COD_PRODUCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DetalleCompra_CodCompra`
    FOREIGN KEY (`COD_COMPRA`)
    REFERENCES `db_inversiones_atlantico`.`TBL_COMPRA` (`COD_COMPRA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_PRODUCCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_PRODUCCION` (
  `COD_PRODUCCION` INT NOT NULL AUTO_INCREMENT,
  `FECHA` DATETIME NULL DEFAULT NULL,
  `ID_USUARIO` INT NULL DEFAULT NULL,
  `COD_PRODUCTO` INT NULL DEFAULT NULL,
  PRIMARY KEY (`COD_PRODUCCION`),
  INDEX `TBL_PRODUCTO_COD_PRODUCTO_idx` (`COD_PRODUCTO` ASC) VISIBLE,
  CONSTRAINT `Produccion_CodProducto`
    FOREIGN KEY (`COD_PRODUCTO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PRODUCTO` (`COD_PRODUCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_DETALLE_PRODUCCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_DETALLE_PRODUCCION` (
  `COD_DETALLE_PRODUCCION` INT NOT NULL AUTO_INCREMENT,
  `CANTIDAD` INT NULL DEFAULT NULL,
  `COD_PRODUCTO` INT NULL DEFAULT NULL,
  `COD_PRODUCCION` INT NULL DEFAULT NULL,
  PRIMARY KEY (`COD_DETALLE_PRODUCCION`),
  INDEX `TBL_PRODUCTO_COD_PRODUCTO_idx` (`COD_PRODUCTO` ASC) VISIBLE,
  INDEX `TBL_PRODUCCION_COD_PRODUCCION_idx` (`COD_PRODUCCION` ASC) VISIBLE,
  CONSTRAINT `DetalleProduccion_CodProducto`
    FOREIGN KEY (`COD_PRODUCTO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PRODUCTO` (`COD_PRODUCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DetalleProduccion_CodProduccion`
    FOREIGN KEY (`COD_PRODUCCION`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PRODUCCION` (`COD_PRODUCCION`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_FACTURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_FACTURA` (
  `NO_FACTURA` BIGINT NOT NULL AUTO_INCREMENT,
  `FECHA` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `ID_USUARIO` INT NULL,
  `COD_CLIENTE` INT NULL,
  `TOTAL_FACTURA` DECIMAL(10,2) NULL,
  `ESTADO` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`NO_FACTURA`),
  INDEX `TBL_CLIENTE_COD_CLIENTE_idx` (`COD_CLIENTE` ASC) VISIBLE,
  CONSTRAINT `Venta_CodCliente`
    FOREIGN KEY (`COD_CLIENTE`)
    REFERENCES `db_inversiones_atlantico`.`TBL_CLIENTE` (`COD_CLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_DETALLE_FACTURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_DETALLE_FACTURA` (
  `CORRELATIVO` BIGINT NOT NULL AUTO_INCREMENT,
  `NO_FACTURA` BIGINT NULL,
  `COD_PRODUCTO` INT NULL,
  `CANTIDAD` INT NULL,
  `PRECIO_VENTA` DECIMAL(10,2) NULL,
  PRIMARY KEY (`CORRELATIVO`),
  INDEX `DetalleFactura_CodProducto_idx` (`COD_PRODUCTO` ASC) VISIBLE,
  INDEX `DetalleFactura_NoFactura_idx` (`NO_FACTURA` ASC) VISIBLE,
  CONSTRAINT `DetalleFactura_CodProducto`
    FOREIGN KEY (`COD_PRODUCTO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PRODUCTO` (`COD_PRODUCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DetalleFactura_NoFactura`
    FOREIGN KEY (`NO_FACTURA`)
    REFERENCES `db_inversiones_atlantico`.`TBL_FACTURA` (`NO_FACTURA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_ESTANTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_ESTANTE` (
  `COD_ESTANTE` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE_ESTANTE` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`COD_ESTANTE`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_FACTURA_DESCUENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_FACTURA_DESCUENTO` (
  `COD_FACTURA_DESCUENTO` INT NOT NULL AUTO_INCREMENT,
  `COD_VENTA` INT NULL DEFAULT NULL,
  `COD_DESCUENTO` INT NULL DEFAULT NULL,
  PRIMARY KEY (`COD_FACTURA_DESCUENTO`),
  INDEX `FacturaDescuento_CodVenta_idx` (`COD_VENTA` ASC) VISIBLE,
  INDEX `FacturaDescuento_CodDescuento_idx` (`COD_DESCUENTO` ASC) VISIBLE,
  CONSTRAINT `FacturaDescuento_CodVenta`
    FOREIGN KEY (`COD_VENTA`)
    REFERENCES `db_inversiones_atlantico`.`TBL_FACTURA` (`NO_FACTURA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FacturaDescuento_CodDescuento`
    FOREIGN KEY (`COD_DESCUENTO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_DESCUENTO` (`COD_DESCUENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_PROMOCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_PROMOCION` (
  `COD_PROMOCION` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE_PROMOCION` VARCHAR(100) NULL DEFAULT NULL,
  `FECHA_INICIO` DATETIME NULL DEFAULT NULL,
  `FECHA_FINAL` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`COD_PROMOCION`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_FACTURA_PROMOCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_FACTURA_PROMOCION` (
  `COD_FACTURA_PROMOCION` INT NOT NULL AUTO_INCREMENT,
  `COD_PROMOCION` INT NULL DEFAULT NULL,
  `COD_VENTA` INT NULL DEFAULT NULL,
  PRIMARY KEY (`COD_FACTURA_PROMOCION`),
  INDEX `FacturaPromocion_CodVenta_idx` (`COD_VENTA` ASC) VISIBLE,
  INDEX `FacturaPromocion_CodPromocion_idx` (`COD_PROMOCION` ASC) VISIBLE,
  CONSTRAINT `FacturaPromocion_CodVenta`
    FOREIGN KEY (`COD_VENTA`)
    REFERENCES `db_inversiones_atlantico`.`TBL_FACTURA` (`NO_FACTURA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FacturaPromocion_CodPromocion`
    FOREIGN KEY (`COD_PROMOCION`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PROMOCION` (`COD_PROMOCION`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_TIPO_INVENTARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_TIPO_INVENTARIO` (
  `COD_TIPO_INVENTARIO` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE_TIPO_INVENTARIO` CHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`COD_TIPO_INVENTARIO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_INVENTARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_INVENTARIO` (
  `COD_INVENTARIO` INT NOT NULL AUTO_INCREMENT,
  `FECHA` DATETIME NULL DEFAULT NULL,
  `DESCRIPCION` VARCHAR(255) NULL DEFAULT NULL,
  `CANTIDAD` INT NULL DEFAULT NULL,
  `COD_PRODUCTO` INT NULL DEFAULT NULL,
  `COD_TIPO_INVENTARIO` INT NULL DEFAULT NULL,
  PRIMARY KEY (`COD_INVENTARIO`),
  INDEX `TBL_PRODUCTO_COD_PRODUCTO_idx` (`COD_PRODUCTO` ASC) VISIBLE,
  INDEX `TBL_TIPO_INVENTARIO_COD_TIPO_INVENTARIO_idx` (`COD_TIPO_INVENTARIO` ASC) VISIBLE,
  CONSTRAINT `InventarioCodProducto`
    FOREIGN KEY (`COD_PRODUCTO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PRODUCTO` (`COD_PRODUCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Inventario_CodTipoInventario`
    FOREIGN KEY (`COD_TIPO_INVENTARIO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_TIPO_INVENTARIO` (`COD_TIPO_INVENTARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_TIPO_MOVIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_TIPO_MOVIMIENTO` (
  `COD_TIPO_MOVIMIENTO` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE_MOVIMIENTO` VARCHAR(7) NULL DEFAULT NULL,
  PRIMARY KEY (`COD_TIPO_MOVIMIENTO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_KARDEX`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_KARDEX` (
  `COD_KARDEX` INT NOT NULL AUTO_INCREMENT,
  `FECHA` DATETIME NULL DEFAULT NULL,
  `COD_PRODUCTO` INT NULL DEFAULT NULL,
  `COD_TIPO_MOVIMIENTO` INT NULL DEFAULT NULL,
  `COD_ESTANTE` INT NULL DEFAULT NULL,
  PRIMARY KEY (`COD_KARDEX`),
  INDEX `tbl_Producto_Cod_Producto_idx` (`COD_PRODUCTO` ASC) VISIBLE,
  INDEX `TBL_ESTANTE_COD_ESTANTE_idx` (`COD_ESTANTE` ASC) VISIBLE,
  INDEX `TBL_TIPO_MOVIMIENTO_COD_TIPO_MOVIMIENTO_idx` (`COD_TIPO_MOVIMIENTO` ASC) VISIBLE,
  CONSTRAINT `Kardex_CodProducto`
    FOREIGN KEY (`COD_PRODUCTO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PRODUCTO` (`COD_PRODUCTO`),
  CONSTRAINT `Kardex_CodEstante`
    FOREIGN KEY (`COD_ESTANTE`)
    REFERENCES `db_inversiones_atlantico`.`TBL_ESTANTE` (`COD_ESTANTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Kardex_CodTipoMovimiento`
    FOREIGN KEY (`COD_TIPO_MOVIMIENTO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_TIPO_MOVIMIENTO` (`COD_TIPO_MOVIMIENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_hist_contrasena`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_hist_contrasena` (
  `id_usuario` INT NULL DEFAULT NULL,
  `contrasena` VARCHAR(100) NOT NULL,
  `creado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_creacion` DATE NULL DEFAULT NULL,
  `modificado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_modificacion` DATE NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_parametros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_parametros` (
  `id_parametro` INT NOT NULL AUTO_INCREMENT,
  `parametro` VARCHAR(50) NOT NULL,
  `valor` VARCHAR(100) NOT NULL,
  `id_usuario` INT NOT NULL,
  `creado_por` VARCHAR(15) NULL,
  `fecha_creacion` DATE NULL,
  `modificado_por` VARCHAR(15) NULL,
  `fecha_modificacion` DATE NULL,
  PRIMARY KEY (`id_parametro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_preguntas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_preguntas` (
  `id_pregunta` INT NOT NULL AUTO_INCREMENT,
  `pregunta` VARCHAR(100) NULL DEFAULT NULL,
  `creado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_creacion` DATE NULL DEFAULT NULL,
  `modificado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_modificacion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_pregunta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_preguntas_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_preguntas_usuario` (
  `id_pregunta` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `respuesta` VARCHAR(100) NOT NULL,
  `creado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_creacion` DATE NULL DEFAULT NULL,
  `modificado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_modificacion` DATE NULL DEFAULT NULL,
  INDEX `TBL_MS_PREGUNTAS_ID_PREGUNTA_idx` (`id_pregunta` ASC) VISIBLE,
  PRIMARY KEY (`id_pregunta`, `id_usuario`),
  CONSTRAINT `PreguntasUsuario_IdPregunta`
    FOREIGN KEY (`id_pregunta`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_preguntas` (`id_pregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_bitacora` (
  `id_bitacora` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NULL,
  `id_usuario` INT NULL,
  `id_objeto` INT NULL,
  `accion` VARCHAR(20) NULL,
  `descripcion` VARCHAR(100) NULL,
  PRIMARY KEY (`id_bitacora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_MS_ESTADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_MS_ESTADO` (
  `ID_ESTADO` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE_ESTADO` VARCHAR(45) NOT NULL,
  `DESCRIPCION` VARCHAR(100) NULL,
  `CREADO_POR` VARCHAR(15) NULL,
  `FECHA_CREACION` DATE NULL,
  `MODIFICADO_POR` VARCHAR(15) NULL,
  `FECHA_MODIFICACION` DATE NULL,
  PRIMARY KEY (`ID_ESTADO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`TBL_DETALLE_FACTURA_TEMP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`TBL_DETALLE_FACTURA_TEMP` (
  `CORRELATIVO` INT NOT NULL AUTO_INCREMENT,
  `COD_PRODUCTO` INT NOT NULL,
  `CANTIDAD` INT NOT NULL,
  `PRECIO_VENTA` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`CORRELATIVO`),
  INDEX `DetalleDacturaTemp_CodProducto_idx` (`COD_PRODUCTO` ASC) VISIBLE,
  CONSTRAINT `DetalleDacturaTemp_CodProducto`
    FOREIGN KEY (`COD_PRODUCTO`)
    REFERENCES `db_inversiones_atlantico`.`TBL_PRODUCTO` (`COD_PRODUCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `db_inversiones_atlantico` ;

-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`categoria` (
  `idcategoria` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `descripcion` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `portada` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `datecreated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ruta` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `status` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`contacto` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `email` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `mensaje` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `ip` VARCHAR(15) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `dispositivo` VARCHAR(25) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `useragent` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `datecreated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_roles` (
  `id_rol` BIGINT NOT NULL AUTO_INCREMENT,
  `nombrerol` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `descripcion` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `status` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_usuarios` (
  `id_usuario` BIGINT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  `nombre_usuario` VARCHAR(80) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `apellidos` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `telefono` BIGINT NOT NULL,
  `email_user` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `password` VARCHAR(75) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `nit` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  `nombrefiscal` VARCHAR(80) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  `direccionfiscal` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  `token` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  `id_rol` BIGINT NOT NULL,
  `datecreated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  INDEX `rolid` (`id_rol` ASC) VISIBLE,
  CONSTRAINT `tbl_ms_usuarios_ibfk_1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_roles` (`id_rol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tipopago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tipopago` (
  `idtipopago` BIGINT NOT NULL AUTO_INCREMENT,
  `tipopago` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `status` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`idtipopago`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`pedido` (
  `idpedido` BIGINT NOT NULL AUTO_INCREMENT,
  `referenciacobro` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  `idtransaccionpaypal` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  `datospaypal` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  `personaid` BIGINT NOT NULL,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `costo_envio` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `monto` DECIMAL(11,2) NOT NULL,
  `tipopagoid` BIGINT NOT NULL,
  `direccion_envio` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `status` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `personaid` (`personaid` ASC) VISIBLE,
  INDEX `tipopagoid` (`tipopagoid` ASC) VISIBLE,
  CONSTRAINT `pedido_ibfk_1`
    FOREIGN KEY (`personaid`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pedido_ibfk_2`
    FOREIGN KEY (`tipopagoid`)
    REFERENCES `db_inversiones_atlantico`.`tipopago` (`idtipopago`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`producto` (
  `idproducto` BIGINT NOT NULL AUTO_INCREMENT,
  `categoriaid` BIGINT NOT NULL,
  `codigo` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `nombre` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `descripcion` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `precio` DECIMAL(11,2) NOT NULL,
  `stock` INT NOT NULL,
  `imagen` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  `datecreated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ruta` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `status` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`idproducto`),
  INDEX `categoriaid` (`categoriaid` ASC) VISIBLE,
  CONSTRAINT `producto_ibfk_1`
    FOREIGN KEY (`categoriaid`)
    REFERENCES `db_inversiones_atlantico`.`categoria` (`idcategoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`detalle_pedido` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `pedidoid` BIGINT NOT NULL,
  `productoid` BIGINT NOT NULL,
  `precio` DECIMAL(11,2) NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pedidoid` (`pedidoid` ASC) VISIBLE,
  INDEX `productoid` (`productoid` ASC) VISIBLE,
  CONSTRAINT `detalle_pedido_ibfk_1`
    FOREIGN KEY (`pedidoid`)
    REFERENCES `db_inversiones_atlantico`.`pedido` (`idpedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `detalle_pedido_ibfk_2`
    FOREIGN KEY (`productoid`)
    REFERENCES `db_inversiones_atlantico`.`producto` (`idproducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`detalle_temp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`detalle_temp` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `personaid` BIGINT NOT NULL,
  `productoid` BIGINT NOT NULL,
  `precio` DECIMAL(11,2) NOT NULL,
  `cantidad` INT NOT NULL,
  `transaccionid` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `productoid` (`productoid` ASC) VISIBLE,
  INDEX `personaid` (`personaid` ASC) VISIBLE,
  CONSTRAINT `detalle_temp_ibfk_1`
    FOREIGN KEY (`productoid`)
    REFERENCES `db_inversiones_atlantico`.`producto` (`idproducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`imagen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`imagen` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `productoid` BIGINT NOT NULL,
  `img` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `productoid` (`productoid` ASC) VISIBLE,
  CONSTRAINT `imagen_ibfk_1`
    FOREIGN KEY (`productoid`)
    REFERENCES `db_inversiones_atlantico`.`producto` (`idproducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`post` (
  `idpost` BIGINT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `contenido` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `portada` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NULL DEFAULT NULL,
  `datecreate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ruta` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `status` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`idpost`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`reembolso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`reembolso` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `pedidoid` BIGINT NOT NULL,
  `idtransaccion` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `datosreembolso` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `observacion` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `status` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pedidoid` (`pedidoid` ASC) VISIBLE,
  CONSTRAINT `reembolso_ibfk_1`
    FOREIGN KEY (`pedidoid`)
    REFERENCES `db_inversiones_atlantico`.`pedido` (`idpedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`suscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`suscripciones` (
  `idsuscripcion` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `email` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `datecreated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idsuscripcion`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_objetos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_objetos` (
  `id_objeto` BIGINT NOT NULL AUTO_INCREMENT,
  `objeto` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `descripcion` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_swedish_ci' NOT NULL,
  `status` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_objeto`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_bitacora` (
  `id_bitacora` INT NOT NULL,
  `fecha` DATETIME NULL DEFAULT NULL,
  `id_usuario` BIGINT NULL DEFAULT NULL,
  `id_objeto` BIGINT NULL DEFAULT NULL,
  `accion` VARCHAR(20) NULL DEFAULT NULL,
  `descripcion` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_bitacora`),
  INDEX `bitacora_objeto_idx` (`id_objeto` ASC) VISIBLE,
  INDEX `bitacora_usuario_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `bitacora_objeto`
    FOREIGN KEY (`id_objeto`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_objetos` (`id_objeto`),
  CONSTRAINT `bitacora_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_hist_contrasena`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_hist_contrasena` (
  `id_usuario` BIGINT NOT NULL,
  `contrasena` VARCHAR(100) NULL DEFAULT NULL,
  `creado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `modificado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `histContra_idUsuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_parametros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_parametros` (
  `id_parametro` INT NOT NULL,
  `parametro` VARCHAR(50) NULL DEFAULT NULL,
  `valor` VARCHAR(100) NULL DEFAULT NULL,
  `id_usuario` BIGINT NULL DEFAULT NULL,
  `creado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `modificado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_parametro`),
  INDEX `parametros_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `parametros_idUsuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_permisos` (
  `idpermiso` BIGINT NOT NULL AUTO_INCREMENT,
  `id_rol` BIGINT NOT NULL,
  `id_objeto` BIGINT NOT NULL,
  `r` INT NOT NULL DEFAULT '0',
  `w` INT NOT NULL DEFAULT '0',
  `u` INT NOT NULL DEFAULT '0',
  `d` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`idpermiso`),
  INDEX `rolid` (`id_rol` ASC) VISIBLE,
  INDEX `moduloid` (`id_objeto` ASC) VISIBLE,
  CONSTRAINT `tbl_ms_permisos_ibfk_1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_roles` (`id_rol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `tbl_ms_permisos_ibfk_2`
    FOREIGN KEY (`id_objeto`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_objetos` (`id_objeto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 163
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_swedish_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_preguntas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_preguntas` (
  `id_pregunta` INT NOT NULL,
  `pregunta` VARCHAR(100) NULL DEFAULT NULL,
  `creado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `modificado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_pregunta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_inversiones_atlantico`.`tbl_ms_preguntas_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_inversiones_atlantico`.`tbl_ms_preguntas_usuario` (
  `id_pregunta` INT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `respuesta` VARCHAR(100) NULL DEFAULT NULL,
  `creado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `modificado_por` VARCHAR(15) NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_pregunta`, `id_usuario`),
  INDEX `preguntaUsuario_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `preguntaUsuario_idPregunta_idx` (`id_pregunta` ASC) VISIBLE,
  CONSTRAINT `preguntaUsuario_idPregunta`
    FOREIGN KEY (`id_pregunta`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_preguntas` (`id_pregunta`),
  CONSTRAINT `preguntaUsuario_idUsuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_inversiones_atlantico`.`tbl_ms_usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
