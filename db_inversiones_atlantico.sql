-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_inversiones_atlantico
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
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_temp`
--

LOCK TABLES `detalle_temp` WRITE;
/*!40000 ALTER TABLE `detalle_temp` DISABLE KEYS */;
INSERT INTO `detalle_temp` VALUES (192,'c4ca4238a0b923820dcc509a6f75849b',12,1,30.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_temp_c`
--

LOCK TABLES `detalle_temp_c` WRITE;
/*!40000 ALTER TABLE `detalle_temp_c` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_temp_c` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_cliente`
--

LOCK TABLES `tbl_cliente` WRITE;
/*!40000 ALTER TABLE `tbl_cliente` DISABLE KEYS */;
INSERT INTO `tbl_cliente` VALUES (5,'12345','JENNIE K','REYES',95501010,NULL,'COLONIA LOS PINOS',NULL,3,1,1,NULL,NULL,NULL,NULL);
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
  `fecha` datetime DEFAULT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `estado` int DEFAULT NULL,
  PRIMARY KEY (`cod_compra`),
  KEY `Compra_idUsuario_idx` (`id_usuario`),
  CONSTRAINT `Compra_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_compra`
--

LOCK TABLES `tbl_compra` WRITE;
/*!40000 ALTER TABLE `tbl_compra` DISABLE KEYS */;
INSERT INTO `tbl_compra` VALUES (4,NULL,NULL,1,NULL),(5,NULL,NULL,1,NULL),(6,30.00,NULL,1,NULL),(7,30.00,NULL,1,NULL),(8,30.00,NULL,1,NULL),(9,30.00,NULL,1,NULL),(10,30.00,NULL,1,NULL),(11,20.00,NULL,1,NULL),(12,40.00,NULL,1,NULL),(13,210.00,NULL,1,NULL);
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
  `rango_inicial` int DEFAULT NULL,
  `rango_final` int DEFAULT NULL,
  `rango_actual` int DEFAULT NULL,
  `numero_CAI` varchar(40) DEFAULT NULL,
  `fecha_vencimiento` datetime DEFAULT NULL,
  `id_usuario` bigint DEFAULT NULL,
  PRIMARY KEY (`cod_talonario`),
  KEY `CAI_IdUsuario_idx` (`id_usuario`),
  CONSTRAINT `CAI_IdUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_configuracion_cai`
--

