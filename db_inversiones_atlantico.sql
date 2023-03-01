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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `idcategoria` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `portada` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `datecreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ruta` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Hombre','Artículos de moda','img_125e45445bd33723d025d7f815ca29f7.jpg','2021-08-20 03:04:04','hombre',1),(2,'Audio y Videojuegos','Lo mejor en tecnología','img_78678a3fe95890d155115d5301e0761d.jpg','2021-08-21 00:47:10','audio-y-videojuegos',1);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagen`
--

DROP TABLE IF EXISTS `imagen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imagen` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `productoid` bigint NOT NULL,
  `img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productoid` (`productoid`),
  CONSTRAINT `imagen_ibfk_1` FOREIGN KEY (`productoid`) REFERENCES `producto` (`idproducto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagen`
--

LOCK TABLES `imagen` WRITE;
/*!40000 ALTER TABLE `imagen` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `idpedido` bigint NOT NULL AUTO_INCREMENT,
  `referenciacobro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `idtransaccionpaypal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `datospaypal` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci,
  `personaid` bigint NOT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `costo_envio` decimal(10,2) NOT NULL DEFAULT '0.00',
  `monto` decimal(11,2) NOT NULL,
  `tipopagoid` bigint NOT NULL,
  `direccion_envio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `estado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`idpedido`),
  KEY `personaid` (`personaid`),
  KEY `tipopagoid` (`tipopagoid`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`personaid`) REFERENCES `tbl_ms_usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`tipopagoid`) REFERENCES `tipopago` (`idtipopago`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_bitacora`
--

LOCK TABLES `tbl_ms_bitacora` WRITE;
/*!40000 ALTER TABLE `tbl_ms_bitacora` DISABLE KEYS */;
INSERT INTO `tbl_ms_bitacora` VALUES (1,'2023-02-22 00:42:29',1,2,'INSERCIÓN','INSERCIÓN DE USUARIO'),(2,'2023-02-22 00:42:59',1,2,'INSERCIÓN','INSERCIÓN DE USUARIO'),(3,'2023-02-22 00:49:56',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(4,'2023-02-22 00:50:03',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(5,'2023-02-22 00:56:53',1,2,'INSERCIÓN','INSERCIÓN DE USUARIO'),(6,'2023-02-22 00:57:38',19,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(7,'2023-02-22 01:29:13',19,2,'INSERCIÓN','INSERCIÓN DE USUARIO'),(8,'2023-02-22 01:29:31',19,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(9,'2023-02-22 01:36:04',19,2,'INSERCIÓN','INSERCIÓN DE USUARIO'),(10,'2023-02-22 01:51:17',19,2,'INSERCIÓN','INSERCIÓN DE USUARIO'),(11,'2023-02-22 01:52:00',19,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(12,'2023-02-22 01:52:08',19,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(13,'2023-02-22 01:55:29',19,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(14,'2023-02-22 01:55:36',19,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(15,'2023-02-22 01:55:43',19,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(16,'2023-02-22 18:04:17',1,2,'INSERCIÓN','INSERCIÓN DE USUARIO'),(17,'2023-02-23 23:20:41',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(18,'2023-02-23 23:26:48',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(19,'2023-02-23 23:28:26',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(20,'2023-02-23 23:37:55',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(21,'2023-02-23 23:38:04',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(22,'2023-02-23 23:38:11',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(23,'2023-02-23 23:38:16',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(24,'2023-02-23 23:38:31',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(25,'2023-02-23 23:38:38',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(26,'2023-02-23 23:39:28',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(27,'2023-02-23 23:48:25',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(28,'2023-02-23 23:48:50',68,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(29,'2023-02-25 16:07:54',1,2,'INSERCIÓN','INSERCIÓN DE USUARIO'),(30,'2023-02-25 16:36:50',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(31,'2023-02-28 00:12:13',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(32,'2023-02-28 00:49:35',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(33,'2023-02-28 00:50:00',1,2,'INSERCIÓN','INSERCIÓN DE USUARIO'),(34,'2023-02-28 00:50:10',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(35,'2023-02-28 22:17:37',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(36,'2023-02-28 22:18:06',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(37,'2023-02-28 22:19:37',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(38,'2023-02-28 22:20:53',1,2,'INSERCIÓN','INSERCIÓN DE USUARIO'),(39,'2023-02-28 22:36:44',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(40,'2023-02-28 22:39:25',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(41,'2023-02-28 23:54:06',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(42,'2023-02-28 23:54:21',1,2,'ACTUALIZACIÓN','ACTUALIZACIÓN DE USUARIO'),(43,'2023-02-28 23:57:31',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(44,'2023-03-01 01:13:37',19,2,'INGRESO','INGRESO AL SISTEMA'),(45,'2023-03-01 01:15:52',19,2,'INGRESO','INGRESO AL SISTEMA'),(46,'2023-03-01 01:23:52',1,2,'INGRESO','INGRESO AL SISTEMA'),(47,'2023-03-01 01:23:54',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(48,'2023-03-01 01:24:09',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(49,'2023-03-01 01:25:25',19,2,'INGRESO','INGRESO AL SISTEMA'),(50,'2023-03-01 01:26:37',19,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(51,'2023-03-01 01:28:50',1,2,'INGRESO','INGRESO AL SISTEMA'),(52,'2023-03-01 01:28:53',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(53,'2023-03-01 01:29:04',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(54,'2023-03-01 01:31:09',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(55,'2023-03-01 01:32:07',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(56,'2023-03-01 01:32:29',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(57,'2023-03-01 01:32:35',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(58,'2023-03-01 01:32:43',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(59,'2023-03-01 01:33:02',1,2,'INGRESO','INGRESO AL SISTEMA'),(60,'2023-03-01 01:33:04',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(61,'2023-03-01 01:33:17',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(62,'2023-03-01 01:33:49',1,2,'INGRESO','INGRESO AL MODULO DE ROLES'),(63,'2023-03-01 01:33:58',1,2,'INGRESO','INGRESO AL SISTEMA'),(64,'2023-03-01 01:34:03',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(65,'2023-03-01 01:34:56',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(66,'2023-03-01 01:35:01',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(67,'2023-03-01 01:36:42',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(68,'2023-03-01 01:36:48',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(69,'2023-03-01 01:37:58',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(70,'2023-03-01 01:38:07',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(71,'2023-03-01 01:39:36',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(72,'2023-03-01 09:35:43',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(73,'2023-03-01 09:41:48',19,2,'INGRESO','INGRESO AL SISTEMA'),(74,'2023-03-01 09:42:26',19,2,'INGRESO','INGRESO AL SISTEMA'),(75,'2023-03-01 09:45:55',19,2,'INGRESO','INGRESO AL SISTEMA'),(76,'2023-03-01 09:47:03',19,2,'INGRESO','INGRESO AL SISTEMA'),(77,'2023-03-01 09:52:23',19,2,'INGRESO','INGRESO AL SISTEMA'),(78,'2023-03-01 09:52:48',1,2,'INGRESO','INGRESO AL SISTEMA'),(79,'2023-03-01 09:52:50',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(80,'2023-03-01 09:53:09',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(81,'2023-03-01 09:53:37',19,2,'INGRESO','INGRESO AL SISTEMA'),(82,'2023-03-01 10:24:16',1,2,'INGRESO','INGRESO AL SISTEMA'),(83,'2023-03-01 10:24:17',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(84,'2023-03-01 10:25:50',1,2,'CREAR','CREACION DE USUARIO'),(85,'2023-03-01 10:26:35',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(86,'2023-03-01 10:30:33',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(87,'2023-03-01 10:31:27',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(88,'2023-03-01 10:31:42',1,2,'CREAR','CREACION DE USUARIO'),(89,'2023-03-01 10:32:23',1,2,'CREAR','CREACION DE USUARIO'),(90,'2023-03-01 10:33:10',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(91,'2023-03-01 10:35:38',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(92,'2023-03-01 10:38:14',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(93,'2023-03-01 10:53:31',19,2,'INGRESO','INGRESO AL SISTEMA'),(94,'2023-03-01 10:53:45',1,2,'INGRESO','INGRESO AL SISTEMA'),(95,'2023-03-01 10:54:23',1,2,'INGRESO','INGRESO AL SISTEMA'),(96,'2023-03-01 11:00:50',1,2,'INGRESO','INGRESO AL SISTEMA'),(97,'2023-03-01 11:13:43',1,2,'INGRESO','INGRESO AL SISTEMA'),(98,'2023-03-01 11:14:10',1,2,'INGRESO','INGRESO AL SISTEMA'),(99,'2023-03-01 11:24:08',1,2,'INGRESO','INGRESO AL SISTEMA'),(100,'2023-03-01 11:26:58',1,2,'INGRESO','INGRESO AL SISTEMA'),(101,'2023-03-01 11:28:52',1,2,'INGRESO','INGRESO AL SISTEMA'),(102,'2023-03-01 11:30:41',1,2,'INGRESO','INGRESO AL SISTEMA'),(103,'2023-03-01 11:35:36',19,2,'INGRESO','INGRESO AL SISTEMA'),(104,'2023-03-01 11:35:47',1,2,'INGRESO','INGRESO AL SISTEMA'),(105,'2023-03-01 12:18:23',1,2,'INGRESO','INGRESO AL SISTEMA'),(106,'2023-03-01 12:18:43',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(107,'2023-03-01 12:19:23',1,2,'CREAR','CREACION DE USUARIO'),(108,'2023-03-01 12:19:28',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(109,'2023-03-01 12:19:44',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(110,'2023-03-01 13:13:27',1,2,'INGRESO','INGRESO AL SISTEMA'),(111,'2023-03-01 13:13:30',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(112,'2023-03-01 13:13:53',1,2,'CREAR','CREACION DE USUARIO'),(113,'2023-03-01 13:14:19',1,2,'INGRESO','INGRESO AL SISTEMA'),(114,'2023-03-01 13:14:21',1,2,'INGRESO','INGRESO AL MODULO USUARIOS'),(115,'2023-03-01 13:14:34',1,2,'ACTUALIZAR','ACTUALIZACIÓN DE USUARIO'),(116,'2023-03-01 13:18:53',80,2,'INGRESO','INGRESO AL SISTEMA'),(117,'2023-03-01 13:21:39',1,2,'INGRESO','INGRESO AL SISTEMA'),(118,'2023-03-01 13:21:41',1,2,'INGRESO','INGRESO AL MODULO USUARIOS');
/*!40000 ALTER TABLE `tbl_ms_bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_estado`
--

DROP TABLE IF EXISTS `tbl_ms_estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_estado` (
  `id_estado` int NOT NULL AUTO_INCREMENT,
  `nombre_estado` varchar(45) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_estado`
--

LOCK TABLES `tbl_ms_estado` WRITE;
/*!40000 ALTER TABLE `tbl_ms_estado` DISABLE KEYS */;
INSERT INTO `tbl_ms_estado` VALUES (1,'NUEVO','NUEVO','ADMIN','2022-11-07','ADMIN','2022-11-07'),(2,'ACTIVO','ACTIVO','ADMIN','2022-11-07','ADMIN','2022-11-07'),(3,'INACTIVO','INACTIVO','ADMIN','2022-11-07','ADMIN','2022-11-07'),(4,'BLOQUEADO','BLOQUEADO','ADMIN','2022-11-07','ADMIN','2022-11-07'),(5,'RESETEO','RESETEO','ADMIN','2022-11-07','ADMIN','2022-11-07'),(6,'PENDIENTE','PENDIENTE','ADMIN','2022-11-07','ADMIN','2022-11-07');
/*!40000 ALTER TABLE `tbl_ms_estado` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_objetos`
--

LOCK TABLES `tbl_ms_objetos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_objetos` DISABLE KEYS */;
INSERT INTO `tbl_ms_objetos` VALUES (1,'INICIO','Dashboard',1),(2,'USUARIOS','Usuarios del sistema',1),(3,'CLIENTES','Clientes de tienda',1),(4,'PRODUCTOS','Todos los productos',1);
/*!40000 ALTER TABLE `tbl_ms_objetos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_parametros`
--

DROP TABLE IF EXISTS `tbl_ms_parametros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_parametros` (
  `id_parametro` int NOT NULL,
  `parametro` varchar(50) DEFAULT NULL,
  `valor` varchar(100) DEFAULT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_parametro`),
  KEY `parametros_idUsuario_idx` (`id_usuario`),
  CONSTRAINT `parametros_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_parametros`
--

LOCK TABLES `tbl_ms_parametros` WRITE;
/*!40000 ALTER TABLE `tbl_ms_parametros` DISABLE KEYS */;
INSERT INTO `tbl_ms_parametros` VALUES (1,'ADMIN_INTENTOS','3',1,'ADMIN','2022-11-07 00:00:00','ADMIN','2022-11-07 00:00:00'),(2,'ADMIN_PREGUTNAS','2',1,'ADMIN','2022-11-07 00:00:00','ADMIN','2022-11-07 00:00:00'),(3,'ADMIN_CORREO','admin@hotmail.com',1,'ADMIN','2022-11-07 00:00:00','ADMIN','2022-11-07 00:00:00'),(4,'FECHA_VENCIMIENTO','30',1,'ADMIN','2022-11-07 00:00:00','ADMIN','2022-11-07 00:00:00');
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
INSERT INTO `tbl_ms_permisos` VALUES (3,1,1,1,1,1,1),(4,1,2,1,1,1,1),(5,1,3,1,1,1,1),(6,1,4,1,1,1,1),(39,3,1,1,0,0,0),(40,3,2,1,0,0,0),(41,3,3,0,0,0,0),(42,3,4,0,0,0,0),(93,11,1,1,0,0,0),(94,11,2,0,0,0,0),(95,11,3,0,0,0,0),(96,11,4,0,0,0,0),(219,4,1,1,0,0,0),(220,4,2,1,1,1,1),(221,4,3,1,0,0,0),(222,4,4,1,0,0,0),(223,21,1,1,1,1,1),(224,21,2,1,1,1,1),(225,21,3,1,0,0,0),(226,21,4,1,0,0,0),(231,2,1,0,0,0,0),(232,2,2,0,0,0,0),(233,2,3,0,0,0,0),(234,2,4,0,0,0,0);
/*!40000 ALTER TABLE `tbl_ms_permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ms_preguntas`
--

DROP TABLE IF EXISTS `tbl_ms_preguntas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ms_preguntas` (
  `id_pregunta` int NOT NULL,
  `pregunta` varchar(100) DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_pregunta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_preguntas`
--

LOCK TABLES `tbl_ms_preguntas` WRITE;
/*!40000 ALTER TABLE `tbl_ms_preguntas` DISABLE KEYS */;
INSERT INTO `tbl_ms_preguntas` VALUES (1,'COMIDA FAVORITA',NULL,NULL,NULL,NULL),(2,'EQUIPO FAVORITO',NULL,NULL,NULL,NULL);
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
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  KEY `preguntaUsuario_idUsuario_idx` (`id_usuario`),
  KEY `preguntaUsuario_idPregunta_idx` (`id_pregunta`),
  CONSTRAINT `preguntaUsuario_idPregunta` FOREIGN KEY (`id_pregunta`) REFERENCES `tbl_ms_preguntas` (`id_pregunta`),
  CONSTRAINT `preguntaUsuario_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_preguntas_usuario`
--

LOCK TABLES `tbl_ms_preguntas_usuario` WRITE;
/*!40000 ALTER TABLE `tbl_ms_preguntas_usuario` DISABLE KEYS */;
INSERT INTO `tbl_ms_preguntas_usuario` VALUES (1,19,'PIZZA',NULL,NULL,NULL,NULL),(1,20,'PASTA',NULL,NULL,NULL,NULL),(1,50,'LASSAñA','BUSTILLO','2023-02-22 00:00:00','BUSTILLO','2023-02-22 00:00:00'),(1,51,'PIZZA','NOLASCO','2023-02-22 00:00:00','NOLASCO','2023-02-22 00:00:00'),(1,52,'PIZZA','CARLOS','2023-02-22 00:00:00','CARLOS','2023-02-22 00:00:00'),(1,53,'PIZZA','DAVID','2023-02-22 00:00:00','DAVID','2023-02-22 00:00:00'),(1,54,'PIZZA','FABIOLA','2023-02-22 00:00:00','FABIOLA','2023-02-22 00:00:00'),(1,55,'PIZZA','ORDOÑEZ','2023-02-22 00:00:00','ORDOÑEZ','2023-02-22 00:00:00'),(1,62,'BALEADAS','LIZZY','2023-02-23 00:00:00','LIZZY','2023-02-23 00:00:00'),(1,63,'POLLO','FANY','2023-02-24 00:00:00','FANY','2023-02-24 00:00:00'),(1,64,'POLLO','DAA','2023-02-25 00:00:00','DAA','2023-02-25 00:00:00'),(1,65,'FRIJOLES','TYPE R','2023-02-25 00:00:00','TYPE R','2023-02-25 00:00:00'),(1,72,'SOPA','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,1,'BARCA','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,20,'ROMA',NULL,NULL,NULL,NULL),(2,50,'BARCELONA','BUSTILLO','2023-02-22 00:00:00','BUSTILLO','2023-02-22 00:00:00'),(2,51,'LIVERPOOL','NOLASCO','2023-02-22 00:00:00','NOLASCO','2023-02-22 00:00:00'),(2,52,'BARCELONA','CARLOS','2023-02-22 00:00:00','CARLOS','2023-02-22 00:00:00'),(2,53,'BARCELONA','DAVID','2023-02-22 00:00:00','DAVID','2023-02-22 00:00:00'),(2,54,'BARCELONA','FABIOLA','2023-02-22 00:00:00','FABIOLA','2023-02-22 00:00:00'),(2,55,'BARCELONA','ORDOÑEZ','2023-02-22 00:00:00','ORDOÑEZ','2023-02-22 00:00:00'),(2,62,'MOTAGUA','LIZZY','2023-02-23 00:00:00','LIZZY','2023-02-23 00:00:00'),(2,63,'REAL MADRID','FANY','2023-02-24 00:00:00','FANY','2023-02-24 00:00:00'),(2,64,'MADRID','DAA','2023-02-25 00:00:00','DAA','2023-02-25 00:00:00'),(2,65,'MADRID','TYPE R','2023-02-25 00:00:00','TYPE R','2023-02-25 00:00:00'),(2,1,'NINGUNO','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,1,'FFFFFFFFF','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,1,'FFFFFFFFF','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,1,'FFFFFFFFF','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,1,'FFFFFFFFF','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,72,'NINGUNOOOOOO','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,72,'NINGUNOOOOO','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,72,'OTROOOOA','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,72,'OTROOOOA','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(1,72,'CARNE ASADA','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(1,72,'F','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(1,72,'CARNE','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(1,72,'CARRNE A','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(1,72,'F','TYPE R','2023-02-26 00:00:00','TYPE R','2023-02-26 00:00:00'),(2,73,'PROGRESO','FOLL','2023-02-27 00:00:00','FOLL','2023-02-27 00:00:00'),(1,73,'SOPA','FOLL','2023-02-27 00:00:00','FOLL','2023-02-27 00:00:00'),(1,72,'POLLO','FOLL','2023-02-27 00:00:00','FOLL','2023-02-27 00:00:00'),(1,72,'D','FOLL','2023-02-27 00:00:00','FOLL','2023-02-27 00:00:00'),(1,72,'EEE','MUESTRA','2023-03-01 00:00:00','MUESTRA','2023-03-01 00:00:00'),(2,72,'G','MUESTRA','2023-03-01 00:00:00','MUESTRA','2023-03-01 00:00:00'),(1,72,'POLLO','YOU','2023-03-01 00:00:00','YOU','2023-03-01 00:00:00'),(2,72,'MADRID','YOU','2023-03-01 00:00:00','YOU','2023-03-01 00:00:00'),(1,79,'CARNE','NUEVO','2023-03-01 00:00:00','NUEVO','2023-03-01 00:00:00'),(1,79,'CARNE','NUEVO','2023-03-01 00:00:00','NUEVO','2023-03-01 00:00:00'),(1,79,'CARNE','NUEVO','2023-03-01 00:00:00','NUEVO','2023-03-01 00:00:00'),(1,79,'CARNE','NUEVO','2023-03-01 00:00:00','NUEVO','2023-03-01 00:00:00'),(1,79,'CARNE','NUEVO','2023-03-01 00:00:00','NUEVO','2023-03-01 00:00:00'),(1,79,'CARNE','NUEVO','2023-03-01 00:00:00','NUEVO','2023-03-01 00:00:00'),(1,79,'CARNE','NUEVO','2023-03-01 00:00:00','NUEVO','2023-03-01 00:00:00'),(1,79,'CARNE','NUEVO','2023-03-01 00:00:00','NUEVO','2023-03-01 00:00:00'),(2,79,'POLLO','NUEVO','2023-03-01 00:00:00','NUEVO','2023-03-01 00:00:00'),(2,79,'POLLO','NUEVO','2023-03-01 00:00:00','NUEVO','2023-03-01 00:00:00'),(1,80,'POLLO','NUEVOA','2023-03-01 00:00:00','NUEVOA','2023-03-01 00:00:00'),(1,80,'POLLO','NUEVOA','2023-03-01 00:00:00','NUEVOA','2023-03-01 00:00:00'),(2,80,'MADRID','NUEVOA','2023-03-01 00:00:00','NUEVOA','2023-03-01 00:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_roles`
--

LOCK TABLES `tbl_ms_roles` WRITE;
/*!40000 ALTER TABLE `tbl_ms_roles` DISABLE KEYS */;
INSERT INTO `tbl_ms_roles` VALUES (1,'ADMINISTRADOR','Acceso a todo el sistema',1),(2,'DEFAULT','Rol por defecto',1),(3,'Clientes de todo','Clientes en general',0),(4,'VENDEDOR','Operador de tienda',1),(5,'prueba','fddfd',0),(6,'prueba2','gg',0),(7,'prueba33','d',0),(8,'prueba4','f',0),(9,'nuevo1','dch',0),(10,'prueba555','gggggg',0),(11,'Nuevo de prueba','sf',0),(12,'probar cambio','sddd',0),(13,'prueba44','f',0),(14,'prueba4446','d',0),(15,'Nueva Prueba','sssss',0),(16,'rrrr','rf',0),(17,'gu','f',0),(18,'fff','fffd',0),(19,'rrr','rr',0),(20,'j','j',0),(21,'www','www',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_usuarios`
--

LOCK TABLES `tbl_ms_usuarios` WRITE;
/*!40000 ALTER TABLE `tbl_ms_usuarios` DISABLE KEYS */;
INSERT INTO `tbl_ms_usuarios` VALUES (1,'ADMIN','ADMINISTRADOR',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,0,NULL,NULL,'admin@atlantico.com','266cafee87dc93ed5428-0031b4c55f3193cfb1fd-6b887d1aff7afd8a3fa1-921e9ca9462a1024d545',NULL,'2021-08-20 01:34:15',NULL,NULL,1),(9,'Adeleh5','Adele',0,'69f7f7a7f8bca9970fa6f9c0b8dad06901d3ef23fd599d3213aa5eee5621c3e3',NULL,0,NULL,NULL,'adele@abelosh.com',NULL,NULL,'2023-02-01 00:27:00',NULL,NULL,1),(10,'alec5','ALEX',0,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,0,NULL,NULL,'alexsa@info.com',NULL,NULL,'2023-02-02 16:00:03',NULL,NULL,1),(11,'Jane3','JANE',0,'49739492dc5974254dc222eb6bb5b554b018535e4541f2dc3e83748f3b270f22',NULL,1,NULL,NULL,'jane@abelosh.com',NULL,NULL,'2023-02-02 16:06:59',NULL,NULL,2),(12,'abril3','ABRIL',0,'8204ff70788a1e37b3e7c2a46273dbc4ab775811ef5b25c603e06961b36b4c27',NULL,0,NULL,NULL,'abril@gmail.com',NULL,NULL,'2023-02-03 14:32:01',NULL,NULL,1),(13,'ALEH5','ALEJANDROH',2,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,0,NULL,NULL,'elvinhf5@hotmail.com',NULL,NULL,'2023-02-03 14:42:54',NULL,NULL,4),(14,'Ju','JUU',0,'3d6603ec44170fc007a3da47d3f9786ecbc1c643a6c3ffe1b7d4400bddc5bcbb',NULL,0,NULL,NULL,'ju@gmail.com',NULL,NULL,'2023-02-03 16:34:45',NULL,NULL,1),(15,'Ceci88','CECI',0,'83c9bf55b354bf286eb3de2c5a8746ed8d0e36abf885b9b0ae38b7a19f4f7c89',NULL,0,NULL,NULL,'ceci@gmail.com',NULL,NULL,'2023-02-03 19:27:23',NULL,NULL,1),(16,'aaaaa','Ttttt',0,'342e489174cc8579d038ea97683b010fee86de2c274d2a2eafcb595b213e643f',NULL,0,NULL,NULL,'ssss7@gmail.com',NULL,NULL,'2023-02-03 20:41:40',NULL,NULL,1),(17,'Fercho','Fercho',0,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,0,NULL,NULL,'fernando@gmail.com',NULL,NULL,'2023-02-03 21:24:09',NULL,NULL,1),(18,'Dorca','Dorca',0,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,2,NULL,NULL,'dorca@hotmail.com',NULL,NULL,'2023-02-03 21:30:23',NULL,NULL,2),(19,'ELVINH5','ELVIN',0,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,0,NULL,NULL,'elvinh5@hotmail.com','8a6ffa8145b490b38163-61ba454e24c5211574de-e233d8e70eb04d5f39ef-18407f49e420ca7dc511',NULL,'2023-02-04 01:16:01','ADMIN','2023-03-01 09:53:09',4),(20,'ALE','ALE',1,'fcf3e61d45d82dffb8bf5e0d31ec1a37334624db53e4b08407b5606a04b38231',NULL,0,NULL,NULL,'elvin0887@gmail.com','9e51311855727608fd48-f9a0d84c7b0e3a9b2f2c-7e067e1298a6a1514aca-eb0019e5463d6426d390',NULL,'2023-02-08 21:40:58',NULL,NULL,2),(21,'qw','Qw',0,'0fd6f543370465bb32abad8ac9900f6bb701722f679d1d97ffadd3e2510aae62',NULL,3,NULL,NULL,'qw@hotmail.com',NULL,NULL,'2023-02-08 23:17:40',NULL,NULL,2),(22,'ADE','ADED',0,'af0b5428fa1e0d38065739829011806f326bf7c5681b3812c44211af78fa7603',NULL,1,NULL,NULL,'mass@abelosh.com',NULL,NULL,'2023-02-08 23:18:03','ADMIN','2023-02-23 23:38:31',2),(23,'ALONEE','ALONEE',0,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,3,NULL,NULL,'massa@hotmail.com',NULL,NULL,'2023-02-08 23:18:46',NULL,NULL,2),(24,'Saho55','SAHORI',0,'48b2a0cd162b9b54faea8cba0390483940e6703c8a24262250a7453543b60441',NULL,0,NULL,NULL,'sahori@hotmail.com',NULL,NULL,'2023-02-09 00:41:34',NULL,NULL,2),(25,'PRUEBA FC','PRUEBA FCD',1,'66886e1b55f3b9d8948acb817b12c17ac3ae140ccad502257cae7406b532f9d3',NULL,0,NULL,NULL,'prueba@hotmail.com',NULL,NULL,'2023-02-09 17:04:53','ADMIN','2023-02-23 23:38:11',1),(26,'suu','Suk',0,'769e77a0c3a3e456cb84123f79149712eb2bdde25c3211621a68dad32da3f8f8',NULL,0,NULL,NULL,'su@hotmail.com',NULL,NULL,'2023-02-09 18:18:46',NULL,NULL,2),(27,'as','Asss',0,'04cd9a6b2739f177c9df7ff28a6677b9558aec053bed84c94ff0236d0e1e84c7',NULL,2,NULL,NULL,'as@hotmail.com',NULL,NULL,'2023-02-09 18:24:19',NULL,NULL,4),(28,'ASD','ASD',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,NULL,NULL,'asd@hotmail.com','7ccf41618af15073d4ed-32ff530f6a50a22f4bf7-8a7dab6fece28ed262bd-1c4a28be8519a8021320',NULL,'2023-02-09 18:25:22','ADMIN','2023-02-23 23:38:38',1),(29,'cere','Cere',0,'d268cd824ce25650d48b36e7a6963be47340112273a7cbff237b14378ce2db14',NULL,0,NULL,NULL,'cew@hotmail.com','3aee43452c789205b518-b2cb4b2a47459cff2f26-f03eef0cfe57bbdda9c7-42966bd586b79f77e0de',NULL,'2023-02-09 19:01:01',NULL,NULL,1),(30,'Daisy','Daisy',0,'926a4fd7745492eea0f98da943b8cffd41cf142f9de112511d102c02a7744f50',NULL,2,NULL,NULL,'daisy@abelosh.com',NULL,NULL,'2023-02-09 19:08:02',NULL,NULL,1),(31,'Uno','Uno',0,'5668ae33067618802ff2d024204a22ba9d882aef1843d3f4100160aa19ab9f5c',NULL,2,NULL,NULL,'unoh5@hotmail.com',NULL,NULL,'2023-02-09 19:51:28',NULL,NULL,4),(32,'we','We',0,'e96e9d9a0d182e34f6c518ca14eeed631ccbfab5580928720555291aeaa2d8e6',NULL,2,NULL,NULL,'we@abelosh.com',NULL,NULL,'2023-02-11 18:31:46',NULL,NULL,1),(33,'wq','Wq',0,'37eca6bf3ce51266895e8e275635b6470be34cc219edc6a8d14e5a0f30745a10',NULL,0,NULL,NULL,'wq@hotmail.com',NULL,NULL,'2023-02-11 18:32:31',NULL,NULL,1),(34,'re','Re',0,'6880d2cec00d68b2c357013f40a7679ca582db55952ae833fd5c3d1ae60b0169',NULL,0,NULL,NULL,'re5@hotmail.com',NULL,NULL,'2023-02-11 18:35:31',NULL,NULL,1),(35,'SA','SA',0,'dce5f61936bbaf3019645ca34e2151f423bcaebd4df1ea2ed8dcfabdacf70d10',NULL,0,NULL,NULL,'sa5@hotmail.com','6eef4ef8fcdaba6c928e-1cf891eed8120ddf8169-3c00cc396788a5d2461a-38b52ae07e6b8de052c9',NULL,'2023-02-11 18:36:13','ADMIN','2023-02-23 23:38:04',1),(36,'jun','Jun',0,'f4cac02d6d1ad5a258a53b1f13f966c368a96a40d5081dcaca3596d288e4b397',NULL,0,NULL,NULL,'ju@abelosh.com',NULL,NULL,'2023-02-11 18:45:03',NULL,NULL,2),(37,'Nami','Nami',2,'62375cb09a79f912c17f90004ad248a86eb39ea1da15a3fcbc2982489e4063b9',NULL,1,NULL,NULL,'nam@hotmail.com',NULL,NULL,'2023-02-11 18:51:37',NULL,NULL,1),(38,'LOOK','LOOk',0,'29e3511a65143941d4a4bcff650a0b2c976576ced78937772555765a47cf50dc',NULL,0,NULL,NULL,'loo5@hotmail.com',NULL,NULL,'2023-02-12 00:48:06',NULL,NULL,4),(39,'JENNIE','JENNn',2,'d823eb978cbb48c49017f1d320ecaf50568f1f9c1e49f46ae314c8bc8f9be236',NULL,0,NULL,NULL,'jen@abelosh.com',NULL,NULL,'2023-02-12 01:52:15',NULL,NULL,2),(40,'fg','Fg',3,'2b0ae197d3c9cab927f1e9ea4395b6c7170d58d2b886d05eb225a6e8cbac736f',NULL,0,NULL,NULL,'fg@abelosh.com',NULL,NULL,'2023-02-14 20:29:23',NULL,NULL,2),(41,'QWWWW','QWWWW',1,'4c6bd6498fc26f7de6edb89bc4e9cb9942659bdeec0ec5ad55c6c39015ab5068',NULL,0,NULL,NULL,'iqwww@abelosh.com',NULL,NULL,'2023-02-14 20:35:39','ADMIN','2023-02-23 23:38:16',1),(42,'ALEJANDROH5','ALEJANDRO',0,'481f6cc0511143ccdd7e2d1b1b94faf0a700a8b49cd13922a70b5ae28acaa8c5',NULL,0,NULL,NULL,'alejandro@hotmail.com',NULL,NULL,'2023-02-15 12:50:12',NULL,NULL,2),(43,'TT','TTTGAA',0,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,0,NULL,NULL,'tt@hotmail.com','f173c39eef558075874e-707d7cca15f39caafe80-5d2f4cee0e4c531d9262-1346f55743e9abbbeefc',NULL,'2023-02-15 23:35:40','ADMIN','2023-02-23 23:28:26',2),(44,'li','Li',0,'0a2d3bc8fa0d2094b65b9f57adb7c6f766af0c552971fd780bea9e7210bb8124',NULL,0,NULL,NULL,'li@hotmail.com',NULL,NULL,'2023-02-15 23:38:00',NULL,NULL,4),(45,'ENRIQUE','HECTOR ENRIQUE BUSTILLO NOLASCO',3,'$2y$10$ghP0wA5x76bsLupWqBe9p.X13lpP5RbIoBgmJZOLttvt4mrSYkQsy','2023-02-21 00:00:00',0,0,'2023-03-23 00:00:00','hectorjrbuno1111@gmail.com','asdad','ENRIQUE','2023-02-21 00:00:00','ENRIQUE','2023-02-21 00:00:00',2),(46,'','',0,'$2y$10$PB0tfwS5DApqzVmXaFt//.9eIP3FCTpYEybxavuzB2ydkL4kR.966','2023-02-22 00:00:00',0,0,'2023-03-24 00:00:00','','asdad','','2023-02-22 00:00:00','','2023-02-22 00:00:00',2),(47,'FERNANDO','FERNANDO',3,'$2y$10$B4yMkX4odfvo4HF9mCxzJeB20N4Q3zpqPusM9Tinji2NiaDEoLl56','2023-02-22 00:00:00',0,0,'2023-03-24 00:00:00','hbustillo@unah.hn','asdad','FERNANDO','2023-02-22 00:00:00','FERNANDO','2023-02-22 00:00:00',2),(48,'ERICKA','ERIKA AYALA',3,'$2y$10$lEkHWPunMaGsMq7Q6ha.0.n2tX80C4TJOWB32TMg.HjIJJWXxsHci','2023-02-22 00:00:00',0,0,'2023-03-24 00:00:00','erica@unah.hn','asdad','ERICKA','2023-02-22 00:00:00','ERICKA','2023-02-22 00:00:00',2),(49,'HECTOR','HECTOR ENRIQUE BUSTILLO NOLASCO',3,'$2y$10$ERxWNL895fzPOgICRY.F.u0z.oZl8.tpxKSk1VCCN..MUcD/d2aw6','2023-02-22 00:00:00',0,0,'2023-03-24 00:00:00','hbueasstillo@unah.hn','asdad','HECTOR','2023-02-22 00:00:00','HECTOR','2023-02-22 00:00:00',2),(50,'BUSTILLO','HECTOR ENRIQUE BUSTILLO NOLASCO',3,'$2y$10$kLWxzLik1xy2UzHIVcTWVe7h6NUKRoceXOQWH9uePkLXAyB3MnhxW','2023-02-22 00:00:00',2,0,'2023-03-24 00:00:00','hectorjrbuno1asdad111@gmail.com','asdad','BUSTILLO','2023-02-22 00:00:00','BUSTILLO','2023-02-22 00:00:00',2),(51,'NOLASCO','HECTOR ENRIQUE BUSTILLO NOLASCO',3,'$2y$10$WjPa/DUrXM1hjI7TZrMRge9MR8lAK3KOCll.rmn3.bP5BAGGxiwCK','2023-02-22 00:00:00',2,0,'2023-03-24 00:00:00','headsdactorjrbuno1111@gmail.com','asdad','NOLASCO','2023-02-22 00:00:00','NOLASCO','2023-02-22 00:00:00',2),(52,'CARLOS','CARLOS COLINDRES',3,'$2y$10$W2.OKU3U9UoTDTfur3/L2OQP4gF9jn84Uh/U.IVmIbfLMCUX6uNfO','2023-02-22 00:00:00',2,0,'2023-03-24 00:00:00','hectorjrbuasdasdano1111@gmail.com','asdad','CARLOS','2023-02-22 00:00:00','CARLOS','2023-02-22 00:00:00',2),(53,'DAVID','CARLOS DAVID',3,'$2y$10$7LeZz93ecMWwve8II4JORezlZeOicLXqSD9bu8anOhS2Hg1yJzSpK','2023-02-22 00:00:00',2,0,'2023-03-24 00:00:00','hectorjrbdasdauno1111@gmail.com','asdad','DAVID','2023-02-22 00:00:00','DAVID','2023-02-22 00:00:00',2),(54,'FABIOLA','ERICA FABIOLA',3,'$2y$10$wLGi/X.KREsAtVMcGY.DpugC2BfT7EEWWNqSYae2oSZeiG/GoM9Ji','2023-02-22 00:00:00',2,0,'2023-03-24 00:00:00','sadasdahectorjrbuno1111@gmail.com','asdad','FABIOLA','2023-02-22 00:00:00','FABIOLA','2023-02-22 00:00:00',2),(55,'ORDOÑEZ','FABIOLA ORDOñEZ',3,'$2y$10$ozB4.vzcIR1gIUDn4ZB4JurduvX7.UH2legjSIR5OmdQ.xXeiPqrm','2023-02-22 00:00:00',2,0,'2023-03-24 00:00:00','asdasdad3hectorjrbuno1111@gmail.com','asdad','ORDOÑEZ','2023-02-22 00:00:00','ORDOÑEZ','2023-02-22 00:00:00',2),(56,'GENESIS','GENESIS CARCAMO',3,'$2y$10$2IJexIuTHI30.Lv0i.Knc.3WVmgZdx/y3oaldaq1Jua1BmMegpHC2','2023-02-22 00:00:00',0,0,'2023-03-24 00:00:00','hectorjrbuno1adadaq111@gmail.com','asdad','GENESIS','2023-02-22 00:00:00','GENESIS','2023-02-22 00:00:00',2),(57,'MARIA','MARIA AVALOS',3,'$2y$10$AggP40nYnoniTRYcC9EQYeaUjgMKWCpRKmSDBLmAIcFd2DT09ZxJi','2023-02-22 00:00:00',0,0,'2023-03-24 00:00:00','hectorjrbunasda2o1111@gmail.com','asdad','MARIA','2023-02-22 00:00:00','MARIA','2023-02-22 00:00:00',2),(58,'EDWIN','EDWIN MONTOYA',3,'$2y$10$2zxlwGWkx6295C9qYTUlyemtgMxQbC/rXIsNfvHlf672Oh2NA2unG','2023-02-22 00:00:00',0,0,'2023-03-24 00:00:00','hectorjrbunoFSFASDA1111@gmail.com','asdad','EDWIN','2023-02-22 00:00:00','EDWIN','2023-02-22 00:00:00',2),(59,'SOANY','SOANY ACOSTA',3,'$2y$10$RdWYC934wdYMIqzOZ.J.eenu7IeGDdlNo/JEC0avum.krWhYdr81S','2023-02-22 00:00:00',0,0,'2023-03-24 00:00:00','hectorjrbuno1asdada111@gmail.com','asdad','SOANY','2023-02-22 00:00:00','SOANY','2023-02-22 00:00:00',2),(60,'MONTOYA','EDWIN MONTOYA',1,'$2y$10$Sv57Oi5sllFzYnTEU2IXyuGZrzFYAvt7UfK7L4WFgrSbptB7PUUCq','2023-02-22 00:00:00',0,0,'2023-03-24 00:00:00','hbueassasdatillo@unah.hn','asdad','MONTOYA','2023-02-22 00:00:00','MONTOYA','2023-02-22 00:00:00',2),(61,'JEANINE','JEANINE OBANDO',1,'$2y$10$F7mne8/WpD5zzoFx/EWOHuVQ.DEcoxsZIKSV8oERW9zsudjoyqKNy','2023-02-22 00:00:00',0,0,'2023-03-24 00:00:00','asdasdadhectorjrbuno1111@gmail.com','','JEANINE','2023-02-22 00:00:00','JEANINE','2023-02-22 00:00:00',2),(62,'LIZZY','LIZZT ARIANA',1,'6cec4cae61b0e91171d11dae96be3245f904aaa05aa64e4753c91520cc7cbf11','2023-02-22 00:00:00',2,0,'2023-03-24 00:00:00','hectorjrbuno111asdadeqr1@gmail.com','asdad','LIZZY','2023-02-22 00:00:00','LIZZY','2023-02-22 00:00:00',2),(63,'FANY','FANY',3,'e052a8adb2482d1b39512d6eeb06a5eeb624d57b98d7acca4fa2dc6cb6c1669f',NULL,2,NULL,NULL,'fany@hotmail.com',NULL,'ADMIN','2023-02-22 00:42:59',NULL,NULL,1),(64,'DAA','DAA',1,'52836f30c5e0dd10a12ff61fa2409f2e1a260e1dc76af086c48893029028386d',NULL,4,NULL,NULL,'daa@hotmail.com',NULL,'ADMIN','2023-02-22 00:56:53','ELVINH5','2023-02-22 00:57:38',2),(65,'TYPE R','TYPEG',3,'b23c9c8a296176c9c506682f1f843b49e4383268d94330d6a5d69914f119e13b',NULL,2,NULL,NULL,'type@hotmail.com',NULL,'ELVINH5','2023-02-22 01:29:13','ELVINH5','2023-02-22 01:29:31',2),(66,'FOLL','FOLL',3,'5185595257e752a611a8918216d440673935fc7e9661f217616df017f898889d',NULL,2,NULL,NULL,'foll@hotmail.com',NULL,'ELVINH5','2023-02-22 01:36:04',NULL,NULL,2),(67,'MUESTRA','MUESTRAAEF',3,'2e415c8f1ff729b5578b0fbffd858d2aa1ac3146104efece1d1c224108a775dd',NULL,2,NULL,NULL,'muestra@hotmail.com',NULL,'ELVINH5','2023-02-22 01:51:17','ELVINH5','2023-02-22 01:55:43',2),(68,'YOU','YOUU',2,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,2,NULL,NULL,'you@hotmail.com',NULL,'ADMIN','2023-02-22 18:04:17','ADMIN','2023-02-23 23:48:25',1),(69,'YOO','YOOJU',0,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','2023-02-23 00:00:00',0,0,'2023-03-25 00:00:00','yoo@hotmail.com','asdad','YOO','2023-02-23 00:00:00','ADMIN','2023-02-25 16:36:50',2),(70,'FELT','FELT',2,'995e3dc279158bcff1008a21ffd9b1a138de6b313271c0b37c452803b1a42693','2023-02-24 00:00:00',0,0,'2023-03-26 00:00:00','felt@hotmail.com','asdad','FELT','2023-02-24 00:00:00','FELT','2023-02-24 00:00:00',2),(71,'MUNDO','MUNDO',3,'155264d9df877ba050f1c9d65e982a16cfc017c9739b4ce5049d50c127e0e574','2023-02-25 00:00:00',0,0,'2023-03-27 00:00:00','mundo@gmail.com','asdad','MUNDO','2023-02-25 00:00:00','MUNDO','2023-02-25 00:00:00',2),(72,'NUEVO','NUEVO EJEMPLO',3,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,NULL,NULL,'nuevo_ejemplo@hotmail.com',NULL,'ADMIN','2023-02-25 16:07:54',NULL,NULL,1),(73,'NUEVOA','NUEVOA',3,'995e3dc279158bcff1008a21ffd9b1a138de6b313271c0b37c452803b1a42693','2023-02-27 00:00:00',0,0,'2023-03-29 00:00:00','nuevoa@hotmail.com','asdad','NUEVOA','2023-02-27 00:00:00','NUEVOA','2023-02-27 00:00:00',2),(74,'VER','VER',1,'3b612c75a7b5048a435fb6ec81e52ff92d6d795a8b5a9c17070f6a63c97a53b2',NULL,0,NULL,NULL,'ver@hotmail.com',NULL,'ADMIN','2023-02-28 00:50:00','ADMIN','2023-02-28 00:50:10',1),(75,'ERIKA','ERIKA',3,'e0714fa225714e6fcc25fe1658ffbab2d5cbaf43be6c02813f4917fdc71fcbda',NULL,0,NULL,NULL,'erika@hotmail.com',NULL,'ADMIN','2023-02-28 22:20:53',NULL,NULL,1),(76,'JORGE4','JPRGE',3,'73c9bdaa4382a7561bcb19c1b22ed28c54cafc55b68f9b6fa84e84c8d97df098',NULL,0,NULL,NULL,'jorge@hotmail.com',NULL,'ADMIN','2023-03-01 10:25:50',NULL,NULL,1),(77,'DD4','DD D',3,'62ca19278a4e43f54e70c321841f2fcd8cfbbde96a6fa02fda3156e0a776008a',NULL,0,NULL,NULL,'dddd5@hotmail.com',NULL,'ADMIN','2023-03-01 10:31:42',NULL,NULL,1),(78,'SADDD F','DAISYI L',3,'6b3b14e4673fdb5ed6508de8fc566057bd93547e49c9027de4f22cd46e84da0a',NULL,0,NULL,NULL,'da@hotmail.com',NULL,'ADMIN','2023-03-01 10:32:23',NULL,NULL,1),(79,'NUEVO2','NUEVODOS',3,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,2,NULL,NULL,'nuevo2@hotmail.com',NULL,'ADMIN','2023-03-01 12:19:23','ADMIN','2023-03-01 12:19:44',1),(80,'NUEVO3','NUEVOTRES',1,'3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c',NULL,2,NULL,NULL,'nuevo3@hotmail.com',NULL,'ADMIN','2023-03-01 13:13:53','ADMIN','2023-03-01 13:14:34',1);
/*!40000 ALTER TABLE `tbl_ms_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipopago`
--

DROP TABLE IF EXISTS `tipopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipopago` (
  `idtipopago` bigint NOT NULL AUTO_INCREMENT,
  `tipopago` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`idtipopago`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipopago`
--

LOCK TABLES `tipopago` WRITE;
/*!40000 ALTER TABLE `tipopago` DISABLE KEYS */;
INSERT INTO `tipopago` VALUES (1,'PayPal',1),(2,'Efectivo',1),(3,'Tarjeta',1),(4,'Cheque',1),(5,'Despósito Bancario',1);
/*!40000 ALTER TABLE `tipopago` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-01 13:24:11