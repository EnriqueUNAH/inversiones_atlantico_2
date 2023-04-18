SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE IF NOT EXISTS db_inversiones_atlantico;

USE db_inversiones_atlantico;

DROP TABLE IF EXISTS categoria;

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

INSERT INTO categoria VALUES("1","Hombre","Artículos de moda","img_125e45445bd33723d025d7f815ca29f7.jpg","2021-08-20 03:04:04","hombre","1");
INSERT INTO categoria VALUES("2","Audio y Videojuegos","Lo mejor en tecnología","img_78678a3fe95890d155115d5301e0761d.jpg","2021-08-21 00:47:10","audio-y-videojuegos","1");



DROP TABLE IF EXISTS configuracion;

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

INSERT INTO configuracion VALUES("1","123123123","Inversiones del Atlántico","Ventas SA","12121212","info@atlantico.com","Tela, Honduras","15.00");



DROP TABLE IF EXISTS detalle_temp;

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

INSERT INTO detalle_temp VALUES("236","d41d8cd98f00b204e9800998ecf8427e","12","1","30.00");
INSERT INTO detalle_temp VALUES("237","d41d8cd98f00b204e9800998ecf8427e","12","1","30.00");



DROP TABLE IF EXISTS detalle_temp_c;

CREATE TABLE `detalle_temp_c` (
  `cod_detalle_factura` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) NOT NULL,
  `cod_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cod_detalle_factura`),
  KEY `detalle_temp_ibfk_2_idx` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS imagen;

