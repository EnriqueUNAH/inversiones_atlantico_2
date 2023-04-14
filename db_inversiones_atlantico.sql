-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: db_inversiones_atlantico
-- ------------------------------------------------------
-- Server version	8.0.30

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
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rtn` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `razon_social` varchar(100) NOT NULL,
  `telefono` bigint NOT NULL,
  `email` varchar(200) NOT NULL,
  `direccion` text NOT NULL,
  `isv` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
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
  `token_user` varchar(50) NOT NULL,
  `cod_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cod_detalle_factura`),
  KEY `nofactura` (`token_user`),
  KEY `codproducto` (`cod_producto`),
  CONSTRAINT `detalle_temp_ibfk_2` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_temp`
--

LOCK TABLES `detalle_temp` WRITE;
/*!40000 ALTER TABLE `detalle_temp` DISABLE KEYS */;
INSERT INTO `detalle_temp` VALUES (236,'d41d8cd98f00b204e9800998ecf8427e',12,1,30.00),(237,'d41d8cd98f00b204e9800998ecf8427e',12,1,30.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_temp_c`
--

LOCK TABLES `detalle_temp_c` WRITE;
/*!40000 ALTER TABLE `detalle_temp_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_temp_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produccion`
--

DROP TABLE IF EXISTS `produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produccion` (
  `cod_produccion` int NOT NULL,
  `producto` varchar(45) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `fecha` varchar(45) DEFAULT NULL,
  `usuario` varchar(45) DEFAULT NULL,
  `estado` int DEFAULT NULL,
  PRIMARY KEY (`cod_produccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion`
--

LOCK TABLES `produccion` WRITE;
/*!40000 ALTER TABLE `produccion` DISABLE KEYS */;
INSERT INTO `produccion` VALUES (1,'CAMISA ENFERMERA',20,'2023-04-13 09:11:48','DORCA AGUILAR',1),(2,'PANTALÒN ESCOLAR',10,'2023-04-13 09:11:48','ENRIQUE NOLASCO',3),(3,'BUSO ESCOLAR',14,'2023-04-13 09:11:48','ERICKA AYALA',2),(4,'CAMISA PERSONALIZADA',23,'2023-04-13 09:11:48','DORCA AGUILAR',1);
/*!40000 ALTER TABLE `produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `idproducto` bigint NOT NULL AUTO_INCREMENT,
  `categoriaid` bigint NOT NULL,
  `codigo` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `stock` int NOT NULL,
  `imagen` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `datecreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ruta` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`idproducto`),
  KEY `categoriaid` (`categoriaid`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`categoriaid`) REFERENCES `categoria` (`idcategoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_cliente`
--

DROP TABLE IF EXISTS `tbl_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_cliente` (
  `cod_cliente` int NOT NULL AUTO_INCREMENT,
  `rtn` varchar(14) DEFAULT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `correo_electronico` varchar(30) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT NULL,
  `cod_genero` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`cod_cliente`),
  KEY `tbl_Genero_Cod_Genero_idx` (`cod_genero`),
  CONSTRAINT `Cliente_CodGenero` FOREIGN KEY (`cod_genero`) REFERENCES `tbl_genero` (`cod_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_cliente`
--

LOCK TABLES `tbl_cliente` WRITE;
/*!40000 ALTER TABLE `tbl_cliente` DISABLE KEYS */;
INSERT INTO `tbl_cliente` VALUES (5,'565656565656','CONSUMIDOR FINAL','',98888888,'','',NULL,3,1,1,NULL,NULL,'ADMIN','2023-04-13 00:57:28'),(6,'801200002389','DORCA NINOSCA AGUILAR','A',97293000,'dorca@hotmail.com','LOS PINOS',NULL,3,NULL,1,'ADMIN','2023-04-11 21:21:35','ADMIN','2023-04-13 00:36:35'),(7,'6565656567788','NANCY ALEJANDRA SALGADO',NULL,32146789,'','',NULL,3,NULL,1,'ADMIN','2023-04-13 00:02:01','ADMIN','2023-04-13 00:57:37');
/*!40000 ALTER TABLE `tbl_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_compra`
--

DROP TABLE IF EXISTS `tbl_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_compra` (
  `cod_compra` int NOT NULL AUTO_INCREMENT,
  `total_pagado` decimal(8,2) DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_usuario` bigint DEFAULT NULL,
  `estado` int DEFAULT '1',
  PRIMARY KEY (`cod_compra`),
  KEY `Compra_idUsuario_idx` (`id_usuario`),
  CONSTRAINT `Compra_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_compra`
--

LOCK TABLES `tbl_compra` WRITE;
/*!40000 ALTER TABLE `tbl_compra` DISABLE KEYS */;
INSERT INTO `tbl_compra` VALUES (4,NULL,NULL,1,NULL),(5,NULL,NULL,1,NULL),(6,30.00,NULL,1,NULL),(7,30.00,NULL,1,NULL),(8,30.00,NULL,1,NULL),(9,30.00,NULL,1,NULL),(10,30.00,NULL,1,NULL),(11,20.00,NULL,1,NULL),(12,40.00,NULL,1,NULL),(13,210.00,NULL,1,NULL),(14,30.00,NULL,1,NULL),(15,50.00,NULL,1,NULL),(16,50.00,NULL,1,NULL),(17,50.00,NULL,1,NULL),(18,50.00,NULL,1,NULL),(19,50.00,NULL,1,NULL),(20,50.00,NULL,1,NULL),(21,80.00,NULL,1,NULL),(22,50.00,NULL,1,NULL),(23,50.00,NULL,1,NULL),(24,50.00,NULL,1,NULL),(25,100.00,NULL,1,NULL),(26,50.00,NULL,1,NULL),(27,50.00,NULL,1,NULL),(28,50.00,NULL,1,NULL),(29,50.00,NULL,1,NULL),(30,50.00,NULL,1,NULL),(31,30.00,NULL,1,NULL),(32,30.00,NULL,1,NULL),(33,50.00,NULL,1,NULL),(34,30.00,NULL,1,NULL),(35,30.00,NULL,1,NULL),(36,70.00,NULL,1,NULL),(37,80.00,NULL,1,NULL),(38,50.00,NULL,1,NULL),(39,20.00,NULL,1,NULL),(40,20.00,NULL,1,NULL),(41,150.00,'2023-04-13 11:37:55',1,2),(42,120.00,'2023-04-13 15:22:38',1,2),(43,30.00,'2023-04-13 22:03:18',1,2),(44,100.00,'2023-04-13 22:18:43',1,1);
/*!40000 ALTER TABLE `tbl_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_configuracion_cai`
--

DROP TABLE IF EXISTS `tbl_configuracion_cai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_configuracion_cai` (
  `cod_talonario` int NOT NULL AUTO_INCREMENT,
  `rango_inicial` varchar(20) DEFAULT NULL,
  `rango_final` varchar(20) DEFAULT NULL,
  `rango_actual` varchar(20) DEFAULT NULL,
  `numero_CAI` varchar(100) DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `estado` int NOT NULL,
  PRIMARY KEY (`cod_talonario`),
  KEY `CAI_IdUsuario_idx` (`id_usuario`),
  CONSTRAINT `CAI_IdUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_configuracion_cai`
--

LOCK TABLES `tbl_configuracion_cai` WRITE;
/*!40000 ALTER TABLE `tbl_configuracion_cai` DISABLE KEYS */;
INSERT INTO `tbl_configuracion_cai` VALUES (1,'000-001-01-00000001','000-001-01-00000250','000-001-01-00000001','690CF2-53A933-A8439D-DF8027-51244A-0A','2023-04-07',1,1);
/*!40000 ALTER TABLE `tbl_configuracion_cai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_descuento`
--

DROP TABLE IF EXISTS `tbl_descuento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_descuento` (
  `cod_descuento` int NOT NULL AUTO_INCREMENT,
  `nombre_descuento` varchar(20) DEFAULT NULL,
  `porcentaje_descuento` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`cod_descuento`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_descuento`
--

LOCK TABLES `tbl_descuento` WRITE;
/*!40000 ALTER TABLE `tbl_descuento` DISABLE KEYS */;
INSERT INTO `tbl_descuento` VALUES (16,'TERCERA EDAD',10.00),(17,'CLIENTE VIP',20.00);
/*!40000 ALTER TABLE `tbl_descuento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_detalle_compra`
--

DROP TABLE IF EXISTS `tbl_detalle_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_detalle_compra` (
  `cod_detalle_compra` int NOT NULL AUTO_INCREMENT,
  `precio_venta` decimal(8,2) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  `cod_compra` int DEFAULT NULL,
  PRIMARY KEY (`cod_detalle_compra`),
  KEY `TBL_PRODUCTO_COD_PRODUCTO_idx` (`cod_producto`),
  KEY `TBL_COMPRA_COD_COMPRA_idx` (`cod_compra`),
  CONSTRAINT `DetalleCompra_CodCompra` FOREIGN KEY (`cod_compra`) REFERENCES `tbl_compra` (`cod_compra`),
  CONSTRAINT `DetalleCompra_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_compra`
--

LOCK TABLES `tbl_detalle_compra` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_compra` DISABLE KEYS */;
INSERT INTO `tbl_detalle_compra` VALUES (1,30.00,1,12,6),(2,30.00,1,12,7),(3,30.00,1,12,8),(4,30.00,1,12,9),(5,30.00,1,12,10),(6,20.00,1,13,11),(7,20.00,1,13,12),(8,20.00,1,13,12),(10,30.00,5,12,13),(11,20.00,3,13,13),(13,30.00,1,12,14),(14,20.00,1,13,15),(15,30.00,1,12,15),(17,30.00,1,12,16),(18,20.00,1,13,16),(20,30.00,1,12,17),(21,20.00,1,13,17),(23,30.00,1,12,18),(24,20.00,1,13,18),(26,30.00,1,12,19),(27,20.00,1,13,19),(29,20.00,1,13,20),(30,30.00,1,12,20),(32,30.00,1,12,21),(33,20.00,1,13,21),(34,30.00,1,12,21),(35,30.00,1,12,22),(36,20.00,1,13,22),(38,30.00,1,12,23),(39,20.00,1,13,23),(41,30.00,1,12,24),(42,20.00,1,13,24),(44,30.00,1,12,25),(45,20.00,1,13,25),(46,30.00,1,12,25),(47,20.00,1,13,25),(51,30.00,1,12,26),(52,20.00,1,13,26),(54,30.00,1,12,27),(55,20.00,1,13,27),(57,30.00,1,12,28),(58,20.00,1,13,28),(60,30.00,1,12,29),(61,20.00,1,13,29),(63,30.00,1,12,30),(64,20.00,1,13,30),(66,30.00,1,12,31),(67,30.00,1,12,32),(68,30.00,1,12,33),(69,20.00,1,13,33),(71,30.00,1,12,34),(72,30.00,1,12,35),(73,20.00,1,13,36),(74,30.00,1,12,36),(75,20.00,1,13,36),(76,30.00,1,12,37),(77,20.00,1,13,37),(78,30.00,1,12,37),(79,30.00,1,12,38),(80,20.00,1,13,38),(81,20.00,1,13,39),(82,20.00,1,13,40),(83,150.00,1,18,41),(84,100.00,1,19,42),(85,20.00,1,13,42),(86,30.00,1,12,43),(87,100.00,1,19,44);
/*!40000 ALTER TABLE `tbl_detalle_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_detalle_factura`
--

DROP TABLE IF EXISTS `tbl_detalle_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_detalle_factura` (
  `cod_detalle_factura` bigint NOT NULL AUTO_INCREMENT,
  `cod_factura` bigint DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`cod_detalle_factura`),
  KEY `DetalleFactura_CodProducto_idx` (`cod_producto`),
  KEY `DetalleFactura_NoFactura_idx` (`cod_factura`),
  CONSTRAINT `DetalleFactura_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `DetalleFactura_NoFactura` FOREIGN KEY (`cod_factura`) REFERENCES `tbl_factura` (`cod_factura`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_factura`
--

LOCK TABLES `tbl_detalle_factura` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_factura` DISABLE KEYS */;
INSERT INTO `tbl_detalle_factura` VALUES (1,31,12,1,30.00),(2,31,13,1,20.00),(4,32,12,1,30.00),(5,33,13,1,20.00),(6,33,12,1,30.00),(8,34,12,3,30.00),(9,34,13,1,20.00),(11,35,13,1,20.00),(12,36,13,1,20.00),(13,37,13,1,20.00),(14,37,12,1,30.00),(16,38,12,1,30.00),(17,39,12,1,30.00),(18,40,12,1,30.00),(19,40,13,2,20.00),(20,40,12,1,30.00),(21,40,13,3,20.00),(22,40,12,4,30.00),(25,41,12,1,30.00),(26,41,13,1,20.00),(27,41,12,129,30.00),(28,42,12,1,30.00),(29,43,12,1,30.00),(30,43,13,1,20.00),(32,44,12,1,30.00),(33,44,13,1,20.00),(34,44,12,1,30.00),(35,45,12,1,30.00),(36,45,13,1,20.00),(38,46,12,1,30.00),(39,47,13,1,20.00),(40,47,12,1,30.00),(42,48,12,1,30.00),(43,49,12,1,30.00),(44,49,13,1,20.00),(46,50,12,1,30.00),(47,51,12,1,30.00),(48,51,13,5,20.00);
/*!40000 ALTER TABLE `tbl_detalle_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_detalle_produccion`
--

DROP TABLE IF EXISTS `tbl_detalle_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_detalle_produccion` (
  `cod_detalle_produccion` int NOT NULL AUTO_INCREMENT,
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `cod_produccion` int DEFAULT NULL,
  PRIMARY KEY (`cod_detalle_produccion`),
  KEY `DetalleProduccion_CodProduccion_idx` (`cod_produccion`),
  KEY `DetalleProduccion_CodProducto_idx` (`cod_producto`),
  CONSTRAINT `DetalleProduccion_CodProduccion` FOREIGN KEY (`cod_produccion`) REFERENCES `tbl_produccion` (`cod_produccion`),
  CONSTRAINT `DetalleProduccion_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_produccion`
--

LOCK TABLES `tbl_detalle_produccion` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_produccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_detalle_produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_factura`
--

DROP TABLE IF EXISTS `tbl_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_factura` (
  `cod_factura` bigint NOT NULL AUTO_INCREMENT,
  `numero_factura` bigint DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_usuario` bigint DEFAULT NULL,
  `cod_cliente` int DEFAULT NULL,
  `totalfactura` decimal(10,2) DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `subtotal` decimal(10,2) DEFAULT NULL,
  `isv` decimal(10,2) DEFAULT NULL,
  `porcentaje_isv` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`cod_factura`),
  KEY `TBL_CLIENTE_COD_CLIENTE_idx` (`cod_cliente`),
  CONSTRAINT `Venta_CodCliente` FOREIGN KEY (`cod_cliente`) REFERENCES `tbl_cliente` (`cod_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_factura`
--

LOCK TABLES `tbl_factura` WRITE;
/*!40000 ALTER TABLE `tbl_factura` DISABLE KEYS */;
INSERT INTO `tbl_factura` VALUES (31,NULL,'2023-04-10 05:51:26',1,5,50.00,2,42.50,7.50,15.00),(32,NULL,'2023-04-09 23:55:59',1,5,30.00,2,25.50,4.50,15.00),(33,NULL,'2023-04-10 00:04:50',1,5,50.00,1,42.50,7.50,15.00),(34,NULL,'2023-04-10 16:53:43',1,5,110.00,2,93.50,16.50,15.00),(35,NULL,'2023-04-10 22:40:53',1,5,20.00,1,17.00,3.00,15.00),(36,NULL,'2023-04-10 22:42:06',1,5,20.00,2,17.00,3.00,15.00),(37,NULL,'2023-04-11 01:55:25',1,5,50.00,1,42.50,7.50,15.00),(38,NULL,'2023-04-11 10:06:33',1,5,30.00,1,25.50,4.50,15.00),(39,NULL,'2023-04-11 13:40:36',1,5,30.00,1,25.50,4.50,15.00),(40,NULL,'2023-04-11 18:15:16',1,5,280.00,1,238.00,42.00,15.00),(41,NULL,'2023-04-11 21:27:20',1,6,3920.00,1,3332.00,588.00,15.00),(42,NULL,'2023-04-11 23:23:21',1,5,30.00,1,25.50,4.50,15.00),(43,NULL,'2023-04-12 00:46:17',1,5,50.00,1,42.50,7.50,15.00),(44,NULL,'2023-04-12 00:47:20',1,5,80.00,1,68.00,12.00,15.00),(45,NULL,'2023-04-12 16:11:44',1,5,50.00,1,42.50,7.50,15.00),(46,NULL,'2023-04-12 16:20:38',1,5,30.00,1,25.50,4.50,15.00),(47,NULL,'2023-04-12 17:11:32',1,5,50.00,1,42.50,7.50,15.00),(48,NULL,'2023-04-12 17:14:46',1,5,30.00,1,25.50,4.50,15.00),(49,NULL,'2023-04-12 19:20:17',1,5,50.00,1,42.50,7.50,15.00),(50,NULL,'2023-04-12 21:22:07',1,5,30.00,1,25.50,4.50,15.00),(51,NULL,'2023-04-13 15:36:59',1,5,130.00,1,110.50,19.50,15.00);
/*!40000 ALTER TABLE `tbl_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_factura_descuento`
--

DROP TABLE IF EXISTS `tbl_factura_descuento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_factura_descuento` (
  `cod_factura_descuento` int NOT NULL AUTO_INCREMENT,
  `porcentaje_descontado` decimal(8,2) DEFAULT NULL,
  `total_descontado` decimal(8,2) DEFAULT NULL,
  `cod_factura` bigint DEFAULT NULL,
  `cod_descuento` int DEFAULT NULL,
  PRIMARY KEY (`cod_factura_descuento`),
  KEY `FacturaDescuento_CodVenta_idx` (`cod_factura`),
  KEY `FacturaDescuento_CodDescuento_idx` (`cod_descuento`),
  CONSTRAINT `FacturaDescuento_CodDescuento` FOREIGN KEY (`cod_descuento`) REFERENCES `tbl_descuento` (`cod_descuento`),
  CONSTRAINT `FacturaDescuento_CodVenta` FOREIGN KEY (`cod_factura`) REFERENCES `tbl_factura` (`cod_factura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_factura_descuento`
--

LOCK TABLES `tbl_factura_descuento` WRITE;
/*!40000 ALTER TABLE `tbl_factura_descuento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_factura_descuento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_factura_promocion`
--

DROP TABLE IF EXISTS `tbl_factura_promocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_factura_promocion` (
  `cod_factura_Promocion` int NOT NULL AUTO_INCREMENT,
  `Cantidad` int DEFAULT NULL,
  `precio_venta` decimal(8,2) DEFAULT NULL,
  `cod_promocion` int DEFAULT NULL,
  `cod_factura` bigint DEFAULT NULL,
  PRIMARY KEY (`cod_factura_Promocion`),
  KEY `FacturaPromocion_CodVenta_idx` (`cod_factura`),
  KEY `FacturaPromocion_CodPromocion_idx` (`cod_promocion`),
  CONSTRAINT `FacturaPromocion_CodPromocion` FOREIGN KEY (`cod_promocion`) REFERENCES `tbl_promocion` (`cod_promocion`),
  CONSTRAINT `FacturaPromocion_CodVenta` FOREIGN KEY (`cod_factura`) REFERENCES `tbl_factura` (`cod_factura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_factura_promocion`
--

LOCK TABLES `tbl_factura_promocion` WRITE;
/*!40000 ALTER TABLE `tbl_factura_promocion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_factura_promocion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_genero`
--

DROP TABLE IF EXISTS `tbl_genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_genero` (
  `cod_genero` int NOT NULL AUTO_INCREMENT,
  `nombre_genero` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cod_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_genero`
--

LOCK TABLES `tbl_genero` WRITE;
/*!40000 ALTER TABLE `tbl_genero` DISABLE KEYS */;
INSERT INTO `tbl_genero` VALUES (3,'FEMENINO'),(4,'MASCULINO');
/*!40000 ALTER TABLE `tbl_genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_inventario`
--

DROP TABLE IF EXISTS `tbl_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_inventario` (
  `cod_inventario` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  `cod_tipo_inventario` int DEFAULT NULL,
  PRIMARY KEY (`cod_inventario`),
  KEY `TBL_PRODUCTO_COD_PRODUCTO_idx` (`cod_producto`),
  KEY `TBL_TIPO_INVENTARIO_COD_TIPO_INVENTARIO_idx` (`cod_tipo_inventario`),
  CONSTRAINT `Inventario_CodTipoInventario` FOREIGN KEY (`cod_tipo_inventario`) REFERENCES `tbl_tipo_inventario` (`cod_tipo_inventario`),
  CONSTRAINT `InventarioCodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_inventario`
--

LOCK TABLES `tbl_inventario` WRITE;
/*!40000 ALTER TABLE `tbl_inventario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_kardex`
--

DROP TABLE IF EXISTS `tbl_kardex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_kardex` (
  `cod_kardex` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `cod_tipo_movimiento` int DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  PRIMARY KEY (`cod_kardex`),
  KEY `tbl_Producto_Cod_Producto_idx` (`cod_producto`),
  KEY `Kardex_idTipoMovimiento_idx` (`cod_tipo_movimiento`),
  CONSTRAINT `Kardex_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `Kardex_idTipoMovimiento` FOREIGN KEY (`cod_tipo_movimiento`) REFERENCES `tbl_tipo_movimiento` (`cod_tipo_movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_kardex`
--

LOCK TABLES `tbl_kardex` WRITE;
/*!40000 ALTER TABLE `tbl_kardex` DISABLE KEYS */;
INSERT INTO `tbl_kardex` VALUES (1,'2023-03-17 00:00:00',1,12);
/*!40000 ALTER TABLE `tbl_kardex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_bitacora`
--

DROP TABLE IF EXISTS `tbl_ms_bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_bitacora` (
  `id_bitacora` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `id_objeto` bigint DEFAULT NULL,
  `accion` varchar(20) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_bitacora`),
  KEY `bitacora_objeto_idx` (`id_objeto`),
  KEY `bitacora_usuario_idx` (`id_usuario`),
  CONSTRAINT `bitacora_objeto` FOREIGN KEY (`id_objeto`) REFERENCES `tbl_ms_objetos` (`id_objeto`),
  CONSTRAINT `bitacora_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_bitacora`
--

LOCK TABLES `tbl_ms_bitacora` WRITE;
/*!40000 ALTER TABLE `tbl_ms_bitacora` DISABLE KEYS */;
INSERT INTO `tbl_ms_bitacora` VALUES (1,'2023-04-12 21:34:54',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(2,'2023-04-12 21:48:25',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(3,'2023-04-12 21:48:46',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(4,'2023-04-12 21:49:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(5,'2023-04-12 21:49:46',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(6,'2023-04-12 21:50:08',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(7,'2023-04-12 21:53:23',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(8,'2023-04-12 21:54:18',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(9,'2023-04-12 21:55:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(10,'2023-04-12 22:05:29',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(11,'2023-04-12 22:14:01',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(12,'2023-04-12 22:15:29',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(13,'2023-04-12 22:16:28',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(14,'2023-04-12 22:20:12',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(15,'2023-04-12 22:21:47',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(16,'2023-04-12 22:21:59',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(17,'2023-04-12 22:22:30',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(18,'2023-04-12 22:29:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(19,'2023-04-12 22:37:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(20,'2023-04-12 22:38:09',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(21,'2023-04-12 22:40:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(22,'2023-04-12 22:50:03',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(23,'2023-04-12 23:18:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(24,'2023-04-13 00:01:22',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(25,'2023-04-13 00:02:01',1,2,'CREAR','CREACION DE CLIENTE'),(26,'2023-04-13 00:29:04',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(27,'2023-04-13 00:29:26',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(28,'2023-04-13 00:29:44',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(29,'2023-04-13 00:29:47',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(30,'2023-04-13 00:30:48',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(31,'2023-04-13 00:33:04',1,2,'CREAR','CREACION DE CLIENTE'),(32,'2023-04-13 00:33:10',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(33,'2023-04-13 00:33:30',1,2,'CREAR','CREACION DE CLIENTE'),(34,'2023-04-13 00:34:57',1,2,'CREAR','CREACION DE CLIENTE'),(35,'2023-04-13 00:35:48',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(36,'2023-04-13 00:36:01',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(37,'2023-04-13 00:36:35',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(38,'2023-04-13 00:36:56',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(39,'2023-04-13 00:37:01',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(40,'2023-04-13 00:37:15',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(41,'2023-04-13 00:38:06',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(42,'2023-04-13 00:42:30',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(43,'2023-04-13 00:42:41',1,2,'CREAR','CREACION DE CLIENTE'),(44,'2023-04-13 00:43:00',1,2,'CREAR','CREACION DE CLIENTE'),(45,'2023-04-13 00:43:19',1,2,'CREAR','CREACION DE CLIENTE'),(46,'2023-04-13 00:43:27',1,2,'CREAR','CREACION DE CLIENTE'),(47,'2023-04-13 00:47:00',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(48,'2023-04-13 00:47:08',1,2,'INGRESO','INGRESO AL SISTEMA'),(49,'2023-04-13 00:47:14',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(50,'2023-04-13 00:47:20',1,2,'CREAR','CREACION DE CLIENTE'),(51,'2023-04-13 00:47:42',1,2,'CREAR','CREACION DE CLIENTE'),(52,'2023-04-13 00:50:15',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(53,'2023-04-13 00:50:28',1,2,'CREAR','CREACION DE CLIENTE'),(54,'2023-04-13 00:54:04',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(55,'2023-04-13 00:55:09',1,2,'INGRESO','INGRESO AL SISTEMA'),(56,'2023-04-13 00:55:16',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(57,'2023-04-13 00:55:25',1,2,'CREAR','CREACION DE CLIENTE'),(58,'2023-04-13 00:55:31',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(59,'2023-04-13 00:56:18',1,2,'INGRESO','INGRESO AL SISTEMA'),(60,'2023-04-13 00:56:23',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(61,'2023-04-13 00:56:33',1,2,'CREAR','CREACION DE CLIENTE'),(62,'2023-04-13 00:56:41',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(63,'2023-04-13 00:56:54',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(64,'2023-04-13 00:57:04',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(65,'2023-04-13 00:57:11',1,2,'CREAR','CREACION DE CLIENTE'),(66,'2023-04-13 00:57:28',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(67,'2023-04-13 00:57:37',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE CLIENTE'),(68,'2023-04-13 00:57:43',1,2,'CREAR','CREACION DE CLIENTE'),(69,'2023-04-13 00:58:17',1,2,'CREAR','CREACION DE CLIENTE'),(70,'2023-04-13 00:58:21',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(71,'2023-04-13 00:58:55',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(72,'2023-04-13 01:10:14',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(73,'2023-04-13 02:37:52',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(74,'2023-04-13 02:37:57',1,2,'CREAR','CREACION DE CLIENTE'),(75,'2023-04-13 02:43:11',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(76,'2023-04-13 03:30:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(77,'2023-04-13 03:30:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(78,'2023-04-13 03:33:16',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(79,'2023-04-13 03:34:04',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(80,'2023-04-13 09:11:48',1,2,'INGRESO','INGRESO AL SISTEMA'),(81,'2023-04-13 10:21:05',1,2,'CREAR','CREACION DE PRODUCTO'),(82,'2023-04-13 10:24:41',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PRODUCTO'),(83,'2023-04-13 10:27:48',1,2,'CREAR','CREACION DE PRODUCTO'),(84,'2023-04-13 10:29:04',1,2,'CREAR','CREACION DE PRODUCTO'),(85,'2023-04-13 10:29:37',1,2,'CREAR','CREACION DE PRODUCTO'),(86,'2023-04-13 10:30:07',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PRODUCTO'),(87,'2023-04-13 10:30:40',1,2,'CREAR','CREACION DE PRODUCTO'),(88,'2023-04-13 10:30:55',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PRODUCTO'),(89,'2023-04-13 10:31:06',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(90,'2023-04-13 10:31:20',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(91,'2023-04-13 10:31:58',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(92,'2023-04-13 11:35:28',1,2,'INGRESO','INGRESO AL SISTEMA'),(93,'2023-04-13 11:35:39',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(94,'2023-04-13 11:35:56',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(95,'2023-04-13 11:37:59',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(96,'2023-04-13 11:38:30',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(97,'2023-04-13 11:40:16',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(98,'2023-04-13 14:47:00',1,2,'INGRESO','INGRESO AL SISTEMA'),(99,'2023-04-13 14:48:10',1,2,'INGRESO','INGRESO AL SISTEMA'),(100,'2023-04-13 14:48:17',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(101,'2023-04-13 14:48:54',1,2,'INGRESO','INGRESO AL SISTEMA'),(102,'2023-04-13 14:49:26',1,2,'INGRESO','INGRESO AL SISTEMA'),(103,'2023-04-13 14:51:47',1,2,'INGRESO','INGRESO AL SISTEMA'),(104,'2023-04-13 14:51:59',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(105,'2023-04-13 14:53:18',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(106,'2023-04-13 15:03:39',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(107,'2023-04-13 15:03:42',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(108,'2023-04-13 15:04:19',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(109,'2023-04-13 15:06:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(110,'2023-04-13 15:06:28',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(111,'2023-04-13 15:08:42',1,2,'INGRESO','INGRESO AL SISTEMA'),(112,'2023-04-13 15:16:06',1,2,'CREAR','CREACION DE PRODUCTO'),(113,'2023-04-13 15:19:30',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(114,'2023-04-13 15:19:36',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(115,'2023-04-13 15:23:25',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(116,'2023-04-13 15:30:36',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(117,'2023-04-13 15:38:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(118,'2023-04-13 15:38:22',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(119,'2023-04-13 21:20:21',1,2,'INGRESO','INGRESO AL SISTEMA'),(120,'2023-04-13 21:20:37',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(121,'2023-04-13 21:21:27',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(122,'2023-04-13 21:22:02',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(123,'2023-04-13 21:22:09',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(124,'2023-04-13 21:22:52',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(125,'2023-04-13 21:23:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(126,'2023-04-13 21:24:06',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(127,'2023-04-13 21:26:17',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(128,'2023-04-13 21:27:00',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(129,'2023-04-13 21:27:22',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(130,'2023-04-13 21:27:29',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(131,'2023-04-13 21:27:30',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(132,'2023-04-13 21:30:53',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(133,'2023-04-13 21:31:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(134,'2023-04-13 21:34:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(135,'2023-04-13 21:47:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(136,'2023-04-13 21:52:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(137,'2023-04-13 21:52:33',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(138,'2023-04-13 21:52:36',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(139,'2023-04-13 21:56:32',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(140,'2023-04-13 22:01:54',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(141,'2023-04-13 22:03:27',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(142,'2023-04-13 22:03:46',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(143,'2023-04-13 22:12:43',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(144,'2023-04-13 22:23:59',1,2,'INGRESO','INGRESO AL SISTEMA'),(145,'2023-04-13 22:24:35',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(146,'2023-04-13 22:27:53',1,2,'INGRESO','INGRESO AL MODULO COMPRAS'),(147,'2023-04-13 22:32:14',1,2,'INGRESO','INGRESO AL MODULO COMPRAS');
/*!40000 ALTER TABLE `tbl_ms_bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_hist_contrasena`
--

DROP TABLE IF EXISTS `tbl_ms_hist_contrasena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_hist_contrasena` (
  `id_usuario` bigint NOT NULL,
  `contrasena` varchar(100) DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `histContra_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `id_objeto` bigint NOT NULL AUTO_INCREMENT,
  `objeto` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_objeto`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
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
  `id_parametro` int NOT NULL AUTO_INCREMENT,
  `parametro` varchar(50) DEFAULT NULL,
  `valor` varchar(100) DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_parametro`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_parametros`
--

LOCK TABLES `tbl_ms_parametros` WRITE;
/*!40000 ALTER TABLE `tbl_ms_parametros` DISABLE KEYS */;
INSERT INTO `tbl_ms_parametros` VALUES (1,'ADMIN_INTENTOS','3',NULL,NULL,NULL,NULL),(2,'ADMIN_PREGUNTAS','2',NULL,NULL,NULL,NULL),(3,'ADMIN_CORREO','uniformesdelatlantico@hotmail.com',NULL,NULL,NULL,NULL),(4,'FECHA_VENCIMIENTO','30',NULL,NULL,NULL,NULL),(5,'IMPUESTO','15',NULL,NULL,NULL,NULL),(6,'NOMBRE_EMPRESA','INVERSIONES UNIFORMES DEL ATLÁNTICO',NULL,NULL,'ADMIN','2023-04-11 21:32:20'),(7,'RAZON_SOCIAL','S. DE R. L. DE C. V.',NULL,NULL,NULL,NULL),(8,'TELEFONO_EMPRESA','9970-5887',NULL,NULL,NULL,NULL),(9,'DIRECCION','BO. EL CENTRO, DOMICILIO RENTADO, ATRÁS DE LA DESPENSA FAMILIAR, TELA. ATLÁNTIDA',NULL,NULL,NULL,NULL),(10,'RTN','01079021315692',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tbl_ms_parametros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_permisos`
--

DROP TABLE IF EXISTS `tbl_ms_permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_permisos` (
  `idpermiso` bigint NOT NULL AUTO_INCREMENT,
  `id_rol` bigint NOT NULL,
  `id_objeto` bigint NOT NULL,
  `r` int NOT NULL DEFAULT '0',
  `w` int NOT NULL DEFAULT '0',
  `u` int NOT NULL DEFAULT '0',
  `d` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`idpermiso`),
  KEY `rolid` (`id_rol`),
  KEY `moduloid` (`id_objeto`),
  CONSTRAINT `tbl_ms_permisos_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tbl_ms_roles` (`id_rol`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_ms_permisos_ibfk_2` FOREIGN KEY (`id_objeto`) REFERENCES `tbl_ms_objetos` (`id_objeto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=555 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_permisos`
--

LOCK TABLES `tbl_ms_permisos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_permisos` DISABLE KEYS */;
INSERT INTO `tbl_ms_permisos` VALUES (39,3,1,1,0,0,0),(40,3,2,1,0,0,0),(42,3,4,0,0,0,0),(93,11,1,1,0,0,0),(94,11,2,0,0,0,0),(96,11,4,0,0,0,0),(223,21,1,1,1,1,1),(224,21,2,1,1,1,1),(226,21,4,1,0,0,0),(231,2,1,0,0,0,0),(232,2,2,0,0,0,0),(234,2,4,0,0,0,0),(520,4,1,1,0,0,0),(521,4,2,1,1,1,1),(522,4,4,1,0,0,0),(523,4,10,1,1,0,0),(524,4,11,1,0,0,0),(525,4,12,0,1,0,0),(526,4,13,1,1,1,0),(527,4,14,1,1,1,1),(528,4,15,1,0,0,0),(529,4,16,1,0,0,1),(530,4,17,1,0,0,0),(531,4,18,1,1,1,1),(532,4,20,1,0,0,0),(533,4,21,1,0,0,0),(534,4,22,1,0,0,0),(535,4,23,1,0,0,0),(536,4,24,1,0,0,0),(537,1,1,1,1,1,1),(538,1,2,1,1,1,1),(539,1,4,1,1,1,1),(540,1,10,1,1,1,1),(541,1,11,1,1,1,1),(542,1,12,1,1,1,1),(543,1,13,1,1,1,1),(544,1,14,1,1,1,1),(545,1,15,1,1,1,1),(546,1,16,1,1,1,1),(547,1,17,1,1,1,1),(548,1,18,1,1,1,1),(549,1,20,1,1,1,1),(550,1,21,1,1,1,1),(551,1,22,1,1,1,1),(552,1,23,1,1,1,1),(553,1,24,1,1,1,1),(554,1,25,1,1,1,1);
/*!40000 ALTER TABLE `tbl_ms_permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_preguntas`
--

DROP TABLE IF EXISTS `tbl_ms_preguntas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_preguntas` (
  `id_pregunta` int NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_pregunta`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_preguntas`
--

LOCK TABLES `tbl_ms_preguntas` WRITE;
/*!40000 ALTER TABLE `tbl_ms_preguntas` DISABLE KEYS */;
INSERT INTO `tbl_ms_preguntas` VALUES (3,'CANCION FAVORITA'),(4,'COMIDA FAVORITA');
/*!40000 ALTER TABLE `tbl_ms_preguntas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_preguntas_usuario`
--

DROP TABLE IF EXISTS `tbl_ms_preguntas_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_preguntas_usuario` (
  `id_pregunta` int NOT NULL,
  `id_usuario` bigint NOT NULL,
  `respuesta` varchar(100) DEFAULT NULL,
  KEY `preguntaUsuario_idUsuario_idx` (`id_usuario`),
  CONSTRAINT `preguntaUsuario_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_preguntas_usuario`
--

LOCK TABLES `tbl_ms_preguntas_usuario` WRITE;
/*!40000 ALTER TABLE `tbl_ms_preguntas_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_ms_preguntas_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_roles`
--

DROP TABLE IF EXISTS `tbl_ms_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_roles` (
  `id_rol` bigint NOT NULL AUTO_INCREMENT,
  `nombrerol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
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
  `id_usuario` bigint NOT NULL AUTO_INCREMENT,
  `usuario` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `nombre_usuario` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `contrasena` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `fecha_ultima_conexion` datetime DEFAULT NULL,
  `preguntas_contestadas` int DEFAULT '0',
  `primer_ingreso` int DEFAULT NULL,
  `fecha_vencimiento` datetime DEFAULT NULL,
  `correo_electronico` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `creado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `id_rol` bigint NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `rolid` (`id_rol`),
  CONSTRAINT `tbl_ms_usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tbl_ms_roles` (`id_rol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_usuarios`
--

LOCK TABLES `tbl_ms_usuarios` WRITE;
/*!40000 ALTER TABLE `tbl_ms_usuarios` DISABLE KEYS */;
INSERT INTO `tbl_ms_usuarios` VALUES (1,'ADMIN','ADMINISTRADOR',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','2023-04-13 22:23:59',0,NULL,NULL,'admin@atlantico.com','733464113f1d79251461-4ff19d069fb2ec635522-a12faeec9a0c21dd0b33-435908728e5136f3ae80',NULL,'2021-08-20 01:34:15','ADMIN','2023-03-22 21:16:11',1),(19,'ALEXANDER','ALEXANDER AGUILAR',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,0,NULL,NULL,'alex@hotmail.com',NULL,NULL,'2023-02-04 01:16:01','ADMIN','2023-03-22 10:36:01',4),(20,'ERIKA','ERIKA AYALA',2,'18ac3e7343f016890c510e93f935261169d9e3f565436429830faf0934f4f8e4',NULL,0,NULL,NULL,'erika3@gmail.com',NULL,NULL,'2023-02-08 21:40:58','ADMIN','2023-03-22 10:35:34',2),(104,'HECTOR','HECTOR BUSTILLOO',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,2,NULL,NULL,'hector@hotmail.com',NULL,'ADMIN','2023-03-08 15:22:09','ADMIN','2023-03-22 21:14:43',1),(136,'JORGE','JORGE ROMERO',1,'c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb','2023-03-30 13:13:42',2,NULL,NULL,'jorge@gmail.com','','ADMIN','2023-03-15 20:49:18','ADMIN','2023-03-29 21:35:43',4),(162,'DORCA','DORCA AGUILAR',1,'c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb','2023-04-09 19:58:52',2,NULL,NULL,'dorcaaguilar@gmail.com',NULL,'ADMIN','2023-03-16 21:25:14','ADMIN','2023-04-09 19:58:13',4);
/*!40000 ALTER TABLE `tbl_ms_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_produccion`
--

DROP TABLE IF EXISTS `tbl_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_produccion` (
  `cod_produccion` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  PRIMARY KEY (`cod_produccion`),
  KEY `P_Cod_Producto_idx` (`id_usuario`),
  CONSTRAINT `Produccion_CodProducto` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_produccion`
--

LOCK TABLES `tbl_produccion` WRITE;
/*!40000 ALTER TABLE `tbl_produccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_producto`
--

DROP TABLE IF EXISTS `tbl_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_producto` (
  `cod_producto` int NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(30) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `cantidad_minima` int DEFAULT NULL,
  `cantidad_maxima` int DEFAULT NULL,
  `cod_tipo_producto` int DEFAULT NULL,
  `precio_venta` decimal(8,2) DEFAULT NULL,
  `estado` int DEFAULT '1',
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `existencia` int DEFAULT NULL,
  PRIMARY KEY (`cod_producto`),
  KEY `TBL_TIPO_PRODUCTO_COD_TIPO_PRODUCTO_idx` (`cod_tipo_producto`),
  CONSTRAINT `Producto_CodTipoProducto` FOREIGN KEY (`cod_tipo_producto`) REFERENCES `tbl_tipo_producto` (`cod_tipo_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_producto`
--

LOCK TABLES `tbl_producto` WRITE;
/*!40000 ALTER TABLE `tbl_producto` DISABLE KEYS */;
INSERT INTO `tbl_producto` VALUES (12,'TELA','TELA BLANCA',200,30,3,30.00,1,NULL,NULL,NULL,NULL,99),(13,'PINTURA','ROJA',10,100,3,20.00,1,NULL,NULL,NULL,NULL,39),(15,'MONOGRAMA','MONOGRAMA ESCOLAR',3,4,4,45.00,1,'ADMIN','2023-04-13 10:21:05','ADMIN','2023-04-13 10:30:07',0),(16,'PINTURA PARA SERIGRAFíA','PINTURA',12,23,3,100.00,1,'ADMIN','2023-04-13 10:27:48',NULL,NULL,0),(17,'PAPEL VINIL','PAPEL',200,100,3,23.00,1,'ADMIN','2023-04-13 10:29:04',NULL,NULL,0),(18,'BUSO ESCOLAR','BUSO',20,40,4,150.00,1,'ADMIN','2023-04-13 10:30:40','ADMIN','2023-04-13 10:30:55',0),(19,'INFORMATICA','INFORMATICA',5,100,3,100.00,1,'ADMIN','2023-04-13 15:16:06',NULL,NULL,1);
/*!40000 ALTER TABLE `tbl_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_promocion`
--

DROP TABLE IF EXISTS `tbl_promocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_promocion` (
  `cod_promocion` int NOT NULL AUTO_INCREMENT,
  `nombre_promocion` varchar(100) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_final` datetime DEFAULT NULL,
  `precio_venta` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`cod_promocion`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_promocion`
--

LOCK TABLES `tbl_promocion` WRITE;
/*!40000 ALTER TABLE `tbl_promocion` DISABLE KEYS */;
INSERT INTO `tbl_promocion` VALUES (2,'CAMISAS PROMO','2023-03-30 22:00:00','2023-04-05 23:03:00',50.00);
/*!40000 ALTER TABLE `tbl_promocion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_promocion_producto`
--

DROP TABLE IF EXISTS `tbl_promocion_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_promocion_producto` (
  `id_promocion_producto` int NOT NULL AUTO_INCREMENT,
  `cod_promocion` int DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id_promocion_producto`),
  KEY `promocion_producto_idx` (`cod_promocion`),
  KEY `promocionProducto_Producto_idx` (`cod_producto`),
  CONSTRAINT `promocionProducto_Producto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `promocionProducto_Promocion` FOREIGN KEY (`cod_promocion`) REFERENCES `tbl_promocion` (`cod_promocion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_promocion_producto`
--

LOCK TABLES `tbl_promocion_producto` WRITE;
/*!40000 ALTER TABLE `tbl_promocion_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_promocion_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_resultado_produccion`
--

DROP TABLE IF EXISTS `tbl_resultado_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_resultado_produccion` (
  `id_resultado_produccion` int NOT NULL AUTO_INCREMENT,
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_resultado_produccion`),
  KEY `ResultadoProduccion_idProducto_idx` (`cod_producto`),
  CONSTRAINT `ResultadoProduccion_idProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_resultado_produccion`
--

LOCK TABLES `tbl_resultado_produccion` WRITE;
/*!40000 ALTER TABLE `tbl_resultado_produccion` DISABLE KEYS */;
INSERT INTO `tbl_resultado_produccion` VALUES (1,12,2,'PRODUCCIÓN');
/*!40000 ALTER TABLE `tbl_resultado_produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_inventario`
--

DROP TABLE IF EXISTS `tbl_tipo_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tipo_inventario` (
  `cod_tipo_inventario` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo_inventario` char(15) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_inventario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_inventario`
--

LOCK TABLES `tbl_tipo_inventario` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_inventario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tipo_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_movimiento`
--

DROP TABLE IF EXISTS `tbl_tipo_movimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tipo_movimiento` (
  `cod_tipo_movimiento` int NOT NULL AUTO_INCREMENT,
  `nombre_movimiento` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_movimiento`
--

LOCK TABLES `tbl_tipo_movimiento` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_movimiento` DISABLE KEYS */;
INSERT INTO `tbl_tipo_movimiento` VALUES (1,'ENTRADA');
/*!40000 ALTER TABLE `tbl_tipo_movimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_producto`
--

DROP TABLE IF EXISTS `tbl_tipo_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tipo_producto` (
  `cod_tipo_producto` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo_producto` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
-- Dumping events for database 'db_inversiones_atlantico'
--

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

        INSERT INTO detalle_temp(token_user,cod_producto,cantidad,precio_venta) VALUES(token_user,codigo,cantidad,precio_actual);

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_detalle_temp_c`(`codigo` INT, `cantidad` INT, `token_user` VARCHAR(50))
BEGIN
	 DECLARE precio_actual decimal(10,2);
        
        SELECT precio_venta INTO precio_actual FROM tbl_producto WHERE cod_producto = codigo;

        INSERT INTO detalle_temp_c(token_user,cod_producto,cantidad,precio_venta) VALUES(token_user,codigo,cantidad,precio_actual);

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
                id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
                SET a = 1;
                
                SET registros = (SELECT COUNT(*) FROM tbl_detalle_compra WHERE cod_compra = no_compra);
                
                IF registros > 0 THEN
                	INSERT INTO tbl_tmp_c(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM tbl_detalle_compra WHERE cod_compra = no_compra;
                    
                    WHILE a <= registros DO
                    	SELECT cod_prod,cant_prod INTO codproducto,cant_producto FROM tbl_tmp_c WHERE id = a;
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
                id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
                SET a = 1;
                
                SET registros = (SELECT COUNT(*) FROM tbl_detalle_factura WHERE cod_factura = no_factura);
                
                IF registros > 0 THEN
                	INSERT INTO tbl_tmp(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM tbl_detalle_factura WHERE cod_factura = no_factura;
                    
                    WHILE a <= registros DO
                    	SELECT cod_prod,cant_prod INTO codproducto,cant_producto FROM tbl_tmp WHERE id = a;
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
        DELETE FROM detalle_temp WHERE cod_detalle_factura = id_detalle;

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
                id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
        SET registros = (SELECT COUNT(*) FROM detalle_temp_c WHERE token_user = token);
        
        IF registros > 0 THEN
        	INSERT INTO tbl_tmp_tokenuser_c(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM detalle_temp_c WHERE token_user = token;
           
            INSERT INTO tbl_compra(id_usuario) VALUES(cod_usuario);
            SET compra = LAST_INSERT_ID();
            
            INSERT INTO tbl_detalle_compra(cod_compra,cod_producto,cantidad,precio_venta) SELECT (compra) as cod_compra, cod_producto,cantidad,precio_venta FROM detalle_temp_c WHERE token_user = token;
            
            WHILE a <= registros DO
            	SELECT cod_prod,cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser_c WHERE id = a;
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
        DECLARE impuesto DECIMAL(10,2);
		DECLARE porcentaje_impuesto DECIMAL(10,2);

        DECLARE nueva_existencia int;
        DECLARE existencia_actual int;

        DECLARE tmp_cod_producto int;
        DECLARE tmp_cant_producto int;
        DECLARE a INT;
        SET a = 1;
        
        CREATE TEMPORARY TABLE tbl_tmp_tokenuser (
                id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
        SET registros = (SELECT COUNT(*) FROM detalle_temp WHERE token_user = token);
        
        IF registros > 0 THEN
        	INSERT INTO tbl_tmp_tokenuser(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM detalle_temp WHERE token_user = token;
            
            INSERT INTO tbl_factura(id_usuario,cod_cliente) VALUES(cod_usuario,cod_cliente);
            SET factura = LAST_INSERT_ID();
            
            INSERT INTO tbl_detalle_factura(cod_factura,cod_producto,cantidad,precio_venta) SELECT (factura) as cod_factura, cod_producto,cantidad,precio_venta FROM detalle_temp WHERE token_user = token;
            
            WHILE a <= registros DO
            	SELECT cod_prod,cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser WHERE id = a;
                SELECT existencia INTO existencia_actual FROM tbl_producto WHERE cod_producto = tmp_cod_producto;
                
                SET nueva_existencia = existencia_actual - tmp_cant_producto;
                UPDATE tbl_producto SET existencia = nueva_existencia WHERE cod_producto = tmp_cod_producto;
                
                SET a=a+1;
            	
            END WHILE;
            
		   SET total = (SELECT SUM(cantidad * precio_venta) FROM detalle_temp WHERE token_user = token);
		   SET porcentaje_impuesto = (SELECT valor FROM tbl_ms_parametros where parametro = "impuesto");--
           SET sub_total = total-((total*porcentaje_impuesto)/100);--
           SET impuesto = total-sub_total;--
            UPDATE tbl_factura SET totalfactura = total, 
									subtotal = sub_total, 
									isv = impuesto, 
									porcentaje_isv = porcentaje_impuesto
            WHERE cod_factura = factura;
          
            DELETE FROM detalle_temp WHERE token_user = token;
            TRUNCATE TABLE tbl_tmp_tokenuser;
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

-- Dump completed on 2023-04-13 22:39:08
