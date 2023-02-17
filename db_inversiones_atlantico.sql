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
  `id_bitacora` int NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_bitacora`
--

LOCK TABLES `tbl_ms_bitacora` WRITE;
/*!40000 ALTER TABLE `tbl_ms_bitacora` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_objetos`
--

LOCK TABLES `tbl_ms_objetos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_objetos` DISABLE KEYS */;
INSERT INTO `tbl_ms_objetos` VALUES (1,'Dashboard','Dashboard',1),(2,'Usuarios','Usuarios del sistema',1),(3,'Clientes','Clientes de tienda',1),(4,'Productos','Todos los productos',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_permisos`
--

LOCK TABLES `tbl_ms_permisos` WRITE;
/*!40000 ALTER TABLE `tbl_ms_permisos` DISABLE KEYS */;
INSERT INTO `tbl_ms_permisos` VALUES (3,1,1,1,1,1,1),(4,1,2,1,1,1,1),(5,1,3,1,1,1,1),(6,1,4,1,1,1,1),(39,3,1,1,0,0,0),(40,3,2,1,0,0,0),(41,3,3,0,0,0,0),(42,3,4,0,0,0,0),(93,11,1,1,0,0,0),(94,11,2,0,0,0,0),(95,11,3,0,0,0,0),(96,11,4,0,0,0,0),(171,2,1,1,1,1,1),(172,2,2,1,1,1,1),(173,2,3,1,1,1,0),(174,2,4,1,1,1,1),(195,21,1,1,1,1,1),(196,21,2,1,1,1,1),(197,21,3,1,0,0,0),(198,21,4,1,0,0,0),(219,4,1,1,0,0,0),(220,4,2,1,1,1,1),(221,4,3,1,0,0,0),(222,4,4,1,0,0,0);
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
  PRIMARY KEY (`id_pregunta`,`id_usuario`),
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
INSERT INTO `tbl_ms_preguntas_usuario` VALUES (1,19,'POLLO',NULL,NULL,NULL,NULL);
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
INSERT INTO `tbl_ms_roles` VALUES (1,'Administrador','Acceso a todo el sistema',1),(2,'Supervisor','Supervisor de materiales',1),(3,'Clientes de todo','Clientes en general',0),(4,'Vendedor','Operador de tienda',1),(5,'prueba','fddfd',0),(6,'prueba2','gg',0),(7,'prueba33','d',0),(8,'prueba4','f',0),(9,'nuevo1','dch',0),(10,'prueba555','gggggg',0),(11,'Nuevo de prueba','sf',0),(12,'probar cambio','sddd',0),(13,'prueba44','f',0),(14,'prueba4446','d',0),(15,'Nueva Prueba','sssss',0),(16,'rrrr','rf',0),(17,'gu','f',0),(18,'fff','fffd',0),(19,'rrr','rr',0),(20,'j','j',0),(21,'www','www',1);
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
  `id_rol` bigint NOT NULL,
  `fecha_ultima_conexion` datetime DEFAULT NULL,
  `preguntas_contestadas` bigint DEFAULT '0',
  `primer_ingreso` datetime DEFAULT NULL,
  `fecha_vencimiento` datetime DEFAULT NULL,
  `correo_electronico` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `creado_por` varchar(15) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(15) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `rolid` (`id_rol`),
  CONSTRAINT `tbl_ms_usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tbl_ms_roles` (`id_rol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ms_usuarios`
--

LOCK TABLES `tbl_ms_usuarios` WRITE;
/*!40000 ALTER TABLE `tbl_ms_usuarios` DISABLE KEYS */;
INSERT INTO `tbl_ms_usuarios` VALUES (1,'ADMIN','ADMINISTRADOR',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',1,NULL,0,NULL,NULL,'admin@atlantico.com','266cafee87dc93ed5428-0031b4c55f3193cfb1fd-6b887d1aff7afd8a3fa1-921e9ca9462a1024d545',NULL,'2021-08-20 01:34:15',NULL,NULL),(9,'Adeleh5','Adele',0,'69f7f7a7f8bca9970fa6f9c0b8dad06901d3ef23fd599d3213aa5eee5621c3e3',1,NULL,0,NULL,NULL,'adele@abelosh.com',NULL,NULL,'2023-02-01 00:27:00',NULL,NULL),(10,'alec5','ALEX',0,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',1,NULL,0,NULL,NULL,'alexsa@info.com',NULL,NULL,'2023-02-02 16:00:03',NULL,NULL),(11,'Jane3','JANE',0,'49739492dc5974254dc222eb6bb5b554b018535e4541f2dc3e83748f3b270f22',2,NULL,1,NULL,NULL,'jane@abelosh.com',NULL,NULL,'2023-02-02 16:06:59',NULL,NULL),(12,'abril3','ABRIL',0,'8204ff70788a1e37b3e7c2a46273dbc4ab775811ef5b25c603e06961b36b4c27',1,NULL,0,NULL,NULL,'abril@gmail.com',NULL,NULL,'2023-02-03 14:32:01',NULL,NULL),(13,'ALEH5','ALEJANDROH',2,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',4,NULL,0,NULL,NULL,'elvinhf5@hotmail.com',NULL,NULL,'2023-02-03 14:42:54',NULL,NULL),(14,'Ju','JUU',0,'3d6603ec44170fc007a3da47d3f9786ecbc1c643a6c3ffe1b7d4400bddc5bcbb',1,NULL,0,NULL,NULL,'ju@gmail.com',NULL,NULL,'2023-02-03 16:34:45',NULL,NULL),(15,'Ceci88','CECI',0,'83c9bf55b354bf286eb3de2c5a8746ed8d0e36abf885b9b0ae38b7a19f4f7c89',1,NULL,0,NULL,NULL,'ceci@gmail.com',NULL,NULL,'2023-02-03 19:27:23',NULL,NULL),(16,'aaaaa','Ttttt',0,'342e489174cc8579d038ea97683b010fee86de2c274d2a2eafcb595b213e643f',1,NULL,0,NULL,NULL,'ssss7@gmail.com',NULL,NULL,'2023-02-03 20:41:40',NULL,NULL),(17,'Fercho','Fercho',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',1,NULL,0,NULL,NULL,'fernando@gmail.com',NULL,NULL,'2023-02-03 21:24:09',NULL,NULL),(18,'Dorca','Dorca',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',2,NULL,2,NULL,NULL,'dorca@hotmail.com',NULL,NULL,'2023-02-03 21:30:23',NULL,NULL),(19,'ELVINH5','ELVIN',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',4,NULL,0,NULL,NULL,'elvinh5@hotmail.com','cec4cd0f470ad227819f-3c78e7c4b5b321fab0ce-02f34e8cb9d8ff58093e-3c73360ea6a4e910ef3b',NULL,'2023-02-04 01:16:01',NULL,NULL),(20,'aaa','Aaa',1,'b62c87b22514971a4954215024aef575d2b07533f78896e25dd1e1bf6a2a4c3f',2,NULL,0,NULL,NULL,'elvin0887@gmail.com','71c0005f73efb0132bed-396c655395dc4de24ab1-2d197ab92d73b5447114-82f2c6cbb1457b87e45b',NULL,'2023-02-08 21:40:58',NULL,NULL),(21,'qw','Qw',0,'0fd6f543370465bb32abad8ac9900f6bb701722f679d1d97ffadd3e2510aae62',2,NULL,3,NULL,NULL,'qw@hotmail.com',NULL,NULL,'2023-02-08 23:17:40',NULL,NULL),(22,'Ade','Aded',1,'af0b5428fa1e0d38065739829011806f326bf7c5681b3812c44211af78fa7603',2,NULL,1,NULL,NULL,'mass@abelosh.com',NULL,NULL,'2023-02-08 23:18:03',NULL,NULL),(23,'ALONEE','ALONEE',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',2,NULL,3,NULL,NULL,'massa@hotmail.com',NULL,NULL,'2023-02-08 23:18:46',NULL,NULL),(24,'Saho55','SAHORI',0,'48b2a0cd162b9b54faea8cba0390483940e6703c8a24262250a7453543b60441',2,NULL,0,NULL,NULL,'sahori@hotmail.com',NULL,NULL,'2023-02-09 00:41:34',NULL,NULL),(25,'Prueba FC','Prueba FCD',1,'66886e1b55f3b9d8948acb817b12c17ac3ae140ccad502257cae7406b532f9d3',1,NULL,0,NULL,NULL,'prueba@hotmail.com',NULL,NULL,'2023-02-09 17:04:53',NULL,NULL),(26,'suu','Suk',0,'769e77a0c3a3e456cb84123f79149712eb2bdde25c3211621a68dad32da3f8f8',2,NULL,0,NULL,NULL,'su@hotmail.com',NULL,NULL,'2023-02-09 18:18:46',NULL,NULL),(27,'as','Asss',0,'04cd9a6b2739f177c9df7ff28a6677b9558aec053bed84c94ff0236d0e1e84c7',4,NULL,2,NULL,NULL,'as@hotmail.com',NULL,NULL,'2023-02-09 18:24:19',NULL,NULL),(28,'asd','Asd',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',1,NULL,1,NULL,NULL,'asd@hotmail.com',NULL,NULL,'2023-02-09 18:25:22',NULL,NULL),(29,'cere','Cere',1,'d268cd824ce25650d48b36e7a6963be47340112273a7cbff237b14378ce2db14',1,NULL,0,NULL,NULL,'cew@hotmail.com',NULL,NULL,'2023-02-09 19:01:01',NULL,NULL),(30,'Daisy','Daisy',2,'926a4fd7745492eea0f98da943b8cffd41cf142f9de112511d102c02a7744f50',1,NULL,2,NULL,NULL,'daisy@abelosh.com',NULL,NULL,'2023-02-09 19:08:02',NULL,NULL),(31,'Uno','Uno',0,'5668ae33067618802ff2d024204a22ba9d882aef1843d3f4100160aa19ab9f5c',4,NULL,2,NULL,NULL,'unoh5@hotmail.com',NULL,NULL,'2023-02-09 19:51:28',NULL,NULL),(32,'we','We',0,'e96e9d9a0d182e34f6c518ca14eeed631ccbfab5580928720555291aeaa2d8e6',1,NULL,2,NULL,NULL,'we@abelosh.com',NULL,NULL,'2023-02-11 18:31:46',NULL,NULL),(33,'wq','Wq',0,'37eca6bf3ce51266895e8e275635b6470be34cc219edc6a8d14e5a0f30745a10',1,NULL,0,NULL,NULL,'wq@hotmail.com',NULL,NULL,'2023-02-11 18:32:31',NULL,NULL),(34,'re','Re',0,'6880d2cec00d68b2c357013f40a7679ca582db55952ae833fd5c3d1ae60b0169',1,NULL,0,NULL,NULL,'re5@hotmail.com',NULL,NULL,'2023-02-11 18:35:31',NULL,NULL),(35,'sa','Sa',3,'dce5f61936bbaf3019645ca34e2151f423bcaebd4df1ea2ed8dcfabdacf70d10',1,NULL,0,NULL,NULL,'sa5@hotmail.com',NULL,NULL,'2023-02-11 18:36:13',NULL,NULL),(36,'jun','Jun',0,'f4cac02d6d1ad5a258a53b1f13f966c368a96a40d5081dcaca3596d288e4b397',2,NULL,0,NULL,NULL,'ju@abelosh.com',NULL,NULL,'2023-02-11 18:45:03',NULL,NULL),(37,'Nami','Nami',2,'62375cb09a79f912c17f90004ad248a86eb39ea1da15a3fcbc2982489e4063b9',1,NULL,1,NULL,NULL,'nam@hotmail.com',NULL,NULL,'2023-02-11 18:51:37',NULL,NULL),(38,'LOOK','LOOk',0,'29e3511a65143941d4a4bcff650a0b2c976576ced78937772555765a47cf50dc',4,NULL,0,NULL,NULL,'loo5@hotmail.com',NULL,NULL,'2023-02-12 00:48:06',NULL,NULL),(39,'JENNIE','JENNn',2,'d823eb978cbb48c49017f1d320ecaf50568f1f9c1e49f46ae314c8bc8f9be236',2,NULL,0,NULL,NULL,'jen@abelosh.com',NULL,NULL,'2023-02-12 01:52:15',NULL,NULL),(40,'fg','Fg',3,'2b0ae197d3c9cab927f1e9ea4395b6c7170d58d2b886d05eb225a6e8cbac736f',2,NULL,0,NULL,NULL,'fg@abelosh.com',NULL,NULL,'2023-02-14 20:29:23',NULL,NULL),(41,'qwwww','Qwwww',1,'4c6bd6498fc26f7de6edb89bc4e9cb9942659bdeec0ec5ad55c6c39015ab5068',1,NULL,0,NULL,NULL,'iqwww@abelosh.com',NULL,NULL,'2023-02-14 20:35:39',NULL,NULL),(42,'ALEJANDROH5','ALEJANDRO',3,'481f6cc0511143ccdd7e2d1b1b94faf0a700a8b49cd13922a70b5ae28acaa8c5',2,NULL,0,NULL,NULL,'alejandro@hotmail.com',NULL,NULL,'2023-02-15 12:50:12',NULL,NULL),(43,'tt','Tt',1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',2,NULL,0,NULL,NULL,'tt@hotmail.com',NULL,NULL,'2023-02-15 23:35:40',NULL,NULL),(44,'li','Li',3,'0a2d3bc8fa0d2094b65b9f57adb7c6f766af0c552971fd780bea9e7210bb8124',4,NULL,0,NULL,NULL,'li@hotmail.com',NULL,NULL,'2023-02-15 23:38:00',NULL,NULL);
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

-- Dump completed on 2023-02-16 21:06:52
