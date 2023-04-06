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
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_temp`
--

LOCK TABLES `detalle_temp` WRITE;
/*!40000 ALTER TABLE `detalle_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_temp` ENABLE KEYS */;
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
INSERT INTO `tbl_cliente` VALUES (5,'12345','JENNIE K','REYES',95501010,NULL,'COLONIA LOS PINOS',NULL,3,1,1);
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
  `isv` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`cod_compra`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_compra`
--

LOCK TABLES `tbl_compra` WRITE;
/*!40000 ALTER TABLE `tbl_compra` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_configuracion_cai`
--

LOCK TABLES `tbl_configuracion_cai` WRITE;
/*!40000 ALTER TABLE `tbl_configuracion_cai` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_descuento`
--

LOCK TABLES `tbl_descuento` WRITE;
/*!40000 ALTER TABLE `tbl_descuento` DISABLE KEYS */;
INSERT INTO `tbl_descuento` VALUES (2,'DESCUENTO ',15.00);
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
  `precio_compra` decimal(8,2) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  `cod_compra` int DEFAULT NULL,
  PRIMARY KEY (`cod_detalle_compra`),
  KEY `TBL_PRODUCTO_COD_PRODUCTO_idx` (`cod_producto`),
  KEY `TBL_COMPRA_COD_COMPRA_idx` (`cod_compra`),
  CONSTRAINT `DetalleCompra_CodCompra` FOREIGN KEY (`cod_compra`) REFERENCES `tbl_compra` (`cod_compra`),
  CONSTRAINT `DetalleCompra_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_compra`
--

LOCK TABLES `tbl_detalle_compra` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_compra` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_factura`
--

LOCK TABLES `tbl_detalle_factura` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_factura` DISABLE KEYS */;
INSERT INTO `tbl_detalle_factura` VALUES (2,3,12,1,30.00),(3,6,12,1,30.00),(4,6,12,2,30.00),(6,10,12,1,30.00),(7,10,12,1,30.00),(9,11,12,1,30.00),(10,12,12,1,30.00),(11,13,12,1,30.00),(12,14,12,1,30.00),(13,15,12,10,30.00),(14,16,12,1,30.00),(15,16,12,2,30.00),(17,17,12,1,30.00),(18,17,12,2,30.00),(20,18,12,5,30.00),(21,19,12,3,30.00),(22,20,12,1,30.00),(23,20,12,2,30.00),(25,21,13,1,20.00),(26,21,12,2,30.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_factura`
--