LOCK TABLES `tbl_configuracion_cai` WRITE;
/*!40000 ALTER TABLE `tbl_configuracion_cai` DISABLE KEYS */;
INSERT INTO `tbl_configuracion_cai` VALUES (1,10,100,2,'212W2W21R3','2023-04-07 22:57:11',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_descuento`
--

LOCK TABLES `tbl_descuento` WRITE;
/*!40000 ALTER TABLE `tbl_descuento` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_compra`
--

LOCK TABLES `tbl_detalle_compra` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_compra` DISABLE KEYS */;
INSERT INTO `tbl_detalle_compra` VALUES (1,30.00,1,12,6),(2,30.00,1,12,7),(3,30.00,1,12,8),(4,30.00,1,12,9),(5,30.00,1,12,10),(6,20.00,1,13,11),(7,20.00,1,13,12),(8,20.00,1,13,12),(10,30.00,5,12,13),(11,20.00,3,13,13);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_factura`
--

LOCK TABLES `tbl_detalle_factura` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_factura` DISABLE KEYS */;
INSERT INTO `tbl_detalle_factura` VALUES (1,31,12,1,30.00),(2,31,13,1,20.00),(4,32,12,1,30.00),(5,33,13,1,20.00),(6,33,12,1,30.00),(8,34,12,3,30.00),(9,34,13,1,20.00),(11,35,13,1,20.00),(12,36,13,1,20.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_factura`
--

LOCK TABLES `tbl_factura` WRITE;
/*!40000 ALTER TABLE `tbl_factura` DISABLE KEYS */;
INSERT INTO `tbl_factura` VALUES (31,NULL,'2023-04-10 05:51:26',1,5,50.00,2,42.50,7.50,15.00),(32,NULL,'2023-04-09 23:55:59',1,5,30.00,2,25.50,4.50,15.00),(33,NULL,'2023-04-10 00:04:50',1,5,50.00,1,42.50,7.50,15.00),(34,NULL,'2023-04-10 16:53:43',1,5,110.00,1,93.50,16.50,15.00),(35,NULL,'2023-04-10 22:40:53',1,5,20.00,1,17.00,3.00,15.00),(36,NULL,'2023-04-10 22:42:06',1,5,20.00,1,17.00,3.00,15.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_bitacora`
--

LOCK TABLES `tbl_ms_bitacora` WRITE;
/*!40000 ALTER TABLE `tbl_ms_bitacora` DISABLE KEYS */;
INSERT INTO `tbl_ms_bitacora` VALUES (1,'2023-03-29 23:40:35',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(2,'2023-03-29 23:41:00',136,2,'INGRESO','INGRESO AL SISTEMA'),(3,'2023-03-29 23:42:52',136,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(4,'2023-03-29 23:43:24',136,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(5,'2023-03-29 23:44:41',136,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(6,'2023-03-29 23:45:36',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(7,'2023-03-29 23:45:48',1,2,'INGRESO','INGRESO AL SISTEMA'),(8,'2023-03-29 23:45:51',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(9,'2023-03-29 23:47:33',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(10,'2023-03-29 23:47:50',136,2,'INGRESO','INGRESO AL SISTEMA'),(11,'2023-03-29 23:48:04',136,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(12,'2023-03-29 23:48:16',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(13,'2023-03-29 23:48:23',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(14,'2023-03-29 23:56:05',1,2,'INGRESO','INGRESO AL SISTEMA'),(15,'2023-03-29 23:56:08',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(16,'2023-03-29 23:56:36',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(17,'2023-03-29 23:56:52',136,2,'INGRESO','INGRESO AL SISTEMA'),(18,'2023-03-29 23:57:12',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(19,'2023-03-29 23:57:18',1,2,'INGRESO','INGRESO AL SISTEMA'),(20,'2023-03-29 23:57:20',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(21,'2023-03-29 23:57:31',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(22,'2023-03-29 23:57:43',136,2,'INGRESO','INGRESO AL SISTEMA'),(23,'2023-03-30 00:01:52',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(24,'2023-03-30 00:02:22',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(25,'2023-03-30 00:02:27',1,2,'INGRESO','INGRESO AL SISTEMA'),(26,'2023-03-30 00:02:34',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(27,'2023-03-30 00:02:58',136,2,'INGRESO','INGRESO AL SISTEMA'),(28,'2023-03-30 00:03:03',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(29,'2023-03-30 00:03:18',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(30,'2023-03-30 00:04:40',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(31,'2023-03-30 00:04:50',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(32,'2023-03-30 00:04:54',1,2,'INGRESO','INGRESO AL SISTEMA'),(33,'2023-03-30 00:04:57',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(34,'2023-03-30 00:05:09',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(35,'2023-03-30 00:05:17',136,2,'INGRESO','INGRESO AL SISTEMA'),(36,'2023-03-30 00:05:26',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(37,'2023-03-30 00:05:31',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(38,'2023-03-30 00:05:56',136,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(39,'2023-03-30 00:06:43',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(40,'2023-03-30 00:07:10',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(41,'2023-03-30 00:07:34',136,2,'INGRESO','INGRESO AL SISTEMA'),(42,'2023-03-30 00:07:37',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(43,'2023-03-30 00:07:44',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(44,'2023-03-30 00:11:08',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(45,'2023-03-30 00:11:20',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(46,'2023-03-30 00:11:24',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(47,'2023-03-30 00:11:29',1,2,'INGRESO','INGRESO AL SISTEMA'),(48,'2023-03-30 00:11:31',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(49,'2023-03-30 00:11:47',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(50,'2023-03-30 00:11:57',136,2,'INGRESO','INGRESO AL SISTEMA'),(51,'2023-03-30 00:12:01',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(52,'2023-03-30 00:12:07',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(53,'2023-03-30 00:12:35',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(54,'2023-03-30 00:12:39',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(55,'2023-03-30 00:14:45',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(56,'2023-03-30 00:16:06',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(57,'2023-03-30 00:23:56',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(58,'2023-03-30 00:24:06',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(59,'2023-03-30 00:27:27',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(60,'2023-03-30 00:27:42',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(61,'2023-03-30 00:28:27',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(62,'2023-03-30 00:28:36',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(63,'2023-03-30 00:28:41',1,2,'INGRESO','INGRESO AL SISTEMA'),(64,'2023-03-30 00:28:43',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(65,'2023-03-30 00:28:46',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(66,'2023-03-30 00:29:06',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(67,'2023-03-30 00:29:17',136,2,'INGRESO','INGRESO AL SISTEMA'),(68,'2023-03-30 00:29:20',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(69,'2023-03-30 00:29:28',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(70,'2023-03-30 00:30:41',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(71,'2023-03-30 00:30:45',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(72,'2023-03-30 00:30:49',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(73,'2023-03-30 00:30:54',1,2,'INGRESO','INGRESO AL SISTEMA'),(74,'2023-03-30 00:30:57',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(75,'2023-03-30 00:31:03',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(76,'2023-03-30 00:31:19',136,2,'INGRESO','INGRESO AL SISTEMA'),(77,'2023-03-30 00:31:28',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(78,'2023-03-30 00:38:23',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(79,'2023-03-30 00:38:29',1,2,'INGRESO','INGRESO AL SISTEMA'),(80,'2023-03-30 00:46:36',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(81,'2023-03-30 00:47:04',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(82,'2023-03-30 00:47:11',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(83,'2023-03-30 00:48:06',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(84,'2023-03-30 00:48:14',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(85,'2023-03-30 00:48:54',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(86,'2023-03-30 00:49:06',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(87,'2023-03-30 00:49:47',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(88,'2023-03-30 00:50:57',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(89,'2023-03-30 00:51:25',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(90,'2023-03-30 00:52:18',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(91,'2023-03-30 00:52:56',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(92,'2023-03-30 00:53:08',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(93,'2023-03-30 00:53:15',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(94,'2023-03-30 00:53:22',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(95,'2023-03-30 00:53:24',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(96,'2023-03-30 00:53:32',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(97,'2023-03-30 00:53:40',136,2,'INGRESO','INGRESO AL SISTEMA'),(98,'2023-03-30 00:53:43',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(99,'2023-03-30 00:53:49',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(100,'2023-03-30 00:53:53',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(101,'2023-03-30 00:53:57',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(102,'2023-03-30 00:54:07',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(103,'2023-03-30 00:54:29',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(104,'2023-03-30 00:54:34',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(105,'2023-03-30 00:54:38',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(106,'2023-03-30 00:54:41',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(107,'2023-03-30 00:54:55',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(108,'2023-03-30 01:11:47',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(109,'2023-03-30 01:11:59',136,2,'INGRESO','INGRESO AL SISTEMA'),(110,'2023-03-30 01:12:02',136,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(111,'2023-03-30 01:12:08',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(112,'2023-03-30 01:12:18',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(113,'2023-03-30 01:15:31',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(114,'2023-03-30 01:16:03',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(115,'2023-03-30 01:16:11',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(116,'2023-03-30 01:20:22',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(117,'2023-03-30 02:14:25',1,2,'INGRESO','INGRESO AL SISTEMA'),(118,'2023-03-30 12:11:42',1,2,'INGRESO','INGRESO AL SISTEMA'),(119,'2023-03-30 12:11:53',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(120,'2023-03-30 12:11:58',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(121,'2023-03-30 12:12:02',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(122,'2023-03-30 12:19:54',1,2,'INGRESO','INGRESO AL SISTEMA'),(123,'2023-03-30 12:46:51',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(124,'2023-03-30 12:49:56',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(125,'2023-03-30 12:50:40',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(126,'2023-03-30 12:55:04',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(127,'2023-03-30 12:55:58',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(128,'2023-03-30 12:56:02',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(129,'2023-03-30 12:56:35',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(130,'2023-03-30 13:13:12',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(131,'2023-03-30 13:13:15',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(132,'2023-03-30 13:13:22',1,2,'INGRESO','INGRESO AL SISTEMA'),(133,'2023-03-30 13:13:27',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(134,'2023-03-30 13:13:30',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(135,'2023-03-30 13:13:32',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(136,'2023-03-30 13:13:42',136,2,'INGRESO','INGRESO AL SISTEMA'),(137,'2023-03-30 13:13:51',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(138,'2023-03-30 13:14:05',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(139,'2023-03-30 13:14:44',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(140,'2023-03-30 13:14:55',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(141,'2023-03-30 13:15:13',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(142,'2023-03-30 13:15:22',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(143,'2023-03-30 13:15:48',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(144,'2023-03-30 13:15:57',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(145,'2023-03-30 13:16:05',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(146,'2023-03-30 13:17:19',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(147,'2023-03-30 13:17:26',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(148,'2023-03-30 13:17:46',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(149,'2023-03-30 13:17:55',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(150,'2023-03-30 13:27:11',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(151,'2023-03-30 13:27:18',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(152,'2023-03-30 19:32:23',1,2,'INGRESO','INGRESO AL SISTEMA'),(153,'2023-03-30 19:32:27',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(154,'2023-03-31 11:54:58',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(155,'2023-03-31 12:16:21',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(156,'2023-03-31 12:16:23',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(157,'2023-04-03 23:46:26',1,2,'INGRESO','INGRESO AL SISTEMA'),(158,'2023-04-03 23:46:28',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(159,'2023-04-04 00:22:20',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(160,'2023-04-04 00:22:25',1,2,'INGRESO','INGRESO AL SISTEMA'),(161,'2023-04-05 09:25:43',1,2,'INGRESO','INGRESO AL SISTEMA'),(162,'2023-04-05 11:01:20',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(163,'2023-04-05 11:01:24',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(164,'2023-04-05 11:08:44',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(165,'2023-04-05 11:09:08',1,2,'INGRESO','INGRESO AL SISTEMA'),(166,'2023-04-05 11:19:20',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(167,'2023-04-05 11:24:45',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(168,'2023-04-05 11:39:26',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(169,'2023-04-05 11:41:34',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(170,'2023-04-05 11:57:12',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(171,'2023-04-05 11:58:25',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(172,'2023-04-05 17:24:46',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(173,'2023-04-05 17:25:19',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(174,'2023-04-05 17:25:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(175,'2023-04-05 17:27:17',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(176,'2023-04-05 17:28:09',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(177,'2023-04-05 17:29:10',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(178,'2023-04-05 17:29:20',1,2,'INGRESO','INGRESO AL SISTEMA'),(179,'2023-04-05 17:29:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(180,'2023-04-05 17:30:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(181,'2023-04-05 17:40:55',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(182,'2023-04-05 17:41:32',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(183,'2023-04-05 17:41:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(184,'2023-04-05 17:42:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(185,'2023-04-05 17:46:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(186,'2023-04-05 17:46:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(187,'2023-04-05 17:48:46',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(188,'2023-04-05 17:49:22',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(189,'2023-04-06 00:47:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(190,'2023-04-06 00:47:21',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(191,'2023-04-06 00:47:45',1,2,'INGRESO','INGRESO AL SISTEMA'),(192,'2023-04-06 00:47:51',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(193,'2023-04-06 15:49:50',1,2,'INGRESO','INGRESO AL SISTEMA'),(194,'2023-04-06 15:49:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(195,'2023-04-06 16:39:56',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(196,'2023-04-06 16:40:04',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(197,'2023-04-06 16:40:26',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(198,'2023-04-06 16:50:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(199,'2023-04-06 21:15:02',1,2,'INGRESO','INGRESO AL SISTEMA'),(200,'2023-04-06 21:15:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(201,'2023-04-06 22:48:30',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(202,'2023-04-06 22:50:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(203,'2023-04-06 22:50:47',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(204,'2023-04-06 23:01:42',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(205,'2023-04-06 23:40:12',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(206,'2023-04-06 23:43:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(207,'2023-04-06 23:43:58',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(208,'2023-04-06 23:44:21',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(209,'2023-04-06 23:45:41',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(210,'2023-04-06 23:46:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(211,'2023-04-06 23:49:49',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(212,'2023-04-06 23:50:28',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(213,'2023-04-06 23:52:15',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(214,'2023-04-06 23:52:18',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(215,'2023-04-07 15:02:47',1,2,'INGRESO','INGRESO AL SISTEMA'),(216,'2023-04-07 15:02:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(217,'2023-04-07 15:06:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(218,'2023-04-07 15:07:26',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(219,'2023-04-07 15:11:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(220,'2023-04-07 15:23:37',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(221,'2023-04-07 15:33:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(222,'2023-04-07 15:34:52',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(223,'2023-04-07 19:59:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(224,'2023-04-07 19:59:31',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(225,'2023-04-07 21:24:27',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(226,'2023-04-07 21:50:28',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(227,'2023-04-07 21:50:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(228,'2023-04-07 22:56:26',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(229,'2023-04-07 22:57:11',1,2,'CREAR','CREACIÓN DE CAI'),(230,'2023-04-07 22:58:10',1,2,'INGRESO','INGRESO AL MÓDULO CONFIGURACIÓN CAI'),(231,'2023-04-07 23:39:34',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(232,'2023-04-07 23:39:53',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PROMOCION'),(233,'2023-04-07 23:40:03',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PROMOCION'),(234,'2023-04-07 23:41:13',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(235,'2023-04-08 00:30:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(236,'2023-04-08 00:44:30',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(237,'2023-04-08 00:44:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(238,'2023-04-08 00:47:49',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(239,'2023-04-08 00:49:00',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(240,'2023-04-08 00:49:16',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(241,'2023-04-08 00:50:14',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(242,'2023-04-08 00:54:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(243,'2023-04-08 00:54:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(244,'2023-04-08 00:55:00',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(245,'2023-04-08 00:56:25',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(246,'2023-04-08 00:56:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(247,'2023-04-08 01:02:06',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(248,'2023-04-08 01:06:20',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(249,'2023-04-08 01:06:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(250,'2023-04-08 01:19:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(251,'2023-04-08 15:19:06',1,2,'INGRESO','INGRESO AL SISTEMA'),(252,'2023-04-08 15:19:31',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(253,'2023-04-08 15:19:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(254,'2023-04-08 15:19:47',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(255,'2023-04-08 15:19:49',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(256,'2023-04-08 15:23:01',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(257,'2023-04-08 15:23:03',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(258,'2023-04-08 15:23:10',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(259,'2023-04-08 15:25:36',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(260,'2023-04-08 15:25:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(261,'2023-04-08 15:25:41',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(262,'2023-04-08 15:25:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(263,'2023-04-08 15:30:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(264,'2023-04-08 15:55:36',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(265,'2023-04-08 15:59:56',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(266,'2023-04-08 16:01:37',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(267,'2023-04-08 16:45:31',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(268,'2023-04-09 07:59:33',1,2,'INGRESO','INGRESO AL SISTEMA'),(269,'2023-04-09 07:59:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(270,'2023-04-09 08:00:25',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(271,'2023-04-09 08:04:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(272,'2023-04-09 08:04:22',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(273,'2023-04-09 08:08:51',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(274,'2023-04-09 08:17:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(275,'2023-04-09 08:17:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(276,'2023-04-09 08:17:41',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(277,'2023-04-09 08:18:10',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(278,'2023-04-09 08:23:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(279,'2023-04-09 08:23:35',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(280,'2023-04-09 08:23:46',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(281,'2023-04-09 10:23:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(282,'2023-04-09 10:28:28',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(283,'2023-04-09 10:34:05',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(284,'2023-04-09 10:34:14',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(285,'2023-04-09 10:38:32',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(286,'2023-04-09 10:39:23',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(287,'2023-04-09 10:39:38',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(288,'2023-04-09 10:41:52',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(289,'2023-04-09 10:56:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(290,'2023-04-09 10:56:55',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(291,'2023-04-09 10:57:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(292,'2023-04-09 10:58:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(293,'2023-04-09 11:03:51',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(294,'2023-04-09 11:05:10',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(295,'2023-04-09 11:05:23',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(296,'2023-04-09 11:05:26',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(297,'2023-04-09 11:05:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(298,'2023-04-09 11:05:56',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(299,'2023-04-09 11:08:23',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(300,'2023-04-09 11:08:44',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(301,'2023-04-09 11:10:16',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(302,'2023-04-09 11:12:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(303,'2023-04-09 11:15:56',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(304,'2023-04-09 11:16:09',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(305,'2023-04-09 11:18:18',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(306,'2023-04-09 11:20:26',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(307,'2023-04-09 11:24:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(308,'2023-04-09 11:24:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(309,'2023-04-09 11:29:31',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(310,'2023-04-09 11:38:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(311,'2023-04-09 11:39:00',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(312,'2023-04-09 11:40:02',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(313,'2023-04-09 11:42:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(314,'2023-04-09 16:43:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(315,'2023-04-09 16:44:14',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(316,'2023-04-09 18:16:03',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(317,'2023-04-09 18:16:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(318,'2023-04-09 18:17:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(319,'2023-04-09 18:19:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(320,'2023-04-09 18:22:58',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(321,'2023-04-09 18:28:10',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(322,'2023-04-09 18:29:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(323,'2023-04-09 18:30:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(324,'2023-04-09 18:34:23',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(325,'2023-04-09 18:34:48',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(326,'2023-04-09 19:45:55',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(327,'2023-04-09 19:46:28',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(328,'2023-04-09 19:52:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(329,'2023-04-09 19:53:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(330,'2023-04-09 19:54:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(331,'2023-04-09 19:54:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(332,'2023-04-09 19:54:22',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(333,'2023-04-09 19:54:44',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(334,'2023-04-09 19:54:52',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(335,'2023-04-09 19:55:21',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(336,'2023-04-09 19:55:26',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(337,'2023-04-09 19:55:31',1,2,'INGRESO','INGRESO AL SISTEMA'),(338,'2023-04-09 19:55:34',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(339,'2023-04-09 19:56:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(340,'2023-04-09 19:57:04',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(341,'2023-04-09 19:57:27',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(342,'2023-04-09 19:57:43',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(343,'2023-04-09 19:57:52',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(344,'2023-04-09 19:58:00',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(345,'2023-04-09 19:58:13',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(346,'2023-04-09 19:58:19',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(347,'2023-04-09 19:58:28',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(348,'2023-04-09 19:58:42',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(349,'2023-04-09 19:58:52',162,2,'INGRESO','INGRESO AL SISTEMA'),(350,'2023-04-09 19:58:55',162,2,'INGRESO','INGRESO AL MODULO VENTAS'),(351,'2023-04-09 19:59:55',162,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(352,'2023-04-09 20:00:14',162,2,'INGRESO','INGRESO AL MODULO VENTAS'),(353,'2023-04-09 20:00:47',162,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(354,'2023-04-09 20:00:58',162,2,'INGRESO','INGRESO AL MODULO VENTAS'),(355,'2023-04-09 20:02:54',162,2,'INGRESO','INGRESO AL MODULO VENTAS'),(356,'2023-04-09 20:04:27',162,2,'INGRESO','INGRESO AL MODULO VENTAS'),(357,'2023-04-09 23:16:33',1,2,'INGRESO','INGRESO AL SISTEMA'),(358,'2023-04-09 23:16:36',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(359,'2023-04-09 23:20:27',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(360,'2023-04-09 23:22:57',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(361,'2023-04-09 23:23:36',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(362,'2023-04-09 23:26:52',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(363,'2023-04-09 23:28:42',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(364,'2023-04-09 23:30:56',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(365,'2023-04-09 23:34:05',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(366,'2023-04-09 23:34:15',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(367,'2023-04-09 23:35:08',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(368,'2023-04-09 23:40:28',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(369,'2023-04-09 23:44:33',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(370,'2023-04-09 23:44:42',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(371,'2023-04-09 23:44:47',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(372,'2023-04-09 23:44:52',1,2,'INGRESO','INGRESO AL SISTEMA'),(373,'2023-04-09 23:44:54',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(374,'2023-04-09 23:44:56',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(375,'2023-04-09 23:56:47',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(376,'2023-04-09 23:57:03',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(377,'2023-04-09 23:57:39',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(378,'2023-04-09 23:58:13',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(379,'2023-04-09 23:58:38',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(380,'2023-04-10 00:04:29',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(381,'2023-04-10 00:05:07',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(382,'2023-04-10 16:53:08',1,2,'INGRESO','INGRESO AL SISTEMA'),(383,'2023-04-10 16:53:12',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(384,'2023-04-10 16:55:03',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(385,'2023-04-10 21:37:29',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(386,'2023-04-10 21:37:38',1,2,'INGRESO','INGRESO AL SISTEMA'),(387,'2023-04-10 21:37:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_objetos`
--

LOCK TABLES `tbl_ms_objetos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_objetos` DISABLE KEYS */;
INSERT INTO `tbl_ms_objetos` VALUES (1,'INICIO','DASHBOARD',1),(2,'USUARIOS','USUARIOS DEL SISTEMA',1),(4,'PRODUCTOS','TODOS LOS PRODUCTOS',1),(10,'PROMOCION','PROMOCIONES',1),(11,'DESCUENTOS','DESCUENTOS',1),(12,'PREGUNTAS','PREGUNTAS SECRETAS',1),(13,'INVENTARIO','INVENTARIO DE LOS PRODUCTOS',1),(14,'ROLES',NULL,1),(15,'BITÁCORA',NULL,1),(16,'PARÁMETROS',NULL,1),(17,'BACKUP',NULL,1),(18,'OBJETOS',NULL,1),(20,'COMPRAS',NULL,1),(21,'VENTAS',NULL,1),(22,'CLIENTES',NULL,1),(23,'KARDEX',NULL,1),(24,'CAI',NULL,1);
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
INSERT INTO `tbl_ms_parametros` VALUES (1,'ADMIN_INTENTOS','3',NULL,NULL,NULL,NULL),(2,'ADMIN_PREGUNTAS','2',NULL,NULL,NULL,NULL),(3,'ADMIN_CORREO','uniformesdelatlantico@hotmail.com',NULL,NULL,NULL,NULL),(4,'FECHA_VENCIMIENTO','30',NULL,NULL,NULL,NULL),(5,'IMPUESTO','15',NULL,NULL,NULL,NULL),(6,'NOMBRE_EMPRESA','INVERSIONES UNIFORMES DEL ATLÁNTICO',NULL,NULL,NULL,NULL),(7,'RAZON_SOCIAL','S. DE R. L. DE C. V.',NULL,NULL,NULL,NULL),(8,'TELEFONO_EMPRESA','9970-5887',NULL,NULL,NULL,NULL),(9,'DIRECCION','BO. EL CENTRO, DOMICILIO RENTADO, ATRÁS DE LA DESPENSA FAMILIAR, TELA. ATLÁNTIDA',NULL,NULL,NULL,NULL),(10,'RTN','01079021315692',NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=537 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_permisos`
--

LOCK TABLES `tbl_ms_permisos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_permisos` DISABLE KEYS */;
INSERT INTO `tbl_ms_permisos` VALUES (39,3,1,1,0,0,0),(40,3,2,1,0,0,0),(42,3,4,0,0,0,0),(93,11,1,1,0,0,0),(94,11,2,0,0,0,0),(96,11,4,0,0,0,0),(223,21,1,1,1,1,1),(224,21,2,1,1,1,1),(226,21,4,1,0,0,0),(231,2,1,0,0,0,0),(232,2,2,0,0,0,0),(234,2,4,0,0,0,0),(418,1,1,1,1,1,1),(419,1,2,1,1,1,1),(420,1,4,1,1,1,1),(421,1,10,1,1,1,1),(422,1,11,1,1,1,1),(423,1,12,1,1,1,1),(424,1,13,1,1,1,1),(425,1,14,1,1,1,1),(426,1,15,1,1,1,1),(427,1,16,1,1,1,1),(428,1,17,1,1,1,1),(429,1,18,1,1,1,1),(430,1,20,1,1,1,1),(431,1,21,1,1,1,1),(432,1,22,1,1,1,1),(433,1,23,1,1,1,1),(434,1,24,1,1,1,1),(520,4,1,1,0,0,0),(521,4,2,1,1,1,1),(522,4,4,1,0,0,0),(523,4,10,1,1,0,0),(524,4,11,1,0,0,0),(525,4,12,0,1,0,0),(526,4,13,1,1,1,0),(527,4,14,1,1,1,1),(528,4,15,1,0,0,0),(529,4,16,1,0,0,1),(530,4,17,1,0,0,0),(531,4,18,1,1,1,1),(532,4,20,1,0,0,0),(533,4,21,1,0,0,0),(534,4,22,1,0,0,0),(535,4,23,1,0,0,0),(536,4,24,1,0,0,0);
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
INSERT INTO `tbl_ms_roles` VALUES (1,'ADMINISTRADOR','Acceso a todo el sistema',1),(2,'DEFAULT','Rol por defecto',1),(3,'Clientes de todo','Clientes en general',0),(4,'VENDEDOR','Operador de tienda',1),(5,'prueba','fddfd',0),(6,'prueba2','gg',0),(7,'prueba33','d',0),(8,'prueba4','f',0),(9,'nuevo1','dch',0),(10,'prueba555','gggggg',0),(11,'Nuevo de prueba','sf',0),(12,'probar cambio','sddd',0),(13,'prueba44','f',0),(14,'prueba4446','d',0),(15,'Nueva Prueba','sssss',0),(16,'rrrr','rf',0),(17,'gu','f',0),(18,'fff','fffd',0),(19,'rrr','rr',0),(20,'j','j',0),(21,'www','www',0),(22,'CONTABILIDAD','rrr',0),(23,'nuevorol','d',1);
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
INSERT INTO `tbl_ms_usuarios` VALUES (1,'ADMIN','ADMINISTRADOR',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','2023-04-10 21:37:38',0,NULL,NULL,'admin@atlantico.com','733464113f1d79251461-4ff19d069fb2ec635522-a12faeec9a0c21dd0b33-435908728e5136f3ae80',NULL,'2021-08-20 01:34:15','ADMIN','2023-03-22 21:16:11',1),(19,'ALEXANDER','ALEXANDER AGUILAR',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,0,NULL,NULL,'alex@hotmail.com',NULL,NULL,'2023-02-04 01:16:01','ADMIN','2023-03-22 10:36:01',4),(20,'ERIKA','ERIKA AYALA',2,'18ac3e7343f016890c510e93f935261169d9e3f565436429830faf0934f4f8e4',NULL,0,NULL,NULL,'erika3@gmail.com',NULL,NULL,'2023-02-08 21:40:58','ADMIN','2023-03-22 10:35:34',2),(104,'HECTOR','HECTOR BUSTILLOO',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,2,NULL,NULL,'hector@hotmail.com',NULL,'ADMIN','2023-03-08 15:22:09','ADMIN','2023-03-22 21:14:43',1),(136,'JORGE','JORGE ROMERO',1,'c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb','2023-03-30 13:13:42',2,NULL,NULL,'jorge@gmail.com','','ADMIN','2023-03-15 20:49:18','ADMIN','2023-03-29 21:35:43',4),(162,'DORCA','DORCA AGUILAR',1,'c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb','2023-04-09 19:58:52',2,NULL,NULL,'dorcaaguilar@gmail.com',NULL,'ADMIN','2023-03-16 21:25:14','ADMIN','2023-04-09 19:58:13',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_producto`
--

LOCK TABLES `tbl_producto` WRITE;
/*!40000 ALTER TABLE `tbl_producto` DISABLE KEYS */;
INSERT INTO `tbl_producto` VALUES (12,'TELA','TELA BLANCA',200,30,3,30.00,1,NULL,NULL,NULL,NULL,111),(13,'PINTURA','ROJA',10,100,3,20.00,1,NULL,NULL,NULL,NULL,30);
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

-- Dump completed on 2023-04-10 22:51:42
