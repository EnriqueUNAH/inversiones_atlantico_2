SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE IF NOT EXISTS db_inversiones_atlantico;

USE db_inversiones_atlantico;

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
) ENGINE=InnoDB AUTO_INCREMENT=933 DEFAULT CHARSET=latin1;

INSERT INTO detalle_temp VALUES("929","c4ca4238a0b923820dcc509a6f75849b","18","29","100.00","","29");



DROP TABLE IF EXISTS detalle_temp_c;

CREATE TABLE `detalle_temp_c` (
  `cod_detalle_factura` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) NOT NULL,
  `cod_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cod_detalle_factura`),
  KEY `detalle_temp_ibfk_2_idx` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS detalle_temp_p;

CREATE TABLE `detalle_temp_p` (
  `cod_detalle_produccion` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) NOT NULL,
  `cod_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`cod_detalle_produccion`),
  KEY `DetallePromoTmp_CodProducto_idx` (`cod_producto`),
  CONSTRAINT `DetallePromoTmp_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS detalle_temp_pr;

CREATE TABLE `detalle_temp_pr` (
  `cod_detalle_produccion` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) NOT NULL,
  `cod_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`cod_detalle_produccion`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS detalle_temp_promo;

CREATE TABLE `detalle_temp_promo` (
  `id_promocion_producto` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id_promocion_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS tbl_cliente;

CREATE TABLE `tbl_cliente` (
  `cod_cliente` int NOT NULL AUTO_INCREMENT,
  `rtn` varchar(14) DEFAULT NULL,
  `nombres` varchar(100) NOT NULL,
  `telefono` int DEFAULT NULL,
  `correo_electronico` varchar(30) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`cod_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_cliente VALUES("5","","CONSUMIDOR FINAL","0","","","1","","2023-04-13 00:57:28","ADMIN","2023-04-13 00:57:28");
