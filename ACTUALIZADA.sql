-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: db_inversiones_atlantico
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `configuracion`
--

DROP TABLE IF EXISTS `configuracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuracion` (
  `cod` bigint NOT NULL AUTO_INCREMENT,
  `rtn` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `razon_social` varchar(100) NOT NULL,
  `telefono` bigint NOT NULL,
  `email` varchar(200) NOT NULL,
  `direccion` text NOT NULL,
  `isv` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracion`
--

LOCK TABLES `configuracion` WRITE;
/*!40000 ALTER TABLE `configuracion` DISABLE KEYS */;
INSERT INTO `configuracion` VALUES (1,'123123123','Inversiones del Atlántico','Ventas SA',12121212,'info@atlantico.com','Tela, Honduras',15.00);
/*!40000 ALTER TABLE `configuracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_temp`
--

DROP TABLE IF EXISTS `detalle_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_temp` (
  `cod_detalle_factura` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `promo` varchar(45) DEFAULT NULL,
  `cant_multi` int DEFAULT NULL,
  PRIMARY KEY (`cod_detalle_factura`),
  KEY `nofactura` (`token_user`),
  KEY `codproducto` (`cod_producto`),
  CONSTRAINT `detalle_temp_ibfk_2` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=959 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_temp`
--

LOCK TABLES `detalle_temp` WRITE;
/*!40000 ALTER TABLE `detalle_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_temp_c`
--

DROP TABLE IF EXISTS `detalle_temp_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_temp_c` (
  `cod_detalle_factura` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) NOT NULL,
  `cod_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cod_detalle_factura`),
  KEY `detalle_temp_ibfk_2_idx` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_temp_c`
--

LOCK TABLES `detalle_temp_c` WRITE;
/*!40000 ALTER TABLE `detalle_temp_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_temp_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_temp_p`
--

DROP TABLE IF EXISTS `detalle_temp_p`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_temp_p` (
  `cod_detalle_produccion` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) NOT NULL,
  `cod_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`cod_detalle_produccion`),
  KEY `DetallePromoTmp_CodProducto_idx` (`cod_producto`),
  CONSTRAINT `DetallePromoTmp_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_temp_p`
--

LOCK TABLES `detalle_temp_p` WRITE;
/*!40000 ALTER TABLE `detalle_temp_p` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_temp_p` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_temp_pr`
--

DROP TABLE IF EXISTS `detalle_temp_pr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_temp_pr` (
  `cod_detalle_produccion` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) NOT NULL,
  `cod_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`cod_detalle_produccion`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_temp_pr`
--

LOCK TABLES `detalle_temp_pr` WRITE;
/*!40000 ALTER TABLE `detalle_temp_pr` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_temp_pr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_temp_promo`
--

DROP TABLE IF EXISTS `detalle_temp_promo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_temp_promo` (
  `id_promocion_producto` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id_promocion_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_temp_promo`
--

LOCK TABLES `detalle_temp_promo` WRITE;
/*!40000 ALTER TABLE `detalle_temp_promo` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_temp_promo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_cliente`
--

DROP TABLE IF EXISTS `tbl_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_cliente` (
  `cod_cliente` int NOT NULL AUTO_INCREMENT COMMENT 'Código del cliente.',
  `rtn` varchar(14) DEFAULT NULL COMMENT 'Número de RTN del cliente.',
  `nombres` varchar(100) NOT NULL COMMENT 'Nombres del cliente.',
  `apellidos` varchar(100) DEFAULT NULL COMMENT 'Apellidos del cliente.',
  `telefono` int DEFAULT NULL COMMENT 'Número de teléfono o celular.',
  `correo_electronico` varchar(30) DEFAULT NULL COMMENT 'Correo electrónico del cliente.',
  `direccion` varchar(255) DEFAULT NULL COMMENT 'Dirección del cliente.',
  `fecha_registro` datetime DEFAULT NULL COMMENT 'Fecha en que se registró al cliente.',
  `id_usuario` int DEFAULT NULL COMMENT 'cod del usuario que registró a ese cliente.',
  `estado` int NOT NULL DEFAULT '1' COMMENT 'Estado del cliente.',
  `creado_por` varchar(15) DEFAULT NULL COMMENT 'Nombre de quién creó al cliente.',
  `fecha_creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación del cliente.',
  `modificado_por` varchar(15) DEFAULT NULL COMMENT 'Nombre del usuario que modificó algún dato del cliente.',
  `fecha_modificacion` datetime DEFAULT NULL COMMENT 'Fecha en que se mdificó algún dato del cliente.',
  PRIMARY KEY (`cod_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que guardará los datos de los clientes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_cliente`
--

LOCK TABLES `tbl_cliente` WRITE;
/*!40000 ALTER TABLE `tbl_cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_compra`
--

DROP TABLE IF EXISTS `tbl_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_compra` (
  `cod_compra` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la compra. ',
  `total_pagado` decimal(8,2) DEFAULT NULL COMMENT 'Total que se pagó en la compra.',
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en la que se realizó la compra.',
  `id_usuario` bigint DEFAULT NULL COMMENT 'cod del usuario que hizo la compra.',
  `estado` int DEFAULT '1' COMMENT 'Estado de la compra.',
  PRIMARY KEY (`cod_compra`),
  KEY `Compra_idUsuario_idx` (`id_usuario`),
  CONSTRAINT `Compra_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los datos principales de una compra.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_compra`
--

LOCK TABLES `tbl_compra` WRITE;
/*!40000 ALTER TABLE `tbl_compra` DISABLE KEYS */;
INSERT INTO `tbl_compra` VALUES (4,NULL,NULL,1,NULL),(5,NULL,NULL,1,NULL),(6,30.00,NULL,1,NULL),(7,30.00,NULL,1,NULL),(8,30.00,NULL,1,NULL),(9,30.00,NULL,1,NULL),(10,30.00,NULL,1,NULL),(11,20.00,NULL,1,NULL),(12,40.00,NULL,1,NULL),(13,210.00,NULL,1,NULL),(14,30.00,NULL,1,NULL),(15,50.00,NULL,1,NULL),(16,50.00,NULL,1,NULL),(17,50.00,NULL,1,NULL),(18,50.00,NULL,1,NULL),(19,50.00,NULL,1,NULL),(20,50.00,NULL,1,NULL),(21,80.00,NULL,1,NULL),(22,50.00,NULL,1,NULL),(23,50.00,NULL,1,NULL),(24,50.00,NULL,1,NULL),(25,100.00,NULL,1,NULL),(26,50.00,NULL,1,NULL),(27,50.00,NULL,1,NULL),(28,50.00,NULL,1,NULL),(29,50.00,NULL,1,NULL),(30,50.00,NULL,1,NULL),(31,30.00,NULL,1,NULL),(32,30.00,NULL,1,NULL),(33,50.00,NULL,1,NULL),(34,30.00,NULL,1,NULL),(35,30.00,NULL,1,NULL),(36,70.00,NULL,1,NULL),(37,80.00,NULL,1,NULL),(38,50.00,NULL,1,NULL),(39,20.00,NULL,1,NULL),(40,20.00,NULL,1,NULL),(41,150.00,'2023-04-13 11:37:55',1,2),(42,120.00,'2023-04-13 15:22:38',1,2),(43,30.00,'2023-04-13 22:03:18',1,2),(44,100.00,'2023-04-13 22:18:43',1,2),(45,300.00,'2023-04-16 10:58:17',1,1),(46,2.00,'2023-04-16 10:58:57',1,1),(47,30.00,'2023-04-17 01:33:58',1,1),(48,22.00,'2023-04-19 00:47:58',1,1),(49,4.00,'2023-04-29 00:15:02',1,1);
/*!40000 ALTER TABLE `tbl_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_configuracion_cai`
--

DROP TABLE IF EXISTS `tbl_configuracion_cai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_configuracion_cai` (
  `cod_talonario` int NOT NULL AUTO_INCREMENT COMMENT 'Código del talonario.',
  `rango_inicial` int DEFAULT NULL COMMENT 'Rango inicial del talonario.',
  `rango_final` int DEFAULT NULL COMMENT 'Rango final del talonario.',
  `rango_actual` int DEFAULT NULL COMMENT 'Rango actual del talonario.',
  `numero_CAI` varchar(100) DEFAULT NULL COMMENT 'Número CAI de la Empresa.',
  `fecha_vencimiento` date DEFAULT NULL COMMENT 'Fecha de vencimiento del talonario.',
  `id_usuario` bigint DEFAULT NULL COMMENT 'cod del usuario que registró el talonario.',
  `estado` int NOT NULL COMMENT 'Estado del talonario.',
  PRIMARY KEY (`cod_talonario`),
  KEY `CAI_IdUsuario_idx` (`id_usuario`),
  CONSTRAINT `CAI_IdUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que sirve para controlar el CAI y los rangos disponibles de un talonario.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_configuracion_cai`
--

LOCK TABLES `tbl_configuracion_cai` WRITE;
/*!40000 ALTER TABLE `tbl_configuracion_cai` DISABLE KEYS */;
INSERT INTO `tbl_configuracion_cai` VALUES (1,1,250,40,'690CF2-53A933-A8439D-DF8027-51244A-0A','2023-04-07',1,1);
/*!40000 ALTER TABLE `tbl_configuracion_cai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_descuento`
--

DROP TABLE IF EXISTS `tbl_descuento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_descuento` (
  `cod_descuento` int NOT NULL AUTO_INCREMENT COMMENT 'Código del descuento.',
  `nombre_descuento` varchar(20) DEFAULT NULL COMMENT 'Nombre del descuento.',
  `porcentaje_descuento` decimal(8,2) DEFAULT NULL COMMENT 'Porcentaje del descuento.',
  PRIMARY KEY (`cod_descuento`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los descuentos que quiere dar la empresa.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_descuento`
--

LOCK TABLES `tbl_descuento` WRITE;
/*!40000 ALTER TABLE `tbl_descuento` DISABLE KEYS */;
INSERT INTO `tbl_descuento` VALUES (16,'SIN DESCUENTO',0.00),(18,'TERCERA EDAD',15.00),(19,'DESCUENTO VIP',25.00);
/*!40000 ALTER TABLE `tbl_descuento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_detalle_compra`
--

DROP TABLE IF EXISTS `tbl_detalle_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_detalle_compra` (
  `cod_detalle_compra` int NOT NULL AUTO_INCREMENT COMMENT 'Código del detalle de compra.',
  `precio_venta` decimal(8,2) DEFAULT NULL COMMENT 'Precio de venta.',
  `cantidad` int DEFAULT NULL COMMENT 'Cantidad que se está comprando.',
  `cod_producto` int DEFAULT NULL COMMENT 'Código del producto que se está comprando.',
  `cod_compra` int DEFAULT NULL COMMENT 'Código de la compra a la que pertenecen estos detalles de la compra.',
  PRIMARY KEY (`cod_detalle_compra`),
  KEY `TBL_PRODUCTO_COD_PRODUCTO_idx` (`cod_producto`),
  KEY `TBL_COMPRA_COD_COMPRA_idx` (`cod_compra`),
  CONSTRAINT `DetalleCompra_CodCompra` FOREIGN KEY (`cod_compra`) REFERENCES `tbl_compra` (`cod_compra`),
  CONSTRAINT `DetalleCompra_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los detalles de una compra.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_compra`
--

LOCK TABLES `tbl_detalle_compra` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_compra` DISABLE KEYS */;
INSERT INTO `tbl_detalle_compra` VALUES (1,30.00,1,12,6),(2,30.00,1,12,7),(3,30.00,1,12,8),(4,30.00,1,12,9),(5,30.00,1,12,10),(6,20.00,1,13,11),(7,20.00,1,13,12),(8,20.00,1,13,12),(10,30.00,5,12,13),(11,20.00,3,13,13),(13,30.00,1,12,14),(14,20.00,1,13,15),(15,30.00,1,12,15),(17,30.00,1,12,16),(18,20.00,1,13,16),(20,30.00,1,12,17),(21,20.00,1,13,17),(23,30.00,1,12,18),(24,20.00,1,13,18),(26,30.00,1,12,19),(27,20.00,1,13,19),(29,20.00,1,13,20),(30,30.00,1,12,20),(32,30.00,1,12,21),(33,20.00,1,13,21),(34,30.00,1,12,21),(35,30.00,1,12,22),(36,20.00,1,13,22),(38,30.00,1,12,23),(39,20.00,1,13,23),(41,30.00,1,12,24),(42,20.00,1,13,24),(44,30.00,1,12,25),(45,20.00,1,13,25),(46,30.00,1,12,25),(47,20.00,1,13,25),(51,30.00,1,12,26),(52,20.00,1,13,26),(54,30.00,1,12,27),(55,20.00,1,13,27),(57,30.00,1,12,28),(58,20.00,1,13,28),(60,30.00,1,12,29),(61,20.00,1,13,29),(63,30.00,1,12,30),(64,20.00,1,13,30),(66,30.00,1,12,31),(67,30.00,1,12,32),(68,30.00,1,12,33),(69,20.00,1,13,33),(71,30.00,1,12,34),(72,30.00,1,12,35),(73,20.00,1,13,36),(74,30.00,1,12,36),(75,20.00,1,13,36),(76,30.00,1,12,37),(77,20.00,1,13,37),(78,30.00,1,12,37),(79,30.00,1,12,38),(80,20.00,1,13,38),(81,20.00,1,13,39),(82,20.00,1,13,40),(83,150.00,1,18,41),(84,100.00,1,19,42),(85,20.00,1,13,42),(86,30.00,1,12,43),(87,100.00,1,19,44),(88,100.00,1,13,45),(89,100.00,2,13,45),(91,1.00,2,13,46),(92,1.00,30,20,47),(93,1.00,10,13,48),(94,1.00,12,16,48),(95,1.00,1,16,49),(96,1.00,1,20,49),(97,1.00,2,13,49);
/*!40000 ALTER TABLE `tbl_detalle_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_detalle_factura`
--

DROP TABLE IF EXISTS `tbl_detalle_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_detalle_factura` (
  `cod_detalle_factura` bigint NOT NULL AUTO_INCREMENT COMMENT 'Código del detalle factura.',
  `cod_factura` bigint DEFAULT NULL,
  `cod_producto` int DEFAULT NULL COMMENT 'Código del producto que se está vendiendo.',
  `cantidad` int DEFAULT NULL COMMENT 'Cantidad del producto que se está vendiendo.',
  `precio_venta` decimal(10,2) DEFAULT NULL COMMENT 'Precio de Venta.',
  `cantidad_multi` int DEFAULT NULL COMMENT 'Esta es la cantidad que se va a multiplicar con el precio.',
  `promocion` varchar(100) DEFAULT NULL COMMENT 'Nombre de la promoción, en caso de que se esté vendiendo productos que pertenecen a una promoción.',
  PRIMARY KEY (`cod_detalle_factura`),
  KEY `DetalleFactura_CodProducto_idx` (`cod_producto`),
  KEY `DetalleFactura_NoFactura_idx` (`cod_factura`),
  CONSTRAINT `DetalleFactura_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `DetalleFactura_NoFactura` FOREIGN KEY (`cod_factura`) REFERENCES `tbl_factura` (`cod_factura`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los detalles de una facatura, es decir, los detalles de una venta.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_factura`
--

LOCK TABLES `tbl_detalle_factura` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_factura` DISABLE KEYS */;
INSERT INTO `tbl_detalle_factura` VALUES (1,126,18,1,100.00,1,NULL),(2,126,19,14,220.00,14,NULL),(3,126,19,5,50.00,1,NULL),(4,126,12,5,NULL,NULL,NULL),(5,126,17,5,NULL,NULL,NULL),(8,127,19,4,220.00,4,NULL),(9,128,21,1,150.00,1,NULL),(10,128,18,1,500.00,1,NULL),(11,128,24,2,NULL,NULL,NULL),(12,128,25,2,NULL,NULL,NULL),(13,128,18,1,100.00,1,NULL),(14,129,15,1,65.20,1,NULL),(15,129,18,1,500.00,1,'PROMO 1'),(16,129,24,2,NULL,NULL,'PROMO 1'),(17,129,25,2,NULL,NULL,'PROMO 1'),(21,130,19,1,220.00,1,NULL),(22,130,18,3,400.00,1,'PROMO 2'),(23,130,19,2,NULL,NULL,'PROMO 2'),(24,131,18,2,100.00,2,NULL),(25,131,18,1,500.00,1,'PROMO 1'),(26,131,24,2,NULL,NULL,'PROMO 1'),(27,131,25,2,NULL,NULL,'PROMO 1'),(28,131,22,1,100.00,1,NULL),(31,132,18,1,100.00,1,NULL),(32,132,18,3,400.00,1,'PROMO 2'),(33,132,19,2,NULL,NULL,'PROMO 2'),(34,133,18,12,100.00,12,NULL),(35,133,18,1,500.00,1,'PROMO 1'),(36,133,24,2,NULL,NULL,'PROMO 1'),(37,133,25,2,NULL,NULL,'PROMO 1');
/*!40000 ALTER TABLE `tbl_detalle_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_detalle_produccion`
--

DROP TABLE IF EXISTS `tbl_detalle_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_detalle_produccion` (
  `cod_detalle_produccion` int NOT NULL AUTO_INCREMENT COMMENT 'Código del detalle de la producción.',
  `cod_producto` int DEFAULT NULL COMMENT 'Código del producto, o mejor dicho, el insumo que se necesita para la producción.',
  `cantidad` int DEFAULT NULL COMMENT 'Cantidad del insumo que se necesita para producir.',
  `cod_produccion` int DEFAULT NULL COMMENT 'Código de la producción a la que pertenen estos detalles.',
  PRIMARY KEY (`cod_detalle_produccion`),
  KEY `DetalleProduccion_CodProduccion_idx` (`cod_produccion`),
  KEY `DetalleProduccion_CodProducto_idx` (`cod_producto`),
  CONSTRAINT `DetalleProduccion_CodProduccion` FOREIGN KEY (`cod_produccion`) REFERENCES `tbl_produccion` (`cod_produccion`),
  CONSTRAINT `DetalleProduccion_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los detalles de una producción.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_produccion`
--

LOCK TABLES `tbl_detalle_produccion` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_produccion` DISABLE KEYS */;
INSERT INTO `tbl_detalle_produccion` VALUES (1,13,5,115),(2,17,11,115),(4,12,1,116),(5,20,1,116),(7,16,1,117),(8,20,1,117),(10,13,1,118),(11,12,11,119),(12,20,22,119),(13,17,33,119),(14,12,2,120),(15,17,1,120),(16,12,10,121),(17,13,4,121);
/*!40000 ALTER TABLE `tbl_detalle_produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_factura`
--

DROP TABLE IF EXISTS `tbl_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_factura` (
  `cod_factura` bigint NOT NULL AUTO_INCREMENT COMMENT 'Código de la factura.',
  `numero_factura` bigint DEFAULT NULL COMMENT 'Número de factura en caso de usar el talonario.',
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se realizó la venta.',
  `id_usuario` bigint DEFAULT NULL COMMENT 'cod del usuario que realizó la venta.',
  `cod_cliente` int DEFAULT NULL COMMENT 'Código del cliente al que se le realizó la venta. (En caso de que se haya facturado con RTN).',
  `totalfactura` decimal(10,2) DEFAULT NULL COMMENT 'Total de la factura. Es decir, total a pagar.',
  `estado` int NOT NULL DEFAULT '1' COMMENT 'Estado de la factura.',
  `subtotal` decimal(10,2) DEFAULT NULL COMMENT 'Subtotal.',
  `isv` decimal(10,2) DEFAULT NULL COMMENT 'Impuesto.',
  `porcentaje_isv` decimal(10,2) DEFAULT NULL COMMENT 'Porcentaje del impuesto. Este porcentaje puede variar y depende del valor que se tenga en la tabla tbl_ms_parametros.',
  `descuento` decimal(10,2) DEFAULT NULL COMMENT 'Cantidad del descuento.',
  `cai` varchar(100) DEFAULT NULL COMMENT 'Número CAI.',
  PRIMARY KEY (`cod_factura`),
  KEY `TBL_CLIENTE_COD_CLIENTE_idx` (`cod_cliente`),
  CONSTRAINT `Venta_CodCliente` FOREIGN KEY (`cod_cliente`) REFERENCES `tbl_cliente` (`cod_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Esta tabla almacena los datos de una venta.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_factura`
--

LOCK TABLES `tbl_factura` WRITE;
/*!40000 ALTER TABLE `tbl_factura` DISABLE KEYS */;
INSERT INTO `tbl_factura` VALUES (126,33,'2023-04-24 11:13:45',1,5,3430.00,1,2982.61,447.39,15.00,0.00,'690CF2-53A933-A8439D-DF8027-51244A-0A'),(127,34,'2023-04-24 11:24:46',1,5,748.00,1,765.22,114.78,15.00,132.00,'690CF2-53A933-A8439D-DF8027-51244A-0A'),(128,35,'2023-04-24 16:37:51',1,5,637.50,1,652.17,97.83,15.00,112.50,'690CF2-53A933-A8439D-DF8027-51244A-0A'),(129,36,'2023-04-28 10:27:29',1,5,565.20,2,491.48,73.72,15.00,0.00,'690CF2-53A933-A8439D-DF8027-51244A-0A'),(130,37,'2023-04-28 10:30:50',1,5,1420.00,1,1234.78,185.22,15.00,0.00,'690CF2-53A933-A8439D-DF8027-51244A-0A'),(131,38,'2023-04-28 20:24:31',1,5,800.00,1,695.65,104.35,15.00,0.00,'690CF2-53A933-A8439D-DF8027-51244A-0A'),(132,39,'2023-04-29 00:10:37',1,5,1300.00,1,1130.43,169.57,15.00,0.00,'690CF2-53A933-A8439D-DF8027-51244A-0A'),(133,40,'2023-06-02 10:37:07',1,5,1700.00,1,1478.26,221.74,15.00,0.00,'690CF2-53A933-A8439D-DF8027-51244A-0A');
/*!40000 ALTER TABLE `tbl_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_kardex`
--

DROP TABLE IF EXISTS `tbl_kardex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_kardex` (
  `cod_kardex` int NOT NULL AUTO_INCREMENT COMMENT 'Código del Kardex.',
  `cod_producto` int DEFAULT NULL COMMENT 'Código del producto.',
  `cod_tipo_movimiento` int DEFAULT NULL COMMENT 'Código del tipo de movimiento. Será de Entrada o Salida.',
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha del movimiento.',
  `cantidad` int DEFAULT NULL COMMENT 'Cantidad del producto o insumo que se ha tenido un movimiento.',
  PRIMARY KEY (`cod_kardex`),
  KEY `tbl_Producto_Cod_Producto_idx` (`cod_producto`),
  KEY `Kardex_idTipoMovimiento_idx` (`cod_tipo_movimiento`),
  CONSTRAINT `Kardex_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `Kardex_idTipoMovimiento` FOREIGN KEY (`cod_tipo_movimiento`) REFERENCES `tbl_tipo_movimiento` (`cod_tipo_movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que mostrará los movimientos de los productos. Ya sean de entrada o salida.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_kardex`
--

LOCK TABLES `tbl_kardex` WRITE;
/*!40000 ALTER TABLE `tbl_kardex` DISABLE KEYS */;
INSERT INTO `tbl_kardex` VALUES (1,12,1,'2023-03-17 00:00:00',20),(2,12,2,'2023-03-17 00:00:00',10),(3,15,2,'2023-04-19 00:34:20',1),(4,19,2,'2023-04-19 00:34:20',1),(5,18,2,'2023-04-19 00:34:20',10),(6,13,1,'2023-04-19 00:47:58',10),(7,16,1,'2023-04-19 00:47:58',12),(9,12,2,'2023-04-19 00:51:37',11),(10,20,2,'2023-04-19 00:51:37',22),(11,17,2,'2023-04-19 00:51:37',33),(12,15,1,'2023-04-19 08:43:35',2),(13,15,1,'2023-04-19 08:43:37',2),(14,15,1,'2023-04-19 08:43:59',2),(15,18,1,'2023-04-19 08:47:48',12),(16,18,2,'2023-04-19 09:09:23',1),(17,18,2,'2023-04-19 09:14:50',1),(18,19,2,'2023-04-19 09:14:50',1),(20,15,2,'2023-04-19 09:32:27',1),(21,18,2,'2023-04-19 09:32:27',1),(23,15,2,'2023-04-19 09:32:51',1),(24,18,2,'2023-04-19 09:33:56',1),(25,19,2,'2023-04-19 09:34:25',1),(26,15,1,'2023-04-19 12:27:21',10),(27,18,2,'2023-04-19 12:50:06',1),(28,18,2,'2023-04-19 12:51:24',1),(29,18,2,'2023-04-19 13:06:10',1),(30,18,2,'2023-04-19 13:13:04',1),(31,15,2,'2023-04-20 18:06:49',1),(32,19,2,'2023-04-20 18:06:49',1),(34,18,2,'2023-04-20 21:37:04',1),(35,16,2,'2023-04-21 13:00:19',30),(36,20,2,'2023-04-21 13:00:19',40),(38,15,2,'2023-04-21 17:36:27',1),(39,19,2,'2023-04-21 17:36:27',5),(40,12,2,'2023-04-21 17:36:27',5),(41,17,2,'2023-04-21 17:36:27',5),(42,16,2,'2023-04-21 17:36:27',30),(43,20,2,'2023-04-21 17:36:27',40),(45,19,2,'2023-04-21 21:16:40',5),(46,12,2,'2023-04-21 21:16:40',5),(47,17,2,'2023-04-21 21:16:40',5),(48,18,2,'2023-04-21 21:16:40',1),(49,15,2,'2023-04-21 21:16:40',1),(52,15,2,'2023-04-21 22:14:25',1),(53,16,2,'2023-04-21 22:14:25',30),(54,20,2,'2023-04-21 22:14:25',40),(55,15,2,'2023-04-21 22:56:55',1),(56,16,2,'2023-04-21 22:56:55',30),(57,20,2,'2023-04-21 22:56:55',40),(58,19,2,'2023-04-21 23:02:46',5),(59,12,2,'2023-04-21 23:02:46',5),(60,17,2,'2023-04-21 23:02:46',5),(61,15,2,'2023-04-21 23:02:46',3),(65,19,2,'2023-04-22 12:21:02',5),(66,12,2,'2023-04-22 12:21:02',5),(67,17,2,'2023-04-22 12:21:02',5),(68,19,2,'2023-04-22 12:54:17',5),(69,12,2,'2023-04-22 12:54:17',5),(70,17,2,'2023-04-22 12:54:17',5),(71,19,2,'2023-04-22 12:56:29',5),(72,12,2,'2023-04-22 12:56:29',5),(73,17,2,'2023-04-22 12:56:29',5),(74,15,2,'2023-04-22 12:57:11',1),(75,16,2,'2023-04-22 12:57:11',30),(76,20,2,'2023-04-22 12:57:11',40),(77,16,2,'2023-04-22 14:17:11',30),(78,20,2,'2023-04-22 14:17:11',40),(79,15,2,'2023-04-22 14:17:11',14),(80,15,2,'2023-04-22 15:05:13',1),(81,19,2,'2023-04-22 15:05:13',5),(82,12,2,'2023-04-22 15:05:13',5),(83,17,2,'2023-04-22 15:05:13',5),(84,16,2,'2023-04-22 15:05:13',30),(85,20,2,'2023-04-22 15:05:13',40),(86,18,2,'2023-04-22 15:05:13',1),(87,15,2,'2023-04-23 18:52:57',1),(88,15,2,'2023-04-23 19:27:31',1),(89,15,2,'2023-04-23 19:27:34',1),(90,15,2,'2023-04-23 19:27:58',1),(91,15,2,'2023-04-23 19:29:52',1),(92,15,2,'2023-04-23 19:35:13',1),(93,15,2,'2023-04-23 19:36:43',1),(94,15,2,'2023-04-23 19:46:51',1),(95,15,2,'2023-04-23 19:52:48',1),(96,15,2,'2023-04-23 20:02:28',1),(97,15,2,'2023-04-23 20:07:13',1),(98,15,2,'2023-04-23 20:07:15',1),(99,15,2,'2023-04-23 20:07:56',1),(100,15,2,'2023-04-23 20:08:52',1),(101,15,2,'2023-04-23 22:24:08',1),(102,15,1,'2023-04-24 08:31:13',10),(103,18,2,'2023-04-24 11:13:45',1),(104,19,2,'2023-04-24 11:13:45',14),(105,19,2,'2023-04-24 11:13:45',5),(106,12,2,'2023-04-24 11:13:45',5),(107,17,2,'2023-04-24 11:13:45',5),(110,19,2,'2023-04-24 11:24:46',4),(111,21,2,'2023-04-24 16:37:51',1),(112,18,2,'2023-04-24 16:37:51',1),(113,24,2,'2023-04-24 16:37:51',2),(114,25,2,'2023-04-24 16:37:51',2),(115,18,2,'2023-04-24 16:37:51',1),(116,15,2,'2023-04-28 10:27:29',1),(117,18,2,'2023-04-28 10:27:29',1),(118,24,2,'2023-04-28 10:27:29',2),(119,25,2,'2023-04-28 10:27:29',2),(123,19,2,'2023-04-28 10:30:50',1),(124,18,2,'2023-04-28 10:30:50',3),(125,19,2,'2023-04-28 10:30:50',2),(126,18,2,'2023-04-28 20:24:31',2),(127,18,2,'2023-04-28 20:24:31',1),(128,24,2,'2023-04-28 20:24:31',2),(129,25,2,'2023-04-28 20:24:31',2),(130,22,2,'2023-04-28 20:24:31',1),(133,18,2,'2023-04-29 00:10:37',1),(134,18,2,'2023-04-29 00:10:37',3),(135,19,2,'2023-04-29 00:10:37',2),(136,16,1,'2023-04-29 00:15:02',1),(137,20,1,'2023-04-29 00:15:02',1),(138,13,1,'2023-04-29 00:15:02',2),(139,12,2,'2023-04-29 00:16:21',2),(140,17,2,'2023-04-29 00:16:21',1),(142,19,1,'2023-04-29 00:16:28',1),(143,18,2,'2023-06-02 10:37:07',12),(144,18,2,'2023-06-02 10:37:07',1),(145,24,2,'2023-06-02 10:37:07',2),(146,25,2,'2023-06-02 10:37:07',2),(150,12,2,'2023-06-02 10:38:55',10),(151,13,2,'2023-06-02 10:38:55',4),(153,19,1,'2023-06-02 10:40:03',10);
/*!40000 ALTER TABLE `tbl_kardex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_bitacora`
--

DROP TABLE IF EXISTS `tbl_ms_bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_bitacora` (
  `id_bitacora` int NOT NULL AUTO_INCREMENT COMMENT 'cod de la bitácora.',
  `fecha` datetime DEFAULT NULL COMMENT 'Fecha en que sucedió el evento.',
  `id_usuario` bigint DEFAULT NULL COMMENT 'cod del usuario que realizó algún movimiento.',
  `id_objeto` bigint DEFAULT NULL COMMENT 'cod del objeto (pantalla) en la que se dió el evento.',
  `accion` varchar(20) DEFAULT NULL COMMENT 'Acción realizada.',
  `descripcion` varchar(255) DEFAULT NULL COMMENT 'Descripción detallada del evento.',
  PRIMARY KEY (`id_bitacora`),
  KEY `bitacora_objeto_idx` (`id_objeto`),
  KEY `bitacora_usuario_idx` (`id_usuario`),
  CONSTRAINT `bitacora_objeto` FOREIGN KEY (`id_objeto`) REFERENCES `tbl_ms_objetos` (`id_objeto`),
  CONSTRAINT `bitacora_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=970 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena todos los eventos que se generen dentro del sistema.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_bitacora`
--

LOCK TABLES `tbl_ms_bitacora` WRITE;
/*!40000 ALTER TABLE `tbl_ms_bitacora` DISABLE KEYS */;
INSERT INTO `tbl_ms_bitacora` VALUES (1,'2023-04-12 21:34:54',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(2,'2023-04-12 21:48:25',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(3,'2023-04-12 21:48:46',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(4,'2023-04-12 21:49:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(5,'2023-04-12 21:49:46',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(6,'2023-04-12 21:50:08',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(7,'2023-04-12 21:53:23',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(8,'2023-04-12 21:54:18',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(9,'2023-04-12 21:55:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(10,'2023-04-12 22:05:29',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(11,'2023-04-12 22:14:01',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(12,'2023-04-12 22:15:29',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(13,'2023-04-12 22:16:28',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(14,'2023-04-12 22:20:12',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(15,'2023-04-12 22:21:47',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(16,'2023-04-12 22:21:59',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(17,'2023-04-12 22:22:30',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(18,'2023-04-12 22:29:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(19,'2023-04-12 22:37:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(20,'2023-04-12 22:38:09',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(21,'2023-04-12 22:40:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(22,'2023-04-12 22:50:03',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(23,'2023-04-12 23:18:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(24,'2023-04-13 00:01:22',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(25,'2023-04-13 00:02:01',1,2,'CREAR','CREACION DE CLIENTE'),(26,'2023-04-13 00:29:04',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(27,'2023-04-13 00:29:26',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(28,'2023-04-13 00:29:44',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(29,'2023-04-13 00:29:47',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(30,'2023-04-13 00:30:48',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(31,'2023-04-13 00:33:04',1,2,'CREAR','CREACION DE CLIENTE'),(32,'2023-04-13 00:33:10',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(33,'2023-04-13 00:33:30',1,2,'CREAR','CREACION DE CLIENTE'),(34,'2023-04-13 00:34:57',1,2,'CREAR','CREACION DE CLIENTE'),(35,'2023-04-13 00:35:48',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(36,'2023-04-13 00:36:01',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(37,'2023-04-13 00:36:35',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(38,'2023-04-13 00:36:56',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(39,'2023-04-13 00:37:01',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(40,'2023-04-13 00:37:15',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(41,'2023-04-13 00:38:06',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(42,'2023-04-13 00:42:30',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(43,'2023-04-13 00:42:41',1,2,'CREAR','CREACION DE CLIENTE'),(44,'2023-04-13 00:43:00',1,2,'CREAR','CREACION DE CLIENTE'),(45,'2023-04-13 00:43:19',1,2,'CREAR','CREACION DE CLIENTE'),(46,'2023-04-13 00:43:27',1,2,'CREAR','CREACION DE CLIENTE'),(47,'2023-04-13 00:47:00',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(48,'2023-04-13 00:47:08',1,2,'INGRESO','INGRESO AL SISTEMA'),(49,'2023-04-13 00:47:14',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(50,'2023-04-13 00:47:20',1,2,'CREAR','CREACION DE CLIENTE'),(51,'2023-04-13 00:47:42',1,2,'CREAR','CREACION DE CLIENTE'),(52,'2023-04-13 00:50:15',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(53,'2023-04-13 00:50:28',1,2,'CREAR','CREACION DE CLIENTE'),(54,'2023-04-13 00:54:04',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(55,'2023-04-13 00:55:09',1,2,'INGRESO','INGRESO AL SISTEMA'),(56,'2023-04-13 00:55:16',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(57,'2023-04-13 00:55:25',1,2,'CREAR','CREACION DE CLIENTE'),(58,'2023-04-13 00:55:31',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(59,'2023-04-13 00:56:18',1,2,'INGRESO','INGRESO AL SISTEMA'),(60,'2023-04-13 00:56:23',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(61,'2023-04-13 00:56:33',1,2,'CREAR','CREACION DE CLIENTE'),(62,'2023-04-13 00:56:41',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(63,'2023-04-13 00:56:54',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(64,'2023-04-13 00:57:04',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(65,'2023-04-13 00:57:11',1,2,'CREAR','CREACION DE CLIENTE'),(66,'2023-04-13 00:57:28',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(67,'2023-04-13 00:57:37',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(68,'2023-04-13 00:57:43',1,2,'CREAR','CREACION DE CLIENTE'),(69,'2023-04-13 00:58:17',1,2,'CREAR','CREACION DE CLIENTE'),(70,'2023-04-13 00:58:21',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(71,'2023-04-13 00:58:55',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(72,'2023-04-13 01:10:14',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(73,'2023-04-13 02:37:52',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(74,'2023-04-13 02:37:57',1,2,'CREAR','CREACION DE CLIENTE'),(75,'2023-04-13 02:43:11',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(76,'2023-04-13 03:30:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(77,'2023-04-13 03:30:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(78,'2023-04-13 03:33:16',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(79,'2023-04-13 03:34:04',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(80,'2023-04-13 09:11:48',1,2,'INGRESO','INGRESO AL SISTEMA'),(81,'2023-04-13 10:21:05',1,2,'CREAR','CREACION DE PRODUCTO'),(82,'2023-04-13 10:24:41',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PRODUCTO'),(83,'2023-04-13 10:27:48',1,2,'CREAR','CREACION DE PRODUCTO'),(84,'2023-04-13 10:29:04',1,2,'CREAR','CREACION DE PRODUCTO'),(85,'2023-04-13 10:29:37',1,2,'CREAR','CREACION DE PRODUCTO'),(86,'2023-04-13 10:30:07',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PRODUCTO'),(87,'2023-04-13 10:30:40',1,2,'CREAR','CREACION DE PRODUCTO'),(88,'2023-04-13 10:30:55',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PRODUCTO'),(89,'2023-04-13 10:31:06',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(90,'2023-04-13 10:31:20',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(91,'2023-04-13 10:31:58',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(92,'2023-04-13 11:35:28',1,2,'INGRESO','INGRESO AL SISTEMA'),(93,'2023-04-13 11:35:39',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(94,'2023-04-13 11:35:56',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(95,'2023-04-13 11:37:59',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(96,'2023-04-13 11:38:30',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(97,'2023-04-13 11:40:16',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(98,'2023-04-13 14:47:00',1,2,'INGRESO','INGRESO AL SISTEMA'),(99,'2023-04-13 14:48:10',1,2,'INGRESO','INGRESO AL SISTEMA'),(100,'2023-04-13 14:48:17',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(101,'2023-04-13 14:48:54',1,2,'INGRESO','INGRESO AL SISTEMA'),(102,'2023-04-13 14:49:26',1,2,'INGRESO','INGRESO AL SISTEMA'),(103,'2023-04-13 14:51:47',1,2,'INGRESO','INGRESO AL SISTEMA'),(104,'2023-04-13 14:51:59',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(105,'2023-04-13 14:53:18',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(106,'2023-04-13 15:03:39',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(107,'2023-04-13 15:03:42',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(108,'2023-04-13 15:04:19',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(109,'2023-04-13 15:06:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(110,'2023-04-13 15:06:28',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(111,'2023-04-13 15:08:42',1,2,'INGRESO','INGRESO AL SISTEMA'),(112,'2023-04-13 15:16:06',1,2,'CREAR','CREACION DE PRODUCTO'),(113,'2023-04-13 15:19:30',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(114,'2023-04-13 15:19:36',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(115,'2023-04-13 15:23:25',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(116,'2023-04-13 15:30:36',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(117,'2023-04-13 15:38:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(118,'2023-04-13 15:38:22',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(119,'2023-04-13 21:20:21',1,2,'INGRESO','INGRESO AL SISTEMA'),(120,'2023-04-13 21:20:37',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(121,'2023-04-13 21:21:27',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(122,'2023-04-13 21:22:02',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(123,'2023-04-13 21:22:09',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(124,'2023-04-13 21:22:52',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(125,'2023-04-13 21:23:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(126,'2023-04-13 21:24:06',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(127,'2023-04-13 21:26:17',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(128,'2023-04-13 21:27:00',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(129,'2023-04-13 21:27:22',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(130,'2023-04-13 21:27:29',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(131,'2023-04-13 21:27:30',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(132,'2023-04-13 21:30:53',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(133,'2023-04-13 21:31:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(134,'2023-04-13 21:34:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(135,'2023-04-13 21:47:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(136,'2023-04-13 21:52:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(137,'2023-04-13 21:52:33',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(138,'2023-04-13 21:52:36',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(139,'2023-04-13 21:56:32',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(140,'2023-04-13 22:01:54',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(141,'2023-04-13 22:03:27',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(142,'2023-04-13 22:03:46',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(143,'2023-04-13 22:12:43',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(144,'2023-04-13 22:23:59',1,2,'INGRESO','INGRESO AL SISTEMA'),(145,'2023-04-13 22:24:35',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(146,'2023-04-13 22:27:53',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(147,'2023-04-13 22:32:14',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(148,'2023-04-13 22:40:44',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(149,'2023-04-13 22:42:19',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(150,'2023-04-13 22:43:18',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(151,'2023-04-13 22:45:28',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(152,'2023-04-13 22:46:01',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(153,'2023-04-14 00:07:27',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(154,'2023-04-14 00:12:02',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(155,'2023-04-14 00:14:08',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(156,'2023-04-14 00:14:21',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(157,'2023-04-14 18:17:53',1,2,'INGRESO','INGRESO AL SISTEMA'),(158,'2023-04-14 18:17:58',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(159,'2023-04-14 18:27:49',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(160,'2023-04-14 18:28:01',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(161,'2023-04-14 18:28:06',1,2,'INGRESO','INGRESO AL SISTEMA'),(162,'2023-04-14 18:28:16',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(163,'2023-04-14 18:28:45',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(164,'2023-04-14 18:29:35',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(165,'2023-04-14 18:29:42',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(166,'2023-04-14 18:36:05',1,2,'INGRESO','INGRESO AL SISTEMA'),(167,'2023-04-14 18:36:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(168,'2023-04-14 18:50:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(169,'2023-04-14 18:54:28',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(170,'2023-04-14 18:56:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(171,'2023-04-14 18:57:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(172,'2023-04-14 18:57:30',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(173,'2023-04-14 18:57:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(174,'2023-04-14 18:58:03',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(175,'2023-04-14 19:00:29',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(176,'2023-04-14 19:00:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(177,'2023-04-14 19:04:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(178,'2023-04-14 19:05:20',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(179,'2023-04-14 19:05:32',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(180,'2023-04-14 19:56:07',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(181,'2023-04-14 21:03:43',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(182,'2023-04-14 22:32:31',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(183,'2023-04-14 22:33:52',1,2,'INGRESO','INGRESO AL SISTEMA'),(184,'2023-04-14 22:34:18',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(185,'2023-04-14 22:34:28',1,2,'INGRESO','INGRESO AL SISTEMA'),(186,'2023-04-14 22:44:33',1,2,'INGRESO','INGRESO AL SISTEMA'),(187,'2023-04-15 00:00:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(188,'2023-04-15 00:01:25',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(189,'2023-04-15 00:01:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(190,'2023-04-15 00:02:12',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(191,'2023-04-15 00:04:46',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(192,'2023-04-15 00:05:02',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(193,'2023-04-15 00:06:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(194,'2023-04-15 00:07:17',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(195,'2023-04-15 00:08:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(196,'2023-04-15 00:09:45',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(197,'2023-04-15 00:10:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(198,'2023-04-15 00:11:52',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(199,'2023-04-15 00:12:18',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(200,'2023-04-15 00:12:35',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(201,'2023-04-15 00:15:21',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(202,'2023-04-15 00:16:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(203,'2023-04-15 00:17:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(204,'2023-04-15 00:17:36',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(205,'2023-04-15 00:20:18',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(206,'2023-04-15 00:21:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(207,'2023-04-15 00:22:29',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(208,'2023-04-15 00:23:02',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(209,'2023-04-15 17:24:57',1,2,'INGRESO','INGRESO AL SISTEMA'),(210,'2023-04-15 17:30:38',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(211,'2023-04-15 17:31:12',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(212,'2023-04-15 17:31:55',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(213,'2023-04-15 17:32:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(214,'2023-04-15 17:32:53',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(215,'2023-04-15 17:34:44',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(216,'2023-04-15 17:35:48',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(217,'2023-04-15 17:37:19',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(218,'2023-04-15 17:40:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(219,'2023-04-15 19:52:10',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(220,'2023-04-15 19:52:15',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(221,'2023-04-15 19:53:36',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(222,'2023-04-15 19:55:13',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(223,'2023-04-15 20:07:25',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(224,'2023-04-15 20:07:26',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(225,'2023-04-15 20:22:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(226,'2023-04-15 20:22:17',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(227,'2023-04-15 20:22:27',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(228,'2023-04-15 20:22:53',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(229,'2023-04-15 20:22:59',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(230,'2023-04-15 20:23:20',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(231,'2023-04-15 20:25:11',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(232,'2023-04-15 22:36:20',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(233,'2023-04-15 22:36:56',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(234,'2023-04-15 22:37:09',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(235,'2023-04-15 22:37:38',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(236,'2023-04-15 22:38:15',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(237,'2023-04-15 22:38:55',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(238,'2023-04-15 22:41:54',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(239,'2023-04-15 22:42:44',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(240,'2023-04-15 22:42:47',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(241,'2023-04-15 22:43:22',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(242,'2023-04-15 22:46:57',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(243,'2023-04-15 22:47:25',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(244,'2023-04-15 22:48:01',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(245,'2023-04-15 23:47:42',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(246,'2023-04-15 23:59:24',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(247,'2023-04-16 00:17:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(248,'2023-04-16 02:05:18',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(249,'2023-04-16 02:07:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(250,'2023-04-16 02:21:03',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(251,'2023-04-16 02:55:21',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(252,'2023-04-16 02:55:28',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(253,'2023-04-16 02:55:36',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(254,'2023-04-16 02:55:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(255,'2023-04-16 02:56:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(256,'2023-04-16 02:56:57',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(257,'2023-04-16 02:57:05',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(258,'2023-04-16 02:57:10',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(259,'2023-04-16 08:56:44',1,2,'INGRESO','INGRESO AL SISTEMA'),(260,'2023-04-16 08:57:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(261,'2023-04-16 09:14:06',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(262,'2023-04-16 09:25:26',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(263,'2023-04-16 09:25:45',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(264,'2023-04-16 09:26:52',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(265,'2023-04-16 09:27:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(266,'2023-04-16 09:32:00',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(267,'2023-04-16 10:27:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(268,'2023-04-16 10:29:03',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(269,'2023-04-16 10:55:58',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(270,'2023-04-16 10:56:47',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(271,'2023-04-16 10:58:21',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(272,'2023-04-16 10:59:03',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(273,'2023-04-16 10:59:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(274,'2023-04-16 14:11:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(275,'2023-04-16 14:11:52',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(276,'2023-04-16 14:12:09',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(277,'2023-04-16 14:12:22',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(278,'2023-04-16 14:13:27',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(279,'2023-04-16 14:13:42',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(280,'2023-04-16 14:14:37',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(281,'2023-04-16 14:15:01',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(282,'2023-04-16 14:15:46',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(283,'2023-04-16 14:18:31',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(284,'2023-04-16 14:19:05',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(285,'2023-04-16 14:20:50',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(286,'2023-04-16 14:21:42',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(287,'2023-04-16 14:21:56',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(288,'2023-04-16 14:23:01',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(289,'2023-04-16 14:23:29',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(290,'2023-04-16 14:24:15',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(291,'2023-04-16 14:25:01',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(292,'2023-04-16 15:09:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(293,'2023-04-16 16:04:13',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(294,'2023-04-16 18:54:05',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(295,'2023-04-16 21:32:46',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(296,'2023-04-16 21:33:41',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(297,'2023-04-16 21:34:05',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(298,'2023-04-16 22:59:06',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(299,'2023-04-16 23:16:41',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(300,'2023-04-17 00:53:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(301,'2023-04-17 01:33:35',1,2,'CREAR','CREACION DE PRODUCTO'),(302,'2023-04-17 01:33:40',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(303,'2023-04-17 01:34:01',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(304,'2023-04-17 07:58:02',1,2,'INGRESO','INGRESO AL SISTEMA'),(305,'2023-04-17 07:59:15',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(306,'2023-04-17 12:06:59',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(307,'2023-04-17 12:09:25',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(308,'2023-04-17 20:56:06',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(309,'2023-04-17 20:57:03',1,2,'CREAR','CREACION DE CLIENTE'),(310,'2023-04-17 20:58:23',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(311,'2023-04-17 21:09:24',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(312,'2023-04-17 21:11:55',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(313,'2023-04-17 21:29:10',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(314,'2023-04-17 21:29:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(315,'2023-04-17 21:31:46',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(316,'2023-04-17 21:33:00',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(317,'2023-04-17 21:33:31',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(318,'2023-04-17 21:34:16',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(319,'2023-04-17 21:34:28',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(320,'2023-04-17 21:39:14',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(321,'2023-04-17 21:39:32',1,2,'CREAR','CREACIÓN DE PROMOCION'),(322,'2023-04-17 21:42:08',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(323,'2023-04-17 21:42:52',1,2,'CREAR','CREACION DE USUARIO'),(324,'2023-04-17 21:43:03',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(325,'2023-04-17 21:46:43',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(326,'2023-04-17 21:46:52',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(327,'2023-04-17 21:47:03',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(328,'2023-04-17 21:47:56',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(329,'2023-04-17 21:48:14',1,2,'CREAR','CREACION DE USUARIO'),(330,'2023-04-17 21:49:05',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(331,'2023-04-17 21:49:23',1,2,'CREAR','CREACION DE USUARIO'),(332,'2023-04-17 21:55:15',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(333,'2023-04-17 21:55:46',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(334,'2023-04-17 21:55:56',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(335,'2023-04-17 21:57:17',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(336,'2023-04-17 22:11:05',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(337,'2023-04-17 22:13:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(338,'2023-04-17 22:13:44',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(339,'2023-04-17 22:14:28',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(340,'2023-04-17 22:24:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(341,'2023-04-17 22:25:38',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(342,'2023-04-17 22:27:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(343,'2023-04-17 22:28:32',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(344,'2023-04-17 23:36:25',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(345,'2023-04-17 23:36:41',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(346,'2023-04-17 23:38:55',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(347,'2023-04-17 23:39:03',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(348,'2023-04-17 23:39:10',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(349,'2023-04-17 23:39:20',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(350,'2023-04-17 23:39:27',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(351,'2023-04-17 23:40:30',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(352,'2023-04-17 23:41:08',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(353,'2023-04-17 23:41:14',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(354,'2023-04-17 23:44:00',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(355,'2023-04-17 23:45:16',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(356,'2023-04-17 23:45:21',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(357,'2023-04-17 23:45:29',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(358,'2023-04-17 23:45:32',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(359,'2023-04-17 23:45:54',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(360,'2023-04-17 23:46:49',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(361,'2023-04-17 23:48:17',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(362,'2023-04-17 23:48:37',1,2,'ELIMINAR','ELIMINACIÓN DE PREGUNTA'),(363,'2023-04-17 23:48:43',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(364,'2023-04-17 23:48:53',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(365,'2023-04-17 23:48:56',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(366,'2023-04-17 23:49:10',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(367,'2023-04-17 23:49:15',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(368,'2023-04-17 23:50:55',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(369,'2023-04-17 23:51:03',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(370,'2023-04-17 23:52:31',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(371,'2023-04-17 23:57:15',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(372,'2023-04-17 23:57:38',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(373,'2023-04-17 23:57:50',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(374,'2023-04-17 23:57:58',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(375,'2023-04-17 23:58:01',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(376,'2023-04-18 00:01:38',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(377,'2023-04-18 00:02:16',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(378,'2023-04-18 00:02:25',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(379,'2023-04-18 00:03:17',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(380,'2023-04-18 00:04:04',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(381,'2023-04-18 00:04:40',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(382,'2023-04-18 00:04:47',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(383,'2023-04-18 00:05:22',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(384,'2023-04-18 00:05:25',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(385,'2023-04-18 00:06:45',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(386,'2023-04-18 00:07:18',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(387,'2023-04-18 00:07:26',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(388,'2023-04-18 00:07:29',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(389,'2023-04-18 00:23:56',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(390,'2023-04-18 00:24:01',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(391,'2023-04-18 00:31:30',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(392,'2023-04-18 00:31:36',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(393,'2023-04-18 00:32:51',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(394,'2023-04-18 00:33:00',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(395,'2023-04-18 00:33:08',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(396,'2023-04-18 00:33:19',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(397,'2023-04-18 00:33:27',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PREGUNTA'),(398,'2023-04-18 00:38:05',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(399,'2023-04-18 00:38:10',1,2,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(400,'2023-04-18 00:38:25',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(401,'2023-04-18 00:38:50',1,2,'CREAR','CREACION DE USUARIO'),(402,'2023-04-18 00:40:34',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(403,'2023-04-18 00:40:57',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(404,'2023-04-18 00:41:24',1,2,'CREAR','CREACION DE USUARIO'),(405,'2023-04-18 00:43:18',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(406,'2023-04-18 00:43:41',1,2,'CREAR','CREACION DE USUARIO'),(407,'2023-04-18 00:43:49',1,2,'CREAR','CREACION DE USUARIO'),(408,'2023-04-18 00:43:57',1,2,'CREAR','CREACION DE USUARIO'),(409,'2023-04-18 00:44:03',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(410,'2023-04-18 00:53:44',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(411,'2023-04-18 00:54:04',1,2,'CREAR','CREACION DE USUARIO'),(412,'2023-04-18 01:16:56',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(413,'2023-04-18 01:17:02',1,2,'CREAR','CREACIÓN DE PREGUNTA'),(414,'2023-04-18 01:28:21',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(415,'2023-04-18 08:50:19',1,2,'INGRESO','INGRESO AL SISTEMA'),(416,'2023-04-18 09:47:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(417,'2023-04-18 09:48:25',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(418,'2023-04-18 10:12:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(419,'2023-04-18 10:13:20',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(420,'2023-04-18 10:13:58',1,11,'INGRESO','INGRESO AL MÓDULO COMPRAS'),(421,'2023-04-18 10:35:34',1,17,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(422,'2023-04-18 10:35:48',1,17,'ACTUALIZAR','ACTUALIZACIÓN DE PARÁMETRO'),(423,'2023-04-18 10:36:13',1,17,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(424,'2023-04-18 10:36:54',1,17,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(425,'2023-04-18 15:16:16',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(426,'2023-04-18 15:17:46',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(427,'2023-04-18 19:27:22',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(428,'2023-04-18 19:27:35',1,2,'INGRESO','INGRESO AL SISTEMA'),(429,'2023-04-19 00:20:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(430,'2023-04-19 00:24:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(431,'2023-04-19 00:34:00',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(432,'2023-04-19 00:34:23',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(433,'2023-04-19 00:34:46',1,15,'INGRESO','INGRESO AL MÓDULO DE KARDEX'),(434,'2023-04-19 00:36:49',1,15,'INGRESO','INGRESO AL MÓDULO DE KARDEX'),(435,'2023-04-19 00:39:20',1,21,'INGRESO','INGRESO AL MÓDULO PRODUCTOS'),(436,'2023-04-19 00:47:37',1,11,'INGRESO','INGRESO AL MÓDULO COMPRAS'),(437,'2023-04-19 00:48:00',1,11,'INGRESO','INGRESO AL MÓDULO COMPRAS'),(438,'2023-04-19 00:48:05',1,15,'INGRESO','INGRESO AL MÓDULO DE KARDEX'),(439,'2023-04-19 01:09:24',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(440,'2023-04-19 01:13:49',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(441,'2023-04-19 01:14:19',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(442,'2023-04-19 01:15:22',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(443,'2023-04-19 01:15:31',1,10,'CREAR','CREACIÓN DE CLIENTE'),(444,'2023-04-19 01:16:03',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(445,'2023-04-19 01:16:11',1,10,'CREAR','CREACIÓN DE CLIENTE'),(446,'2023-04-19 01:16:32',1,10,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(447,'2023-04-19 01:18:33',1,10,'CREAR','CREACIÓN DE CLIENTE'),(448,'2023-04-19 01:24:07',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(449,'2023-04-19 01:24:13',1,10,'CREAR','CREACIÓN DE CLIENTE'),(450,'2023-04-19 01:24:20',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(451,'2023-04-19 01:29:13',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(452,'2023-04-19 01:29:18',1,10,'CREAR','CREACIÓN DE CLIENTE'),(453,'2023-04-19 01:29:46',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(454,'2023-04-19 01:30:27',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(455,'2023-04-19 01:30:31',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(456,'2023-04-19 01:30:35',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(457,'2023-04-19 02:08:56',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(458,'2023-04-19 02:15:25',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(459,'2023-04-19 02:20:33',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(460,'2023-04-19 02:20:46',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(461,'2023-04-19 02:23:48',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(462,'2023-04-19 02:27:51',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(463,'2023-04-19 02:28:11',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(464,'2023-04-19 02:28:46',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(465,'2023-04-19 02:29:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(466,'2023-04-19 02:53:32',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(467,'2023-04-19 02:53:39',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(468,'2023-04-19 02:53:44',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(469,'2023-04-19 02:53:47',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(470,'2023-04-19 02:57:37',1,4,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(471,'2023-04-19 02:57:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(472,'2023-04-19 08:36:28',1,2,'INGRESO','INGRESO AL SISTEMA'),(473,'2023-04-19 08:36:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(474,'2023-04-19 08:43:21',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(475,NULL,NULL,NULL,NULL,NULL),(476,NULL,NULL,NULL,NULL,NULL),(477,NULL,NULL,NULL,NULL,NULL),(478,'2023-04-19 08:47:54',1,15,'INGRESO','INGRESO AL MÓDULO DE KARDEX'),(479,'2023-04-19 09:09:01',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(480,'2023-04-19 09:09:30',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(481,'2023-04-19 09:14:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(482,'2023-04-19 09:32:13',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(483,'2023-04-19 09:32:30',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(484,'2023-04-19 09:32:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(485,'2023-04-19 09:33:13',1,4,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(486,'2023-04-19 09:33:39',1,4,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(487,'2023-04-19 09:33:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(488,'2023-04-19 09:33:58',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(489,'2023-04-19 09:34:18',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(490,'2023-04-19 09:34:28',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(491,'2023-04-19 11:02:37',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(492,'2023-04-19 11:07:31',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(493,'2023-04-19 11:08:12',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(494,'2023-04-19 11:08:44',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(495,'2023-04-19 11:08:58',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(496,'2023-04-19 11:09:37',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(497,'2023-04-19 11:10:06',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(498,'2023-04-19 11:13:10',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(499,'2023-04-19 11:13:41',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(500,'2023-04-19 11:14:53',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(501,'2023-04-19 11:15:21',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(502,'2023-04-19 11:16:04',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(503,'2023-04-19 11:20:32',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(504,'2023-04-19 11:23:54',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(505,'2023-04-19 11:24:01',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(506,'2023-04-19 11:28:10',1,4,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(507,'2023-04-19 11:29:02',1,4,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(508,'2023-04-19 12:40:00',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(509,'2023-04-19 12:40:34',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(510,'2023-04-19 12:41:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(511,'2023-04-19 12:50:10',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(512,'2023-04-19 12:51:09',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(513,'2023-04-19 12:51:27',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(514,'2023-04-19 12:55:58',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(515,'2023-04-19 12:56:41',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(516,'2023-04-19 13:05:49',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(517,'2023-04-19 13:06:13',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(518,'2023-04-19 13:12:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(519,'2023-04-19 13:13:06',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(520,'2023-04-20 12:13:55',1,2,'INGRESO','INGRESO AL SISTEMA'),(521,'2023-04-20 12:14:10',1,21,'INGRESO','INGRESO AL MÓDULO PRODUCTOS'),(522,'2023-04-20 12:14:19',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(523,'2023-04-20 12:15:00',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(524,'2023-04-20 18:05:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(525,'2023-04-20 18:06:02',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(526,'2023-04-20 18:06:51',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(527,'2023-04-20 21:37:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(528,'2023-04-20 23:12:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(529,'2023-04-21 13:00:22',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(530,'2023-04-21 17:36:30',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(531,'2023-04-21 21:16:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(532,'2023-04-21 22:14:27',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(533,'2023-04-21 22:56:57',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(534,'2023-04-21 23:01:45',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(535,'2023-04-21 23:02:49',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(536,'2023-04-21 23:12:26',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(537,'2023-04-22 12:21:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(538,'2023-04-22 12:54:19',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(539,'2023-04-22 12:56:31',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(540,'2023-04-22 12:57:13',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(541,'2023-04-22 14:17:13',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(542,'2023-04-22 15:03:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(543,'2023-04-22 15:05:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(544,'2023-04-22 17:39:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(545,'2023-04-23 18:53:00',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(546,'2023-04-23 19:29:55',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(547,'2023-04-23 19:34:59',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(548,'2023-04-23 19:35:17',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(549,'2023-04-23 19:36:45',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(550,'2023-04-23 19:46:35',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(551,'2023-04-23 19:46:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(552,'2023-04-23 19:52:41',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(553,'2023-04-23 19:52:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(554,'2023-04-23 20:02:32',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(555,'2023-04-23 20:06:57',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(556,'2023-04-23 20:08:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(557,'2023-04-23 20:16:51',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(558,'2023-04-23 20:16:58',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(559,'2023-04-23 20:21:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(560,'2023-04-23 20:21:41',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(561,'2023-04-23 20:22:20',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(562,'2023-04-23 22:24:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(563,'2023-04-23 22:31:21',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(564,'2023-04-23 22:32:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(565,'2023-04-23 22:34:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(566,'2023-04-23 22:35:34',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(567,'2023-04-23 22:36:10',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(568,'2023-04-23 22:36:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(569,'2023-04-23 22:38:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(570,'2023-04-23 22:40:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(571,'2023-04-23 22:45:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(572,'2023-04-23 22:46:56',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(573,'2023-04-23 22:49:59',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(574,'2023-04-23 22:50:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(575,'2023-04-23 22:59:56',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(576,'2023-04-23 23:00:28',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(577,'2023-04-23 23:00:56',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(578,'2023-04-23 23:06:45',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(579,'2023-04-23 23:07:01',1,10,'CREAR','CREACIÓN DE CLIENTE'),(580,'2023-04-23 23:07:05',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(581,'2023-04-23 23:07:20',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(582,'2023-04-23 23:07:43',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(583,'2023-04-23 23:07:55',1,10,'CREAR','CREACIÓN DE CLIENTE'),(584,'2023-04-23 23:08:00',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(585,'2023-04-23 23:08:47',1,10,'CREAR','CREACIÓN DE CLIENTE'),(586,'2023-04-23 23:09:23',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(587,'2023-04-23 23:14:44',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(588,'2023-04-23 23:53:26',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(589,'2023-04-23 23:53:33',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(590,'2023-04-23 23:53:40',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(591,'2023-04-24 00:07:08',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(592,'2023-04-24 00:08:38',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(593,'2023-04-24 00:08:44',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(594,'2023-04-24 00:09:04',1,10,'CREAR','CREACIÓN DE CLIENTE'),(595,'2023-04-24 00:09:08',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(596,'2023-04-24 00:10:10',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(597,'2023-04-24 00:16:51',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(598,'2023-04-24 01:59:05',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(599,'2023-04-24 01:59:15',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(600,'2023-04-24 02:05:36',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(601,'2023-04-24 02:05:50',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(602,'2023-04-24 02:07:54',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(603,'2023-04-24 02:13:45',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(604,'2023-04-24 02:15:38',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(605,'2023-04-24 02:20:32',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(606,'2023-04-24 02:22:56',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(607,'2023-04-24 02:27:01',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(608,'2023-04-24 02:30:34',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(609,'2023-04-24 02:31:36',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(610,'2023-04-24 02:32:04',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(611,'2023-04-24 02:33:00',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(612,'2023-04-24 02:33:55',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(613,'2023-04-24 02:35:47',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(614,'2023-04-24 02:40:48',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(615,'2023-04-24 02:43:23',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(616,'2023-04-24 02:45:45',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(617,'2023-04-24 02:46:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(618,'2023-04-24 03:00:58',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(619,'2023-04-24 07:53:34',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(620,'2023-04-24 07:53:46',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(621,'2023-04-24 07:55:55',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(622,'2023-04-24 08:30:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(623,'2023-04-24 08:32:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(624,'2023-04-24 11:13:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(625,'2023-04-24 11:19:04',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(626,'2023-04-24 11:19:33',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(627,'2023-04-24 11:19:38',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(628,'2023-04-24 11:19:42',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(629,'2023-04-24 11:19:47',1,10,'ELIMINAR','ELIMINACIÓN DE CLIENTE'),(630,'2023-04-24 11:24:28',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(631,'2023-04-24 11:24:49',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(632,'2023-04-24 11:30:25',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(633,'2023-04-24 11:30:47',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(634,'2023-04-24 12:49:00',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(635,'2023-04-24 13:48:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(636,'2023-04-24 13:48:57',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(637,'2023-04-24 15:08:10',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(638,'2023-04-24 15:08:23',1,22,'ACTUALIZAR','ACTUALIZACIÓN DE PROMOCIÓN'),(639,'2023-04-24 15:08:27',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(640,'2023-04-24 15:08:45',1,22,'ACTUALIZAR','ACTUALIZACIÓN DE PROMOCIÓN'),(641,'2023-04-24 15:08:51',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(642,'2023-04-24 15:10:05',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(643,'2023-04-24 15:10:14',1,22,'ACTUALIZAR','ACTUALIZACIÓN DE PROMOCIÓN'),(644,'2023-04-24 15:10:18',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(645,'2023-04-24 15:10:40',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(646,'2023-04-24 15:10:47',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(647,'2023-04-24 15:10:57',1,22,'ACTUALIZAR','ACTUALIZACIÓN DE PROMOCIÓN'),(648,'2023-04-24 15:10:57',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(649,'2023-04-24 15:11:06',1,22,'ACTUALIZAR','ACTUALIZACIÓN DE PROMOCIÓN'),(650,'2023-04-24 15:11:06',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(651,'2023-04-24 15:13:06',1,22,'ACTUALIZAR','ACTUALIZACIÓN DE PROMOCIÓN'),(652,'2023-04-24 15:13:06',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(653,'2023-04-24 15:15:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(654,'2023-04-24 15:20:18',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(655,'2023-04-24 15:20:24',1,21,'INGRESO','INGRESO AL MÓDULO PRODUCTOS'),(656,'2023-04-24 15:21:08',1,21,'CREAR','CREACION DE PRODUCTO'),(657,'2023-04-24 15:21:30',1,21,'CREAR','CREACION DE PRODUCTO'),(658,'2023-04-24 15:22:09',1,21,'CREAR','CREACION DE PRODUCTO'),(659,'2023-04-24 15:22:42',1,21,'CREAR','CREACION DE PRODUCTO'),(660,'2023-04-24 15:23:06',1,21,'CREAR','CREACION DE PRODUCTO'),(661,'2023-04-24 15:23:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(662,'2023-04-24 15:25:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(663,'2023-04-24 15:28:36',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(664,'2023-04-24 15:28:45',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(665,'2023-04-24 15:30:12',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(666,'2023-04-24 15:30:14',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(667,'2023-04-24 15:30:40',1,2,'INGRESO','INGRESO AL SISTEMA'),(668,'2023-04-24 15:30:47',1,21,'INGRESO','INGRESO AL MÓDULO PRODUCTOS'),(669,'2023-04-24 15:31:16',1,21,'ACTUALIZAR','ACTUALIZACIÓN DE PRODUCTO'),(670,'2023-04-24 15:32:03',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(671,'2023-04-24 15:36:57',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(672,'2023-04-24 15:37:09',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(673,'2023-04-24 15:38:31',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(674,'2023-04-24 16:20:01',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(675,'2023-04-24 16:33:44',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(676,'2023-04-24 16:37:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(677,'2023-04-24 16:40:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(678,'2023-04-24 16:44:00',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(679,'2023-04-24 16:48:06',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(680,'2023-04-24 16:48:15',1,10,'INGRESO','INGRESO AL MÓDULO CLIENTES'),(681,'2023-04-24 16:48:20',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(682,'2023-04-25 23:09:21',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(683,'2023-04-26 01:13:39',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(684,'2023-04-27 21:03:31',1,2,'INGRESO','INGRESO AL SISTEMA'),(685,'2023-04-27 21:18:09',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(686,'2023-04-27 21:19:50',1,2,'INGRESO','INGRESO AL SISTEMA'),(687,'2023-04-27 21:20:23',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(688,'2023-04-27 21:23:06',1,24,'ELIMINAR','ELIMINACIÓN DE USUARIO'),(689,'2023-04-27 21:23:14',1,24,'ELIMINAR','ELIMINACIÓN DE USUARIO'),(690,'2023-04-27 21:23:20',1,23,'INGRESO','INGRESO AL MÓDULO DE ROLES'),(691,'2023-04-27 21:24:44',1,17,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(692,'2023-04-27 21:25:38',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(693,'2023-04-27 21:25:43',1,16,'INGRESO','INGRESO AL MÓDULO OBJETOS'),(694,'2023-04-27 21:26:22',1,4,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(695,'2023-04-27 21:27:21',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(696,'2023-04-27 21:27:24',1,16,'INGRESO','INGRESO AL MÓDULO OBJETOS'),(697,'2023-04-27 21:27:32',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(698,'2023-04-27 21:28:39',1,18,'CREAR','CREACIÓN DE PREGUNTA'),(699,'2023-04-27 21:29:12',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(700,'2023-04-27 23:46:33',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(701,'2023-04-28 00:13:20',1,2,'INGRESO','INGRESO AL SISTEMA'),(702,'2023-04-28 00:13:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(703,'2023-04-28 10:27:35',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(704,'2023-04-28 10:30:52',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(705,'2023-04-28 14:52:12',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(706,'2023-04-28 20:23:04',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(707,'2023-04-28 20:23:52',1,24,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(708,'2023-04-28 20:23:54',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(709,'2023-04-28 20:24:03',1,2,'INGRESO','INGRESO AL SISTEMA'),(710,'2023-04-28 20:24:06',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(711,'2023-04-28 20:24:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(712,'2023-04-28 20:27:05',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(713,'2023-04-29 00:00:07',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(714,'2023-04-29 00:02:08',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(715,'2023-04-29 00:02:19',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(716,'2023-04-29 00:04:47',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(717,'2023-04-29 00:06:02',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(718,'2023-04-29 00:10:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(719,'2023-04-29 00:10:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(720,'2023-04-29 00:10:50',1,11,'INGRESO','INGRESO AL MÓDULO COMPRAS'),(721,'2023-04-29 00:15:05',1,11,'INGRESO','INGRESO AL MÓDULO COMPRAS'),(722,'2023-04-29 00:15:55',1,11,'INGRESO','INGRESO AL MÓDULO COMPRAS'),(723,'2023-04-29 00:16:54',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(724,'2023-05-04 20:29:51',1,2,'INGRESO','INGRESO AL SISTEMA'),(725,'2023-05-04 20:30:01',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(726,'2023-05-04 20:32:28',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(727,'2023-05-04 20:33:52',1,18,'CREAR','CREACIÓN DE PREGUNTA .EE. '),(728,'2023-05-04 20:36:03',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(729,'2023-05-04 20:38:00',1,18,'CREAR','SE INSERTÓ LA PREGUNTA: COMO SE LLAMA TU ABUELA MATERNA'),(730,'2023-05-04 20:50:40',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(731,'2023-05-04 20:52:15',1,18,'CREAR','SE CREÓ LA PREGUNTA: CóMO'),(732,'2023-05-04 20:52:44',1,18,'CREAR','SE CREÓ LA PREGUNTA: CóMO SE LLAMA TU MASCOTA'),(733,'2023-05-04 20:52:49',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA'),(734,'2023-05-04 20:54:27',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(735,'2023-05-04 20:54:53',1,18,'CREAR','SE CREÓ LA PREGUNTA: CóMO SE LLAMA?'),(736,'2023-05-04 21:02:46',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(737,'2023-05-04 21:03:10',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA'),(738,'2023-05-04 21:03:17',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA'),(739,'2023-05-04 21:03:22',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA'),(740,'2023-05-04 21:04:34',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(741,'2023-05-04 21:04:40',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(742,'2023-05-04 21:05:39',1,24,'CREAR','CREACION DE USUARIO'),(743,'2023-05-04 21:05:43',1,24,'CREAR','CREACION DE USUARIO'),(744,'2023-05-04 21:05:49',1,24,'CREAR','CREACION DE USUARIO'),(745,'2023-05-04 21:06:03',1,24,'CREAR','CREACION DE USUARIO'),(746,'2023-05-04 21:06:04',1,24,'CREAR','CREACION DE USUARIO'),(747,'2023-05-04 21:07:37',1,24,'CREAR','CREACION DE USUARIO'),(748,'2023-05-04 21:07:40',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(749,'2023-05-04 21:07:49',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(750,'2023-05-04 21:09:01',192,2,'PREGUNTAS','CONTESTO PREGUNTA CORRECTAMENTE'),(751,'2023-05-04 21:09:45',192,2,'PREGUNTAS','CONTESTO PREGUNTA CORRECTAMENTE'),(752,'2023-05-04 21:11:59',1,2,'INGRESO','INGRESO AL SISTEMA'),(753,'2023-05-04 21:12:59',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(754,'2023-05-04 21:13:37',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA'),(755,'2023-05-04 21:13:41',1,18,'ELIMINAR','SE INTENTÓ ELIMINAR LA PREGUNTA, NO SE ELIMINÓ PORQUE TIENE INTEGRIDAD REFERENCIAL.'),(756,'2023-05-04 21:28:25',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(757,'2023-05-04 21:29:29',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(758,'2023-05-04 21:33:10',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(759,'2023-05-04 21:34:11',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(760,'2023-05-04 21:38:31',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(761,'2023-05-04 21:39:33',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(762,'2023-05-04 21:40:38',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(763,'2023-05-04 21:41:39',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(764,'2023-05-04 21:41:54',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(765,'2023-05-04 21:42:43',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA ..'),(766,'2023-05-04 21:43:18',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(767,'2023-05-04 21:44:14',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA ..'),(768,'2023-05-04 21:46:56',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(769,'2023-05-04 21:47:35',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA 20 '),(770,'2023-05-04 21:50:14',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(771,'2023-05-04 21:51:21',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(772,'2023-05-04 21:54:32',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(773,'2023-05-04 21:55:30',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(774,'2023-05-04 22:08:19',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(775,'2023-05-04 22:09:56',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(776,'2023-05-05 21:38:40',1,2,'INGRESO','INGRESO AL SISTEMA'),(777,'2023-05-05 21:38:43',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(778,'2023-05-05 21:43:18',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(779,'2023-05-05 21:50:48',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(780,'2023-05-05 21:50:52',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(781,'2023-05-05 21:51:12',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(782,'2023-05-05 21:52:11',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(783,'2023-05-05 21:52:27',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(784,'2023-05-05 21:52:45',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(785,'2023-05-05 21:53:55',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(786,'2023-05-05 21:53:58',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(787,'2023-05-05 21:54:01',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(788,'2023-05-05 21:54:55',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(789,'2023-05-05 21:54:58',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(790,'2023-05-05 21:55:00',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(791,'2023-05-05 22:01:11',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(792,'2023-05-05 22:01:15',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(793,'2023-05-05 22:01:16',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(794,'2023-05-05 22:01:39',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(795,'2023-05-05 22:02:01',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(796,'2023-05-05 22:04:31',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(797,'2023-05-05 22:04:53',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(798,'2023-05-05 22:04:56',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(799,'2023-05-05 22:05:01',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(800,'2023-05-05 22:05:34',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(801,'2023-05-05 22:05:48',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(802,'2023-05-05 22:07:42',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(803,'2023-05-05 22:07:46',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(804,'2023-05-05 22:10:07',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(805,'2023-05-05 22:10:13',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(806,'2023-05-05 22:10:23',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(807,'2023-05-05 22:11:40',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(808,'2023-05-05 22:14:22',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(809,'2023-05-05 22:14:31',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(810,'2023-05-05 22:17:50',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(811,'2023-05-05 22:17:53',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(812,'2023-05-05 22:17:59',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(813,'2023-05-05 22:18:17',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(814,'2023-05-05 22:18:31',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(815,'2023-05-05 22:19:47',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(816,'2023-05-05 22:19:55',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA Array'),(817,'2023-05-05 22:20:01',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(818,'2023-05-05 22:20:13',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(819,'2023-05-05 22:23:23',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(820,'2023-05-05 22:23:27',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA Array'),(821,'2023-05-05 22:23:52',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(822,'2023-05-05 22:23:57',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA Array'),(823,'2023-05-05 22:24:09',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(824,'2023-05-05 22:24:11',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(825,'2023-05-05 22:24:44',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA Array'),(826,'2023-05-05 22:25:51',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(827,'2023-05-05 22:26:00',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA Array'),(828,'2023-05-05 22:26:27',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(829,'2023-05-05 22:28:32',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(830,'2023-05-05 22:28:39',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(831,'2023-05-05 22:29:44',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(832,'2023-05-05 22:30:55',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(833,'2023-05-05 22:31:00',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(834,'2023-05-05 22:32:07',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(835,'2023-05-05 22:33:59',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(836,'2023-05-05 22:36:12',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(837,'2023-05-05 22:36:27',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(838,'2023-05-05 22:37:16',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(839,'2023-05-05 22:37:19',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA Array'),(840,'2023-05-05 22:37:20',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(841,'2023-05-05 22:38:20',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(842,'2023-05-05 22:38:23',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA Array'),(843,'2023-05-05 22:38:24',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(844,'2023-05-05 22:38:28',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(845,'2023-05-05 22:38:31',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA Array'),(846,'2023-05-05 22:38:33',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(847,'2023-05-05 22:42:15',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(848,'2023-05-05 22:42:18',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA Array'),(849,'2023-05-05 22:42:20',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA '),(850,'2023-05-05 22:42:23',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(851,'2023-05-05 22:42:39',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA Array'),(852,'2023-05-05 22:46:03',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(853,'2023-05-05 22:46:08',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA s'),(854,'2023-05-05 22:46:33',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(855,'2023-05-05 22:46:39',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA r'),(856,'2023-05-05 22:46:42',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA q'),(857,'2023-05-05 22:46:45',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA p'),(858,'2023-05-05 22:46:48',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA o'),(859,'2023-05-05 22:46:52',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA l'),(860,'2023-05-05 22:47:48',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(861,'2023-05-05 22:47:58',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA d'),(862,'2023-05-05 22:48:03',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA a'),(863,'2023-05-05 22:48:33',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(864,'2023-05-05 22:48:36',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(865,'2023-05-05 22:49:57',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(866,'2023-05-05 22:50:05',1,18,'ELIMINAR','SE INTENTÓ ELIMINAR LA PREGUNTA CóMO SE LLAMA TU MASCOTA, NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.'),(867,'2023-05-05 22:51:20',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(868,'2023-05-05 22:51:24',1,18,'ELIMINAR','SE INTENTÓ ELIMINAR LA PREGUNTA CóMO SE LLAMA TU MASCOTA, NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.'),(869,'2023-05-05 22:51:27',1,18,'ELIMINAR','SE INTENTÓ ELIMINAR LA PREGUNTA COMO SE LLAMA TU ABUELA MATERNA, NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.'),(870,'2023-05-05 22:53:27',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(871,'2023-05-05 22:53:30',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA k'),(872,'2023-05-05 22:53:33',1,18,'ELIMINAR','SE INTENTÓ ELIMINAR LA PREGUNTA: \"CóMO SE LLAMA TU MASCOTA\", NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.'),(873,'2023-05-05 22:53:37',1,18,'ELIMINAR','SE INTENTÓ ELIMINAR LA PREGUNTA: \"COMO SE LLAMA TU ABUELA MATERNA\", NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.'),(874,'2023-05-05 22:53:40',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(875,'2023-05-05 22:54:28',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(876,'2023-05-05 22:54:32',1,18,'ELIMINAR','SE INTENTÓ ELIMINAR LA PREGUNTA: (CóMO SE LLAMA TU MASCOTA), NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.'),(877,'2023-05-05 22:54:35',1,18,'ELIMINAR','ELIMINACIÓN DE PREGUNTA f'),(878,'2023-05-05 22:54:37',1,18,'ELIMINAR','SE INTENTÓ ELIMINAR LA PREGUNTA: (COMO SE LLAMA TU ABUELA MATERNA), NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.'),(879,'2023-05-05 22:54:41',1,23,'INGRESO','INGRESO AL MÓDULO DE ROLES'),(880,'2023-05-05 23:44:57',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(881,'2023-05-05 23:45:02',1,18,'ELIMINAR','ELIMINACIÓN DE LA PREGUNTA: j'),(882,'2023-05-05 23:45:43',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(883,'2023-05-05 23:45:46',1,18,'ELIMINAR','ELIMINACIÓN DE LA PREGUNTA: i'),(884,'2023-05-05 23:45:50',1,18,'ELIMINAR','ELIMINACIÓN DE LA PREGUNTA: h'),(885,'2023-05-05 23:45:52',1,18,'ELIMINAR','ELIMINACIÓN DE LA PREGUNTA: g'),(886,'2023-05-05 23:45:56',1,18,'ELIMINAR','ELIMINACIÓN DE LA PREGUNTA: e'),(887,'2023-05-05 23:45:59',1,18,'ELIMINAR','ELIMINACIÓN DE LA PREGUNTA: ]'),(888,'2023-05-05 23:46:02',1,18,'ELIMINAR','ELIMINACIÓN DE LA PREGUNTA: ['),(889,'2023-05-05 23:46:05',1,18,'ELIMINAR','SE INTENTÓ ELIMINAR LA PREGUNTA: (COMO SE LLAMA TU ABUELA MATERNA), NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.'),(890,'2023-05-05 23:46:08',1,18,'ELIMINAR','SE INTENTÓ ELIMINAR LA PREGUNTA: (CóMO SE LLAMA TU MASCOTA), NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.'),(891,'2023-05-19 14:39:07',1,2,'INGRESO','INGRESO AL SISTEMA'),(892,'2023-05-19 14:39:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(893,'2023-06-02 10:34:51',1,2,'INGRESO','INGRESO AL SISTEMA'),(894,'2023-06-02 10:35:25',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(895,'2023-06-02 10:37:13',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(896,'2023-06-02 10:40:22',1,21,'INGRESO','INGRESO AL MÓDULO PRODUCTOS'),(897,'2023-06-02 10:41:51',1,15,'INGRESO','INGRESO AL MÓDULO DE KARDEX'),(898,'2023-06-02 10:42:06',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(899,'2023-06-02 10:42:12',1,23,'INGRESO','INGRESO AL MÓDULO DE ROLES'),(900,'2023-06-02 10:43:17',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(901,'2023-06-02 10:49:48',1,2,'INGRESO','INGRESO AL SISTEMA'),(902,'2023-06-02 10:56:27',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(903,'2023-06-02 11:00:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(904,'2023-06-02 11:00:56',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(905,'2023-06-02 11:03:55',1,2,'INGRESO','INGRESO AL SISTEMA'),(906,'2023-06-02 11:03:59',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(907,'2023-06-02 11:07:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(908,'2023-06-02 15:36:57',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(909,'2023-06-02 23:14:07',1,2,'INGRESO','INGRESO AL SISTEMA'),(910,'2023-06-02 23:15:36',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(911,'2023-06-02 23:47:23',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(912,'2023-06-02 23:47:34',1,11,'INGRESO','INGRESO AL MÓDULO COMPRAS'),(913,'2023-06-02 23:47:40',1,11,'INGRESO','INGRESO AL MÓDULO COMPRAS'),(914,'2023-06-02 23:51:09',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(915,'2023-06-02 23:55:02',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(916,'2023-06-02 23:57:43',1,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(917,'2023-06-02 23:57:58',1,24,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(918,'2023-06-02 23:58:00',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(919,'2023-06-02 23:58:16',192,2,'INGRESO','INGRESO AL SISTEMA'),(920,'2023-06-02 23:58:18',192,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(921,'2023-06-02 23:58:33',192,23,'INGRESO','INGRESO AL MÓDULO DE ROLES'),(922,'2023-06-02 23:58:37',192,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(923,'2023-06-02 23:58:46',1,2,'INGRESO','INGRESO AL SISTEMA'),(924,'2023-06-02 23:58:52',1,23,'INGRESO','INGRESO AL MÓDULO DE ROLES'),(925,'2023-06-02 23:59:04',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(926,'2023-06-02 23:59:12',192,2,'INGRESO','INGRESO AL SISTEMA'),(927,'2023-06-02 23:59:15',192,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(928,'2023-06-03 00:06:46',192,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(929,'2023-06-03 00:06:48',192,23,'INGRESO','INGRESO AL MÓDULO DE ROLES'),(930,'2023-06-03 00:07:02',192,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(931,'2023-06-03 00:07:12',1,2,'INGRESO','INGRESO AL SISTEMA'),(932,'2023-06-03 00:07:23',1,23,'INGRESO','INGRESO AL MÓDULO DE ROLES'),(933,'2023-06-03 00:07:57',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(934,'2023-06-03 00:08:14',192,2,'INGRESO','INGRESO AL SISTEMA'),(935,'2023-06-03 00:08:22',192,23,'INGRESO','INGRESO AL MÓDULO DE ROLES'),(936,'2023-06-03 00:08:49',192,24,'INGRESO','INGRESO AL MÓDULO USUARIOS'),(937,'2023-06-03 00:14:22',192,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(938,'2023-06-06 15:02:32',1,2,'INGRESO','INGRESO AL SISTEMA'),(939,'2023-06-06 15:13:17',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(940,'2023-06-06 15:13:42',1,2,'INGRESO','INGRESO AL SISTEMA'),(941,'2023-06-06 15:14:39',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(942,'2023-06-06 17:19:50',1,2,'INGRESO','INGRESO AL SISTEMA'),(943,'2023-06-08 22:00:58',1,2,'INGRESO','INGRESO AL SISTEMA'),(944,'2023-06-08 22:01:05',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(945,'2023-06-08 22:01:40',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(946,'2023-06-08 22:05:17',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(947,'2023-06-08 22:06:00',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(948,'2023-06-08 22:06:42',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(949,'2023-06-10 22:40:32',1,2,'INGRESO','INGRESO AL SISTEMA'),(950,'2023-06-10 23:53:35',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(951,'2023-06-11 17:51:13',1,2,'INGRESO','INGRESO AL SISTEMA'),(952,'2023-06-11 17:51:21',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(953,'2023-06-11 17:51:54',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(954,'2023-06-11 17:54:10',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(955,'2023-06-11 17:54:35',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(956,'2023-06-11 17:54:45',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(957,'2023-06-11 17:58:44',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(958,'2023-06-11 18:04:00',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(959,'2023-06-11 18:44:14',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(960,'2023-06-11 18:44:16',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(961,'2023-06-11 18:45:40',1,18,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(962,'2023-06-11 18:51:48',1,22,'INGRESO','INGRESO AL MÓDULO PROMOCIÓN'),(963,'2023-06-11 18:53:59',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(964,'2023-06-24 23:38:02',1,2,'INGRESO','INGRESO AL SISTEMA'),(965,'2023-06-24 23:38:36',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(966,'2023-06-26 22:47:29',1,2,'INGRESO','INGRESO AL SISTEMA'),(967,'2023-07-17 12:38:14',1,2,'INGRESO','INGRESO AL SISTEMA'),(968,'2023-07-17 12:38:26',1,23,'INGRESO','INGRESO AL MÓDULO DE ROLES'),(969,'2023-07-17 13:56:57',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN');
/*!40000 ALTER TABLE `tbl_ms_bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_hist_contrasena`
--

DROP TABLE IF EXISTS `tbl_ms_hist_contrasena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_hist_contrasena` (
  `id_usuario` bigint NOT NULL COMMENT 'cod del usuario.',
  `contrasena` varchar(100) DEFAULT NULL COMMENT 'Contraseña del usuario.',
  `creado_por` varchar(15) DEFAULT NULL COMMENT 'Nombre del usuario.',
  `fecha_creacion` datetime DEFAULT NULL COMMENT 'Fecha de creación.',
  `modificado_por` varchar(15) DEFAULT NULL COMMENT 'Nombre del usuario que modificó.',
  `fecha_modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación.',
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `histContra_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena el historial de las contraseñas de los usuarios.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_hist_contrasena`
--

LOCK TABLES `tbl_ms_hist_contrasena` WRITE;
/*!40000 ALTER TABLE `tbl_ms_hist_contrasena` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_ms_hist_contrasena` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_objetos`
--

DROP TABLE IF EXISTS `tbl_ms_objetos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_objetos` (
  `id_objeto` bigint NOT NULL AUTO_INCREMENT COMMENT 'cod el objeto.',
  `objeto` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL COMMENT 'Nombre del objeto (Pantalla).',
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci COMMENT 'Descripción del objeto.',
  `estado` int NOT NULL DEFAULT '1' COMMENT 'Estado del objeto.',
  PRIMARY KEY (`id_objeto`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci COMMENT='Tabla que almacena el nombre del objeto (Pantalla).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_objetos`
--

LOCK TABLES `tbl_ms_objetos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_objetos` DISABLE KEYS */;
INSERT INTO `tbl_ms_objetos` VALUES (1,'BACKUP','',1),(2,'BITÁCORA','',1),(4,'CAI','',1),(10,'CLIENTES','',1),(11,'COMPRAS','',1),(12,'DESCUENTOS','',1),(13,'INICIO','',1),(14,'INVENTARIO',NULL,1),(15,'KARDEX',NULL,1),(16,'OBJETOS',NULL,1),(17,'PARÁMETROS',NULL,1),(18,'PREGUNTAS',NULL,1),(20,'PRODUCCIÓN',NULL,1),(21,'PRODUCTOS',NULL,1),(22,'PROMOCIÓN',NULL,1),(23,'ROLES',NULL,1),(24,'USUARIOS',NULL,1),(25,'VENTAS',NULL,1);
/*!40000 ALTER TABLE `tbl_ms_objetos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_parametros`
--

DROP TABLE IF EXISTS `tbl_ms_parametros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_parametros` (
  `id_parametro` int NOT NULL AUTO_INCREMENT COMMENT 'cod del parámetro.',
  `parametro` varchar(50) DEFAULT NULL,
  `valor` varchar(100) DEFAULT NULL COMMENT 'Valor que tendrá el parámetro.',
  `creado_por` varchar(15) DEFAULT NULL COMMENT 'Nombre del usuario que registró el parámetro.',
  `fecha_creacion` datetime DEFAULT NULL COMMENT 'Fecha en la que se registró el parámetro.',
  `modificado_por` varchar(15) DEFAULT NULL COMMENT 'Nombre del usuario que modificó el parámetro.',
  `fecha_modificacion` datetime DEFAULT NULL COMMENT 'Fecha de modificación del parámetro.',
  PRIMARY KEY (`id_parametro`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los parámetros principales de la empresa.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_parametros`
--

LOCK TABLES `tbl_ms_parametros` WRITE;
/*!40000 ALTER TABLE `tbl_ms_parametros` DISABLE KEYS */;
INSERT INTO `tbl_ms_parametros` VALUES (1,'ADMIN_INTENTOS','3',NULL,NULL,NULL,NULL),(2,'ADMIN_PREGUNTAS','2',NULL,NULL,NULL,NULL),(3,'ADMIN_CORREO','uniformesdelatlantico@hotmail.com',NULL,NULL,NULL,NULL),(4,'FECHA_VENCIMIENTO','30',NULL,NULL,NULL,NULL),(5,'IMPUESTO','15',NULL,NULL,'ADMIN','2023-04-16 02:57:05'),(6,'NOMBRE_EMPRESA','INVERSIONES UNIFORMES DEL ATLÁNTICO',NULL,NULL,'ADMIN','2023-04-18 10:35:48'),(7,'RAZON_SOCIAL','S. DE R. L. DE C. V.',NULL,NULL,NULL,NULL),(8,'TELEFONO_EMPRESA','9970-5887',NULL,NULL,NULL,NULL),(9,'DIRECCION','BO. EL CENTRO, DOMICILIO RENTADO, ATRÁS DE LA DESPENSA FAMILIAR, TELA. ATLÁNTIDA',NULL,NULL,NULL,NULL),(10,'RTN','01079021315692',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tbl_ms_parametros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_permisos`
--

DROP TABLE IF EXISTS `tbl_ms_permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_permisos` (
  `idpermiso` bigint NOT NULL AUTO_INCREMENT COMMENT 'cod del permiso.',
  `id_rol` bigint NOT NULL COMMENT 'cod del rol del usuario.',
  `id_objeto` bigint NOT NULL COMMENT 'cod del objeto, es decir, la pantalla.',
  `r` int NOT NULL DEFAULT '0' COMMENT 'Permiso de consultar.',
  `w` int NOT NULL DEFAULT '0' COMMENT 'Permiso de agregar.',
  `u` int NOT NULL DEFAULT '0' COMMENT 'Permiso de actualizar.',
  `d` int NOT NULL DEFAULT '0' COMMENT 'Permiso de eliminar.',
  PRIMARY KEY (`idpermiso`),
  KEY `rolid` (`id_rol`),
  KEY `moduloid` (`id_objeto`),
  CONSTRAINT `tbl_ms_permisos_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tbl_ms_roles` (`id_rol`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_ms_permisos_ibfk_2` FOREIGN KEY (`id_objeto`) REFERENCES `tbl_ms_objetos` (`id_objeto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=609 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci COMMENT='Permisos que tendrá un usuario dentro del sistema.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_permisos`
--

LOCK TABLES `tbl_ms_permisos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_permisos` DISABLE KEYS */;
INSERT INTO `tbl_ms_permisos` VALUES (39,3,1,1,0,0,0),(40,3,2,1,0,0,0),(42,3,4,0,0,0,0),(93,11,1,1,0,0,0),(94,11,2,0,0,0,0),(96,11,4,0,0,0,0),(223,21,1,1,1,1,1),(224,21,2,1,1,1,1),(226,21,4,1,0,0,0),(231,2,1,0,0,0,0),(232,2,2,0,0,0,0),(234,2,4,0,0,0,0),(537,1,1,1,1,1,1),(538,1,2,1,1,1,1),(539,1,4,1,1,1,1),(540,1,10,1,1,1,1),(541,1,11,1,1,1,1),(542,1,12,1,1,1,1),(543,1,13,1,1,1,1),(544,1,14,1,1,1,1),(545,1,15,1,1,1,1),(546,1,16,1,1,1,1),(547,1,17,1,1,1,1),(548,1,18,1,1,1,1),(549,1,20,1,1,1,1),(550,1,21,1,1,1,1),(551,1,22,1,1,1,1),(552,1,23,1,1,1,1),(553,1,24,1,1,1,1),(554,1,25,1,1,1,1),(591,4,1,1,0,0,0),(592,4,2,1,1,1,1),(593,4,4,1,0,0,0),(594,4,10,1,1,0,0),(595,4,11,1,0,0,0),(596,4,12,0,1,0,0),(597,4,13,1,1,1,0),(598,4,14,1,1,1,1),(599,4,15,1,1,0,0),(600,4,16,1,0,0,1),(601,4,17,1,0,0,0),(602,4,18,1,1,1,1),(603,4,20,1,0,0,0),(604,4,21,1,0,0,0),(605,4,22,1,0,0,0),(606,4,23,1,1,1,1),(607,4,24,1,1,1,1),(608,4,25,0,0,0,0);
/*!40000 ALTER TABLE `tbl_ms_permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_preguntas`
--

DROP TABLE IF EXISTS `tbl_ms_preguntas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_preguntas` (
  `id_pregunta` int NOT NULL AUTO_INCREMENT COMMENT 'cod de la pregunta.',
  `pregunta` varchar(100) DEFAULT NULL COMMENT 'Nombre de la pregunta.',
  PRIMARY KEY (`id_pregunta`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que guarda las preguntas que le aparecerán al usuario cuando conteste las preguntas secretas.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_preguntas`
--

LOCK TABLES `tbl_ms_preguntas` WRITE;
/*!40000 ALTER TABLE `tbl_ms_preguntas` DISABLE KEYS */;
INSERT INTO `tbl_ms_preguntas` VALUES (9,'COMO SE LLAMA TU ABUELA MATERNA'),(11,'CóMO SE LLAMA TU MASCOTA');
/*!40000 ALTER TABLE `tbl_ms_preguntas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_preguntas_usuario`
--

DROP TABLE IF EXISTS `tbl_ms_preguntas_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_preguntas_usuario` (
  `id_pregunta` int NOT NULL COMMENT 'cod de la pregunta.',
  `id_usuario` bigint NOT NULL COMMENT 'cod del usuario.',
  `respuesta` varchar(100) DEFAULT NULL COMMENT 'Respuesta que dió el usuario cuando contestó la pregunta.',
  KEY `preguntaUsuario_idUsuario_idx` (`id_usuario`),
  CONSTRAINT `preguntaUsuario_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla intermedia entre las preguntas y los usuarios. Va guardando las preguntas que contesta un usuario, que pueden ser varias.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_preguntas_usuario`
--

LOCK TABLES `tbl_ms_preguntas_usuario` WRITE;
/*!40000 ALTER TABLE `tbl_ms_preguntas_usuario` DISABLE KEYS */;
INSERT INTO `tbl_ms_preguntas_usuario` VALUES (11,192,'BOBBY'),(9,192,'ROSA');
/*!40000 ALTER TABLE `tbl_ms_preguntas_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_roles`
--

DROP TABLE IF EXISTS `tbl_ms_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_roles` (
  `id_rol` bigint NOT NULL AUTO_INCREMENT COMMENT 'cod del rol.',
  `nombrerol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL COMMENT 'Nombre del rol.',
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL COMMENT 'Descripción del rol. Osea una explicación de ese rol.',
  `estado` int NOT NULL DEFAULT '1' COMMENT 'Estado del rol.',
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci COMMENT='Tabla que almacena los roles del sistema.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_roles`
--

LOCK TABLES `tbl_ms_roles` WRITE;
/*!40000 ALTER TABLE `tbl_ms_roles` DISABLE KEYS */;
INSERT INTO `tbl_ms_roles` VALUES (1,'ADMINISTRADOR','Acceso a todo el sistema',1),(2,'DEFAULT','Rol por defecto',1),(3,'Clientes de todo','Clientes en general',0),(4,'VENDEDOR','Operador de tienda',1),(5,'prueba','fddfd',0),(6,'prueba2','gg',0),(7,'prueba33','d',0),(8,'prueba4','f',0),(9,'nuevo1','dch',0),(10,'prueba555','gggggg',0),(11,'Nuevo de prueba','sf',0),(12,'probar cambio','sddd',0),(13,'prueba44','f',0),(14,'prueba4446','d',0),(15,'Nueva Prueba','sssss',0),(16,'rrrr','rf',0),(17,'gu','f',0),(18,'fff','fffd',0),(19,'rrr','rr',0),(20,'j','j',0),(21,'www','www',0),(22,'CONTABILIDAD','rrr',0),(23,'nuevorol','d',0);
/*!40000 ALTER TABLE `tbl_ms_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_usuarios`
--

DROP TABLE IF EXISTS `tbl_ms_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_usuarios` (
  `id_usuario` bigint NOT NULL AUTO_INCREMENT COMMENT 'cod del usuario.',
  `usuario` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL COMMENT 'Usuario.',
  `nombre_usuario` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL COMMENT 'Nombre del usuario.',
  `estado` int NOT NULL DEFAULT '1' COMMENT 'Estado del usuario.',
  `contrasena` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL COMMENT 'Contraseña del usuario.',
  `fecha_ultima_conexion` datetime DEFAULT NULL COMMENT 'Última conexión del usuario al sistema.',
  `preguntas_contestadas` int DEFAULT '0' COMMENT 'Preguntas contestadas por el usuario.',
  `primer_ingreso` int DEFAULT NULL COMMENT 'Primer ingreso del usuario al sistema.',
  `fecha_vencimiento` datetime DEFAULT NULL COMMENT 'Fecha de vencimiento del usuario.',
  `correo_electronico` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL COMMENT 'Correo electrónico del usuario. ',
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL COMMENT 'Este token sirve para cuando el usuario esté recuperando su contraseña por medio de correo electrónico.',
  `creado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL COMMENT 'Muestra qué usuario creó a este otro usuario.',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se registró al usuario.',
  `modificado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL COMMENT 'Muestra quién fue que modificó al usuario.',
  `fecha_modificacion` datetime DEFAULT NULL COMMENT 'Fecha en que se modificó al usuario.',
  `id_rol` bigint NOT NULL COMMENT 'cod del rol que tiene el usuario dentro del sistema.',
  PRIMARY KEY (`id_usuario`),
  KEY `rolid` (`id_rol`),
  CONSTRAINT `tbl_ms_usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tbl_ms_roles` (`id_rol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci COMMENT='Tabla que almacena los usuarios del sistema.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_usuarios`
--

LOCK TABLES `tbl_ms_usuarios` WRITE;
/*!40000 ALTER TABLE `tbl_ms_usuarios` DISABLE KEYS */;
INSERT INTO `tbl_ms_usuarios` VALUES (1,'ADMIN','ADMINISTRADOR',1,'ca29863b8b4be2fd63b5bc73276c8e407cda29e03da5c4646b96612110aaf901','2023-07-17 12:38:14',0,NULL,NULL,'admin@atlantico.com','733464113f1d79251461-4ff19d069fb2ec635522-a12faeec9a0c21dd0b33-435908728e5136f3ae80',NULL,'2021-08-20 01:34:15','ADMIN','2023-04-28 20:23:52',1),(19,'ALEXANDER','ALEXANDER AGUILAR',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,0,NULL,NULL,'alex@hotmail.com',NULL,NULL,'2023-02-04 01:16:01','ADMIN','2023-03-22 10:36:01',4),(20,'ERIKA','ERIKA AYALA',2,'18ac3e7343f016890c510e93f935261169d9e3f565436429830faf0934f4f8e4',NULL,0,NULL,NULL,'erika3@gmail.com',NULL,NULL,'2023-02-08 21:40:58','ADMIN','2023-03-22 10:35:34',2),(104,'HECTOR','HECTOR BUSTILLOO',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,2,NULL,NULL,'hector@hotmail.com',NULL,'ADMIN','2023-03-08 15:22:09','ADMIN','2023-03-22 21:14:43',1),(190,'ANA','ANA',3,'c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb',NULL,0,NULL,NULL,'ana@hotmail.com',NULL,'ADMIN','2023-05-04 21:05:39',NULL,NULL,1),(191,'ANALIA','ANALIA',3,'c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb',NULL,0,NULL,NULL,'analia@hotmail.com',NULL,'ADMIN','2023-05-04 21:06:03',NULL,NULL,1),(192,'LOPEZ','LOPEZ',1,'c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb','2023-06-03 00:08:14',2,NULL,NULL,'lopez@hotmail.com',NULL,'ADMIN','2023-05-04 21:07:37','ADMIN','2023-06-02 23:57:58',4);
/*!40000 ALTER TABLE `tbl_ms_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_porcentaje_descuento`
--

DROP TABLE IF EXISTS `tbl_porcentaje_descuento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_porcentaje_descuento` (
  `cod` int NOT NULL AUTO_INCREMENT COMMENT 'Código.',
  `porcentaje_descuento` decimal(10,2) DEFAULT NULL COMMENT 'Porcentaje del descuento.',
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que guarda el porcentaje del descuento que se haya seleccionado al momento de crear una venta.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_porcentaje_descuento`
--

LOCK TABLES `tbl_porcentaje_descuento` WRITE;
/*!40000 ALTER TABLE `tbl_porcentaje_descuento` DISABLE KEYS */;
INSERT INTO `tbl_porcentaje_descuento` VALUES (1,0.00);
/*!40000 ALTER TABLE `tbl_porcentaje_descuento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_produccion`
--

DROP TABLE IF EXISTS `tbl_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_produccion` (
  `cod_produccion` int NOT NULL AUTO_INCREMENT COMMENT 'Código de producción.',
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL COMMENT 'Cantidad que se va a producir.',
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se mandó a producción.',
  `id_usuario` bigint DEFAULT NULL COMMENT 'cod del usuario que registró la producción.',
  `estado` int DEFAULT '1' COMMENT 'Estado de la producción.',
  PRIMARY KEY (`cod_produccion`),
  KEY `Produccion_CodProducto_idx` (`cod_producto`),
  KEY `Produccion_IdUsuario_idx` (`id_usuario`),
  CONSTRAINT `Produccion_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `Produccion_IdUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena la producción de productos en la empresa.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_produccion`
--

LOCK TABLES `tbl_produccion` WRITE;
/*!40000 ALTER TABLE `tbl_produccion` DISABLE KEYS */;
INSERT INTO `tbl_produccion` VALUES (115,15,2,'2023-04-18 20:41:31',1,1),(116,15,10,'2023-04-18 20:43:47',1,3),(117,18,12,'2023-04-18 20:45:23',1,1),(118,19,15,'2023-04-18 20:46:12',1,4),(119,19,1,'2023-04-19 00:51:36',1,3),(120,19,2,'2023-04-29 00:16:21',1,2),(121,19,10,'2023-06-02 10:38:55',1,3);
/*!40000 ALTER TABLE `tbl_produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_producto`
--

DROP TABLE IF EXISTS `tbl_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_producto` (
  `cod_producto` int NOT NULL AUTO_INCREMENT COMMENT 'Código del producto.',
  `nombre_producto` varchar(30) DEFAULT NULL COMMENT 'Nombre del producto.',
  `descripcion` varchar(255) DEFAULT NULL COMMENT 'Descripción del producto.',
  `cantidad_minima` int DEFAULT NULL COMMENT 'Cantidad mínima que se debe tener de ese producto en el inventario.',
  `cantidad_maxima` int DEFAULT NULL COMMENT 'Cantidad máxima que se debe tener de ese producto en el inventario.',
  `cod_tipo_producto` int DEFAULT NULL COMMENT 'Código del tipo de producto. Me ayuda a diferenciar si es un producto terminado o un insumo.',
  `precio_venta` decimal(8,2) DEFAULT NULL COMMENT 'Precio de venta.',
  `estado` int DEFAULT '1' COMMENT 'Estado del producto.',
  `creado_por` varchar(15) DEFAULT NULL COMMENT 'Nombre del usuario que registró el producto.',
  `fecha_creacion` datetime DEFAULT NULL COMMENT 'Fecha en que se registró el producto.',
  `modificado_por` varchar(15) DEFAULT NULL COMMENT 'Nombre del usuario que modificó el producto.',
  `fecha_modificacion` datetime DEFAULT NULL COMMENT 'Fecha en que se modificó el producto.',
  `existencia` int DEFAULT NULL COMMENT 'Existencia del producto en mi inventario.',
  PRIMARY KEY (`cod_producto`),
  KEY `TBL_TIPO_PRODUCTO_COD_TIPO_PRODUCTO_idx` (`cod_tipo_producto`),
  CONSTRAINT `Producto_CodTipoProducto` FOREIGN KEY (`cod_tipo_producto`) REFERENCES `tbl_tipo_producto` (`cod_tipo_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los productos e insumos de la empresa.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_producto`
--

LOCK TABLES `tbl_producto` WRITE;
/*!40000 ALTER TABLE `tbl_producto` DISABLE KEYS */;
INSERT INTO `tbl_producto` VALUES (12,'TELA','TELA BLANCA',200,30,3,30.00,1,NULL,NULL,NULL,NULL,77),(13,'PINTURA','ROJA',10,100,3,20.00,1,NULL,NULL,NULL,NULL,48),(15,'MONOGRAMA','MONOGRAMA ESCOLAR',3,4,4,65.20,1,'ADMIN','2023-04-13 10:21:05','ADMIN','2023-04-13 10:30:07',23),(16,'PINTURA PARA SERIGRAFíA','PINTURA',12,23,3,100.00,1,'ADMIN','2023-04-13 10:27:48',NULL,NULL,201),(17,'PAPEL VINIL','PAPEL',200,100,3,23.00,1,'ADMIN','2023-04-13 10:29:04',NULL,NULL,122),(18,'BUSO ESCOLAR','BUSO',20,40,4,100.00,1,'ADMIN','2023-04-13 10:30:40','ADMIN','2023-04-13 10:30:55',16),(19,'CAMISA BLANCA','CAMISA',5,100,4,220.00,1,'ADMIN','2023-04-13 15:16:06',NULL,NULL,959),(20,'HILASA','HILASA',2,23,3,43.00,1,'ADMIN','2023-04-17 01:33:35',NULL,NULL,124),(21,'BANDERA HONDURAS','BANDERA',12,22,4,150.00,1,'ADMIN','2023-04-24 15:21:08',NULL,NULL,11),(22,'TERMO','TERMO',12,45,4,100.00,1,'ADMIN','2023-04-24 15:21:30','ADMIN','2023-04-24 15:31:16',22),(23,'COJíN','COJíN',3,45,4,170.00,1,'ADMIN','2023-04-24 15:22:09',NULL,NULL,100),(24,'PANTALóN ESCOLAR','PANTALóN',120,200,4,250.00,1,'ADMIN','2023-04-24 15:22:42',NULL,NULL,6),(25,'CUBALLERA BLANCA','CUBALLERA',24,55,4,250.00,1,'ADMIN','2023-04-24 15:23:06',NULL,NULL,28);
/*!40000 ALTER TABLE `tbl_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_promocion`
--

DROP TABLE IF EXISTS `tbl_promocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_promocion` (
  `cod_promocion` int NOT NULL AUTO_INCREMENT COMMENT 'Código de la promoción.',
  `nombre_promocion` varchar(100) DEFAULT NULL COMMENT 'Nombre de la promoción.',
  `fecha_inicio` datetime DEFAULT NULL COMMENT 'Fecha de inicio de la promoción.',
  `fecha_final` datetime DEFAULT NULL COMMENT 'Fecha en que finaliza la promoción.',
  `precio_venta` decimal(8,2) DEFAULT NULL COMMENT 'Precio de venta.',
  `id_usuario` bigint DEFAULT NULL COMMENT 'cod del usuario que registró esa promoción.',
  `estado` int DEFAULT '1' COMMENT 'Estado de la promoción.',
  PRIMARY KEY (`cod_promocion`),
  KEY `Promo_Usuario_idx` (`id_usuario`),
  CONSTRAINT `Promo_Usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena las promociones que quiera implementar la empresa.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_promocion`
--

LOCK TABLES `tbl_promocion` WRITE;
/*!40000 ALTER TABLE `tbl_promocion` DISABLE KEYS */;
INSERT INTO `tbl_promocion` VALUES (2,'PROMO 1','2023-03-30 22:00:00','2023-04-28 23:03:00',500.00,1,1),(3,'PROMO 2','2023-03-30 22:00:00','2023-04-26 23:03:00',400.00,1,1);
/*!40000 ALTER TABLE `tbl_promocion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_promocion_producto`
--

DROP TABLE IF EXISTS `tbl_promocion_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_promocion_producto` (
  `id_promocion_producto` int NOT NULL AUTO_INCREMENT COMMENT 'cod de la promoción producto.',
  `cod_promocion` int DEFAULT NULL COMMENT 'Código de la promoción.',
  `cod_producto` int DEFAULT NULL COMMENT 'Código del producto.',
  `cantidad` int DEFAULT NULL COMMENT 'Cantidad de producto.',
  PRIMARY KEY (`id_promocion_producto`),
  KEY `promocion_producto_idx` (`cod_promocion`),
  KEY `promocionProducto_Producto_idx` (`cod_producto`),
  CONSTRAINT `promocionProducto_Producto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `promocionProducto_Promocion` FOREIGN KEY (`cod_promocion`) REFERENCES `tbl_promocion` (`cod_promocion`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla intermedia entre promoción y producto. Almacenará los detalles de una promoción. Una promoción puede tener varios productos, y un producto puede estar en varias promociones.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_promocion_producto`
--

LOCK TABLES `tbl_promocion_producto` WRITE;
/*!40000 ALTER TABLE `tbl_promocion_producto` DISABLE KEYS */;
INSERT INTO `tbl_promocion_producto` VALUES (1,2,18,1),(2,2,24,2),(4,2,25,2),(10,3,18,3),(11,3,19,2);
/*!40000 ALTER TABLE `tbl_promocion_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_movimiento`
--

DROP TABLE IF EXISTS `tbl_tipo_movimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tipo_movimiento` (
  `cod_tipo_movimiento` int NOT NULL AUTO_INCREMENT COMMENT 'Código del tipo de movimiento.',
  `nombre_movimiento` varchar(7) DEFAULT NULL COMMENT 'Nombre del tipo de movimiento.',
  PRIMARY KEY (`cod_tipo_movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Taba que almacena los dos tipos de movimientos. Entrada y Salida.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_movimiento`
--

LOCK TABLES `tbl_tipo_movimiento` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_movimiento` DISABLE KEYS */;
INSERT INTO `tbl_tipo_movimiento` VALUES (1,'ENTRADA'),(2,'SALIDA');
/*!40000 ALTER TABLE `tbl_tipo_movimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_producto`
--

DROP TABLE IF EXISTS `tbl_tipo_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tipo_producto` (
  `cod_tipo_producto` int NOT NULL AUTO_INCREMENT COMMENT 'código del tipo de producto.',
  `nombre_tipo_producto` varchar(30) DEFAULT NULL COMMENT 'Nombre del tipo de producto.',
  PRIMARY KEY (`cod_tipo_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena el tipo de producto.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_producto`
--

LOCK TABLES `tbl_tipo_producto` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_producto` DISABLE KEYS */;
INSERT INTO `tbl_tipo_producto` VALUES (3,'INSUMO'),(4,'PRODUCTO TERMINADO');
/*!40000 ALTER TABLE `tbl_tipo_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_inversiones_atlantico'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_detalle_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_detalle_temp`(`codigo` INT, `cantidad` INT, `token_user` VARCHAR(50))
BEGIN

        DECLARE precio_actual decimal(10,2);
        SELECT precio_venta INTO precio_actual FROM tbl_producto WHERE cod_producto = codigo;

        INSERT INTO detalle_temp(token_user,cod_producto,cantidad,precio_venta,cant_multi) VALUES(token_user,codigo,cantidad,precio_actual,cantidad);

        SELECT tmp.cod_detalle_factura, tmp.cod_producto,p.nombre_producto,tmp.cantidad,tmp.precio_venta FROM detalle_temp tmp
        INNER JOIN tbl_producto p
        ON tmp.cod_producto = p.cod_producto
        WHERE tmp.token_user = token_user;

    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_detalle_temp_c` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_detalle_temp_c`(`codigo` INT, `cantidad` INT, `token_user` VARCHAR(50), `precio_compra` decimal(10,2))
BEGIN                
        INSERT INTO detalle_temp_c(token_user,cod_producto,cantidad,precio_venta) VALUES(token_user,codigo,cantidad,precio_compra);

        SELECT tmp.cod_detalle_factura, tmp.cod_producto,p.nombre_producto,tmp.cantidad,tmp.precio_venta FROM detalle_temp_c tmp
        INNER JOIN tbl_producto p
        ON tmp.cod_producto = p.cod_producto
        WHERE tmp.token_user = token_user;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_detalle_temp_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_detalle_temp_p`(`codigo` INT, `cantidad` INT, `token_user` VARCHAR(50))
BEGIN		
        DECLARE precio_actual decimal(10,2);
        SELECT precio_venta INTO precio_actual FROM tbl_producto WHERE cod_producto = codigo;

        INSERT INTO detalle_temp_p(token_user,cod_producto,cantidad) VALUES(token_user,codigo,cantidad);

        SELECT tmp.cod_detalle_produccion, tmp.cod_producto,p.nombre_producto,tmp.cantidad FROM detalle_temp_p tmp
        INNER JOIN tbl_producto p
        ON tmp.cod_producto = p.cod_producto
        WHERE tmp.token_user = token_user;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_detalle_temp_pr` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_detalle_temp_pr`(`codigo` INT, `cantidad` INT, `token_user` VARCHAR(50))
BEGIN

        DECLARE precio_actual decimal(10,2);
        SELECT precio_venta INTO precio_actual FROM tbl_producto WHERE cod_producto = codigo;

        INSERT INTO detalle_temp_pr(token_user,cod_producto,cantidad) VALUES(token_user,codigo,cantidad);

        SELECT tmp.cod_detalle_produccion, tmp.cod_producto,p.nombre_producto,tmp.cantidad FROM detalle_temp_pr tmp
        INNER JOIN tbl_producto p
        ON tmp.cod_producto = p.cod_producto
        WHERE tmp.token_user = token_user;

    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_promocion_detalle_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_promocion_detalle_temp`(
    IN `cod_promocion` INT,
    IN `token_user` VARCHAR(50)
)
BEGIN
DECLARE promo VARCHAR(50);

    DECLARE cod_producto INT;
    DECLARE cantidad INT;
    DECLARE precio_actual decimal(10,2);
    DECLARE total_productos INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE isFirstRow BOOL DEFAULT TRUE; -- add this variable
    
    DECLARE cursor_productos CURSOR FOR 
        SELECT tp.cod_producto, tp.cantidad, promo.precio_venta AS precio_venta, promo.nombre_promocion AS promo 
        FROM tbl_producto p
        INNER JOIN tbl_promocion_producto tp ON tp.cod_producto = p.cod_producto
        INNER JOIN tbl_promocion promo ON tp.cod_promocion = promo.cod_promocion
        WHERE tp.cod_promocion = cod_promocion;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cursor_productos;
    
    read_loop: LOOP
        FETCH cursor_productos INTO cod_producto, cantidad, precio_actual, promo;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- use the isFirstRow variable to insert the precio_venta value only in the first row
        IF isFirstRow THEN
            INSERT INTO detalle_temp(token_user,cod_producto,cantidad,precio_venta, promo, cant_multi) 
            VALUES(token_user,cod_producto,cantidad,precio_actual, promo, 1);
            SET isFirstRow = FALSE; -- set isFirstRow to false after the first insert
        ELSE
            INSERT INTO detalle_temp(token_user,cod_producto,cantidad, promo) 
            VALUES(token_user,cod_producto,cantidad, promo);
        END IF;
        
        SET total_productos = total_productos + 1;
    END LOOP;
    
    CLOSE cursor_productos;
    
    SELECT cod_detalle_factura, d.cod_producto, nombre_producto, d.cantidad, d.precio_venta, d.promo
    FROM detalle_temp d
    INNER JOIN tbl_producto p ON d.cod_producto = p.cod_producto 
    WHERE d.token_user = token_user;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `anular_compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anular_compra`(IN `no_compra` INT)
BEGIN
		DECLARE existe_compra int;
        DECLARE registros int;
        DECLARE a int;
        
        DECLARE codproducto int;
        DECLARE cant_producto int;
        DECLARE existencia_actual int;
        DECLARE nueva_existencia int;
        
        SET existe_compra = (SELECT COUNT(*) FROM tbl_compra WHERE cod_compra = no_compra and estado = 1);
        
        IF existe_compra > 0 THEN
        	CREATE TEMPORARY TABLE tbl_tmp_c (
                cod BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
                SET a = 1;
                
                SET registros = (SELECT COUNT(*) FROM tbl_detalle_compra WHERE cod_compra = no_compra);
                
                IF registros > 0 THEN
                	INSERT INTO tbl_tmp_c(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM tbl_detalle_compra WHERE cod_compra = no_compra;
                    
                    WHILE a <= registros DO
                    	SELECT cod_prod,cant_prod INTO codproducto,cant_producto FROM tbl_tmp_c WHERE cod = a;
                        SELECT existencia INTO existencia_actual FROM tbl_producto WHERE cod_producto = codproducto;
                        SET nueva_existencia = existencia_actual - cant_producto;
                        UPDATE tbl_producto SET existencia = nueva_existencia WHERE cod_producto = codproducto;
                        
                        SET a=a+1;
                    END WHILE;
                    
                    UPDATE tbl_compra SET estado = 2 WHERE cod_compra = no_compra;
                    DROP TABLE tbl_tmp_c;
                    SELECT * from tbl_compra WHERE cod_compra = no_compra;
                   
                END IF;

        ELSE
        	SELECT 0 factura;
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `anular_factura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anular_factura`(IN `no_factura` INT)
BEGIN
    	DECLARE existe_factura int;
        DECLARE registros int;
        DECLARE a int;
        
        DECLARE codproducto int;
        DECLARE cant_producto int;
        DECLARE existencia_actual int;
        DECLARE nueva_existencia int;
        
        SET existe_factura = (SELECT COUNT(*) FROM tbl_factura WHERE cod_factura = no_factura and estado = 1);
        
        IF existe_factura > 0 THEN
        	CREATE TEMPORARY TABLE tbl_tmp (
                cod BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
                SET a = 1;
                
                SET registros = (SELECT COUNT(*) FROM tbl_detalle_factura WHERE cod_factura = no_factura);
                
                IF registros > 0 THEN
                	INSERT INTO tbl_tmp(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM tbl_detalle_factura WHERE cod_factura = no_factura;
                    
                    WHILE a <= registros DO
                    	SELECT cod_prod,cant_prod INTO codproducto,cant_producto FROM tbl_tmp WHERE cod = a;
                        SELECT existencia INTO existencia_actual FROM tbl_producto WHERE cod_producto = codproducto;
                        SET nueva_existencia = existencia_actual + cant_producto;
                        UPDATE tbl_producto SET existencia = nueva_existencia WHERE cod_producto = codproducto;
                        
                        SET a=a+1;
                    END WHILE;
                    
                    UPDATE tbl_factura SET estado = 2 WHERE cod_factura = no_factura;
                    DROP TABLE tbl_tmp;
                    SELECT * from tbl_factura WHERE cod_factura = no_factura;
                   
                END IF;

        ELSE
        	SELECT 0 factura;
        END IF;
        
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `anular_produccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anular_produccion`(IN `no_factura` INT)
BEGIN
    	DECLARE existe_factura int;
        DECLARE registros int;
        DECLARE a int;
        
        DECLARE codproducto int;
        DECLARE cant_producto int;
        DECLARE existencia_actual int;
        DECLARE nueva_existencia int;
        
        SET existe_factura = (SELECT COUNT(*) FROM tbl_produccion WHERE cod_produccion = no_factura and estado = 1);
        
        IF existe_factura > 0 THEN
        	CREATE TEMPORARY TABLE tbl_tmp (
                cod BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
                SET a = 1;
                
                SET registros = (SELECT COUNT(*) FROM tbl_detalle_produccion WHERE cod_produccion = no_factura);
                
                IF registros > 0 THEN
                	INSERT INTO tbl_tmp(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM tbl_detalle_produccion WHERE cod_produccion = no_factura;
                    
                    WHILE a <= registros DO
                    	SELECT cod_prod,cant_prod INTO codproducto,cant_producto FROM tbl_tmp WHERE cod = a;
                        SELECT existencia INTO existencia_actual FROM tbl_producto WHERE cod_producto = codproducto;
                        SET nueva_existencia = existencia_actual + cant_producto;
                        UPDATE tbl_producto SET existencia = nueva_existencia WHERE cod_producto = codproducto;
                        
                        SET a=a+1;
                    END WHILE;
                    
                    UPDATE tbl_produccion SET estado = 2 WHERE cod_produccion = no_factura;
                    DROP TABLE tbl_tmp;
                    SELECT * from tbl_produccion WHERE cod_produccion = no_factura;
                   
                END IF;

        ELSE
        	SELECT 0 factura;
        END IF;
        
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `anular_promocion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anular_promocion`(IN `no_factura` INT)
BEGIN
		DECLARE existe_factura int;
        DECLARE registros int;
        DECLARE a int;
        
        DECLARE codproducto int;
        DECLARE cant_producto int;
        DECLARE existencia_actual int;
        DECLARE nueva_existencia int;
        
        SET existe_factura = (SELECT COUNT(*) FROM tbl_promocion WHERE cod_promocion = no_factura and estado = 1);
        
        IF existe_factura > 0 THEN
        	CREATE TEMPORARY TABLE tbl_tmp_p (
                cod BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
                SET a = 1;
                
                SET registros = (SELECT COUNT(*) FROM tbl_promocion_producto WHERE cod_promocion = no_factura);
                
                IF registros > 0 THEN
                	INSERT INTO tbl_tmp_p(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM tbl_promocion_producto WHERE cod_promocion = no_factura;
                    
                    WHILE a <= registros DO
                    	SELECT cod_prod,cant_prod INTO codproducto,cant_producto FROM tbl_tmp_p WHERE cod = a;
                        SELECT existencia INTO existencia_actual FROM tbl_producto WHERE cod_producto = codproducto;
                        SET nueva_existencia = existencia_actual + cant_producto;
                        UPDATE tbl_producto SET existencia = nueva_existencia WHERE cod_producto = codproducto;
                        
                        SET a=a+1;
                    END WHILE;
                    
                    UPDATE tbl_promocion SET estado = 2 WHERE cod_promocion = no_factura;
                    DROP TABLE tbl_tmp_p;
                    SELECT * from tbl_promocion WHERE cod_promocion = no_factura;
                   
                END IF;

        ELSE
        	SELECT 0 factura;
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `del_detalle_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_detalle_temp`(`id_detalle` INT, `token` VARCHAR(50))
BEGIN
    DECLARE promo_valor VARCHAR(50);

    SELECT promo INTO promo_valor FROM detalle_temp WHERE cod_detalle_factura = id_detalle;

    DELETE FROM detalle_temp WHERE cod_detalle_factura = id_detalle AND (promo IS NOT NULL OR promo IS NULL);

    IF promo_valor IS NOT NULL THEN
        DELETE FROM detalle_temp WHERE promo = promo_valor;
    END IF;

    SELECT tmp.cod_detalle_factura, tmp.cod_producto,p.nombre_producto,tmp.cantidad,tmp.precio_venta FROM detalle_temp tmp
    INNER JOIN tbl_producto p
    ON tmp.cod_producto = p.cod_producto
    WHERE tmp.token_user = token;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `del_detalle_temp_c` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_detalle_temp_c`(`id_detalle` INT, `token` VARCHAR(50))
BEGIN
	DELETE FROM detalle_temp_c WHERE cod_detalle_factura = id_detalle;

	SELECT tmp.cod_detalle_factura, tmp.cod_producto,p.nombre_producto,tmp.cantidad,tmp.precio_venta FROM detalle_temp_c tmp
	INNER JOIN tbl_producto p
	ON tmp.cod_producto = p.cod_producto
	WHERE tmp.token_user = token;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `del_detalle_temp_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_detalle_temp_p`(`id_detalle` INT, `token` VARCHAR(50))
BEGIN
DELETE FROM detalle_temp_p WHERE cod_detalle_produccion = id_detalle;

        SELECT tmp.cod_detalle_produccion, tmp.cod_producto,p.nombre_producto,tmp.cantidad FROM detalle_temp_p tmp
        INNER JOIN tbl_producto p
        ON tmp.cod_producto = p.cod_producto
        WHERE tmp.token_user = token;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `del_detalle_temp_pr` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_detalle_temp_pr`(`id_detalle` INT, `token` VARCHAR(50))
BEGIN
        DELETE FROM detalle_temp_pr WHERE cod_detalle_produccion = id_detalle;

        SELECT tmp.cod_detalle_produccion, tmp.cod_producto,p.nombre_producto,tmp.cantidad FROM detalle_temp_pr tmp
        INNER JOIN tbl_producto p
        ON tmp.cod_producto = p.cod_producto
        WHERE tmp.token_user = token;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `procesar_compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `procesar_compra`(`cod_usuario` INT, `token` VARCHAR(50))
BEGIN
		DECLARE compra INT;
        
        DECLARE registros INT;
        DECLARE total DECIMAL(10,2);

        DECLARE nueva_existencia int;
        DECLARE existencia_actual int;

        DECLARE tmp_cod_producto int;
        DECLARE tmp_cant_producto int;
        DECLARE a INT;
        SET a = 1;
        
        CREATE TEMPORARY TABLE tbl_tmp_tokenuser_c (
                cod BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
        SET registros = (SELECT COUNT(*) FROM detalle_temp_c WHERE token_user = token);
        
        IF registros > 0 THEN
        	INSERT INTO tbl_tmp_tokenuser_c(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM detalle_temp_c WHERE token_user = token;
           
            INSERT INTO tbl_compra(id_usuario) VALUES(cod_usuario);
            SET compra = LAST_INSERT_ID();
            
            INSERT INTO tbl_detalle_compra(cod_compra,cod_producto,cantidad,precio_venta) SELECT (compra) as cod_compra, cod_producto,cantidad,precio_venta FROM detalle_temp_c WHERE token_user = token;
                        INSERT INTO tbl_kardex (cod_producto, cantidad, fecha, cod_tipo_movimiento)
                        
                        
SELECT cod_producto, cantidad, NOW(), 1
FROM detalle_temp_c
WHERE token_user = token;
            
            
            WHILE a <= registros DO
            	SELECT cod_prod,cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser_c WHERE cod = a;
                SELECT existencia INTO existencia_actual FROM tbl_producto WHERE cod_producto = tmp_cod_producto;
                
                SET nueva_existencia = existencia_actual + tmp_cant_producto;
                UPDATE tbl_producto SET existencia = nueva_existencia WHERE cod_producto = tmp_cod_producto;
                
                SET a=a+1;
            	
            END WHILE;
                                  
            
            
		   SET total = (SELECT SUM(cantidad * precio_venta) FROM detalle_temp_c WHERE token_user = token);
           
            UPDATE tbl_compra SET total_pagado = total
            WHERE cod_compra = compra;--
          
            DELETE FROM detalle_temp_c WHERE token_user = token;
            TRUNCATE TABLE tbl_tmp_tokenuser_c;
            SELECT * FROM tbl_compra WHERE cod_compra = compra;
        ELSE
        	SELECT 0;
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `procesar_produccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `procesar_produccion`(`cod_usuario` INT, `token` VARCHAR(50),`codproducto` INT,`cantidadproducto` INT)
BEGIN
		DECLARE factura INT;

        DECLARE registros INT;

        DECLARE nueva_existencia int;
        DECLARE existencia_actual int;

        DECLARE tmp_cod_producto int;
        DECLARE tmp_cant_producto int;
        DECLARE a INT;
        SET a = 1;
        
        CREATE TEMPORARY TABLE tbl_tmp_tokenuser (
                cod BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
        SET registros = (SELECT COUNT(*) FROM detalle_temp_pr WHERE token_user = token);
        
        IF registros > 0 THEN
        	INSERT INTO tbl_tmp_tokenuser(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM detalle_temp_pr WHERE token_user = token;
            
            INSERT INTO tbl_produccion(id_usuario) VALUES(cod_usuario);
            SET factura = LAST_INSERT_ID();
            
            INSERT INTO tbl_detalle_produccion(cod_produccion,cod_producto,cantidad) SELECT (factura) as cod_produccion, cod_producto,cantidad FROM detalle_temp_pr WHERE token_user = token;
     
            INSERT INTO tbl_kardex (cod_producto, cantidad, fecha, cod_tipo_movimiento)
SELECT cod_producto, cantidad, NOW(), 2
FROM detalle_temp_pr
WHERE token_user = token;
            
                 
     
            WHILE a <= registros DO
            	SELECT cod_prod,cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser WHERE cod = a;
                SELECT existencia INTO existencia_actual FROM tbl_producto WHERE cod_producto = tmp_cod_producto;
                
                SET nueva_existencia = existencia_actual - tmp_cant_producto;
                UPDATE tbl_producto SET existencia = nueva_existencia WHERE cod_producto = tmp_cod_producto;
                
                SET a=a+1;
            	
            END WHILE;
            
	

           
            UPDATE tbl_produccion SET cod_producto = codproducto, 
									cantidad = cantidadproducto							
            WHERE cod_produccion = factura;
          
            DELETE FROM detalle_temp_pr WHERE token_user = token;
            TRUNCATE TABLE tbl_tmp_tokenuser;
            SELECT * FROM tbl_produccion WHERE cod_produccion = factura;
           
        ELSE
        	SELECT 0;
        END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `procesar_promo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `procesar_promo`(`cod_usuario` INT, `token` VARCHAR(50), `nombre_promo` VARCHAR(20), `fecha_i` DATETIME, `fecha_f` DATETIME, `precio` DECIMAL(8,2))
BEGIN
	DECLARE factura INT;

        DECLARE registros INT;

        DECLARE nueva_existencia int;
        DECLARE existencia_actual int;

        DECLARE tmp_cod_producto int;
        DECLARE tmp_cant_producto int;
        DECLARE a INT;
        SET a = 1;
        
        CREATE TEMPORARY TABLE tbl_tmp_tokenuser_p (
                cod BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
        SET registros = (SELECT COUNT(*) FROM detalle_temp_p WHERE token_user = token);
        
        IF registros > 0 THEN
        	INSERT INTO tbl_tmp_tokenuser_p(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM detalle_temp_p WHERE token_user = token;
            
            INSERT INTO tbl_promocion(id_usuario) VALUES(cod_usuario);
            SET factura = LAST_INSERT_ID();
            
            INSERT INTO tbl_promocion_producto(cod_promocion,cod_producto,cantidad) SELECT (factura) as cod_promocion, cod_producto,cantidad FROM detalle_temp_p WHERE token_user = token;
	 
            WHILE a <= registros DO
            	SELECT cod_prod,cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser_p WHERE cod = a;
                SELECT existencia INTO existencia_actual FROM tbl_producto WHERE cod_producto = tmp_cod_producto;
                
              SET a=a+1;
            END WHILE;
           
            UPDATE tbl_promocion SET nombre_promocion = nombre_promo, 
									fecha_inicio = fecha_i,
                                    fecha_final = fecha_f,
                                    precio_venta = precio
            WHERE cod_promocion = factura;
          
            DELETE FROM detalle_temp_p WHERE token_user = token;
            TRUNCATE TABLE tbl_tmp_tokenuser_p;
            SELECT * FROM tbl_promocion WHERE cod_promocion = factura;
           
        ELSE
        	SELECT 0;
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `procesar_venta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `procesar_venta`(`cod_usuario` INT, `cod_cliente` INT, `token` VARCHAR(50))
BEGIN
		DECLARE factura INT;

        DECLARE registros INT;
        DECLARE total DECIMAL(10,2);
        
		DECLARE sub_total DECIMAL(10,2);--
         DECLARE porcentaje_desc DECIMAL(10,2);--
        DECLARE descuentos DECIMAL(10,2);--       
        DECLARE total_pagar DECIMAL(10,2);--
        
        
        DECLARE impuesto DECIMAL(10,2);
		DECLARE porcentaje_impuesto DECIMAL(10,2);

        DECLARE nueva_existencia int;
        DECLARE existencia_actual int;

        DECLARE tmp_cod_producto int;
        DECLARE tmp_cant_producto int;
        DECLARE a INT;
        SET a = 1;
        
        CREATE TEMPORARY TABLE tbl_tmp_tokenuser (
                cod BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
        SET registros = (SELECT COUNT(*) FROM detalle_temp WHERE token_user = token);
        
        IF registros > 0 THEN
        	INSERT INTO tbl_tmp_tokenuser(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM detalle_temp WHERE token_user = token;
            
            INSERT INTO tbl_factura(id_usuario,cod_cliente) VALUES(cod_usuario,cod_cliente);
            SET factura = LAST_INSERT_ID();
            
            INSERT INTO tbl_detalle_factura(cod_factura,cod_producto,cantidad,precio_venta,cantidad_multi,promocion) SELECT (factura) as cod_factura, cod_producto,cantidad,precio_venta,cant_multi,promo FROM detalle_temp WHERE token_user = token;
            
            
            
            INSERT INTO tbl_kardex (cod_producto, cantidad, fecha, cod_tipo_movimiento)
			SELECT cod_producto, cantidad, NOW(), 2
			FROM detalle_temp
	WHERE token_user = token;
            
            
            WHILE a <= registros DO
            	SELECT cod_prod,cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser WHERE cod = a;
                SELECT existencia INTO existencia_actual FROM tbl_producto WHERE cod_producto = tmp_cod_producto;
              
              
                SET nueva_existencia = existencia_actual - tmp_cant_producto;
                UPDATE tbl_producto SET existencia = nueva_existencia WHERE cod_producto = tmp_cod_producto;
                
                SET a=a+1;
            	
            END WHILE;
            
		   SET total = (SELECT SUM(cantidad * precio_venta) FROM detalle_temp WHERE token_user = token);
		   SET porcentaje_impuesto = (SELECT valor FROM tbl_ms_parametros where parametro = "impuesto");--
           
           
           
           
            SET porcentaje_desc = (SELECT porcentaje_descuento FROM tbl_porcentaje_descuento where cod = 1);--
			SET descuentos = (total * (porcentaje_desc/100));
           SET total_pagar = total - descuentos;
           
			SET sub_total 	= (total  / (1 + (porcentaje_impuesto / 100))); --     
            SET impuesto = (total-sub_total); --
           	
				
           
            UPDATE tbl_factura SET totalfactura = total_pagar, 
									subtotal = sub_total, 
									isv = impuesto, 
									porcentaje_isv = porcentaje_impuesto,
                                    descuento = descuentos
            WHERE cod_factura = factura;
          
            DELETE FROM detalle_temp WHERE token_user = token;
            TRUNCATE TABLE tbl_tmp_tokenuser;
            
            
            
            
                 START TRANSACTION;

SELECT rango_actual, numero_CAI INTO @rango_actual, @numero_CAI
FROM tbl_configuracion_cai
WHERE estado = 1
ORDER BY cod_talonario DESC
LIMIT 1;

UPDATE tbl_configuracion_cai
SET rango_actual = @rango_actual + 1
WHERE estado = 1
ORDER BY cod_talonario DESC
LIMIT 1;

UPDATE tbl_factura SET numero_factura = @rango_actual + 1, 
									cai = @numero_CAI							
            WHERE cod_factura = factura;  
COMMIT;
     	      UPDATE tbl_porcentaje_descuento SET porcentaje_descuento = 0 where cod = 1;

            SELECT * FROM tbl_factura WHERE cod_factura = factura;	
            
        ELSE
        	SELECT 0;
        END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-18 19:32:44