CREATE TABLE `imagen` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `productoid` bigint NOT NULL,
  `img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productoid` (`productoid`),
  CONSTRAINT `imagen_ibfk_1` FOREIGN KEY (`productoid`) REFERENCES `producto` (`idproducto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;




DROP TABLE IF EXISTS pedido;

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




DROP TABLE IF EXISTS produccion;

CREATE TABLE `produccion` (
  `cod_produccion` int NOT NULL,
  `producto` varchar(45) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `fecha` varchar(45) DEFAULT NULL,
  `usuario` varchar(45) DEFAULT NULL,
  `estado` int DEFAULT NULL,
  PRIMARY KEY (`cod_produccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO produccion VALUES("1","CAMISA ENFERMERA","20","2023-04-13 09:11:48","DORCA AGUILAR","1");
INSERT INTO produccion VALUES("2","PANTALÒN ESCOLAR","10","2023-04-13 09:11:48","ENRIQUE NOLASCO","3");
INSERT INTO produccion VALUES("3","BUSO ESCOLAR","14","2023-04-13 09:11:48","ERICKA AYALA","2");
INSERT INTO produccion VALUES("4","CAMISA PERSONALIZADA","23","2023-04-13 09:11:48","DORCA AGUILAR","1");



DROP TABLE IF EXISTS producto;

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




DROP TABLE IF EXISTS tbl_cliente;

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

INSERT INTO tbl_cliente VALUES("5","565656565656","CONSUMIDOR FINAL","","98888888","","","","3","1","1","","","ADMIN","2023-04-13 00:57:28");
INSERT INTO tbl_cliente VALUES("6","801200002389","DORCA NINOSCA AGUILAR","A","97293000","dorca@hotmail.com","LOS PINOS","","3","","1","ADMIN","2023-04-11 21:21:35","ADMIN","2023-04-13 00:36:35");
INSERT INTO tbl_cliente VALUES("7","6565656567788","NANCY ALEJANDRA SALGADO","","32146789","","","","3","","1","ADMIN","2023-04-13 00:02:01","ADMIN","2023-04-13 00:57:37");



DROP TABLE IF EXISTS tbl_compra;

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

INSERT INTO tbl_compra VALUES("4","","","1","");
INSERT INTO tbl_compra VALUES("5","","","1","");
INSERT INTO tbl_compra VALUES("6","30.00","","1","");
INSERT INTO tbl_compra VALUES("7","30.00","","1","");
INSERT INTO tbl_compra VALUES("8","30.00","","1","");
INSERT INTO tbl_compra VALUES("9","30.00","","1","");
INSERT INTO tbl_compra VALUES("10","30.00","","1","");
INSERT INTO tbl_compra VALUES("11","20.00","","1","");
INSERT INTO tbl_compra VALUES("12","40.00","","1","");
INSERT INTO tbl_compra VALUES("13","210.00","","1","");
INSERT INTO tbl_compra VALUES("14","30.00","","1","");
INSERT INTO tbl_compra VALUES("15","50.00","","1","");
INSERT INTO tbl_compra VALUES("16","50.00","","1","");
INSERT INTO tbl_compra VALUES("17","50.00","","1","");
INSERT INTO tbl_compra VALUES("18","50.00","","1","");
INSERT INTO tbl_compra VALUES("19","50.00","","1","");
INSERT INTO tbl_compra VALUES("20","50.00","","1","");
INSERT INTO tbl_compra VALUES("21","80.00","","1","");
INSERT INTO tbl_compra VALUES("22","50.00","","1","");
INSERT INTO tbl_compra VALUES("23","50.00","","1","");
INSERT INTO tbl_compra VALUES("24","50.00","","1","");
INSERT INTO tbl_compra VALUES("25","100.00","","1","");
INSERT INTO tbl_compra VALUES("26","50.00","","1","");
INSERT INTO tbl_compra VALUES("27","50.00","","1","");
INSERT INTO tbl_compra VALUES("28","50.00","","1","");
INSERT INTO tbl_compra VALUES("29","50.00","","1","");
INSERT INTO tbl_compra VALUES("30","50.00","","1","");
INSERT INTO tbl_compra VALUES("31","30.00","","1","");
INSERT INTO tbl_compra VALUES("32","30.00","","1","");
INSERT INTO tbl_compra VALUES("33","50.00","","1","");
INSERT INTO tbl_compra VALUES("34","30.00","","1","");
INSERT INTO tbl_compra VALUES("35","30.00","","1","");
INSERT INTO tbl_compra VALUES("36","70.00","","1","");
INSERT INTO tbl_compra VALUES("37","80.00","","1","");
INSERT INTO tbl_compra VALUES("38","50.00","","1","");
INSERT INTO tbl_compra VALUES("39","20.00","","1","");
INSERT INTO tbl_compra VALUES("40","20.00","","1","");
INSERT INTO tbl_compra VALUES("41","150.00","2023-04-13 11:37:55","1","2");
INSERT INTO tbl_compra VALUES("42","120.00","2023-04-13 15:22:38","1","2");
INSERT INTO tbl_compra VALUES("43","30.00","2023-04-13 22:03:18","1","2");
INSERT INTO tbl_compra VALUES("44","100.00","2023-04-13 22:18:43","1","1");



DROP TABLE IF EXISTS tbl_configuracion_cai;

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

INSERT INTO tbl_configuracion_cai VALUES("1","000-001-01-00000001","000-001-01-00000250","000-001-01-00000001","690CF2-53A933-A8439D-DF8027-51244A-0A","2023-04-07","1","1");



DROP TABLE IF EXISTS tbl_descuento;

CREATE TABLE `tbl_descuento` (
  `cod_descuento` int NOT NULL AUTO_INCREMENT,
  `nombre_descuento` varchar(20) DEFAULT NULL,
  `porcentaje_descuento` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`cod_descuento`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_descuento VALUES("16","TERCERA EDAD","10.00");
INSERT INTO tbl_descuento VALUES("17","CLIENTE VIP","20.00");



DROP TABLE IF EXISTS tbl_detalle_compra;

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

INSERT INTO tbl_detalle_compra VALUES("1","30.00","1","12","6");
INSERT INTO tbl_detalle_compra VALUES("2","30.00","1","12","7");
INSERT INTO tbl_detalle_compra VALUES("3","30.00","1","12","8");
INSERT INTO tbl_detalle_compra VALUES("4","30.00","1","12","9");
INSERT INTO tbl_detalle_compra VALUES("5","30.00","1","12","10");
INSERT INTO tbl_detalle_compra VALUES("6","20.00","1","13","11");
INSERT INTO tbl_detalle_compra VALUES("7","20.00","1","13","12");
INSERT INTO tbl_detalle_compra VALUES("8","20.00","1","13","12");
INSERT INTO tbl_detalle_compra VALUES("10","30.00","5","12","13");
INSERT INTO tbl_detalle_compra VALUES("11","20.00","3","13","13");
INSERT INTO tbl_detalle_compra VALUES("13","30.00","1","12","14");
INSERT INTO tbl_detalle_compra VALUES("14","20.00","1","13","15");
INSERT INTO tbl_detalle_compra VALUES("15","30.00","1","12","15");
INSERT INTO tbl_detalle_compra VALUES("17","30.00","1","12","16");
INSERT INTO tbl_detalle_compra VALUES("18","20.00","1","13","16");
INSERT INTO tbl_detalle_compra VALUES("20","30.00","1","12","17");
INSERT INTO tbl_detalle_compra VALUES("21","20.00","1","13","17");
INSERT INTO tbl_detalle_compra VALUES("23","30.00","1","12","18");
INSERT INTO tbl_detalle_compra VALUES("24","20.00","1","13","18");
INSERT INTO tbl_detalle_compra VALUES("26","30.00","1","12","19");
INSERT INTO tbl_detalle_compra VALUES("27","20.00","1","13","19");
INSERT INTO tbl_detalle_compra VALUES("29","20.00","1","13","20");
INSERT INTO tbl_detalle_compra VALUES("30","30.00","1","12","20");
INSERT INTO tbl_detalle_compra VALUES("32","30.00","1","12","21");
INSERT INTO tbl_detalle_compra VALUES("33","20.00","1","13","21");
INSERT INTO tbl_detalle_compra VALUES("34","30.00","1","12","21");
INSERT INTO tbl_detalle_compra VALUES("35","30.00","1","12","22");
INSERT INTO tbl_detalle_compra VALUES("36","20.00","1","13","22");
INSERT INTO tbl_detalle_compra VALUES("38","30.00","1","12","23");
INSERT INTO tbl_detalle_compra VALUES("39","20.00","1","13","23");
INSERT INTO tbl_detalle_compra VALUES("41","30.00","1","12","24");
INSERT INTO tbl_detalle_compra VALUES("42","20.00","1","13","24");
INSERT INTO tbl_detalle_compra VALUES("44","30.00","1","12","25");
INSERT INTO tbl_detalle_compra VALUES("45","20.00","1","13","25");
INSERT INTO tbl_detalle_compra VALUES("46","30.00","1","12","25");
INSERT INTO tbl_detalle_compra VALUES("47","20.00","1","13","25");
INSERT INTO tbl_detalle_compra VALUES("51","30.00","1","12","26");
INSERT INTO tbl_detalle_compra VALUES("52","20.00","1","13","26");
INSERT INTO tbl_detalle_compra VALUES("54","30.00","1","12","27");
INSERT INTO tbl_detalle_compra VALUES("55","20.00","1","13","27");
INSERT INTO tbl_detalle_compra VALUES("57","30.00","1","12","28");
INSERT INTO tbl_detalle_compra VALUES("58","20.00","1","13","28");
INSERT INTO tbl_detalle_compra VALUES("60","30.00","1","12","29");
INSERT INTO tbl_detalle_compra VALUES("61","20.00","1","13","29");
INSERT INTO tbl_detalle_compra VALUES("63","30.00","1","12","30");
INSERT INTO tbl_detalle_compra VALUES("64","20.00","1","13","30");
INSERT INTO tbl_detalle_compra VALUES("66","30.00","1","12","31");
INSERT INTO tbl_detalle_compra VALUES("67","30.00","1","12","32");
INSERT INTO tbl_detalle_compra VALUES("68","30.00","1","12","33");
INSERT INTO tbl_detalle_compra VALUES("69","20.00","1","13","33");
INSERT INTO tbl_detalle_compra VALUES("71","30.00","1","12","34");
INSERT INTO tbl_detalle_compra VALUES("72","30.00","1","12","35");
INSERT INTO tbl_detalle_compra VALUES("73","20.00","1","13","36");
INSERT INTO tbl_detalle_compra VALUES("74","30.00","1","12","36");
INSERT INTO tbl_detalle_compra VALUES("75","20.00","1","13","36");
INSERT INTO tbl_detalle_compra VALUES("76","30.00","1","12","37");
INSERT INTO tbl_detalle_compra VALUES("77","20.00","1","13","37");
INSERT INTO tbl_detalle_compra VALUES("78","30.00","1","12","37");
INSERT INTO tbl_detalle_compra VALUES("79","30.00","1","12","38");
INSERT INTO tbl_detalle_compra VALUES("80","20.00","1","13","38");
INSERT INTO tbl_detalle_compra VALUES("81","20.00","1","13","39");
INSERT INTO tbl_detalle_compra VALUES("82","20.00","1","13","40");
INSERT INTO tbl_detalle_compra VALUES("83","150.00","1","18","41");
INSERT INTO tbl_detalle_compra VALUES("84","100.00","1","19","42");
INSERT INTO tbl_detalle_compra VALUES("85","20.00","1","13","42");
INSERT INTO tbl_detalle_compra VALUES("86","30.00","1","12","43");
INSERT INTO tbl_detalle_compra VALUES("87","100.00","1","19","44");



DROP TABLE IF EXISTS tbl_detalle_factura;

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

INSERT INTO tbl_detalle_factura VALUES("1","31","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("2","31","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("4","32","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("5","33","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("6","33","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("8","34","12","3","30.00");
INSERT INTO tbl_detalle_factura VALUES("9","34","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("11","35","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("12","36","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("13","37","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("14","37","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("16","38","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("17","39","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("18","40","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("19","40","13","2","20.00");
INSERT INTO tbl_detalle_factura VALUES("20","40","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("21","40","13","3","20.00");
INSERT INTO tbl_detalle_factura VALUES("22","40","12","4","30.00");
INSERT INTO tbl_detalle_factura VALUES("25","41","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("26","41","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("27","41","12","129","30.00");
INSERT INTO tbl_detalle_factura VALUES("28","42","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("29","43","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("30","43","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("32","44","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("33","44","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("34","44","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("35","45","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("36","45","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("38","46","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("39","47","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("40","47","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("42","48","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("43","49","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("44","49","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("46","50","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("47","51","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("48","51","13","5","20.00");



DROP TABLE IF EXISTS tbl_detalle_produccion;

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




DROP TABLE IF EXISTS tbl_estante;

CREATE TABLE `tbl_estante` (
  `cod_estante` int NOT NULL,
  `nombre_estante` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cod_estante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS tbl_factura;

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

INSERT INTO tbl_factura VALUES("31","","2023-04-10 05:51:26","1","5","50.00","2","42.50","7.50","15.00");
INSERT INTO tbl_factura VALUES("32","","2023-04-09 23:55:59","1","5","30.00","2","25.50","4.50","15.00");
INSERT INTO tbl_factura VALUES("33","","2023-04-10 00:04:50","1","5","50.00","1","42.50","7.50","15.00");
INSERT INTO tbl_factura VALUES("34","","2023-04-10 16:53:43","1","5","110.00","2","93.50","16.50","15.00");
INSERT INTO tbl_factura VALUES("35","","2023-04-10 22:40:53","1","5","20.00","1","17.00","3.00","15.00");
INSERT INTO tbl_factura VALUES("36","","2023-04-10 22:42:06","1","5","20.00","2","17.00","3.00","15.00");
INSERT INTO tbl_factura VALUES("37","","2023-04-11 01:55:25","1","5","50.00","1","42.50","7.50","15.00");
INSERT INTO tbl_factura VALUES("38","","2023-04-11 10:06:33","1","5","30.00","1","25.50","4.50","15.00");
INSERT INTO tbl_factura VALUES("39","","2023-04-11 13:40:36","1","5","30.00","1","25.50","4.50","15.00");
INSERT INTO tbl_factura VALUES("40","","2023-04-11 18:15:16","1","5","280.00","1","238.00","42.00","15.00");
INSERT INTO tbl_factura VALUES("41","","2023-04-11 21:27:20","1","6","3920.00","1","3332.00","588.00","15.00");
INSERT INTO tbl_factura VALUES("42","","2023-04-11 23:23:21","1","5","30.00","1","25.50","4.50","15.00");
INSERT INTO tbl_factura VALUES("43","","2023-04-12 00:46:17","1","5","50.00","1","42.50","7.50","15.00");
INSERT INTO tbl_factura VALUES("44","","2023-04-12 00:47:20","1","5","80.00","1","68.00","12.00","15.00");
INSERT INTO tbl_factura VALUES("45","","2023-04-12 16:11:44","1","5","50.00","1","42.50","7.50","15.00");
INSERT INTO tbl_factura VALUES("46","","2023-04-12 16:20:38","1","5","30.00","1","25.50","4.50","15.00");
INSERT INTO tbl_factura VALUES("47","","2023-04-12 17:11:32","1","5","50.00","1","42.50","7.50","15.00");
INSERT INTO tbl_factura VALUES("48","","2023-04-12 17:14:46","1","5","30.00","1","25.50","4.50","15.00");
INSERT INTO tbl_factura VALUES("49","","2023-04-12 19:20:17","1","5","50.00","1","42.50","7.50","15.00");
INSERT INTO tbl_factura VALUES("50","","2023-04-12 21:22:07","1","5","30.00","1","25.50","4.50","15.00");
INSERT INTO tbl_factura VALUES("51","","2023-04-13 15:36:59","1","5","130.00","1","110.50","19.50","15.00");



DROP TABLE IF EXISTS tbl_factura_descuento;

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




DROP TABLE IF EXISTS tbl_factura_promocion;

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




DROP TABLE IF EXISTS tbl_genero;

CREATE TABLE `tbl_genero` (
  `cod_genero` int NOT NULL AUTO_INCREMENT,
  `nombre_genero` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cod_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_genero VALUES("3","FEMENINO");
INSERT INTO tbl_genero VALUES("4","MASCULINO");



DROP TABLE IF EXISTS tbl_inventario;

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




DROP TABLE IF EXISTS tbl_kardex;

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

INSERT INTO tbl_kardex VALUES("1","2023-03-17 00:00:00","1","12");



DROP TABLE IF EXISTS tbl_ms_bitacora;

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
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_ms_bitacora VALUES("1","2023-04-12 21:34:54","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("2","2023-04-12 21:48:25","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("3","2023-04-12 21:48:46","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("4","2023-04-12 21:49:04","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("5","2023-04-12 21:49:46","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("6","2023-04-12 21:50:08","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("7","2023-04-12 21:53:23","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("8","2023-04-12 21:54:18","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("9","2023-04-12 21:55:43","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("10","2023-04-12 22:05:29","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("11","2023-04-12 22:14:01","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("12","2023-04-12 22:15:29","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("13","2023-04-12 22:16:28","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("14","2023-04-12 22:20:12","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("15","2023-04-12 22:21:47","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("16","2023-04-12 22:21:59","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("17","2023-04-12 22:22:30","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("18","2023-04-12 22:29:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("19","2023-04-12 22:37:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("20","2023-04-12 22:38:09","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("21","2023-04-12 22:40:04","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("22","2023-04-12 22:50:03","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("23","2023-04-12 23:18:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("24","2023-04-13 00:01:22","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("25","2023-04-13 00:02:01","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("26","2023-04-13 00:29:04","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("27","2023-04-13 00:29:26","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("28","2023-04-13 00:29:44","1","2","ACTUALIZAR","ACTUALIZACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("29","2023-04-13 00:29:47","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("30","2023-04-13 00:30:48","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("31","2023-04-13 00:33:04","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("32","2023-04-13 00:33:10","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("33","2023-04-13 00:33:30","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("34","2023-04-13 00:34:57","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("35","2023-04-13 00:35:48","1","2","ACTUALIZAR","ACTUALIZACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("36","2023-04-13 00:36:01","1","2","ACTUALIZAR","ACTUALIZACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("37","2023-04-13 00:36:35","1","2","ACTUALIZAR","ACTUALIZACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("38","2023-04-13 00:36:56","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("39","2023-04-13 00:37:01","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("40","2023-04-13 00:37:15","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("41","2023-04-13 00:38:06","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("42","2023-04-13 00:42:30","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("43","2023-04-13 00:42:41","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("44","2023-04-13 00:43:00","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("45","2023-04-13 00:43:19","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("46","2023-04-13 00:43:27","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("47","2023-04-13 00:47:00","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("48","2023-04-13 00:47:08","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("49","2023-04-13 00:47:14","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("50","2023-04-13 00:47:20","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("51","2023-04-13 00:47:42","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("52","2023-04-13 00:50:15","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("53","2023-04-13 00:50:28","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("54","2023-04-13 00:54:04","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("55","2023-04-13 00:55:09","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("56","2023-04-13 00:55:16","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("57","2023-04-13 00:55:25","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("58","2023-04-13 00:55:31","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("59","2023-04-13 00:56:18","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("60","2023-04-13 00:56:23","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("61","2023-04-13 00:56:33","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("62","2023-04-13 00:56:41","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("63","2023-04-13 00:56:54","1","2","ACTUALIZAR","ACTUALIZACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("64","2023-04-13 00:57:04","1","2","ACTUALIZAR","ACTUALIZACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("65","2023-04-13 00:57:11","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("66","2023-04-13 00:57:28","1","2","ACTUALIZAR","ACTUALIZACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("67","2023-04-13 00:57:37","1","2","ACTUALIZAR","ACTUALIZACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("68","2023-04-13 00:57:43","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("69","2023-04-13 00:58:17","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("70","2023-04-13 00:58:21","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("71","2023-04-13 00:58:55","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("72","2023-04-13 01:10:14","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("73","2023-04-13 02:37:52","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("74","2023-04-13 02:37:57","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("75","2023-04-13 02:43:11","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("76","2023-04-13 03:30:04","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("77","2023-04-13 03:30:08","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("78","2023-04-13 03:33:16","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("79","2023-04-13 03:34:04","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("80","2023-04-13 09:11:48","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("81","2023-04-13 10:21:05","1","2","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("82","2023-04-13 10:24:41","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("83","2023-04-13 10:27:48","1","2","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("84","2023-04-13 10:29:04","1","2","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("85","2023-04-13 10:29:37","1","2","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("86","2023-04-13 10:30:07","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("87","2023-04-13 10:30:40","1","2","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("88","2023-04-13 10:30:55","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("89","2023-04-13 10:31:06","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("90","2023-04-13 10:31:20","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("91","2023-04-13 10:31:58","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("92","2023-04-13 11:35:28","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("93","2023-04-13 11:35:39","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("94","2023-04-13 11:35:56","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("95","2023-04-13 11:37:59","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("96","2023-04-13 11:38:30","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("97","2023-04-13 11:40:16","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("98","2023-04-13 14:47:00","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("99","2023-04-13 14:48:10","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("100","2023-04-13 14:48:17","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("101","2023-04-13 14:48:54","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("102","2023-04-13 14:49:26","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("103","2023-04-13 14:51:47","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("104","2023-04-13 14:51:59","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("105","2023-04-13 14:53:18","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("106","2023-04-13 15:03:39","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("107","2023-04-13 15:03:42","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("108","2023-04-13 15:04:19","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("109","2023-04-13 15:06:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("110","2023-04-13 15:06:28","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("111","2023-04-13 15:08:42","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("112","2023-04-13 15:16:06","1","2","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("113","2023-04-13 15:19:30","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("114","2023-04-13 15:19:36","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("115","2023-04-13 15:23:25","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("116","2023-04-13 15:30:36","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("117","2023-04-13 15:38:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("118","2023-04-13 15:38:22","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("119","2023-04-13 21:20:21","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("120","2023-04-13 21:20:37","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("121","2023-04-13 21:21:27","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("122","2023-04-13 21:22:02","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("123","2023-04-13 21:22:09","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("124","2023-04-13 21:22:52","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("125","2023-04-13 21:23:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("126","2023-04-13 21:24:06","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("127","2023-04-13 21:26:17","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("128","2023-04-13 21:27:00","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("129","2023-04-13 21:27:22","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("130","2023-04-13 21:27:29","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("131","2023-04-13 21:27:30","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("132","2023-04-13 21:30:53","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("133","2023-04-13 21:31:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("134","2023-04-13 21:34:11","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("135","2023-04-13 21:47:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("136","2023-04-13 21:52:11","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("137","2023-04-13 21:52:33","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("138","2023-04-13 21:52:36","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("139","2023-04-13 21:56:32","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("140","2023-04-13 22:01:54","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("141","2023-04-13 22:03:27","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("142","2023-04-13 22:03:46","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("143","2023-04-13 22:12:43","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("144","2023-04-13 22:23:59","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("145","2023-04-13 22:24:35","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("146","2023-04-13 22:27:53","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("147","2023-04-13 22:32:14","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("148","2023-04-17 20:40:08","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("149","2023-04-17 20:40:22","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("150","2023-04-17 20:40:32","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("151","2023-04-17 20:40:39","1","2","INGRESO","INGRESO AL SISTEMA");



DROP TABLE IF EXISTS tbl_ms_estado;

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

INSERT INTO tbl_ms_estado VALUES("1","NUEVO","NUEVO","ADMIN","2022-11-07","ADMIN","2022-11-07");
INSERT INTO tbl_ms_estado VALUES("2","ACTIVO","ACTIVO","ADMIN","2022-11-07","ADMIN","2022-11-07");
INSERT INTO tbl_ms_estado VALUES("3","INACTIVO","INACTIVO","ADMIN","2022-11-07","ADMIN","2022-11-07");
INSERT INTO tbl_ms_estado VALUES("4","BLOQUEADO","BLOQUEADO","ADMIN","2022-11-07","ADMIN","2022-11-07");
INSERT INTO tbl_ms_estado VALUES("5","RESETEO","RESETEO","ADMIN","2022-11-07","ADMIN","2022-11-07");
INSERT INTO tbl_ms_estado VALUES("6","PENDIENTE","PENDIENTE","ADMIN","2022-11-07","ADMIN","2022-11-07");



DROP TABLE IF EXISTS tbl_ms_hist_contrasena;

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




DROP TABLE IF EXISTS tbl_ms_objetos;

CREATE TABLE `tbl_ms_objetos` (
  `id_objeto` bigint NOT NULL AUTO_INCREMENT,
  `objeto` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_objeto`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

INSERT INTO tbl_ms_objetos VALUES("1","BACKUP","","1");
INSERT INTO tbl_ms_objetos VALUES("2","BITÁCORA","","1");
INSERT INTO tbl_ms_objetos VALUES("4","CAI","","1");
INSERT INTO tbl_ms_objetos VALUES("10","CLIENTES","","1");
INSERT INTO tbl_ms_objetos VALUES("11","COMPRAS","","1");
INSERT INTO tbl_ms_objetos VALUES("12","DESCUENTOS","","1");
INSERT INTO tbl_ms_objetos VALUES("13","INICIO","","1");
INSERT INTO tbl_ms_objetos VALUES("14","INVENTARIO","","1");
INSERT INTO tbl_ms_objetos VALUES("15","KARDEX","","1");
INSERT INTO tbl_ms_objetos VALUES("16","OBJETOS","","1");
INSERT INTO tbl_ms_objetos VALUES("17","PARÁMETROS","","1");
INSERT INTO tbl_ms_objetos VALUES("18","PREGUNTAS","","1");
INSERT INTO tbl_ms_objetos VALUES("20","PRODUCCIÓN","","1");
INSERT INTO tbl_ms_objetos VALUES("21","PRODUCTOS","","1");
INSERT INTO tbl_ms_objetos VALUES("22","PROMOCIÓN","","1");
INSERT INTO tbl_ms_objetos VALUES("23","ROLES","","1");
INSERT INTO tbl_ms_objetos VALUES("24","USUARIOS","","1");
INSERT INTO tbl_ms_objetos VALUES("25","VENTAS","","1");



DROP TABLE IF EXISTS tbl_ms_parametros;

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

INSERT INTO tbl_ms_parametros VALUES("1","ADMIN_INTENTOS","3","","","","");
INSERT INTO tbl_ms_parametros VALUES("2","ADMIN_PREGUNTAS","2","","","","");
INSERT INTO tbl_ms_parametros VALUES("3","ADMIN_CORREO","uniformesdelatlantico@hotmail.com","","","","");
INSERT INTO tbl_ms_parametros VALUES("4","FECHA_VENCIMIENTO","30","","","","");
INSERT INTO tbl_ms_parametros VALUES("5","IMPUESTO","15","","","","");
INSERT INTO tbl_ms_parametros VALUES("6","NOMBRE_EMPRESA","INVERSIONES UNIFORMES DEL ATLÁNTICO","","","ADMIN","2023-04-11 21:32:20");
INSERT INTO tbl_ms_parametros VALUES("7","RAZON_SOCIAL","S. DE R. L. DE C. V.","","","","");
INSERT INTO tbl_ms_parametros VALUES("8","TELEFONO_EMPRESA","9970-5887","","","","");
INSERT INTO tbl_ms_parametros VALUES("9","DIRECCION","BO. EL CENTRO, DOMICILIO RENTADO, ATRÁS DE LA DESPENSA FAMILIAR, TELA. ATLÁNTIDA","","","","");
INSERT INTO tbl_ms_parametros VALUES("10","RTN","01079021315692","","","","");



DROP TABLE IF EXISTS tbl_ms_permisos;

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

INSERT INTO tbl_ms_permisos VALUES("39","3","1","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("40","3","2","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("42","3","4","0","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("93","11","1","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("94","11","2","0","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("96","11","4","0","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("223","21","1","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("224","21","2","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("226","21","4","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("231","2","1","0","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("232","2","2","0","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("234","2","4","0","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("520","4","1","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("521","4","2","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("522","4","4","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("523","4","10","1","1","0","0");
INSERT INTO tbl_ms_permisos VALUES("524","4","11","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("525","4","12","0","1","0","0");
INSERT INTO tbl_ms_permisos VALUES("526","4","13","1","1","1","0");
INSERT INTO tbl_ms_permisos VALUES("527","4","14","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("528","4","15","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("529","4","16","1","0","0","1");
INSERT INTO tbl_ms_permisos VALUES("530","4","17","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("531","4","18","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("532","4","20","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("533","4","21","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("534","4","22","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("535","4","23","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("536","4","24","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("537","1","1","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("538","1","2","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("539","1","4","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("540","1","10","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("541","1","11","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("542","1","12","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("543","1","13","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("544","1","14","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("545","1","15","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("546","1","16","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("547","1","17","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("548","1","18","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("549","1","20","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("550","1","21","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("551","1","22","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("552","1","23","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("553","1","24","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("554","1","25","1","1","1","1");



DROP TABLE IF EXISTS tbl_ms_preguntas;

CREATE TABLE `tbl_ms_preguntas` (
  `id_pregunta` int NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_pregunta`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_ms_preguntas VALUES("3","CANCION FAVORITA");
INSERT INTO tbl_ms_preguntas VALUES("4","COMIDA FAVORITA");



DROP TABLE IF EXISTS tbl_ms_preguntas_usuario;

CREATE TABLE `tbl_ms_preguntas_usuario` (
  `id_pregunta` int NOT NULL,
  `id_usuario` bigint NOT NULL,
  `respuesta` varchar(100) DEFAULT NULL,
  KEY `preguntaUsuario_idUsuario_idx` (`id_usuario`),
  CONSTRAINT `preguntaUsuario_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS tbl_ms_roles;

CREATE TABLE `tbl_ms_roles` (
  `id_rol` bigint NOT NULL AUTO_INCREMENT,
  `nombrerol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

INSERT INTO tbl_ms_roles VALUES("1","ADMINISTRADOR","Acceso a todo el sistema","1");
INSERT INTO tbl_ms_roles VALUES("2","DEFAULT","Rol por defecto","1");
INSERT INTO tbl_ms_roles VALUES("3","Clientes de todo","Clientes en general","0");
INSERT INTO tbl_ms_roles VALUES("4","VENDEDOR","Operador de tienda","1");
INSERT INTO tbl_ms_roles VALUES("5","prueba","fddfd","0");
INSERT INTO tbl_ms_roles VALUES("6","prueba2","gg","0");
INSERT INTO tbl_ms_roles VALUES("7","prueba33","d","0");
INSERT INTO tbl_ms_roles VALUES("8","prueba4","f","0");
INSERT INTO tbl_ms_roles VALUES("9","nuevo1","dch","0");
INSERT INTO tbl_ms_roles VALUES("10","prueba555","gggggg","0");
INSERT INTO tbl_ms_roles VALUES("11","Nuevo de prueba","sf","0");
INSERT INTO tbl_ms_roles VALUES("12","probar cambio","sddd","0");
INSERT INTO tbl_ms_roles VALUES("13","prueba44","f","0");
INSERT INTO tbl_ms_roles VALUES("14","prueba4446","d","0");
INSERT INTO tbl_ms_roles VALUES("15","Nueva Prueba","sssss","0");
INSERT INTO tbl_ms_roles VALUES("16","rrrr","rf","0");
INSERT INTO tbl_ms_roles VALUES("17","gu","f","0");
INSERT INTO tbl_ms_roles VALUES("18","fff","fffd","0");
INSERT INTO tbl_ms_roles VALUES("19","rrr","rr","0");
INSERT INTO tbl_ms_roles VALUES("20","j","j","0");
INSERT INTO tbl_ms_roles VALUES("21","www","www","0");
INSERT INTO tbl_ms_roles VALUES("22","CONTABILIDAD","rrr","0");
INSERT INTO tbl_ms_roles VALUES("23","nuevorol","d","0");



DROP TABLE IF EXISTS tbl_ms_usuarios;

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

INSERT INTO tbl_ms_usuarios VALUES("1","ADMIN","ADMINISTRADOR","1","8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92","2023-04-17 20:40:39","0","","","admin@atlantico.com","733464113f1d79251461-4ff19d069fb2ec635522-a12faeec9a0c21dd0b33-435908728e5136f3ae80","","2021-08-20 01:34:15","ADMIN","2023-03-22 21:16:11","1");
INSERT INTO tbl_ms_usuarios VALUES("19","ALEXANDER","ALEXANDER AGUILAR","2","3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c","","0","","","alex@hotmail.com","","","2023-02-04 01:16:01","ADMIN","2023-03-22 10:36:01","4");
INSERT INTO tbl_ms_usuarios VALUES("20","ERIKA","ERIKA AYALA","2","18ac3e7343f016890c510e93f935261169d9e3f565436429830faf0934f4f8e4","","0","","","erika3@gmail.com","","","2023-02-08 21:40:58","ADMIN","2023-03-22 10:35:34","2");
INSERT INTO tbl_ms_usuarios VALUES("104","HECTOR","HECTOR BUSTILLOO","2","3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c","","2","","","hector@hotmail.com","","ADMIN","2023-03-08 15:22:09","ADMIN","2023-03-22 21:14:43","1");
INSERT INTO tbl_ms_usuarios VALUES("136","JORGE","JORGE ROMERO","1","c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb","2023-03-30 13:13:42","2","","","jorge@gmail.com","","ADMIN","2023-03-15 20:49:18","ADMIN","2023-03-29 21:35:43","4");
INSERT INTO tbl_ms_usuarios VALUES("162","DORCA","DORCA AGUILAR","1","c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb","2023-04-09 19:58:52","2","","","dorcaaguilar@gmail.com","","ADMIN","2023-03-16 21:25:14","ADMIN","2023-04-09 19:58:13","4");



DROP TABLE IF EXISTS tbl_produccion;

CREATE TABLE `tbl_produccion` (
  `cod_produccion` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  PRIMARY KEY (`cod_produccion`),
  KEY `P_Cod_Producto_idx` (`id_usuario`),
  CONSTRAINT `Produccion_CodProducto` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS tbl_producto;

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

INSERT INTO tbl_producto VALUES("12","TELA","TELA BLANCA","200","30","3","30.00","1","","","","","99");
INSERT INTO tbl_producto VALUES("13","PINTURA","ROJA","10","100","3","20.00","1","","","","","39");
INSERT INTO tbl_producto VALUES("15","MONOGRAMA","MONOGRAMA ESCOLAR","3","4","4","45.00","1","ADMIN","2023-04-13 10:21:05","ADMIN","2023-04-13 10:30:07","0");
INSERT INTO tbl_producto VALUES("16","PINTURA PARA SERIGRAFíA","PINTURA","12","23","3","100.00","1","ADMIN","2023-04-13 10:27:48","","","0");
INSERT INTO tbl_producto VALUES("17","PAPEL VINIL","PAPEL","200","100","3","23.00","1","ADMIN","2023-04-13 10:29:04","","","0");
INSERT INTO tbl_producto VALUES("18","BUSO ESCOLAR","BUSO","20","40","4","150.00","1","ADMIN","2023-04-13 10:30:40","ADMIN","2023-04-13 10:30:55","0");
INSERT INTO tbl_producto VALUES("19","INFORMATICA","INFORMATICA","5","100","3","100.00","1","ADMIN","2023-04-13 15:16:06","","","1");



DROP TABLE IF EXISTS tbl_promocion;

CREATE TABLE `tbl_promocion` (
  `cod_promocion` int NOT NULL AUTO_INCREMENT,
  `nombre_promocion` varchar(100) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_final` datetime DEFAULT NULL,
  `precio_venta` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`cod_promocion`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_promocion VALUES("2","CAMISAS PROMO","2023-03-30 22:00:00","2023-04-05 23:03:00","50.00");



DROP TABLE IF EXISTS tbl_promocion_producto;

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




DROP TABLE IF EXISTS tbl_resultado_produccion;

CREATE TABLE `tbl_resultado_produccion` (
  `id_resultado_produccion` int NOT NULL AUTO_INCREMENT,
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_resultado_produccion`),
  KEY `ResultadoProduccion_idProducto_idx` (`cod_producto`),
  CONSTRAINT `ResultadoProduccion_idProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_resultado_produccion VALUES("1","12","2","PRODUCCIÓN");



DROP TABLE IF EXISTS tbl_tipo_inventario;

CREATE TABLE `tbl_tipo_inventario` (
  `cod_tipo_inventario` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo_inventario` char(15) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_inventario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS tbl_tipo_movimiento;

CREATE TABLE `tbl_tipo_movimiento` (
  `cod_tipo_movimiento` int NOT NULL AUTO_INCREMENT,
  `nombre_movimiento` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_tipo_movimiento VALUES("1","ENTRADA");



DROP TABLE IF EXISTS tbl_tipo_producto;

CREATE TABLE `tbl_tipo_producto` (
  `cod_tipo_producto` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo_producto` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_tipo_producto VALUES("3","INSUMO");
INSERT INTO tbl_tipo_producto VALUES("4","PRODUCTO TERMINADO");



DROP TABLE IF EXISTS tipopago;

CREATE TABLE `tipopago` (
  `idtipopago` bigint NOT NULL AUTO_INCREMENT,
  `tipopago` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`idtipopago`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

INSERT INTO tipopago VALUES("1","PayPal","1");
INSERT INTO tipopago VALUES("2","Efectivo","1");
INSERT INTO tipopago VALUES("3","Tarjeta","1");
INSERT INTO tipopago VALUES("4","Cheque","1");
INSERT INTO tipopago VALUES("5","Despósito Bancario","1");



SET FOREIGN_KEY_CHECKS=1;