INSERT INTO tbl_cliente VALUES("29","8012000837474","DORCA AGUILAR","98273849","dorca@hotmail.com","LOS PINOS","1","ADMIN","2023-07-28 16:47:36",NULL,NULL);
INSERT INTO tbl_cliente VALUES("30","8012000374848","ENRIQUE NOLASCO","87353535","enrique@gmail.com","CA","1","ADMIN","2023-07-28 16:48:04",NULL,NULL);



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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_compra VALUES("4",NULL,NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("5",NULL,NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("6","30.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("7","30.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("8","30.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("9","30.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("10","30.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("11","20.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("12","40.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("13","210.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("14","30.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("15","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("16","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("17","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("18","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("19","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("20","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("21","80.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("22","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("23","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("24","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("25","100.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("26","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("27","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("28","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("29","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("30","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("31","30.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("32","30.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("33","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("34","30.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("35","30.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("36","70.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("37","80.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("38","50.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("39","20.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("40","20.00",NULL,"1",NULL);
INSERT INTO tbl_compra VALUES("41","150.00","2023-04-13 11:37:55","1","2");
INSERT INTO tbl_compra VALUES("42","120.00","2023-04-13 15:22:38","1","2");
INSERT INTO tbl_compra VALUES("43","30.00","2023-04-13 22:03:18","1","2");
INSERT INTO tbl_compra VALUES("44","100.00","2023-04-13 22:18:43","1","2");
INSERT INTO tbl_compra VALUES("45","300.00","2023-04-16 10:58:17","1","1");
INSERT INTO tbl_compra VALUES("46","2.00","2023-04-16 10:58:57","1","1");
INSERT INTO tbl_compra VALUES("47","30.00","2023-04-17 01:33:58","1","1");
INSERT INTO tbl_compra VALUES("48","22.00","2023-04-19 00:47:58","1","1");
INSERT INTO tbl_compra VALUES("49","4.00","2023-04-29 00:15:02","1","1");



DROP TABLE IF EXISTS tbl_configuracion_cai;

CREATE TABLE `tbl_configuracion_cai` (
  `cod_talonario` int NOT NULL AUTO_INCREMENT,
  `rango_inicial` int DEFAULT NULL,
  `rango_final` int DEFAULT NULL,
  `rango_actual` int DEFAULT NULL,
  `numero_CAI` varchar(100) DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `estado` int NOT NULL,
  PRIMARY KEY (`cod_talonario`),
  KEY `CAI_IdUsuario_idx` (`id_usuario`),
  CONSTRAINT `CAI_IdUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_configuracion_cai VALUES("1","1","250","39","690CF2-53A933-A8439D-DF8027-51244A-0A","2023-04-07","1","1");



DROP TABLE IF EXISTS tbl_descuento;

CREATE TABLE `tbl_descuento` (
  `cod_descuento` int NOT NULL AUTO_INCREMENT,
  `nombre_descuento` varchar(20) DEFAULT NULL,
  `porcentaje_descuento` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`cod_descuento`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_descuento VALUES("16","SIN DESCUENTO","0.00");
INSERT INTO tbl_descuento VALUES("18","TERCERA EDAD","15.00");
INSERT INTO tbl_descuento VALUES("19","DESCUENTO VIP","25.00");



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
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
INSERT INTO tbl_detalle_compra VALUES("88","100.00","1","13","45");
INSERT INTO tbl_detalle_compra VALUES("89","100.00","2","13","45");
INSERT INTO tbl_detalle_compra VALUES("91","1.00","2","13","46");
INSERT INTO tbl_detalle_compra VALUES("92","1.00","30","20","47");
INSERT INTO tbl_detalle_compra VALUES("93","1.00","10","13","48");
INSERT INTO tbl_detalle_compra VALUES("94","1.00","12","16","48");
INSERT INTO tbl_detalle_compra VALUES("95","1.00","1","16","49");
INSERT INTO tbl_detalle_compra VALUES("96","1.00","1","20","49");
INSERT INTO tbl_detalle_compra VALUES("97","1.00","2","13","49");



DROP TABLE IF EXISTS tbl_detalle_factura;

CREATE TABLE `tbl_detalle_factura` (
  `cod_detalle_factura` bigint NOT NULL AUTO_INCREMENT,
  `cod_factura` bigint DEFAULT NULL,
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `cantidad_multi` int DEFAULT NULL,
  `promocion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cod_detalle_factura`),
  KEY `DetalleFactura_CodProducto_idx` (`cod_producto`),
  KEY `DetalleFactura_NoFactura_idx` (`cod_factura`),
  CONSTRAINT `DetalleFactura_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `DetalleFactura_NoFactura` FOREIGN KEY (`cod_factura`) REFERENCES `tbl_factura` (`cod_factura`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_detalle_factura VALUES("1","126","18","1","100.00","1",NULL);
INSERT INTO tbl_detalle_factura VALUES("2","126","19","14","220.00","14",NULL);
INSERT INTO tbl_detalle_factura VALUES("3","126","19","5","50.00","1",NULL);
INSERT INTO tbl_detalle_factura VALUES("4","126","12","5",NULL,NULL,NULL);
INSERT INTO tbl_detalle_factura VALUES("5","126","17","5",NULL,NULL,NULL);
INSERT INTO tbl_detalle_factura VALUES("8","127","19","4","220.00","4",NULL);
INSERT INTO tbl_detalle_factura VALUES("9","128","21","1","150.00","1",NULL);
INSERT INTO tbl_detalle_factura VALUES("10","128","18","1","500.00","1",NULL);
INSERT INTO tbl_detalle_factura VALUES("11","128","24","2",NULL,NULL,NULL);
INSERT INTO tbl_detalle_factura VALUES("12","128","25","2",NULL,NULL,NULL);
INSERT INTO tbl_detalle_factura VALUES("13","128","18","1","100.00","1",NULL);
INSERT INTO tbl_detalle_factura VALUES("14","129","15","1","65.20","1",NULL);
INSERT INTO tbl_detalle_factura VALUES("15","129","18","1","500.00","1","PROMO 1");
INSERT INTO tbl_detalle_factura VALUES("16","129","24","2",NULL,NULL,"PROMO 1");
INSERT INTO tbl_detalle_factura VALUES("17","129","25","2",NULL,NULL,"PROMO 1");
INSERT INTO tbl_detalle_factura VALUES("21","130","19","1","220.00","1",NULL);
INSERT INTO tbl_detalle_factura VALUES("22","130","18","3","400.00","1","PROMO 2");
INSERT INTO tbl_detalle_factura VALUES("23","130","19","2",NULL,NULL,"PROMO 2");
INSERT INTO tbl_detalle_factura VALUES("24","131","18","2","100.00","2",NULL);
INSERT INTO tbl_detalle_factura VALUES("25","131","18","1","500.00","1","PROMO 1");
INSERT INTO tbl_detalle_factura VALUES("26","131","24","2",NULL,NULL,"PROMO 1");
INSERT INTO tbl_detalle_factura VALUES("27","131","25","2",NULL,NULL,"PROMO 1");
INSERT INTO tbl_detalle_factura VALUES("28","131","22","1","100.00","1",NULL);
INSERT INTO tbl_detalle_factura VALUES("31","132","18","1","100.00","1",NULL);
INSERT INTO tbl_detalle_factura VALUES("32","132","18","3","400.00","1","PROMO 2");
INSERT INTO tbl_detalle_factura VALUES("33","132","19","2",NULL,NULL,"PROMO 2");



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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_detalle_produccion VALUES("1","13","5","115");
INSERT INTO tbl_detalle_produccion VALUES("2","17","11","115");
INSERT INTO tbl_detalle_produccion VALUES("4","12","1","116");
INSERT INTO tbl_detalle_produccion VALUES("5","20","1","116");
INSERT INTO tbl_detalle_produccion VALUES("7","16","1","117");
INSERT INTO tbl_detalle_produccion VALUES("8","20","1","117");
INSERT INTO tbl_detalle_produccion VALUES("10","13","1","118");
INSERT INTO tbl_detalle_produccion VALUES("11","12","11","119");
INSERT INTO tbl_detalle_produccion VALUES("12","20","22","119");
INSERT INTO tbl_detalle_produccion VALUES("13","17","33","119");
INSERT INTO tbl_detalle_produccion VALUES("14","12","2","120");
INSERT INTO tbl_detalle_produccion VALUES("15","17","1","120");



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
  `descuento` decimal(10,2) DEFAULT NULL,
  `cai` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cod_factura`),
  KEY `TBL_CLIENTE_COD_CLIENTE_idx` (`cod_cliente`),
  CONSTRAINT `Venta_CodCliente` FOREIGN KEY (`cod_cliente`) REFERENCES `tbl_cliente` (`cod_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_factura VALUES("126","33","2023-04-24 11:13:45","1","5","3430.00","1","2982.61","447.39","15.00","0.00","690CF2-53A933-A8439D-DF8027-51244A-0A");
INSERT INTO tbl_factura VALUES("127","34","2023-04-24 11:24:46","1","5","748.00","1","765.22","114.78","15.00","132.00","690CF2-53A933-A8439D-DF8027-51244A-0A");
INSERT INTO tbl_factura VALUES("128","35","2023-04-24 16:37:51","1","5","637.50","1","652.17","97.83","15.00","112.50","690CF2-53A933-A8439D-DF8027-51244A-0A");
INSERT INTO tbl_factura VALUES("129","36","2023-04-28 10:27:29","1","5","565.20","2","491.48","73.72","15.00","0.00","690CF2-53A933-A8439D-DF8027-51244A-0A");
INSERT INTO tbl_factura VALUES("130","37","2023-04-28 10:30:50","1","5","1420.00","1","1234.78","185.22","15.00","0.00","690CF2-53A933-A8439D-DF8027-51244A-0A");
INSERT INTO tbl_factura VALUES("131","38","2023-04-28 20:24:31","1","5","800.00","1","695.65","104.35","15.00","0.00","690CF2-53A933-A8439D-DF8027-51244A-0A");
INSERT INTO tbl_factura VALUES("132","39","2023-04-29 00:10:37","1","5","1300.00","1","1130.43","169.57","15.00","0.00","690CF2-53A933-A8439D-DF8027-51244A-0A");



DROP TABLE IF EXISTS tbl_kardex;

CREATE TABLE `tbl_kardex` (
  `cod_kardex` int NOT NULL AUTO_INCREMENT,
  `cod_producto` int DEFAULT NULL,
  `cod_tipo_movimiento` int DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`cod_kardex`),
  KEY `tbl_Producto_Cod_Producto_idx` (`cod_producto`),
  KEY `Kardex_idTipoMovimiento_idx` (`cod_tipo_movimiento`),
  CONSTRAINT `Kardex_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `Kardex_idTipoMovimiento` FOREIGN KEY (`cod_tipo_movimiento`) REFERENCES `tbl_tipo_movimiento` (`cod_tipo_movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_kardex VALUES("1","12","1","2023-03-17 00:00:00","20");
INSERT INTO tbl_kardex VALUES("2","12","2","2023-03-17 00:00:00","10");
INSERT INTO tbl_kardex VALUES("3","15","2","2023-04-19 00:34:20","1");
INSERT INTO tbl_kardex VALUES("4","19","2","2023-04-19 00:34:20","1");
INSERT INTO tbl_kardex VALUES("5","18","2","2023-04-19 00:34:20","10");
INSERT INTO tbl_kardex VALUES("6","13","1","2023-04-19 00:47:58","10");
INSERT INTO tbl_kardex VALUES("7","16","1","2023-04-19 00:47:58","12");
INSERT INTO tbl_kardex VALUES("9","12","2","2023-04-19 00:51:37","11");
INSERT INTO tbl_kardex VALUES("10","20","2","2023-04-19 00:51:37","22");
INSERT INTO tbl_kardex VALUES("11","17","2","2023-04-19 00:51:37","33");
INSERT INTO tbl_kardex VALUES("12","15","1","2023-04-19 08:43:35","2");
INSERT INTO tbl_kardex VALUES("13","15","1","2023-04-19 08:43:37","2");
INSERT INTO tbl_kardex VALUES("14","15","1","2023-04-19 08:43:59","2");
INSERT INTO tbl_kardex VALUES("15","18","1","2023-04-19 08:47:48","12");
INSERT INTO tbl_kardex VALUES("16","18","2","2023-04-19 09:09:23","1");
INSERT INTO tbl_kardex VALUES("17","18","2","2023-04-19 09:14:50","1");
INSERT INTO tbl_kardex VALUES("18","19","2","2023-04-19 09:14:50","1");
INSERT INTO tbl_kardex VALUES("20","15","2","2023-04-19 09:32:27","1");
INSERT INTO tbl_kardex VALUES("21","18","2","2023-04-19 09:32:27","1");
INSERT INTO tbl_kardex VALUES("23","15","2","2023-04-19 09:32:51","1");
INSERT INTO tbl_kardex VALUES("24","18","2","2023-04-19 09:33:56","1");
INSERT INTO tbl_kardex VALUES("25","19","2","2023-04-19 09:34:25","1");
INSERT INTO tbl_kardex VALUES("26","15","1","2023-04-19 12:27:21","10");
INSERT INTO tbl_kardex VALUES("27","18","2","2023-04-19 12:50:06","1");
INSERT INTO tbl_kardex VALUES("28","18","2","2023-04-19 12:51:24","1");
INSERT INTO tbl_kardex VALUES("29","18","2","2023-04-19 13:06:10","1");
INSERT INTO tbl_kardex VALUES("30","18","2","2023-04-19 13:13:04","1");
INSERT INTO tbl_kardex VALUES("31","15","2","2023-04-20 18:06:49","1");
INSERT INTO tbl_kardex VALUES("32","19","2","2023-04-20 18:06:49","1");
INSERT INTO tbl_kardex VALUES("34","18","2","2023-04-20 21:37:04","1");
INSERT INTO tbl_kardex VALUES("35","16","2","2023-04-21 13:00:19","30");
INSERT INTO tbl_kardex VALUES("36","20","2","2023-04-21 13:00:19","40");
INSERT INTO tbl_kardex VALUES("38","15","2","2023-04-21 17:36:27","1");
INSERT INTO tbl_kardex VALUES("39","19","2","2023-04-21 17:36:27","5");
INSERT INTO tbl_kardex VALUES("40","12","2","2023-04-21 17:36:27","5");
INSERT INTO tbl_kardex VALUES("41","17","2","2023-04-21 17:36:27","5");
INSERT INTO tbl_kardex VALUES("42","16","2","2023-04-21 17:36:27","30");
INSERT INTO tbl_kardex VALUES("43","20","2","2023-04-21 17:36:27","40");
INSERT INTO tbl_kardex VALUES("45","19","2","2023-04-21 21:16:40","5");
INSERT INTO tbl_kardex VALUES("46","12","2","2023-04-21 21:16:40","5");
INSERT INTO tbl_kardex VALUES("47","17","2","2023-04-21 21:16:40","5");
INSERT INTO tbl_kardex VALUES("48","18","2","2023-04-21 21:16:40","1");
INSERT INTO tbl_kardex VALUES("49","15","2","2023-04-21 21:16:40","1");
INSERT INTO tbl_kardex VALUES("52","15","2","2023-04-21 22:14:25","1");
INSERT INTO tbl_kardex VALUES("53","16","2","2023-04-21 22:14:25","30");
INSERT INTO tbl_kardex VALUES("54","20","2","2023-04-21 22:14:25","40");
INSERT INTO tbl_kardex VALUES("55","15","2","2023-04-21 22:56:55","1");
INSERT INTO tbl_kardex VALUES("56","16","2","2023-04-21 22:56:55","30");
INSERT INTO tbl_kardex VALUES("57","20","2","2023-04-21 22:56:55","40");
INSERT INTO tbl_kardex VALUES("58","19","2","2023-04-21 23:02:46","5");
INSERT INTO tbl_kardex VALUES("59","12","2","2023-04-21 23:02:46","5");
INSERT INTO tbl_kardex VALUES("60","17","2","2023-04-21 23:02:46","5");
INSERT INTO tbl_kardex VALUES("61","15","2","2023-04-21 23:02:46","3");
INSERT INTO tbl_kardex VALUES("65","19","2","2023-04-22 12:21:02","5");
INSERT INTO tbl_kardex VALUES("66","12","2","2023-04-22 12:21:02","5");
INSERT INTO tbl_kardex VALUES("67","17","2","2023-04-22 12:21:02","5");
INSERT INTO tbl_kardex VALUES("68","19","2","2023-04-22 12:54:17","5");
INSERT INTO tbl_kardex VALUES("69","12","2","2023-04-22 12:54:17","5");
INSERT INTO tbl_kardex VALUES("70","17","2","2023-04-22 12:54:17","5");
INSERT INTO tbl_kardex VALUES("71","19","2","2023-04-22 12:56:29","5");
INSERT INTO tbl_kardex VALUES("72","12","2","2023-04-22 12:56:29","5");
INSERT INTO tbl_kardex VALUES("73","17","2","2023-04-22 12:56:29","5");
INSERT INTO tbl_kardex VALUES("74","15","2","2023-04-22 12:57:11","1");
INSERT INTO tbl_kardex VALUES("75","16","2","2023-04-22 12:57:11","30");
INSERT INTO tbl_kardex VALUES("76","20","2","2023-04-22 12:57:11","40");
INSERT INTO tbl_kardex VALUES("77","16","2","2023-04-22 14:17:11","30");
INSERT INTO tbl_kardex VALUES("78","20","2","2023-04-22 14:17:11","40");
INSERT INTO tbl_kardex VALUES("79","15","2","2023-04-22 14:17:11","14");
INSERT INTO tbl_kardex VALUES("80","15","2","2023-04-22 15:05:13","1");
INSERT INTO tbl_kardex VALUES("81","19","2","2023-04-22 15:05:13","5");
INSERT INTO tbl_kardex VALUES("82","12","2","2023-04-22 15:05:13","5");
INSERT INTO tbl_kardex VALUES("83","17","2","2023-04-22 15:05:13","5");
INSERT INTO tbl_kardex VALUES("84","16","2","2023-04-22 15:05:13","30");
INSERT INTO tbl_kardex VALUES("85","20","2","2023-04-22 15:05:13","40");
INSERT INTO tbl_kardex VALUES("86","18","2","2023-04-22 15:05:13","1");
INSERT INTO tbl_kardex VALUES("87","15","2","2023-04-23 18:52:57","1");
INSERT INTO tbl_kardex VALUES("88","15","2","2023-04-23 19:27:31","1");
INSERT INTO tbl_kardex VALUES("89","15","2","2023-04-23 19:27:34","1");
INSERT INTO tbl_kardex VALUES("90","15","2","2023-04-23 19:27:58","1");
INSERT INTO tbl_kardex VALUES("91","15","2","2023-04-23 19:29:52","1");
INSERT INTO tbl_kardex VALUES("92","15","2","2023-04-23 19:35:13","1");
INSERT INTO tbl_kardex VALUES("93","15","2","2023-04-23 19:36:43","1");
INSERT INTO tbl_kardex VALUES("94","15","2","2023-04-23 19:46:51","1");
INSERT INTO tbl_kardex VALUES("95","15","2","2023-04-23 19:52:48","1");
INSERT INTO tbl_kardex VALUES("96","15","2","2023-04-23 20:02:28","1");
INSERT INTO tbl_kardex VALUES("97","15","2","2023-04-23 20:07:13","1");
INSERT INTO tbl_kardex VALUES("98","15","2","2023-04-23 20:07:15","1");
INSERT INTO tbl_kardex VALUES("99","15","2","2023-04-23 20:07:56","1");
INSERT INTO tbl_kardex VALUES("100","15","2","2023-04-23 20:08:52","1");
INSERT INTO tbl_kardex VALUES("101","15","2","2023-04-23 22:24:08","1");
INSERT INTO tbl_kardex VALUES("102","15","1","2023-04-24 08:31:13","10");
INSERT INTO tbl_kardex VALUES("103","18","2","2023-04-24 11:13:45","1");
INSERT INTO tbl_kardex VALUES("104","19","2","2023-04-24 11:13:45","14");
INSERT INTO tbl_kardex VALUES("105","19","2","2023-04-24 11:13:45","5");
INSERT INTO tbl_kardex VALUES("106","12","2","2023-04-24 11:13:45","5");
INSERT INTO tbl_kardex VALUES("107","17","2","2023-04-24 11:13:45","5");
INSERT INTO tbl_kardex VALUES("110","19","2","2023-04-24 11:24:46","4");
INSERT INTO tbl_kardex VALUES("111","21","2","2023-04-24 16:37:51","1");
INSERT INTO tbl_kardex VALUES("112","18","2","2023-04-24 16:37:51","1");
INSERT INTO tbl_kardex VALUES("113","24","2","2023-04-24 16:37:51","2");
INSERT INTO tbl_kardex VALUES("114","25","2","2023-04-24 16:37:51","2");
INSERT INTO tbl_kardex VALUES("115","18","2","2023-04-24 16:37:51","1");
INSERT INTO tbl_kardex VALUES("116","15","2","2023-04-28 10:27:29","1");
INSERT INTO tbl_kardex VALUES("117","18","2","2023-04-28 10:27:29","1");
INSERT INTO tbl_kardex VALUES("118","24","2","2023-04-28 10:27:29","2");
INSERT INTO tbl_kardex VALUES("119","25","2","2023-04-28 10:27:29","2");
INSERT INTO tbl_kardex VALUES("123","19","2","2023-04-28 10:30:50","1");
INSERT INTO tbl_kardex VALUES("124","18","2","2023-04-28 10:30:50","3");
INSERT INTO tbl_kardex VALUES("125","19","2","2023-04-28 10:30:50","2");
INSERT INTO tbl_kardex VALUES("126","18","2","2023-04-28 20:24:31","2");
INSERT INTO tbl_kardex VALUES("127","18","2","2023-04-28 20:24:31","1");
INSERT INTO tbl_kardex VALUES("128","24","2","2023-04-28 20:24:31","2");
INSERT INTO tbl_kardex VALUES("129","25","2","2023-04-28 20:24:31","2");
INSERT INTO tbl_kardex VALUES("130","22","2","2023-04-28 20:24:31","1");
INSERT INTO tbl_kardex VALUES("133","18","2","2023-04-29 00:10:37","1");
INSERT INTO tbl_kardex VALUES("134","18","2","2023-04-29 00:10:37","3");
INSERT INTO tbl_kardex VALUES("135","19","2","2023-04-29 00:10:37","2");
INSERT INTO tbl_kardex VALUES("136","16","1","2023-04-29 00:15:02","1");
INSERT INTO tbl_kardex VALUES("137","20","1","2023-04-29 00:15:02","1");
INSERT INTO tbl_kardex VALUES("138","13","1","2023-04-29 00:15:02","2");
INSERT INTO tbl_kardex VALUES("139","12","2","2023-04-29 00:16:21","2");
INSERT INTO tbl_kardex VALUES("140","17","2","2023-04-29 00:16:21","1");
INSERT INTO tbl_kardex VALUES("142","19","1","2023-04-29 00:16:28","1");



DROP TABLE IF EXISTS tbl_ms_bitacora;

CREATE TABLE `tbl_ms_bitacora` (
  `id_bitacora` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `id_objeto` bigint DEFAULT NULL,
  `accion` varchar(20) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_bitacora`),
  KEY `bitacora_objeto_idx` (`id_objeto`),
  KEY `bitacora_usuario_idx` (`id_usuario`),
  CONSTRAINT `bitacora_objeto` FOREIGN KEY (`id_objeto`) REFERENCES `tbl_ms_objetos` (`id_objeto`),
  CONSTRAINT `bitacora_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=904 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
INSERT INTO tbl_ms_bitacora VALUES("148","2023-04-13 22:40:44","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("149","2023-04-13 22:42:19","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("150","2023-04-13 22:43:18","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("151","2023-04-13 22:45:28","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("152","2023-04-13 22:46:01","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("153","2023-04-14 00:07:27","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("154","2023-04-14 00:12:02","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("155","2023-04-14 00:14:08","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("156","2023-04-14 00:14:21","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("157","2023-04-14 18:17:53","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("158","2023-04-14 18:17:58","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("159","2023-04-14 18:27:49","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("160","2023-04-14 18:28:01","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("161","2023-04-14 18:28:06","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("162","2023-04-14 18:28:16","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("163","2023-04-14 18:28:45","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("164","2023-04-14 18:29:35","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("165","2023-04-14 18:29:42","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("166","2023-04-14 18:36:05","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("167","2023-04-14 18:36:08","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("168","2023-04-14 18:50:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("169","2023-04-14 18:54:28","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("170","2023-04-14 18:56:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("171","2023-04-14 18:57:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("172","2023-04-14 18:57:30","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("173","2023-04-14 18:57:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("174","2023-04-14 18:58:03","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("175","2023-04-14 19:00:29","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("176","2023-04-14 19:00:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("177","2023-04-14 19:04:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("178","2023-04-14 19:05:20","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("179","2023-04-14 19:05:32","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("180","2023-04-14 19:56:07","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("181","2023-04-14 21:03:43","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("182","2023-04-14 22:32:31","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("183","2023-04-14 22:33:52","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("184","2023-04-14 22:34:18","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("185","2023-04-14 22:34:28","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("186","2023-04-14 22:44:33","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("187","2023-04-15 00:00:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("188","2023-04-15 00:01:25","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("189","2023-04-15 00:01:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("190","2023-04-15 00:02:12","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("191","2023-04-15 00:04:46","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("192","2023-04-15 00:05:02","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("193","2023-04-15 00:06:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("194","2023-04-15 00:07:17","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("195","2023-04-15 00:08:04","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("196","2023-04-15 00:09:45","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("197","2023-04-15 00:10:43","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("198","2023-04-15 00:11:52","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("199","2023-04-15 00:12:18","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("200","2023-04-15 00:12:35","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("201","2023-04-15 00:15:21","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("202","2023-04-15 00:16:08","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("203","2023-04-15 00:17:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("204","2023-04-15 00:17:36","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("205","2023-04-15 00:20:18","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("206","2023-04-15 00:21:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("207","2023-04-15 00:22:29","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("208","2023-04-15 00:23:02","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("209","2023-04-15 17:24:57","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("210","2023-04-15 17:30:38","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("211","2023-04-15 17:31:12","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("212","2023-04-15 17:31:55","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("213","2023-04-15 17:32:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("214","2023-04-15 17:32:53","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("215","2023-04-15 17:34:44","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("216","2023-04-15 17:35:48","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("217","2023-04-15 17:37:19","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("218","2023-04-15 17:40:08","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("219","2023-04-15 19:52:10","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("220","2023-04-15 19:52:15","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("221","2023-04-15 19:53:36","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("222","2023-04-15 19:55:13","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("223","2023-04-15 20:07:25","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("224","2023-04-15 20:07:26","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("225","2023-04-15 20:22:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("226","2023-04-15 20:22:17","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("227","2023-04-15 20:22:27","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("228","2023-04-15 20:22:53","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("229","2023-04-15 20:22:59","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("230","2023-04-15 20:23:20","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("231","2023-04-15 20:25:11","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("232","2023-04-15 22:36:20","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("233","2023-04-15 22:36:56","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("234","2023-04-15 22:37:09","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("235","2023-04-15 22:37:38","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("236","2023-04-15 22:38:15","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("237","2023-04-15 22:38:55","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("238","2023-04-15 22:41:54","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("239","2023-04-15 22:42:44","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("240","2023-04-15 22:42:47","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("241","2023-04-15 22:43:22","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("242","2023-04-15 22:46:57","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("243","2023-04-15 22:47:25","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("244","2023-04-15 22:48:01","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("245","2023-04-15 23:47:42","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("246","2023-04-15 23:59:24","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("247","2023-04-16 00:17:11","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("248","2023-04-16 02:05:18","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("249","2023-04-16 02:07:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("250","2023-04-16 02:21:03","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("251","2023-04-16 02:55:21","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("252","2023-04-16 02:55:28","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("253","2023-04-16 02:55:36","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PARAMETRO");
INSERT INTO tbl_ms_bitacora VALUES("254","2023-04-16 02:55:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("255","2023-04-16 02:56:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("256","2023-04-16 02:56:57","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("257","2023-04-16 02:57:05","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PARAMETRO");
INSERT INTO tbl_ms_bitacora VALUES("258","2023-04-16 02:57:10","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("259","2023-04-16 08:56:44","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("260","2023-04-16 08:57:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("261","2023-04-16 09:14:06","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("262","2023-04-16 09:25:26","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("263","2023-04-16 09:25:45","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("264","2023-04-16 09:26:52","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("265","2023-04-16 09:27:04","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("266","2023-04-16 09:32:00","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("267","2023-04-16 10:27:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("268","2023-04-16 10:29:03","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("269","2023-04-16 10:55:58","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("270","2023-04-16 10:56:47","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("271","2023-04-16 10:58:21","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("272","2023-04-16 10:59:03","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("273","2023-04-16 10:59:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("274","2023-04-16 14:11:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("275","2023-04-16 14:11:52","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("276","2023-04-16 14:12:09","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("277","2023-04-16 14:12:22","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("278","2023-04-16 14:13:27","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("279","2023-04-16 14:13:42","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("280","2023-04-16 14:14:37","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("281","2023-04-16 14:15:01","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("282","2023-04-16 14:15:46","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("283","2023-04-16 14:18:31","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("284","2023-04-16 14:19:05","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("285","2023-04-16 14:20:50","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("286","2023-04-16 14:21:42","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("287","2023-04-16 14:21:56","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("288","2023-04-16 14:23:01","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("289","2023-04-16 14:23:29","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("290","2023-04-16 14:24:15","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("291","2023-04-16 14:25:01","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("292","2023-04-16 15:09:04","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("293","2023-04-16 16:04:13","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("294","2023-04-16 18:54:05","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("295","2023-04-16 21:32:46","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("296","2023-04-16 21:33:41","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("297","2023-04-16 21:34:05","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("298","2023-04-16 22:59:06","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("299","2023-04-16 23:16:41","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("300","2023-04-17 00:53:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("301","2023-04-17 01:33:35","1","2","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("302","2023-04-17 01:33:40","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("303","2023-04-17 01:34:01","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("304","2023-04-17 07:58:02","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("305","2023-04-17 07:59:15","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("306","2023-04-17 12:06:59","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("307","2023-04-17 12:09:25","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("308","2023-04-17 20:56:06","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("309","2023-04-17 20:57:03","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("310","2023-04-17 20:58:23","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("311","2023-04-17 21:09:24","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("312","2023-04-17 21:11:55","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("313","2023-04-17 21:29:10","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("314","2023-04-17 21:29:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("315","2023-04-17 21:31:46","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("316","2023-04-17 21:33:00","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("317","2023-04-17 21:33:31","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("318","2023-04-17 21:34:16","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("319","2023-04-17 21:34:28","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("320","2023-04-17 21:39:14","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("321","2023-04-17 21:39:32","1","2","CREAR","CREACIÓN DE PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("322","2023-04-17 21:42:08","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("323","2023-04-17 21:42:52","1","2","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("324","2023-04-17 21:43:03","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("325","2023-04-17 21:46:43","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("326","2023-04-17 21:46:52","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("327","2023-04-17 21:47:03","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("328","2023-04-17 21:47:56","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("329","2023-04-17 21:48:14","1","2","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("330","2023-04-17 21:49:05","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("331","2023-04-17 21:49:23","1","2","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("332","2023-04-17 21:55:15","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("333","2023-04-17 21:55:46","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("334","2023-04-17 21:55:56","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("335","2023-04-17 21:57:17","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("336","2023-04-17 22:11:05","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("337","2023-04-17 22:13:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("338","2023-04-17 22:13:44","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("339","2023-04-17 22:14:28","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("340","2023-04-17 22:24:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("341","2023-04-17 22:25:38","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("342","2023-04-17 22:27:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("343","2023-04-17 22:28:32","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("344","2023-04-17 23:36:25","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("345","2023-04-17 23:36:41","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("346","2023-04-17 23:38:55","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("347","2023-04-17 23:39:03","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("348","2023-04-17 23:39:10","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("349","2023-04-17 23:39:20","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("350","2023-04-17 23:39:27","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("351","2023-04-17 23:40:30","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("352","2023-04-17 23:41:08","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("353","2023-04-17 23:41:14","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("354","2023-04-17 23:44:00","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("355","2023-04-17 23:45:16","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("356","2023-04-17 23:45:21","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("357","2023-04-17 23:45:29","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("358","2023-04-17 23:45:32","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("359","2023-04-17 23:45:54","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("360","2023-04-17 23:46:49","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("361","2023-04-17 23:48:17","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("362","2023-04-17 23:48:37","1","2","ELIMINAR","ELIMINACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("363","2023-04-17 23:48:43","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("364","2023-04-17 23:48:53","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("365","2023-04-17 23:48:56","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("366","2023-04-17 23:49:10","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("367","2023-04-17 23:49:15","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("368","2023-04-17 23:50:55","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("369","2023-04-17 23:51:03","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("370","2023-04-17 23:52:31","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("371","2023-04-17 23:57:15","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("372","2023-04-17 23:57:38","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("373","2023-04-17 23:57:50","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("374","2023-04-17 23:57:58","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("375","2023-04-17 23:58:01","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("376","2023-04-18 00:01:38","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("377","2023-04-18 00:02:16","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("378","2023-04-18 00:02:25","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("379","2023-04-18 00:03:17","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("380","2023-04-18 00:04:04","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("381","2023-04-18 00:04:40","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("382","2023-04-18 00:04:47","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("383","2023-04-18 00:05:22","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("384","2023-04-18 00:05:25","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("385","2023-04-18 00:06:45","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("386","2023-04-18 00:07:18","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("387","2023-04-18 00:07:26","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("388","2023-04-18 00:07:29","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("389","2023-04-18 00:23:56","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("390","2023-04-18 00:24:01","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("391","2023-04-18 00:31:30","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("392","2023-04-18 00:31:36","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("393","2023-04-18 00:32:51","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("394","2023-04-18 00:33:00","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("395","2023-04-18 00:33:08","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("396","2023-04-18 00:33:19","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("397","2023-04-18 00:33:27","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("398","2023-04-18 00:38:05","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("399","2023-04-18 00:38:10","1","2","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("400","2023-04-18 00:38:25","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("401","2023-04-18 00:38:50","1","2","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("402","2023-04-18 00:40:34","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("403","2023-04-18 00:40:57","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("404","2023-04-18 00:41:24","1","2","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("405","2023-04-18 00:43:18","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("406","2023-04-18 00:43:41","1","2","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("407","2023-04-18 00:43:49","1","2","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("408","2023-04-18 00:43:57","1","2","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("409","2023-04-18 00:44:03","1","2","ELIMINAR","ELIMINACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("410","2023-04-18 00:53:44","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("411","2023-04-18 00:54:04","1","2","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("412","2023-04-18 01:16:56","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("413","2023-04-18 01:17:02","1","2","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("414","2023-04-18 01:28:21","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("415","2023-04-18 08:50:19","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("416","2023-04-18 09:47:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("417","2023-04-18 09:48:25","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("418","2023-04-18 10:12:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("419","2023-04-18 10:13:20","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("420","2023-04-18 10:13:58","1","11","INGRESO","INGRESO AL MÓDULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("421","2023-04-18 10:35:34","1","17","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("422","2023-04-18 10:35:48","1","17","ACTUALIZAR","ACTUALIZACIÓN DE PARÁMETRO");
INSERT INTO tbl_ms_bitacora VALUES("423","2023-04-18 10:36:13","1","17","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("424","2023-04-18 10:36:54","1","17","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("425","2023-04-18 15:16:16","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("426","2023-04-18 15:17:46","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("427","2023-04-18 19:27:22","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("428","2023-04-18 19:27:35","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("429","2023-04-19 00:20:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("430","2023-04-19 00:24:43","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("431","2023-04-19 00:34:00","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("432","2023-04-19 00:34:23","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("433","2023-04-19 00:34:46","1","15","INGRESO","INGRESO AL MÓDULO DE KARDEX");
INSERT INTO tbl_ms_bitacora VALUES("434","2023-04-19 00:36:49","1","15","INGRESO","INGRESO AL MÓDULO DE KARDEX");
INSERT INTO tbl_ms_bitacora VALUES("435","2023-04-19 00:39:20","1","21","INGRESO","INGRESO AL MÓDULO PRODUCTOS");
INSERT INTO tbl_ms_bitacora VALUES("436","2023-04-19 00:47:37","1","11","INGRESO","INGRESO AL MÓDULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("437","2023-04-19 00:48:00","1","11","INGRESO","INGRESO AL MÓDULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("438","2023-04-19 00:48:05","1","15","INGRESO","INGRESO AL MÓDULO DE KARDEX");
INSERT INTO tbl_ms_bitacora VALUES("439","2023-04-19 01:09:24","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("440","2023-04-19 01:13:49","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("441","2023-04-19 01:14:19","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("442","2023-04-19 01:15:22","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("443","2023-04-19 01:15:31","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("444","2023-04-19 01:16:03","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("445","2023-04-19 01:16:11","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("446","2023-04-19 01:16:32","1","10","ACTUALIZAR","ACTUALIZACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("447","2023-04-19 01:18:33","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("448","2023-04-19 01:24:07","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("449","2023-04-19 01:24:13","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("450","2023-04-19 01:24:20","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("451","2023-04-19 01:29:13","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("452","2023-04-19 01:29:18","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("453","2023-04-19 01:29:46","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("454","2023-04-19 01:30:27","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("455","2023-04-19 01:30:31","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("456","2023-04-19 01:30:35","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("457","2023-04-19 02:08:56","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("458","2023-04-19 02:15:25","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("459","2023-04-19 02:20:33","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("460","2023-04-19 02:20:46","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("461","2023-04-19 02:23:48","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("462","2023-04-19 02:27:51","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("463","2023-04-19 02:28:11","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("464","2023-04-19 02:28:46","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("465","2023-04-19 02:29:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("466","2023-04-19 02:53:32","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("467","2023-04-19 02:53:39","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("468","2023-04-19 02:53:44","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("469","2023-04-19 02:53:47","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("470","2023-04-19 02:57:37","1","4","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("471","2023-04-19 02:57:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("472","2023-04-19 08:36:28","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("473","2023-04-19 08:36:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("474","2023-04-19 08:43:21","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("475",NULL,NULL,NULL,NULL,NULL);
INSERT INTO tbl_ms_bitacora VALUES("476",NULL,NULL,NULL,NULL,NULL);
INSERT INTO tbl_ms_bitacora VALUES("477",NULL,NULL,NULL,NULL,NULL);
INSERT INTO tbl_ms_bitacora VALUES("478","2023-04-19 08:47:54","1","15","INGRESO","INGRESO AL MÓDULO DE KARDEX");
INSERT INTO tbl_ms_bitacora VALUES("479","2023-04-19 09:09:01","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("480","2023-04-19 09:09:30","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("481","2023-04-19 09:14:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("482","2023-04-19 09:32:13","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("483","2023-04-19 09:32:30","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("484","2023-04-19 09:32:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("485","2023-04-19 09:33:13","1","4","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("486","2023-04-19 09:33:39","1","4","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("487","2023-04-19 09:33:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("488","2023-04-19 09:33:58","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("489","2023-04-19 09:34:18","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("490","2023-04-19 09:34:28","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("491","2023-04-19 11:02:37","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("492","2023-04-19 11:07:31","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("493","2023-04-19 11:08:12","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("494","2023-04-19 11:08:44","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("495","2023-04-19 11:08:58","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("496","2023-04-19 11:09:37","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("497","2023-04-19 11:10:06","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("498","2023-04-19 11:13:10","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("499","2023-04-19 11:13:41","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("500","2023-04-19 11:14:53","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("501","2023-04-19 11:15:21","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("502","2023-04-19 11:16:04","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("503","2023-04-19 11:20:32","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("504","2023-04-19 11:23:54","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("505","2023-04-19 11:24:01","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("506","2023-04-19 11:28:10","1","4","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("507","2023-04-19 11:29:02","1","4","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("508","2023-04-19 12:40:00","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("509","2023-04-19 12:40:34","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("510","2023-04-19 12:41:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("511","2023-04-19 12:50:10","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("512","2023-04-19 12:51:09","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("513","2023-04-19 12:51:27","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("514","2023-04-19 12:55:58","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("515","2023-04-19 12:56:41","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("516","2023-04-19 13:05:49","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("517","2023-04-19 13:06:13","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("518","2023-04-19 13:12:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("519","2023-04-19 13:13:06","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("520","2023-04-20 12:13:55","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("521","2023-04-20 12:14:10","1","21","INGRESO","INGRESO AL MÓDULO PRODUCTOS");
INSERT INTO tbl_ms_bitacora VALUES("522","2023-04-20 12:14:19","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("523","2023-04-20 12:15:00","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("524","2023-04-20 18:05:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("525","2023-04-20 18:06:02","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("526","2023-04-20 18:06:51","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("527","2023-04-20 21:37:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("528","2023-04-20 23:12:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("529","2023-04-21 13:00:22","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("530","2023-04-21 17:36:30","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("531","2023-04-21 21:16:43","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("532","2023-04-21 22:14:27","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("533","2023-04-21 22:56:57","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("534","2023-04-21 23:01:45","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("535","2023-04-21 23:02:49","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("536","2023-04-21 23:12:26","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("537","2023-04-22 12:21:04","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("538","2023-04-22 12:54:19","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("539","2023-04-22 12:56:31","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("540","2023-04-22 12:57:13","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("541","2023-04-22 14:17:13","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("542","2023-04-22 15:03:11","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("543","2023-04-22 15:05:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("544","2023-04-22 17:39:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("545","2023-04-23 18:53:00","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("546","2023-04-23 19:29:55","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("547","2023-04-23 19:34:59","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("548","2023-04-23 19:35:17","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("549","2023-04-23 19:36:45","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("550","2023-04-23 19:46:35","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("551","2023-04-23 19:46:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("552","2023-04-23 19:52:41","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("553","2023-04-23 19:52:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("554","2023-04-23 20:02:32","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("555","2023-04-23 20:06:57","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("556","2023-04-23 20:08:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("557","2023-04-23 20:16:51","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("558","2023-04-23 20:16:58","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("559","2023-04-23 20:21:11","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("560","2023-04-23 20:21:41","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("561","2023-04-23 20:22:20","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("562","2023-04-23 22:24:11","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("563","2023-04-23 22:31:21","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("564","2023-04-23 22:32:11","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("565","2023-04-23 22:34:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("566","2023-04-23 22:35:34","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("567","2023-04-23 22:36:10","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("568","2023-04-23 22:36:43","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("569","2023-04-23 22:38:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("570","2023-04-23 22:40:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("571","2023-04-23 22:45:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("572","2023-04-23 22:46:56","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("573","2023-04-23 22:49:59","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("574","2023-04-23 22:50:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("575","2023-04-23 22:59:56","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("576","2023-04-23 23:00:28","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("577","2023-04-23 23:00:56","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("578","2023-04-23 23:06:45","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("579","2023-04-23 23:07:01","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("580","2023-04-23 23:07:05","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("581","2023-04-23 23:07:20","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("582","2023-04-23 23:07:43","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("583","2023-04-23 23:07:55","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("584","2023-04-23 23:08:00","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("585","2023-04-23 23:08:47","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("586","2023-04-23 23:09:23","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("587","2023-04-23 23:14:44","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("588","2023-04-23 23:53:26","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("589","2023-04-23 23:53:33","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("590","2023-04-23 23:53:40","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("591","2023-04-24 00:07:08","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("592","2023-04-24 00:08:38","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("593","2023-04-24 00:08:44","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("594","2023-04-24 00:09:04","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("595","2023-04-24 00:09:08","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("596","2023-04-24 00:10:10","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("597","2023-04-24 00:16:51","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("598","2023-04-24 01:59:05","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("599","2023-04-24 01:59:15","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("600","2023-04-24 02:05:36","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("601","2023-04-24 02:05:50","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("602","2023-04-24 02:07:54","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("603","2023-04-24 02:13:45","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("604","2023-04-24 02:15:38","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("605","2023-04-24 02:20:32","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("606","2023-04-24 02:22:56","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("607","2023-04-24 02:27:01","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("608","2023-04-24 02:30:34","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("609","2023-04-24 02:31:36","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("610","2023-04-24 02:32:04","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("611","2023-04-24 02:33:00","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("612","2023-04-24 02:33:55","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("613","2023-04-24 02:35:47","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("614","2023-04-24 02:40:48","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("615","2023-04-24 02:43:23","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("616","2023-04-24 02:45:45","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("617","2023-04-24 02:46:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("618","2023-04-24 03:00:58","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("619","2023-04-24 07:53:34","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("620","2023-04-24 07:53:46","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("621","2023-04-24 07:55:55","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("622","2023-04-24 08:30:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("623","2023-04-24 08:32:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("624","2023-04-24 11:13:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("625","2023-04-24 11:19:04","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("626","2023-04-24 11:19:33","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("627","2023-04-24 11:19:38","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("628","2023-04-24 11:19:42","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("629","2023-04-24 11:19:47","1","10","ELIMINAR","ELIMINACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("630","2023-04-24 11:24:28","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("631","2023-04-24 11:24:49","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("632","2023-04-24 11:30:25","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("633","2023-04-24 11:30:47","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("634","2023-04-24 12:49:00","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("635","2023-04-24 13:48:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("636","2023-04-24 13:48:57","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("637","2023-04-24 15:08:10","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("638","2023-04-24 15:08:23","1","22","ACTUALIZAR","ACTUALIZACIÓN DE PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("639","2023-04-24 15:08:27","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("640","2023-04-24 15:08:45","1","22","ACTUALIZAR","ACTUALIZACIÓN DE PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("641","2023-04-24 15:08:51","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("642","2023-04-24 15:10:05","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("643","2023-04-24 15:10:14","1","22","ACTUALIZAR","ACTUALIZACIÓN DE PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("644","2023-04-24 15:10:18","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("645","2023-04-24 15:10:40","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("646","2023-04-24 15:10:47","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("647","2023-04-24 15:10:57","1","22","ACTUALIZAR","ACTUALIZACIÓN DE PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("648","2023-04-24 15:10:57","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("649","2023-04-24 15:11:06","1","22","ACTUALIZAR","ACTUALIZACIÓN DE PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("650","2023-04-24 15:11:06","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("651","2023-04-24 15:13:06","1","22","ACTUALIZAR","ACTUALIZACIÓN DE PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("652","2023-04-24 15:13:06","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("653","2023-04-24 15:15:04","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("654","2023-04-24 15:20:18","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("655","2023-04-24 15:20:24","1","21","INGRESO","INGRESO AL MÓDULO PRODUCTOS");
INSERT INTO tbl_ms_bitacora VALUES("656","2023-04-24 15:21:08","1","21","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("657","2023-04-24 15:21:30","1","21","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("658","2023-04-24 15:22:09","1","21","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("659","2023-04-24 15:22:42","1","21","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("660","2023-04-24 15:23:06","1","21","CREAR","CREACION DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("661","2023-04-24 15:23:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("662","2023-04-24 15:25:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("663","2023-04-24 15:28:36","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("664","2023-04-24 15:28:45","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("665","2023-04-24 15:30:12","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("666","2023-04-24 15:30:14","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("667","2023-04-24 15:30:40","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("668","2023-04-24 15:30:47","1","21","INGRESO","INGRESO AL MÓDULO PRODUCTOS");
INSERT INTO tbl_ms_bitacora VALUES("669","2023-04-24 15:31:16","1","21","ACTUALIZAR","ACTUALIZACIÓN DE PRODUCTO");
INSERT INTO tbl_ms_bitacora VALUES("670","2023-04-24 15:32:03","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("671","2023-04-24 15:36:57","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("672","2023-04-24 15:37:09","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("673","2023-04-24 15:38:31","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("674","2023-04-24 16:20:01","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("675","2023-04-24 16:33:44","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("676","2023-04-24 16:37:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("677","2023-04-24 16:40:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("678","2023-04-24 16:44:00","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("679","2023-04-24 16:48:06","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("680","2023-04-24 16:48:15","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("681","2023-04-24 16:48:20","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("682","2023-04-25 23:09:21","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("683","2023-04-26 01:13:39","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("684","2023-04-27 21:03:31","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("685","2023-04-27 21:18:09","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("686","2023-04-27 21:19:50","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("687","2023-04-27 21:20:23","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("688","2023-04-27 21:23:06","1","24","ELIMINAR","ELIMINACIÓN DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("689","2023-04-27 21:23:14","1","24","ELIMINAR","ELIMINACIÓN DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("690","2023-04-27 21:23:20","1","23","INGRESO","INGRESO AL MÓDULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("691","2023-04-27 21:24:44","1","17","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("692","2023-04-27 21:25:38","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("693","2023-04-27 21:25:43","1","16","INGRESO","INGRESO AL MÓDULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("694","2023-04-27 21:26:22","1","4","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("695","2023-04-27 21:27:21","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("696","2023-04-27 21:27:24","1","16","INGRESO","INGRESO AL MÓDULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("697","2023-04-27 21:27:32","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("698","2023-04-27 21:28:39","1","18","CREAR","CREACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("699","2023-04-27 21:29:12","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("700","2023-04-27 23:46:33","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("701","2023-04-28 00:13:20","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("702","2023-04-28 00:13:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("703","2023-04-28 10:27:35","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("704","2023-04-28 10:30:52","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("705","2023-04-28 14:52:12","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("706","2023-04-28 20:23:04","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("707","2023-04-28 20:23:52","1","24","ACTUALIZAR","ACTUALIZACIÓN DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("708","2023-04-28 20:23:54","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("709","2023-04-28 20:24:03","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("710","2023-04-28 20:24:06","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("711","2023-04-28 20:24:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("712","2023-04-28 20:27:05","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("713","2023-04-29 00:00:07","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("714","2023-04-29 00:02:08","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("715","2023-04-29 00:02:19","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("716","2023-04-29 00:04:47","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("717","2023-04-29 00:06:02","1","22","INGRESO","INGRESO AL MÓDULO PROMOCIÓN");
INSERT INTO tbl_ms_bitacora VALUES("718","2023-04-29 00:10:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("719","2023-04-29 00:10:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("720","2023-04-29 00:10:50","1","11","INGRESO","INGRESO AL MÓDULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("721","2023-04-29 00:15:05","1","11","INGRESO","INGRESO AL MÓDULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("722","2023-04-29 00:15:55","1","11","INGRESO","INGRESO AL MÓDULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("723","2023-04-29 00:16:54","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("724","2023-05-04 20:29:51","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("725","2023-05-04 20:30:01","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("726","2023-05-04 20:32:28","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("727","2023-05-04 20:33:52","1","18","CREAR","CREACIÓN DE PREGUNTA .EE. ");
INSERT INTO tbl_ms_bitacora VALUES("728","2023-05-04 20:36:03","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("729","2023-05-04 20:38:00","1","18","CREAR","SE INSERTÓ LA PREGUNTA: COMO SE LLAMA TU ABUELA MATERNA");
INSERT INTO tbl_ms_bitacora VALUES("730","2023-05-04 20:50:40","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("731","2023-05-04 20:52:15","1","18","CREAR","SE CREÓ LA PREGUNTA: CóMO");
INSERT INTO tbl_ms_bitacora VALUES("732","2023-05-04 20:52:44","1","18","CREAR","SE CREÓ LA PREGUNTA: CóMO SE LLAMA TU MASCOTA");
INSERT INTO tbl_ms_bitacora VALUES("733","2023-05-04 20:52:49","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("734","2023-05-04 20:54:27","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("735","2023-05-04 20:54:53","1","18","CREAR","SE CREÓ LA PREGUNTA: CóMO SE LLAMA?");
INSERT INTO tbl_ms_bitacora VALUES("736","2023-05-04 21:02:46","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("737","2023-05-04 21:03:10","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("738","2023-05-04 21:03:17","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("739","2023-05-04 21:03:22","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("740","2023-05-04 21:04:34","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("741","2023-05-04 21:04:40","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("742","2023-05-04 21:05:39","1","24","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("743","2023-05-04 21:05:43","1","24","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("744","2023-05-04 21:05:49","1","24","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("745","2023-05-04 21:06:03","1","24","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("746","2023-05-04 21:06:04","1","24","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("747","2023-05-04 21:07:37","1","24","CREAR","CREACION DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("748","2023-05-04 21:07:40","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("749","2023-05-04 21:07:49","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("750","2023-05-04 21:09:01","192","2","PREGUNTAS","CONTESTO PREGUNTA CORRECTAMENTE");
INSERT INTO tbl_ms_bitacora VALUES("751","2023-05-04 21:09:45","192","2","PREGUNTAS","CONTESTO PREGUNTA CORRECTAMENTE");
INSERT INTO tbl_ms_bitacora VALUES("752","2023-05-04 21:11:59","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("753","2023-05-04 21:12:59","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("754","2023-05-04 21:13:37","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA");
INSERT INTO tbl_ms_bitacora VALUES("755","2023-05-04 21:13:41","1","18","ELIMINAR","SE INTENTÓ ELIMINAR LA PREGUNTA, NO SE ELIMINÓ PORQUE TIENE INTEGRIDAD REFERENCIAL.");
INSERT INTO tbl_ms_bitacora VALUES("756","2023-05-04 21:28:25","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("757","2023-05-04 21:29:29","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("758","2023-05-04 21:33:10","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("759","2023-05-04 21:34:11","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("760","2023-05-04 21:38:31","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("761","2023-05-04 21:39:33","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("762","2023-05-04 21:40:38","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("763","2023-05-04 21:41:39","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("764","2023-05-04 21:41:54","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("765","2023-05-04 21:42:43","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ..");
INSERT INTO tbl_ms_bitacora VALUES("766","2023-05-04 21:43:18","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("767","2023-05-04 21:44:14","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ..");
INSERT INTO tbl_ms_bitacora VALUES("768","2023-05-04 21:46:56","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("769","2023-05-04 21:47:35","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA 20 ");
INSERT INTO tbl_ms_bitacora VALUES("770","2023-05-04 21:50:14","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("771","2023-05-04 21:51:21","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("772","2023-05-04 21:54:32","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("773","2023-05-04 21:55:30","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("774","2023-05-04 22:08:19","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("775","2023-05-04 22:09:56","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("776","2023-05-05 21:38:40","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("777","2023-05-05 21:38:43","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("778","2023-05-05 21:43:18","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("779","2023-05-05 21:50:48","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("780","2023-05-05 21:50:52","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("781","2023-05-05 21:51:12","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("782","2023-05-05 21:52:11","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("783","2023-05-05 21:52:27","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("784","2023-05-05 21:52:45","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("785","2023-05-05 21:53:55","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("786","2023-05-05 21:53:58","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("787","2023-05-05 21:54:01","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("788","2023-05-05 21:54:55","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("789","2023-05-05 21:54:58","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("790","2023-05-05 21:55:00","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("791","2023-05-05 22:01:11","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("792","2023-05-05 22:01:15","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("793","2023-05-05 22:01:16","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("794","2023-05-05 22:01:39","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("795","2023-05-05 22:02:01","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("796","2023-05-05 22:04:31","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("797","2023-05-05 22:04:53","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("798","2023-05-05 22:04:56","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("799","2023-05-05 22:05:01","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("800","2023-05-05 22:05:34","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("801","2023-05-05 22:05:48","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("802","2023-05-05 22:07:42","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("803","2023-05-05 22:07:46","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("804","2023-05-05 22:10:07","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("805","2023-05-05 22:10:13","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("806","2023-05-05 22:10:23","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("807","2023-05-05 22:11:40","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("808","2023-05-05 22:14:22","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("809","2023-05-05 22:14:31","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("810","2023-05-05 22:17:50","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("811","2023-05-05 22:17:53","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("812","2023-05-05 22:17:59","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("813","2023-05-05 22:18:17","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("814","2023-05-05 22:18:31","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("815","2023-05-05 22:19:47","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("816","2023-05-05 22:19:55","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA Array");
INSERT INTO tbl_ms_bitacora VALUES("817","2023-05-05 22:20:01","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("818","2023-05-05 22:20:13","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("819","2023-05-05 22:23:23","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("820","2023-05-05 22:23:27","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA Array");
INSERT INTO tbl_ms_bitacora VALUES("821","2023-05-05 22:23:52","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("822","2023-05-05 22:23:57","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA Array");
INSERT INTO tbl_ms_bitacora VALUES("823","2023-05-05 22:24:09","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("824","2023-05-05 22:24:11","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("825","2023-05-05 22:24:44","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA Array");
INSERT INTO tbl_ms_bitacora VALUES("826","2023-05-05 22:25:51","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("827","2023-05-05 22:26:00","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA Array");
INSERT INTO tbl_ms_bitacora VALUES("828","2023-05-05 22:26:27","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("829","2023-05-05 22:28:32","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("830","2023-05-05 22:28:39","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("831","2023-05-05 22:29:44","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("832","2023-05-05 22:30:55","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("833","2023-05-05 22:31:00","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("834","2023-05-05 22:32:07","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("835","2023-05-05 22:33:59","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("836","2023-05-05 22:36:12","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("837","2023-05-05 22:36:27","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("838","2023-05-05 22:37:16","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("839","2023-05-05 22:37:19","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA Array");
INSERT INTO tbl_ms_bitacora VALUES("840","2023-05-05 22:37:20","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("841","2023-05-05 22:38:20","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("842","2023-05-05 22:38:23","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA Array");
INSERT INTO tbl_ms_bitacora VALUES("843","2023-05-05 22:38:24","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("844","2023-05-05 22:38:28","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("845","2023-05-05 22:38:31","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA Array");
INSERT INTO tbl_ms_bitacora VALUES("846","2023-05-05 22:38:33","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("847","2023-05-05 22:42:15","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("848","2023-05-05 22:42:18","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA Array");
INSERT INTO tbl_ms_bitacora VALUES("849","2023-05-05 22:42:20","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA ");
INSERT INTO tbl_ms_bitacora VALUES("850","2023-05-05 22:42:23","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("851","2023-05-05 22:42:39","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA Array");
INSERT INTO tbl_ms_bitacora VALUES("852","2023-05-05 22:46:03","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("853","2023-05-05 22:46:08","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA s");
INSERT INTO tbl_ms_bitacora VALUES("854","2023-05-05 22:46:33","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("855","2023-05-05 22:46:39","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA r");
INSERT INTO tbl_ms_bitacora VALUES("856","2023-05-05 22:46:42","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA q");
INSERT INTO tbl_ms_bitacora VALUES("857","2023-05-05 22:46:45","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA p");
INSERT INTO tbl_ms_bitacora VALUES("858","2023-05-05 22:46:48","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA o");
INSERT INTO tbl_ms_bitacora VALUES("859","2023-05-05 22:46:52","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA l");
INSERT INTO tbl_ms_bitacora VALUES("860","2023-05-05 22:47:48","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("861","2023-05-05 22:47:58","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA d");
INSERT INTO tbl_ms_bitacora VALUES("862","2023-05-05 22:48:03","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA a");
INSERT INTO tbl_ms_bitacora VALUES("863","2023-05-05 22:48:33","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("864","2023-05-05 22:48:36","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("865","2023-05-05 22:49:57","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("866","2023-05-05 22:50:05","1","18","ELIMINAR","SE INTENTÓ ELIMINAR LA PREGUNTA CóMO SE LLAMA TU MASCOTA, NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.");
INSERT INTO tbl_ms_bitacora VALUES("867","2023-05-05 22:51:20","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("868","2023-05-05 22:51:24","1","18","ELIMINAR","SE INTENTÓ ELIMINAR LA PREGUNTA CóMO SE LLAMA TU MASCOTA, NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.");
INSERT INTO tbl_ms_bitacora VALUES("869","2023-05-05 22:51:27","1","18","ELIMINAR","SE INTENTÓ ELIMINAR LA PREGUNTA COMO SE LLAMA TU ABUELA MATERNA, NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.");
INSERT INTO tbl_ms_bitacora VALUES("870","2023-05-05 22:53:27","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("871","2023-05-05 22:53:30","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA k");
INSERT INTO tbl_ms_bitacora VALUES("872","2023-05-05 22:53:33","1","18","ELIMINAR","SE INTENTÓ ELIMINAR LA PREGUNTA: \"CóMO SE LLAMA TU MASCOTA\", NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.");
INSERT INTO tbl_ms_bitacora VALUES("873","2023-05-05 22:53:37","1","18","ELIMINAR","SE INTENTÓ ELIMINAR LA PREGUNTA: \"COMO SE LLAMA TU ABUELA MATERNA\", NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.");
INSERT INTO tbl_ms_bitacora VALUES("874","2023-05-05 22:53:40","1","24","INGRESO","INGRESO AL MÓDULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("875","2023-05-05 22:54:28","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("876","2023-05-05 22:54:32","1","18","ELIMINAR","SE INTENTÓ ELIMINAR LA PREGUNTA: (CóMO SE LLAMA TU MASCOTA), NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.");
INSERT INTO tbl_ms_bitacora VALUES("877","2023-05-05 22:54:35","1","18","ELIMINAR","ELIMINACIÓN DE PREGUNTA f");
INSERT INTO tbl_ms_bitacora VALUES("878","2023-05-05 22:54:37","1","18","ELIMINAR","SE INTENTÓ ELIMINAR LA PREGUNTA: (COMO SE LLAMA TU ABUELA MATERNA), NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.");
INSERT INTO tbl_ms_bitacora VALUES("879","2023-05-05 22:54:41","1","23","INGRESO","INGRESO AL MÓDULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("880","2023-05-05 23:44:57","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("881","2023-05-05 23:45:02","1","18","ELIMINAR","ELIMINACIÓN DE LA PREGUNTA: j");
INSERT INTO tbl_ms_bitacora VALUES("882","2023-05-05 23:45:43","1","18","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("883","2023-05-05 23:45:46","1","18","ELIMINAR","ELIMINACIÓN DE LA PREGUNTA: i");
INSERT INTO tbl_ms_bitacora VALUES("884","2023-05-05 23:45:50","1","18","ELIMINAR","ELIMINACIÓN DE LA PREGUNTA: h");
INSERT INTO tbl_ms_bitacora VALUES("885","2023-05-05 23:45:52","1","18","ELIMINAR","ELIMINACIÓN DE LA PREGUNTA: g");
INSERT INTO tbl_ms_bitacora VALUES("886","2023-05-05 23:45:56","1","18","ELIMINAR","ELIMINACIÓN DE LA PREGUNTA: e");
INSERT INTO tbl_ms_bitacora VALUES("887","2023-05-05 23:45:59","1","18","ELIMINAR","ELIMINACIÓN DE LA PREGUNTA: ]");
INSERT INTO tbl_ms_bitacora VALUES("888","2023-05-05 23:46:02","1","18","ELIMINAR","ELIMINACIÓN DE LA PREGUNTA: [");
INSERT INTO tbl_ms_bitacora VALUES("889","2023-05-05 23:46:05","1","18","ELIMINAR","SE INTENTÓ ELIMINAR LA PREGUNTA: (COMO SE LLAMA TU ABUELA MATERNA), NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.");
INSERT INTO tbl_ms_bitacora VALUES("890","2023-05-05 23:46:08","1","18","ELIMINAR","SE INTENTÓ ELIMINAR LA PREGUNTA: (CóMO SE LLAMA TU MASCOTA), NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.");
INSERT INTO tbl_ms_bitacora VALUES("891","2023-05-19 14:39:07","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("892","2023-05-19 14:39:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("893","2023-07-28 16:04:41","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("894","2023-07-28 16:05:09","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("895","2023-07-28 16:19:20","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("896","2023-07-28 16:20:00","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("897","2023-07-28 16:20:05","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("898","2023-07-28 16:45:38","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("899","2023-07-28 16:46:03","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("900","2023-07-28 16:46:36","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("901","2023-07-28 16:47:05","1","10","INGRESO","INGRESO AL MÓDULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("902","2023-07-28 16:47:36","1","10","CREAR","CREACIÓN DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("903","2023-07-28 16:48:04","1","10","CREAR","CREACIÓN DE CLIENTE");



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
INSERT INTO tbl_ms_objetos VALUES("14","INVENTARIO",NULL,"1");
INSERT INTO tbl_ms_objetos VALUES("15","KARDEX",NULL,"1");
INSERT INTO tbl_ms_objetos VALUES("16","OBJETOS",NULL,"1");
INSERT INTO tbl_ms_objetos VALUES("17","PARÁMETROS",NULL,"1");
INSERT INTO tbl_ms_objetos VALUES("18","PREGUNTAS",NULL,"1");
INSERT INTO tbl_ms_objetos VALUES("20","PRODUCCIÓN",NULL,"1");
INSERT INTO tbl_ms_objetos VALUES("21","PRODUCTOS",NULL,"1");
INSERT INTO tbl_ms_objetos VALUES("22","PROMOCIÓN",NULL,"1");
INSERT INTO tbl_ms_objetos VALUES("23","ROLES",NULL,"1");
INSERT INTO tbl_ms_objetos VALUES("24","USUARIOS",NULL,"1");
INSERT INTO tbl_ms_objetos VALUES("25","VENTAS",NULL,"1");



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

INSERT INTO tbl_ms_parametros VALUES("1","ADMIN_INTENTOS","3",NULL,NULL,NULL,NULL);
INSERT INTO tbl_ms_parametros VALUES("2","ADMIN_PREGUNTAS","2",NULL,NULL,NULL,NULL);
INSERT INTO tbl_ms_parametros VALUES("3","ADMIN_CORREO","uniformesdelatlantico@hotmail.com",NULL,NULL,NULL,NULL);
INSERT INTO tbl_ms_parametros VALUES("4","FECHA_VENCIMIENTO","30",NULL,NULL,NULL,NULL);
INSERT INTO tbl_ms_parametros VALUES("5","IMPUESTO","15",NULL,NULL,"ADMIN","2023-04-16 02:57:05");
INSERT INTO tbl_ms_parametros VALUES("6","NOMBRE_EMPRESA","INVERSIONES UNIFORMES DEL ATLÁNTICO",NULL,NULL,"ADMIN","2023-04-18 10:35:48");
INSERT INTO tbl_ms_parametros VALUES("7","RAZON_SOCIAL","S. DE R. L. DE C. V.",NULL,NULL,NULL,NULL);
INSERT INTO tbl_ms_parametros VALUES("8","TELEFONO_EMPRESA","9970-5887",NULL,NULL,NULL,NULL);
INSERT INTO tbl_ms_parametros VALUES("9","DIRECCION","BO. EL CENTRO, DOMICILIO RENTADO, ATRÁS DE LA DESPENSA FAMILIAR, TELA. ATLÁNTIDA",NULL,NULL,NULL,NULL);
INSERT INTO tbl_ms_parametros VALUES("10","RTN","01079021315692",NULL,NULL,NULL,NULL);



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
) ENGINE=InnoDB AUTO_INCREMENT=573 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

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
INSERT INTO tbl_ms_permisos VALUES("555","4","1","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("556","4","2","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("557","4","4","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("558","4","10","1","1","0","0");
INSERT INTO tbl_ms_permisos VALUES("559","4","11","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("560","4","12","0","1","0","0");
INSERT INTO tbl_ms_permisos VALUES("561","4","13","1","1","1","0");
INSERT INTO tbl_ms_permisos VALUES("562","4","14","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("563","4","15","1","1","0","0");
INSERT INTO tbl_ms_permisos VALUES("564","4","16","1","0","0","1");
INSERT INTO tbl_ms_permisos VALUES("565","4","17","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("566","4","18","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("567","4","20","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("568","4","21","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("569","4","22","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("570","4","23","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("571","4","24","1","0","0","0");
INSERT INTO tbl_ms_permisos VALUES("572","4","25","0","0","0","0");



DROP TABLE IF EXISTS tbl_ms_preguntas;

CREATE TABLE `tbl_ms_preguntas` (
  `id_pregunta` int NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_pregunta`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_ms_preguntas VALUES("9","COMO SE LLAMA TU ABUELA MATERNA");
INSERT INTO tbl_ms_preguntas VALUES("11","CóMO SE LLAMA TU MASCOTA");



DROP TABLE IF EXISTS tbl_ms_preguntas_usuario;

CREATE TABLE `tbl_ms_preguntas_usuario` (
  `id_pregunta` int NOT NULL,
  `id_usuario` bigint NOT NULL,
  `respuesta` varchar(100) DEFAULT NULL,
  KEY `preguntaUsuario_idUsuario_idx` (`id_usuario`),
  CONSTRAINT `preguntaUsuario_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_ms_preguntas_usuario VALUES("11","192","BOBBY");
INSERT INTO tbl_ms_preguntas_usuario VALUES("9","192","ROSA");



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
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

INSERT INTO tbl_ms_usuarios VALUES("1","ADMIN","ADMINISTRADOR","1","ca29863b8b4be2fd63b5bc73276c8e407cda29e03da5c4646b96612110aaf901","2023-05-19 14:39:07","0",NULL,NULL,"admin@atlantico.com","733464113f1d79251461-4ff19d069fb2ec635522-a12faeec9a0c21dd0b33-435908728e5136f3ae80",NULL,"2021-08-20 01:34:15","ADMIN","2023-04-28 20:23:52","1");
INSERT INTO tbl_ms_usuarios VALUES("19","ALEXANDER","ALEXANDER AGUILAR","2","3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c",NULL,"0",NULL,NULL,"alex@hotmail.com",NULL,NULL,"2023-02-04 01:16:01","ADMIN","2023-03-22 10:36:01","4");
INSERT INTO tbl_ms_usuarios VALUES("20","ERIKA","ERIKA AYALA","2","18ac3e7343f016890c510e93f935261169d9e3f565436429830faf0934f4f8e4",NULL,"0",NULL,NULL,"erika3@gmail.com",NULL,NULL,"2023-02-08 21:40:58","ADMIN","2023-03-22 10:35:34","2");
INSERT INTO tbl_ms_usuarios VALUES("104","HECTOR","HECTOR BUSTILLOO","2","3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c",NULL,"2",NULL,NULL,"hector@hotmail.com",NULL,"ADMIN","2023-03-08 15:22:09","ADMIN","2023-03-22 21:14:43","1");
INSERT INTO tbl_ms_usuarios VALUES("190","ANA","ANA","3","c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb",NULL,"0",NULL,NULL,"ana@hotmail.com",NULL,"ADMIN","2023-05-04 21:05:39",NULL,NULL,"1");
INSERT INTO tbl_ms_usuarios VALUES("191","ANALIA","ANALIA","3","c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb",NULL,"0",NULL,NULL,"analia@hotmail.com",NULL,"ADMIN","2023-05-04 21:06:03",NULL,NULL,"1");
INSERT INTO tbl_ms_usuarios VALUES("192","LOPEZ","LOPEZ","1","c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb",NULL,"2",NULL,NULL,"lopez@hotmail.com",NULL,"ADMIN","2023-05-04 21:07:37",NULL,NULL,"1");



DROP TABLE IF EXISTS tbl_porcentaje_descuento;

CREATE TABLE `tbl_porcentaje_descuento` (
  `cod` int NOT NULL AUTO_INCREMENT,
  `porcentaje_descuento` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_porcentaje_descuento VALUES("1","15.00");



DROP TABLE IF EXISTS tbl_produccion;

CREATE TABLE `tbl_produccion` (
  `cod_produccion` int NOT NULL AUTO_INCREMENT,
  `cod_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_usuario` bigint DEFAULT NULL,
  `estado` int DEFAULT '1',
  PRIMARY KEY (`cod_produccion`),
  KEY `Produccion_CodProducto_idx` (`cod_producto`),
  KEY `Produccion_IdUsuario_idx` (`id_usuario`),
  CONSTRAINT `Produccion_CodProducto` FOREIGN KEY (`cod_producto`) REFERENCES `tbl_producto` (`cod_producto`),
  CONSTRAINT `Produccion_IdUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_produccion VALUES("115","15","2","2023-04-18 20:41:31","1","1");
INSERT INTO tbl_produccion VALUES("116","15","10","2023-04-18 20:43:47","1","3");
INSERT INTO tbl_produccion VALUES("117","18","12","2023-04-18 20:45:23","1","1");
INSERT INTO tbl_produccion VALUES("118","19","15","2023-04-18 20:46:12","1","4");
INSERT INTO tbl_produccion VALUES("119","19","1","2023-04-19 00:51:36","1","3");
INSERT INTO tbl_produccion VALUES("120","19","2","2023-04-29 00:16:21","1","2");



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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_producto VALUES("12","TELA","TELA BLANCA","200","30","3","30.00","1",NULL,NULL,NULL,NULL,"87");
INSERT INTO tbl_producto VALUES("13","PINTURA","ROJA","10","100","3","20.00","1",NULL,NULL,NULL,NULL,"52");
INSERT INTO tbl_producto VALUES("15","MONOGRAMA","MONOGRAMA ESCOLAR","3","4","4","65.20","1","ADMIN","2023-04-13 10:21:05","ADMIN","2023-04-13 10:30:07","23");
INSERT INTO tbl_producto VALUES("16","PINTURA PARA SERIGRAFíA","PINTURA","12","23","3","100.00","1","ADMIN","2023-04-13 10:27:48",NULL,NULL,"201");
INSERT INTO tbl_producto VALUES("17","PAPEL VINIL","PAPEL","200","100","3","23.00","1","ADMIN","2023-04-13 10:29:04",NULL,NULL,"122");
INSERT INTO tbl_producto VALUES("18","BUSO ESCOLAR","BUSO","20","40","4","100.00","1","ADMIN","2023-04-13 10:30:40","ADMIN","2023-04-13 10:30:55","29");
INSERT INTO tbl_producto VALUES("19","CAMISA BLANCA","CAMISA","5","100","4","220.00","1","ADMIN","2023-04-13 15:16:06",NULL,NULL,"949");
INSERT INTO tbl_producto VALUES("20","HILASA","HILASA","2","23","3","43.00","1","ADMIN","2023-04-17 01:33:35",NULL,NULL,"124");
INSERT INTO tbl_producto VALUES("21","BANDERA HONDURAS","BANDERA","12","22","4","150.00","1","ADMIN","2023-04-24 15:21:08",NULL,NULL,"11");
INSERT INTO tbl_producto VALUES("22","TERMO","TERMO","12","45","4","100.00","1","ADMIN","2023-04-24 15:21:30","ADMIN","2023-04-24 15:31:16","22");
INSERT INTO tbl_producto VALUES("23","COJíN","COJíN","3","45","4","170.00","1","ADMIN","2023-04-24 15:22:09",NULL,NULL,"100");
INSERT INTO tbl_producto VALUES("24","PANTALóN ESCOLAR","PANTALóN","120","200","4","250.00","1","ADMIN","2023-04-24 15:22:42",NULL,NULL,"8");
INSERT INTO tbl_producto VALUES("25","CUBALLERA BLANCA","CUBALLERA","24","55","4","250.00","1","ADMIN","2023-04-24 15:23:06",NULL,NULL,"30");



DROP TABLE IF EXISTS tbl_promocion;

CREATE TABLE `tbl_promocion` (
  `cod_promocion` int NOT NULL AUTO_INCREMENT,
  `nombre_promocion` varchar(100) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_final` datetime DEFAULT NULL,
  `precio_venta` decimal(8,2) DEFAULT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `estado` int DEFAULT '1',
  PRIMARY KEY (`cod_promocion`),
  KEY `Promo_Usuario_idx` (`id_usuario`),
  CONSTRAINT `Promo_Usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_promocion VALUES("2","PROMO 1","2023-03-30 22:00:00","2023-04-28 23:03:00","500.00","1","1");
INSERT INTO tbl_promocion VALUES("3","PROMO 2","2023-03-30 22:00:00","2023-04-26 23:03:00","400.00","1","1");



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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_promocion_producto VALUES("1","2","18","1");
INSERT INTO tbl_promocion_producto VALUES("2","2","24","2");
INSERT INTO tbl_promocion_producto VALUES("4","2","25","2");
INSERT INTO tbl_promocion_producto VALUES("10","3","18","3");
INSERT INTO tbl_promocion_producto VALUES("11","3","19","2");



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



DROP TABLE IF EXISTS tbl_tipo_movimiento;

CREATE TABLE `tbl_tipo_movimiento` (
  `cod_tipo_movimiento` int NOT NULL AUTO_INCREMENT,
  `nombre_movimiento` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_tipo_movimiento VALUES("1","ENTRADA");
INSERT INTO tbl_tipo_movimiento VALUES("2","SALIDA");



DROP TABLE IF EXISTS tbl_tipo_producto;

CREATE TABLE `tbl_tipo_producto` (
  `cod_tipo_producto` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo_producto` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_tipo_producto VALUES("3","INSUMO");
INSERT INTO tbl_tipo_producto VALUES("4","PRODUCTO TERMINADO");



SET FOREIGN_KEY_CHECKS=1;