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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `cantidad` int DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `cod_factura` bigint DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  PRIMARY KEY (`cod_detalle_factura`),
  KEY `DetalleFactura_CodProducto_idx` (`cod_producto`),
  KEY `DetalleFactura_NoFactura_idx` (`cod_factura`),
  CONSTRAINT `DetalleFactura_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `DetalleFactura_NoFactura` FOREIGN KEY (`cod_factura`) REFERENCES `tbl_factura` (`cod_factura`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_factura`
--

LOCK TABLES `tbl_detalle_factura` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_factura` DISABLE KEYS */;
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
  `total` decimal(10,2) DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `subtotal` decimal(10,2) DEFAULT NULL,
  `isv` decimal(10,2) DEFAULT NULL,
  `porcentaje_isv` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`cod_factura`),
  KEY `TBL_CLIENTE_COD_CLIENTE_idx` (`cod_cliente`),
  CONSTRAINT `Venta_CodCliente` FOREIGN KEY (`cod_cliente`) REFERENCES `tbl_cliente` (`cod_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_factura`
--

LOCK TABLES `tbl_factura` WRITE;
/*!40000 ALTER TABLE `tbl_factura` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_genero`
--

LOCK TABLES `tbl_genero` WRITE;
/*!40000 ALTER TABLE `tbl_genero` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_kardex`
--

LOCK TABLES `tbl_kardex` WRITE;
/*!40000 ALTER TABLE `tbl_kardex` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_bitacora`
--

LOCK TABLES `tbl_ms_bitacora` WRITE;
/*!40000 ALTER TABLE `tbl_ms_bitacora` DISABLE KEYS */;
INSERT INTO `tbl_ms_bitacora` VALUES (1,'2023-03-06 17:09:16',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(2,'2023-03-06 17:10:20',1,2,'INGRESO','INGRESO AL SISTEMA'),(3,'2023-03-06 17:10:22',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(4,'2023-03-06 17:10:57',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(5,'2023-03-06 17:11:07',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(6,'2023-03-06 17:11:20',19,2,'INGRESO','INGRESO AL SISTEMA'),(7,'2023-03-06 17:11:23',19,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(8,'2023-03-06 17:48:36',1,2,'INGRESO','INGRESO AL SISTEMA'),(9,'2023-03-06 17:48:38',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(10,'2023-03-06 17:49:42',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(11,'2023-03-06 17:50:43',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(12,'2023-03-06 18:03:58',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(13,'2023-03-06 18:04:43',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(14,'2023-03-06 23:37:57',1,2,'INGRESO','INGRESO AL SISTEMA'),(15,'2023-03-06 23:42:04',1,2,'INGRESO','INGRESO AL SISTEMA'),(16,'2023-03-06 23:44:59',1,2,'INGRESO','INGRESO AL SISTEMA'),(17,'2023-03-06 23:45:00',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(18,'2023-03-06 23:45:18',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(19,'2023-03-06 23:45:25',20,2,'INGRESO','INGRESO AL SISTEMA'),(20,'2023-03-06 23:47:06',20,2,'INGRESO','INGRESO AL SISTEMA'),(21,'2023-03-07 00:39:52',20,2,'INGRESO','INGRESO AL SISTEMA'),(22,'2023-03-07 00:43:16',20,2,'INGRESO','INGRESO AL SISTEMA'),(23,'2023-03-07 00:43:55',1,2,'INGRESO','INGRESO AL SISTEMA'),(24,'2023-03-07 00:43:57',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(25,'2023-03-07 00:44:16',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(26,'2023-03-07 00:44:27',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(27,'2023-03-07 00:45:12',1,2,'INGRESO','INGRESO AL SISTEMA'),(28,'2023-03-07 00:45:14',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(29,'2023-03-07 00:45:31',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(30,'2023-03-07 01:01:54',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(31,'2023-03-07 01:02:21',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(32,'2023-03-07 01:03:06',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(33,'2023-03-07 01:05:30',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(34,'2023-03-07 01:05:36',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(35,'2023-03-07 01:06:24',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(36,'2023-03-07 01:06:41',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(37,'2023-03-07 01:09:48',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(38,'2023-03-07 01:10:28',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(39,'2023-03-07 01:10:49',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(40,'2023-03-07 01:11:33',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(41,'2023-03-07 01:12:27',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(42,'2023-03-07 01:14:13',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(43,'2023-03-07 22:02:57',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(44,'2023-03-07 22:04:08',1,2,'INGRESO','INGRESO AL SISTEMA'),(45,'2023-03-08 14:49:13',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(46,'2023-03-08 14:49:27',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(47,'2023-03-08 14:50:17',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(48,'2023-03-08 14:52:21',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(49,'2023-03-08 15:05:58',1,2,'CREAR','CREACION DE PARAMETRO'),(50,'2023-03-08 15:09:13',1,2,'CREAR','CREACION DE PARAMETRO'),(51,'2023-03-08 15:11:36',1,2,'CREAR','CREACION DE PARAMETRO'),(52,'2023-03-08 15:20:23',1,2,'CREAR','CREACION DE PARAMETRO'),(53,'2023-03-08 15:20:37',1,2,'CREAR','CREACION DE PARAMETRO'),(54,'2023-03-08 15:21:38',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(55,'2023-03-08 15:22:09',1,2,'CREAR','CREACION DE USUARIO'),(56,'2023-03-08 15:24:28',1,2,'CREAR','CREACION DE PARAMETRO'),(57,'2023-03-08 15:32:28',1,2,'CREAR','CREACION DE PARAMETRO'),(58,'2023-03-08 15:32:52',1,2,'CREAR','CREACION DE PARAMETRO'),(59,'2023-03-08 15:39:55',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(60,'2023-03-08 15:40:24',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(61,'2023-03-08 15:45:36',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(62,'2023-03-08 16:12:23',1,2,'CREAR','CREACION DE PARAMETRO'),(63,'2023-03-08 16:16:57',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(64,'2023-03-08 21:41:30',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(65,'2023-03-08 21:41:40',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(66,'2023-03-08 21:43:05',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(67,'2023-03-08 21:43:34',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(68,'2023-03-08 23:05:32',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(69,'2023-03-08 23:12:16',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(70,'2023-03-08 23:12:31',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(71,'2023-03-08 23:18:58',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(72,'2023-03-08 23:21:46',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(73,'2023-03-08 23:22:28',1,2,'CREAR','CREACION DE PARAMETRO'),(74,'2023-03-08 23:26:47',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(75,'2023-03-08 23:27:23',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(76,'2023-03-08 23:28:01',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(77,'2023-03-09 01:03:22',1,2,'CREAR','CREACION DE PARAMETRO'),(78,'2023-03-09 01:03:27',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(79,'2023-03-09 01:04:05',1,2,'CREAR','CREACION DE PARAMETRO'),(80,'2023-03-09 01:04:17',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(81,'2023-03-09 01:05:41',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(82,'2023-03-09 01:05:51',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(83,'2023-03-09 01:07:37',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(84,'2023-03-09 01:07:42',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(85,'2023-03-09 01:07:45',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(86,'2023-03-09 01:07:48',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(87,'2023-03-09 01:07:51',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(88,'2023-03-09 01:08:10',1,2,'CREAR','CREACION DE PARAMETRO'),(89,'2023-03-09 01:08:52',1,2,'CREAR','CREACION DE PARAMETRO'),(90,'2023-03-09 01:09:07',1,2,'CREAR','CREACION DE PARAMETRO'),(91,'2023-03-09 01:09:26',1,2,'CREAR','CREACION DE PARAMETRO'),(92,'2023-03-09 01:09:34',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(93,'2023-03-09 01:10:01',1,2,'CREAR','CREACION DE PARAMETRO'),(94,'2023-03-09 01:10:09',1,2,'CREAR','CREACION DE PARAMETRO'),(95,'2023-03-09 01:12:00',1,2,'CREAR','CREACION DE PARAMETRO'),(96,'2023-03-09 14:30:22',1,2,'CREAR','CREACION DE PARAMETRO'),(97,'2023-03-09 14:34:12',1,2,'CREAR','CREACION DE PARAMETRO'),(98,'2023-03-09 14:37:18',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(99,'2023-03-09 14:37:39',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PARAMETRO'),(100,'2023-03-09 15:28:16',1,2,'INGRESO','INGRESO AL MÓDULO PARAMETROS'),(101,'2023-03-09 15:28:49',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(102,'2023-03-09 15:30:18',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(103,'2023-03-09 15:30:40',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(104,'2023-03-09 15:30:44',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(105,'2023-03-09 15:30:48',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(106,'2023-03-10 01:04:44',1,2,'INGRESO','INGRESO AL SISTEMA'),(107,'2023-03-10 01:04:46',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(108,'2023-03-10 01:05:07',1,2,'CREAR','CREACION DE USUARIO'),(109,'2023-03-10 01:23:58',1,2,'INGRESO','INGRESO AL SISTEMA'),(110,'2023-03-10 01:24:01',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(111,'2023-03-10 01:24:20',1,2,'CREAR','CREACION DE USUARIO'),(112,'2023-03-10 01:24:31',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(113,'2023-03-10 01:45:24',1,2,'INGRESO','INGRESO AL SISTEMA'),(114,'2023-03-10 01:45:27',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(115,'2023-03-10 01:47:42',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(116,'2023-03-10 01:47:48',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(117,'2023-03-10 01:48:23',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(118,'2023-03-10 01:49:47',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(119,'2023-03-10 01:52:56',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(120,'2023-03-10 01:53:29',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(121,'2023-03-10 01:55:48',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(122,'2023-03-10 01:56:40',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(123,'2023-03-10 01:57:03',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(124,'2023-03-10 01:57:41',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(125,'2023-03-10 01:57:58',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(126,'2023-03-10 02:00:28',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(127,'2023-03-10 02:01:16',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(128,'2023-03-10 02:01:27',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(129,'2023-03-10 02:01:44',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(130,'2023-03-10 02:03:31',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(131,'2023-03-10 02:04:09',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(132,'2023-03-10 02:04:50',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(133,'2023-03-10 02:05:12',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(134,'2023-03-10 02:05:27',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(135,'2023-03-10 02:05:37',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(136,'2023-03-10 02:06:02',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(137,'2023-03-10 02:06:29',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(138,'2023-03-10 02:06:41',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(139,'2023-03-10 02:07:25',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(140,'2023-03-10 02:07:39',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(141,'2023-03-10 02:07:48',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(142,'2023-03-10 02:08:01',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(143,'2023-03-10 02:08:32',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(144,'2023-03-10 02:09:09',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(145,'2023-03-10 02:09:32',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(146,'2023-03-10 02:10:27',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(147,'2023-03-10 02:10:55',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(148,'2023-03-10 02:12:22',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(149,'2023-03-10 02:12:34',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(150,'2023-03-10 21:22:42',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(151,'2023-03-10 21:22:57',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(152,'2023-03-10 21:23:01',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(153,'2023-03-10 21:24:09',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE PROMOCION'),(154,'2023-03-10 21:24:28',1,2,'ELIMINAR','ELIMINACION DE PROMOCION'),(155,'2023-03-10 21:29:42',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(156,'2023-03-10 21:31:13',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(157,'2023-03-10 21:31:22',1,2,'ELIMINAR','ELIMINACION DE OBJETO'),(158,'2023-03-10 21:33:38',1,2,'INGRESO','INGRESO AL SISTEMA'),(159,'2023-03-10 21:33:56',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(160,'2023-03-10 21:34:05',1,2,'INGRESO','INGRESO AL MODULO OBJETOS'),(161,'2023-03-10 21:34:17',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE OBJETO'),(162,'2023-03-10 21:34:23',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE OBJETO'),(163,'2023-03-10 21:34:38',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE OBJETO'),(164,'2023-03-10 21:34:42',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE OBJETO'),(165,'2023-03-10 21:34:48',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE OBJETO'),(166,'2023-03-10 21:35:36',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(167,'2023-03-10 21:35:49',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(168,'2023-03-10 21:38:30',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(169,'2023-03-10 21:46:30',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(170,'2023-03-11 00:08:12',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(171,'2023-03-11 00:17:22',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(172,'2023-03-11 00:17:54',1,2,'INGRESO','INGRESO AL SISTEMA'),(173,'2023-03-11 00:18:13',1,2,'INGRESO','INGRESO AL SISTEMA'),(174,'2023-03-11 00:18:17',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(175,'2023-03-11 00:18:19',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(176,'2023-03-11 00:18:25',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(177,'2023-03-11 00:18:28',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(178,'2023-03-11 00:18:55',1,2,'INGRESO','INGRESO AL SISTEMA'),(179,'2023-03-11 00:22:10',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(180,'2023-03-11 00:22:13',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(181,'2023-03-11 00:22:19',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(182,'2023-03-11 00:22:37',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(183,'2023-03-11 00:22:42',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(184,'2023-03-11 00:23:25',1,2,'CREAR','CREACION DE USUARIO'),(185,'2023-03-11 00:29:57',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(186,'2023-03-11 00:30:16',1,2,'CREAR','CREACIÓN DE PARÁMETRO'),(187,'2023-03-11 00:30:26',1,2,'CREAR','CREACIÓN DE PARÁMETRO'),(188,'2023-03-11 00:30:47',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(189,'2023-03-11 00:31:16',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(190,'2023-03-11 00:31:39',1,2,'CREAR','CREACIÓN DE PARÁMETRO'),(191,'2023-03-11 00:31:45',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(192,'2023-03-11 00:31:49',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(193,'2023-03-11 00:33:43',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(194,'2023-03-11 00:54:45',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(195,'2023-03-11 00:56:53',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(196,'2023-03-11 00:59:27',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS'),(197,'2023-03-11 00:59:42',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(198,'2023-03-11 01:14:55',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(199,'2023-03-11 01:15:15',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(200,'2023-03-11 01:15:50',104,2,'INGRESO','INGRESO AL SISTEMA'),(201,'2023-03-11 01:15:59',1,2,'INGRESO','INGRESO AL SISTEMA'),(202,'2023-03-11 01:16:01',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(203,'2023-03-11 01:17:38',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(204,'2023-03-11 01:17:50',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(205,'2023-03-11 01:18:27',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(206,'2023-03-11 01:19:06',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(207,'2023-03-11 01:19:35',1,2,'CREAR','CREACION DE USUARIO'),(208,'2023-03-11 01:20:01',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(209,'2023-03-11 01:36:56',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(210,'2023-03-11 01:37:09',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(211,'2023-03-11 01:38:34',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(212,'2023-03-11 01:41:52',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(213,'2023-03-11 01:42:03',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(214,'2023-03-11 01:42:15',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(215,'2023-03-11 01:42:38',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(216,'2023-03-11 01:42:46',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(217,'2023-03-11 01:42:58',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(218,'2023-03-11 01:43:14',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(219,'2023-03-11 01:48:57',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(220,'2023-03-11 01:50:38',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(221,'2023-03-11 01:50:47',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(222,'2023-03-11 01:50:55',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(223,'2023-03-11 01:51:04',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(224,'2023-03-11 01:53:55',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(225,'2023-03-11 01:54:02',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(226,'2023-03-11 01:54:18',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(227,'2023-03-11 01:56:24',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(228,'2023-03-11 01:56:31',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(229,'2023-03-11 01:56:42',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(230,'2023-03-11 01:58:04',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(231,'2023-03-11 01:58:14',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(232,'2023-03-11 01:59:21',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(233,'2023-03-11 01:59:27',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(234,'2023-03-11 01:59:37',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(235,'2023-03-11 01:59:44',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(236,'2023-03-11 02:01:43',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(237,'2023-03-11 02:01:59',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(238,'2023-03-11 02:02:25',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(239,'2023-03-11 02:02:43',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(240,'2023-03-11 02:08:14',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(241,'2023-03-11 02:08:28',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(242,'2023-03-11 02:09:09',1,2,'CREAR','CREACION DE USUARIO'),(243,'2023-03-11 02:09:14',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(244,'2023-03-11 02:12:12',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(245,'2023-03-11 02:12:21',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(246,'2023-03-13 01:34:27',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(247,'2023-03-13 01:40:03',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(248,'2023-03-13 01:40:22',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(249,'2023-03-13 01:41:38',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(250,'2023-03-13 01:55:24',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(251,'2023-03-13 01:55:54',1,2,'CREAR','CREACION DE USUARIO'),(252,'2023-03-13 02:03:25',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(253,'2023-03-13 02:04:47',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(254,'2023-03-13 02:06:13',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(255,'2023-03-13 02:11:29',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(256,'2023-03-13 02:11:45',1,2,'CREAR','CREACION DE USUARIO'),(257,'2023-03-13 02:29:20',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(258,'2023-03-13 02:30:16',1,2,'CREAR','CREACION DE USUARIO'),(259,'2023-03-13 02:30:31',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(260,'2023-03-13 02:37:49',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(261,'2023-03-13 02:39:59',1,2,'CREAR','CREACION DE USUARIO'),(262,'2023-03-13 02:40:04',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(263,'2023-03-13 02:40:08',1,2,'ELIMINAR','ELIMINACION DE USUARIO'),(264,'2023-03-13 02:40:34',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(265,'2023-03-13 02:42:53',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(266,'2023-03-13 02:43:45',1,2,'INGRESO','INGRESO AL SISTEMA'),(267,'2023-03-13 02:43:47',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(268,'2023-03-13 02:44:11',1,2,'INGRESO','INGRESO AL SISTEMA'),(269,'2023-03-13 02:44:13',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(270,'2023-03-13 21:17:30',1,2,'INGRESO','INGRESO AL SISTEMA'),(271,'2023-03-13 21:19:42',1,2,'INGRESO','INGRESO AL MÓDULO PARÁMETROS');
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
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_objeto`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_objetos`
--

LOCK TABLES `tbl_ms_objetos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_objetos` DISABLE KEYS */;
INSERT INTO `tbl_ms_objetos` VALUES (1,'INICIO','DASHBOARD',1),(2,'USUARIOS','Usuarios del sistema',1),(4,'PRODUCTOS','Todos los productos',1),(10,'PROMOCION','Promociones',1),(11,'DESCUENTO','DESCUENTOS',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_parametros`
--

LOCK TABLES `tbl_ms_parametros` WRITE;
/*!40000 ALTER TABLE `tbl_ms_parametros` DISABLE KEYS */;
INSERT INTO `tbl_ms_parametros` VALUES (1,'ADMIN_INTENTOS','2',NULL,NULL,NULL,NULL),(2,'ADMIN_PREGUNTAS','2',NULL,NULL,NULL,NULL),(3,'ADMIN_CORREO','inversiones@gmail.com',NULL,NULL,NULL,NULL),(4,'FECHA_VENCIMIENTO','30',NULL,NULL,NULL,NULL),(7,'PRUEBA3','5','ADMIN','2023-03-11 00:30:16',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_permisos`
--

LOCK TABLES `tbl_ms_permisos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_permisos` DISABLE KEYS */;
INSERT INTO `tbl_ms_permisos` VALUES (3,1,1,1,1,1,1),(4,1,2,1,1,1,1),(6,1,4,1,1,1,1),(39,3,1,1,0,0,0),(40,3,2,1,0,0,0),(42,3,4,0,0,0,0),(93,11,1,1,0,0,0),(94,11,2,0,0,0,0),(96,11,4,0,0,0,0),(219,4,1,1,0,0,0),(220,4,2,1,1,1,1),(222,4,4,1,0,0,0),(223,21,1,1,1,1,1),(224,21,2,1,1,1,1),(226,21,4,1,0,0,0),(231,2,1,0,0,0,0),(232,2,2,0,0,0,0),(234,2,4,0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_preguntas`
--

LOCK TABLES `tbl_ms_preguntas` WRITE;
/*!40000 ALTER TABLE `tbl_ms_preguntas` DISABLE KEYS */;
INSERT INTO `tbl_ms_preguntas` VALUES (2,'CANCION FAVORITA');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_roles`
--

LOCK TABLES `tbl_ms_roles` WRITE;
/*!40000 ALTER TABLE `tbl_ms_roles` DISABLE KEYS */;
INSERT INTO `tbl_ms_roles` VALUES (1,'ADMINISTRADOR','Acceso a todo el sistema',1),(2,'DEFAULT','Rol por defecto',1),(3,'Clientes de todo','Clientes en general',0),(4,'VENDEDOR','Operador de tienda',1),(5,'prueba','fddfd',0),(6,'prueba2','gg',0),(7,'prueba33','d',0),(8,'prueba4','f',0),(9,'nuevo1','dch',0),(10,'prueba555','gggggg',0),(11,'Nuevo de prueba','sf',0),(12,'probar cambio','sddd',0),(13,'prueba44','f',0),(14,'prueba4446','d',0),(15,'Nueva Prueba','sssss',0),(16,'rrrr','rf',0),(17,'gu','f',0),(18,'fff','fffd',0),(19,'rrr','rr',0),(20,'j','j',0),(21,'www','www',0),(22,'CONTABILIDAD','rrr',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_usuarios`
--

LOCK TABLES `tbl_ms_usuarios` WRITE;
/*!40000 ALTER TABLE `tbl_ms_usuarios` DISABLE KEYS */;
INSERT INTO `tbl_ms_usuarios` VALUES (1,'ADMIN','ADMINISTRADOR',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,0,NULL,NULL,'admin@atlantico.com','266cafee87dc93ed5428-0031b4c55f3193cfb1fd-6b887d1aff7afd8a3fa1-921e9ca9462a1024d545',NULL,'2021-08-20 01:34:15','ADMIN','2023-03-13 02:40:34',1),(13,'ALEH5','ALEJANDROH',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,0,NULL,NULL,'elvinhf5@hotmail.com',NULL,NULL,'2023-02-03 14:42:54','ADMIN','2023-03-11 01:43:14',4),(19,'ELVINH5','ELVIN',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,0,NULL,NULL,'elvinh5@hotmail.com','8a6ffa8145b490b38163-61ba454e24c5211574de-e233d8e70eb04d5f39ef-18407f49e420ca7dc511',NULL,'2023-02-04 01:16:01','ADMIN','2023-03-11 02:12:21',4),(20,'ALE','ALE',4,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,0,NULL,NULL,'elvin0887@gmail.com','9e51311855727608fd48-f9a0d84c7b0e3a9b2f2c-7e067e1298a6a1514aca-eb0019e5463d6426d390',NULL,'2023-02-08 21:40:58','ADMIN','2023-03-07 00:44:16',2),(104,'ALEXA','ALEXA',2,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,2,NULL,NULL,'alexa@hotmail.com',NULL,'ADMIN','2023-03-08 15:22:09','ADMIN','2023-03-11 01:15:15',1),(106,'ROSI','ROSI',0,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,0,NULL,NULL,'rosi5@hotmail.com',NULL,'ADMIN','2023-03-10 01:24:20','ADMIN','2023-03-10 01:24:31',1),(109,'ALEX4','ALEX',4,'a8b6ebfda14bd0a8957cbe01dd5be337c7616a2e562629c030ee2b33e865606b',NULL,0,NULL,NULL,'alex4@hotmail.com',NULL,'ADMIN','2023-03-13 01:55:54',NULL,NULL,1);
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
  `existencia` int DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_usuario` int DEFAULT NULL,
  `estado` int DEFAULT '1',
  `foto` text,
  PRIMARY KEY (`cod_producto`),
  KEY `TBL_TIPO_PRODUCTO_COD_TIPO_PRODUCTO_idx` (`cod_tipo_producto`),
  CONSTRAINT `Producto_CodTipoProducto` FOREIGN KEY (`cod_tipo_producto`) REFERENCES `tbl_tipo_producto` (`cod_tipo_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_producto`
--

LOCK TABLES `tbl_producto` WRITE;
/*!40000 ALTER TABLE `tbl_producto` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_promocion`
--

LOCK TABLES `tbl_promocion` WRITE;
/*!40000 ALTER TABLE `tbl_promocion` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_resultado_produccion`
--

LOCK TABLES `tbl_resultado_produccion` WRITE;
/*!40000 ALTER TABLE `tbl_resultado_produccion` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_movimiento`
--

LOCK TABLES `tbl_tipo_movimiento` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_movimiento` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_producto`
--

LOCK TABLES `tbl_tipo_producto` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_producto` DISABLE KEYS */;
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

-- Dump completed on 2023-03-13 21:28:13