LOCK TABLES `tbl_factura` WRITE;
/*!40000 ALTER TABLE `tbl_factura` DISABLE KEYS */;
INSERT INTO `tbl_factura` VALUES (3,NULL,'2023-04-04 00:00:59',1,5,NULL,1,NULL,NULL,NULL),(6,NULL,'2023-04-04 00:14:02',1,5,NULL,1,NULL,NULL,NULL),(10,NULL,'2023-04-04 00:26:01',1,5,60.00,1,NULL,NULL,NULL),(11,NULL,'2023-04-04 00:28:16',1,5,30.00,2,NULL,NULL,NULL),(12,NULL,'2023-04-04 00:29:12',1,5,30.00,1,NULL,NULL,NULL),(13,NULL,'2023-04-05 10:51:40',1,5,30.00,1,NULL,NULL,NULL),(14,NULL,'2023-04-05 16:38:27',1,5,30.00,2,NULL,NULL,NULL),(15,NULL,'2023-04-05 16:42:04',1,5,300.00,1,NULL,NULL,NULL),(16,NULL,'2023-04-05 16:51:45',1,5,90.00,1,77.00,NULL,NULL),(17,NULL,'2023-04-05 16:54:34',1,5,90.00,1,76.50,NULL,NULL),(18,NULL,'2023-04-05 17:12:12',1,5,150.00,1,127.50,NULL,NULL),(19,NULL,'2023-04-05 17:23:51',1,5,90.00,1,76.50,13.50,NULL),(20,NULL,'2023-04-06 15:01:21',1,5,90.00,1,76.50,13.50,NULL),(21,NULL,'2023-04-06 15:50:24',1,5,80.00,1,68.00,12.00,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_bitacora`
--

LOCK TABLES `tbl_ms_bitacora` WRITE;
/*!40000 ALTER TABLE `tbl_ms_bitacora` DISABLE KEYS */;
INSERT INTO `tbl_ms_bitacora` VALUES (1,'2023-03-29 23:40:35',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(2,'2023-03-29 23:41:00',136,2,'INGRESO','INGRESO AL SISTEMA'),(3,'2023-03-29 23:42:52',136,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(4,'2023-03-29 23:43:24',136,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(5,'2023-03-29 23:44:41',136,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(6,'2023-03-29 23:45:36',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(7,'2023-03-29 23:45:48',1,2,'INGRESO','INGRESO AL SISTEMA'),(8,'2023-03-29 23:45:51',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(9,'2023-03-29 23:47:33',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(10,'2023-03-29 23:47:50',136,2,'INGRESO','INGRESO AL SISTEMA'),(11,'2023-03-29 23:48:04',136,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(12,'2023-03-29 23:48:16',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(13,'2023-03-29 23:48:23',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(14,'2023-03-29 23:56:05',1,2,'INGRESO','INGRESO AL SISTEMA'),(15,'2023-03-29 23:56:08',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(16,'2023-03-29 23:56:36',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(17,'2023-03-29 23:56:52',136,2,'INGRESO','INGRESO AL SISTEMA'),(18,'2023-03-29 23:57:12',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(19,'2023-03-29 23:57:18',1,2,'INGRESO','INGRESO AL SISTEMA'),(20,'2023-03-29 23:57:20',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(21,'2023-03-29 23:57:31',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(22,'2023-03-29 23:57:43',136,2,'INGRESO','INGRESO AL SISTEMA'),(23,'2023-03-30 00:01:52',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(24,'2023-03-30 00:02:22',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(25,'2023-03-30 00:02:27',1,2,'INGRESO','INGRESO AL SISTEMA'),(26,'2023-03-30 00:02:34',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(27,'2023-03-30 00:02:58',136,2,'INGRESO','INGRESO AL SISTEMA'),(28,'2023-03-30 00:03:03',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(29,'2023-03-30 00:03:18',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(30,'2023-03-30 00:04:40',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(31,'2023-03-30 00:04:50',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(32,'2023-03-30 00:04:54',1,2,'INGRESO','INGRESO AL SISTEMA'),(33,'2023-03-30 00:04:57',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(34,'2023-03-30 00:05:09',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(35,'2023-03-30 00:05:17',136,2,'INGRESO','INGRESO AL SISTEMA'),(36,'2023-03-30 00:05:26',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(37,'2023-03-30 00:05:31',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(38,'2023-03-30 00:05:56',136,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(39,'2023-03-30 00:06:43',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(40,'2023-03-30 00:07:10',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(41,'2023-03-30 00:07:34',136,2,'INGRESO','INGRESO AL SISTEMA'),(42,'2023-03-30 00:07:37',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(43,'2023-03-30 00:07:44',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(44,'2023-03-30 00:11:08',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(45,'2023-03-30 00:11:20',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(46,'2023-03-30 00:11:24',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(47,'2023-03-30 00:11:29',1,2,'INGRESO','INGRESO AL SISTEMA'),(48,'2023-03-30 00:11:31',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(49,'2023-03-30 00:11:47',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(50,'2023-03-30 00:11:57',136,2,'INGRESO','INGRESO AL SISTEMA'),(51,'2023-03-30 00:12:01',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(52,'2023-03-30 00:12:07',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(53,'2023-03-30 00:12:35',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(54,'2023-03-30 00:12:39',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(55,'2023-03-30 00:14:45',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(56,'2023-03-30 00:16:06',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(57,'2023-03-30 00:23:56',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(58,'2023-03-30 00:24:06',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(59,'2023-03-30 00:27:27',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(60,'2023-03-30 00:27:42',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(61,'2023-03-30 00:28:27',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(62,'2023-03-30 00:28:36',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(63,'2023-03-30 00:28:41',1,2,'INGRESO','INGRESO AL SISTEMA'),(64,'2023-03-30 00:28:43',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(65,'2023-03-30 00:28:46',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(66,'2023-03-30 00:29:06',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(67,'2023-03-30 00:29:17',136,2,'INGRESO','INGRESO AL SISTEMA'),(68,'2023-03-30 00:29:20',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(69,'2023-03-30 00:29:28',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(70,'2023-03-30 00:30:41',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(71,'2023-03-30 00:30:45',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(72,'2023-03-30 00:30:49',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(73,'2023-03-30 00:30:54',1,2,'INGRESO','INGRESO AL SISTEMA'),(74,'2023-03-30 00:30:57',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(75,'2023-03-30 00:31:03',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(76,'2023-03-30 00:31:19',136,2,'INGRESO','INGRESO AL SISTEMA'),(77,'2023-03-30 00:31:28',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(78,'2023-03-30 00:38:23',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(79,'2023-03-30 00:38:29',1,2,'INGRESO','INGRESO AL SISTEMA'),(80,'2023-03-30 00:46:36',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(81,'2023-03-30 00:47:04',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(82,'2023-03-30 00:47:11',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(83,'2023-03-30 00:48:06',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(84,'2023-03-30 00:48:14',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(85,'2023-03-30 00:48:54',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(86,'2023-03-30 00:49:06',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(87,'2023-03-30 00:49:47',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(88,'2023-03-30 00:50:57',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(89,'2023-03-30 00:51:25',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(90,'2023-03-30 00:52:18',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(91,'2023-03-30 00:52:56',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(92,'2023-03-30 00:53:08',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(93,'2023-03-30 00:53:15',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(94,'2023-03-30 00:53:22',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(95,'2023-03-30 00:53:24',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(96,'2023-03-30 00:53:32',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(97,'2023-03-30 00:53:40',136,2,'INGRESO','INGRESO AL SISTEMA'),(98,'2023-03-30 00:53:43',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(99,'2023-03-30 00:53:49',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(100,'2023-03-30 00:53:53',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(101,'2023-03-30 00:53:57',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(102,'2023-03-30 00:54:07',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(103,'2023-03-30 00:54:29',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(104,'2023-03-30 00:54:34',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(105,'2023-03-30 00:54:38',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(106,'2023-03-30 00:54:41',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(107,'2023-03-30 00:54:55',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(108,'2023-03-30 01:11:47',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(109,'2023-03-30 01:11:59',136,2,'INGRESO','INGRESO AL SISTEMA'),(110,'2023-03-30 01:12:02',136,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(111,'2023-03-30 01:12:08',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(112,'2023-03-30 01:12:18',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(113,'2023-03-30 01:15:31',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(114,'2023-03-30 01:16:03',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(115,'2023-03-30 01:16:11',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(116,'2023-03-30 01:20:22',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(117,'2023-03-30 02:14:25',1,2,'INGRESO','INGRESO AL SISTEMA'),(118,'2023-03-30 12:11:42',1,2,'INGRESO','INGRESO AL SISTEMA'),(119,'2023-03-30 12:11:53',1,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(120,'2023-03-30 12:11:58',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(121,'2023-03-30 12:12:02',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(122,'2023-03-30 12:19:54',1,2,'INGRESO','INGRESO AL SISTEMA'),(123,'2023-03-30 12:46:51',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(124,'2023-03-30 12:49:56',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(125,'2023-03-30 12:50:40',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(126,'2023-03-30 12:55:04',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(127,'2023-03-30 12:55:58',1,2,'INGRESO','INGRESO AL MODULO CLIENTES'),(128,'2023-03-30 12:56:02',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(129,'2023-03-30 12:56:35',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(130,'2023-03-30 13:13:12',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(131,'2023-03-30 13:13:15',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(132,'2023-03-30 13:13:22',1,2,'INGRESO','INGRESO AL SISTEMA'),(133,'2023-03-30 13:13:27',1,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(134,'2023-03-30 13:13:30',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(135,'2023-03-30 13:13:32',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(136,'2023-03-30 13:13:42',136,2,'INGRESO','INGRESO AL SISTEMA'),(137,'2023-03-30 13:13:51',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(138,'2023-03-30 13:14:05',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(139,'2023-03-30 13:14:44',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(140,'2023-03-30 13:14:55',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(141,'2023-03-30 13:15:13',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(142,'2023-03-30 13:15:22',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(143,'2023-03-30 13:15:48',136,2,'INGRESO','INGRESO AL MÓDULO PREGUNTAS'),(144,'2023-03-30 13:15:57',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(145,'2023-03-30 13:16:05',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(146,'2023-03-30 13:17:19',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(147,'2023-03-30 13:17:26',136,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(148,'2023-03-30 13:17:46',136,2,'INGRESO','INGRESO AL MÓDULO PROMOCION'),(149,'2023-03-30 13:17:55',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(150,'2023-03-30 13:27:11',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(151,'2023-03-30 13:27:18',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(152,'2023-03-30 19:32:23',1,2,'INGRESO','INGRESO AL SISTEMA'),(153,'2023-03-30 19:32:27',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(154,'2023-03-31 11:54:58',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(155,'2023-03-31 12:16:21',136,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(156,'2023-03-31 12:16:23',136,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(157,'2023-04-03 23:46:26',1,2,'INGRESO','INGRESO AL SISTEMA'),(158,'2023-04-03 23:46:28',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(159,'2023-04-04 00:22:20',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(160,'2023-04-04 00:22:25',1,2,'INGRESO','INGRESO AL SISTEMA'),(161,'2023-04-05 09:25:43',1,2,'INGRESO','INGRESO AL SISTEMA'),(162,'2023-04-05 11:01:20',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(163,'2023-04-05 11:01:24',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(164,'2023-04-05 11:08:44',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(165,'2023-04-05 11:09:08',1,2,'INGRESO','INGRESO AL SISTEMA'),(166,'2023-04-05 11:19:20',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(167,'2023-04-05 11:24:45',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(168,'2023-04-05 11:39:26',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(169,'2023-04-05 11:41:34',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(170,'2023-04-05 11:57:12',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(171,'2023-04-05 11:58:25',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(172,'2023-04-05 17:24:46',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(173,'2023-04-05 17:25:19',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(174,'2023-04-05 17:25:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(175,'2023-04-05 17:27:17',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(176,'2023-04-05 17:28:09',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(177,'2023-04-05 17:29:10',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(178,'2023-04-05 17:29:20',1,2,'INGRESO','INGRESO AL SISTEMA'),(179,'2023-04-05 17:29:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(180,'2023-04-05 17:30:50',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(181,'2023-04-05 17:40:55',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(182,'2023-04-05 17:41:32',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(183,'2023-04-05 17:41:40',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(184,'2023-04-05 17:42:43',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(185,'2023-04-05 17:46:24',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(186,'2023-04-05 17:46:54',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(187,'2023-04-05 17:48:46',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(188,'2023-04-05 17:49:22',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(189,'2023-04-06 00:47:11',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(190,'2023-04-06 00:47:21',1,2,'CERRAR SESIÓN','USUARIO CERRÓ SESIÓN'),(191,'2023-04-06 00:47:45',1,2,'INGRESO','INGRESO AL SISTEMA'),(192,'2023-04-06 00:47:51',1,2,'INGRESO','INGRESO AL MODULO VENTAS'),(193,'2023-04-06 15:49:50',1,2,'INGRESO','INGRESO AL SISTEMA'),(194,'2023-04-06 15:49:53',1,2,'INGRESO','INGRESO AL MODULO VENTAS');
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
INSERT INTO `tbl_ms_parametros` VALUES (1,'ADMIN_INTENTOS','3',NULL,NULL,NULL,NULL),(2,'ADMIN_PREGUNTAS','2',NULL,NULL,NULL,NULL),(3,'ADMIN_CORREO','inversiones@gmail.com',NULL,NULL,NULL,NULL),(4,'FECHA_VENCIMIENTO','30',NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=503 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_permisos`
--

LOCK TABLES `tbl_ms_permisos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_permisos` DISABLE KEYS */;
INSERT INTO `tbl_ms_permisos` VALUES (39,3,1,1,0,0,0),(40,3,2,1,0,0,0),(42,3,4,0,0,0,0),(93,11,1,1,0,0,0),(94,11,2,0,0,0,0),(96,11,4,0,0,0,0),(223,21,1,1,1,1,1),(224,21,2,1,1,1,1),(226,21,4,1,0,0,0),(231,2,1,0,0,0,0),(232,2,2,0,0,0,0),(234,2,4,0,0,0,0),(418,1,1,1,1,1,1),(419,1,2,1,1,1,1),(420,1,4,1,1,1,1),(421,1,10,1,1,1,1),(422,1,11,1,1,1,1),(423,1,12,1,1,1,1),(424,1,13,1,1,1,1),(425,1,14,1,1,1,1),(426,1,15,1,1,1,1),(427,1,16,1,1,1,1),(428,1,17,1,1,1,1),(429,1,18,1,1,1,1),(430,1,20,1,1,1,1),(431,1,21,1,1,1,1),(432,1,22,1,1,1,1),(433,1,23,1,1,1,1),(434,1,24,1,1,1,1),(486,4,1,1,0,0,0),(487,4,2,1,1,1,1),(488,4,4,1,0,0,0),(489,4,10,1,1,0,0),(490,4,11,1,0,0,0),(491,4,12,0,1,0,0),(492,4,13,1,1,1,0),(493,4,14,1,1,1,1),(494,4,15,1,0,0,0),(495,4,16,1,0,0,1),(496,4,17,1,0,0,0),(497,4,18,1,1,1,1),(498,4,20,1,0,0,0),(499,4,21,1,0,0,0),(500,4,22,1,0,0,0),(501,4,23,1,0,0,0),(502,4,24,1,0,0,0);
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
INSERT INTO `tbl_ms_usuarios` VALUES (1,'ADMIN','ADMINISTRADOR',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','2023-04-06 15:49:50',0,NULL,NULL,'admin@atlantico.com','733464113f1d79251461-4ff19d069fb2ec635522-a12faeec9a0c21dd0b33-435908728e5136f3ae80',NULL,'2021-08-20 01:34:15','ADMIN','2023-03-22 21:16:11',1),(19,'ALEXANDER','ALEXANDER AGUILAR',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,0,NULL,NULL,'alex@hotmail.com',NULL,NULL,'2023-02-04 01:16:01','ADMIN','2023-03-22 10:36:01',4),(20,'ERIKA','ERIKA AYALA',2,'18ac3e7343f016890c510e93f935261169d9e3f565436429830faf0934f4f8e4',NULL,0,NULL,NULL,'erika3@gmail.com',NULL,NULL,'2023-02-08 21:40:58','ADMIN','2023-03-22 10:35:34',2),(104,'HECTOR','HECTOR BUSTILLOO',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,2,NULL,NULL,'hector@hotmail.com',NULL,'ADMIN','2023-03-08 15:22:09','ADMIN','2023-03-22 21:14:43',1),(136,'JORGE','JORGE ROMERO',1,'c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb','2023-03-30 13:13:42',2,NULL,NULL,'jorge@gmail.com','','ADMIN','2023-03-15 20:49:18','ADMIN','2023-03-29 21:35:43',4),(162,'DORCA','DORCA AGUILAR',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c','2023-03-20 10:55:49',2,NULL,NULL,'dorcaaguilar@gmail.com',NULL,'ADMIN','2023-03-16 21:25:14','ADMIN','2023-03-22 10:35:53',1);
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
INSERT INTO `tbl_producto` VALUES (12,'TELA','TELA BLANCA',200,30,3,30.00,1,NULL,NULL,NULL,NULL,81),(13,'PINTURA','ROJA',10,100,3,20.00,1,NULL,NULL,NULL,NULL,34);
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-06 15:52:40
