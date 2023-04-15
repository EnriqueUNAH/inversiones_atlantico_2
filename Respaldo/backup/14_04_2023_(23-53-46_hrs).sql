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
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS detalle_temp_c;

CREATE TABLE `detalle_temp_c` (
  `cod_detalle_factura` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) NOT NULL,
  `cod_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cod_detalle_factura`),
  KEY `detalle_temp_ibfk_2_idx` (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




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
  `telefono` int DEFAULT NULL,
  `correo_electronico` varchar(30) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `cod_genero` int DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`cod_cliente`),
  KEY `tbl_Genero_Cod_Genero_idx` (`cod_genero`),
  CONSTRAINT `Cliente_CodGenero` FOREIGN KEY (`cod_genero`) REFERENCES `tbl_genero` (`cod_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_cliente VALUES("5","12345","JENNIE K","95501010","","COLONIA LOS PINOS","3","","","","");
INSERT INTO tbl_cliente VALUES("7","5678","DORCA NINOSCA AGUILAR CASTRO","98765432","dorca_aguilar@yahoo.es","COL. LOS PINOS","3","ADMIN","2023-04-13 00:37:04","","");
INSERT INTO tbl_cliente VALUES("8","8902","NOE FABRICIO AGUILAR CASTRO","98766543","noe@yahoo.es","","3","ADMIN","2023-04-13 00:45:48","","");
INSERT INTO tbl_cliente VALUES("9","4567","LUIS JOSE LOPEZ","98765436","","","3","ADMIN","2023-04-13 00:46:19","","");
INSERT INTO tbl_cliente VALUES("10","6789","MARIA JOSE ALVAREZ","98976554","maria@yahoo.es","COL. VILLA VIEJA","3","ADMIN","2023-04-13 01:48:13","","");



DROP TABLE IF EXISTS tbl_compra;

CREATE TABLE `tbl_compra` (
  `cod_compra` int NOT NULL AUTO_INCREMENT,
  `total_pagado` decimal(8,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `estado` int DEFAULT NULL,
  PRIMARY KEY (`cod_compra`),
  KEY `Compra_idUsuario_idx` (`id_usuario`),
  CONSTRAINT `Compra_idUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
INSERT INTO tbl_compra VALUES("14","200.00","","1","");
INSERT INTO tbl_compra VALUES("15","20.00","","1","");
INSERT INTO tbl_compra VALUES("16","10.00","2023-04-13 00:00:00","1","1");
INSERT INTO tbl_compra VALUES("17","30.00","","1","");



DROP TABLE IF EXISTS tbl_configuracion_cai;

CREATE TABLE `tbl_configuracion_cai` (
  `cod_talonario` int NOT NULL AUTO_INCREMENT,
  `rango_inicial` int DEFAULT NULL,
  `rango_final` int DEFAULT NULL,
  `rango_actual` int DEFAULT NULL,
  `numero_CAI` varchar(40) DEFAULT NULL,
  `fecha_vencimiento` datetime DEFAULT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `estado` int DEFAULT NULL,
  PRIMARY KEY (`cod_talonario`),
  KEY `CAI_IdUsuario_idx` (`id_usuario`),
  CONSTRAINT `CAI_IdUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_configuracion_cai VALUES("1","10","100","2","212W2W21R3","2023-04-07 22:57:11","1","");



DROP TABLE IF EXISTS tbl_descuento;

CREATE TABLE `tbl_descuento` (
  `cod_descuento` int NOT NULL AUTO_INCREMENT,
  `nombre_descuento` varchar(20) DEFAULT NULL,
  `porcentaje_descuento` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`cod_descuento`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
INSERT INTO tbl_detalle_compra VALUES("13","20.00","1","13","15");
INSERT INTO tbl_detalle_compra VALUES("14","30.00","1","12","17");



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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_detalle_factura VALUES("1","31","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("2","31","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("4","32","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("5","33","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("6","33","12","1","30.00");
INSERT INTO tbl_detalle_factura VALUES("8","34","12","3","30.00");
INSERT INTO tbl_detalle_factura VALUES("9","34","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("11","35","13","1","20.00");
INSERT INTO tbl_detalle_factura VALUES("12","36","13","1","20.00");



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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_factura VALUES("31","","2023-04-10 05:51:26","1","5","50.00","2","42.50","7.50","15.00");
INSERT INTO tbl_factura VALUES("32","","2023-04-09 23:55:59","1","5","30.00","2","25.50","4.50","15.00");
INSERT INTO tbl_factura VALUES("33","","2023-04-10 00:04:50","1","5","50.00","1","42.50","7.50","15.00");
INSERT INTO tbl_factura VALUES("34","","2023-04-10 16:53:43","1","5","110.00","1","93.50","16.50","15.00");
INSERT INTO tbl_factura VALUES("35","","2023-04-10 22:40:53","1","5","20.00","1","17.00","3.00","15.00");
INSERT INTO tbl_factura VALUES("36","","2023-04-10 22:42:06","1","5","20.00","1","17.00","3.00","15.00");



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
) ENGINE=InnoDB AUTO_INCREMENT=543 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_ms_bitacora VALUES("1","2023-03-29 23:40:35","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("2","2023-03-29 23:41:00","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("3","2023-03-29 23:42:52","136","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("4","2023-03-29 23:43:24","136","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("5","2023-03-29 23:44:41","136","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("6","2023-03-29 23:45:36","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("7","2023-03-29 23:45:48","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("8","2023-03-29 23:45:51","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("9","2023-03-29 23:47:33","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("10","2023-03-29 23:47:50","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("11","2023-03-29 23:48:04","136","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("12","2023-03-29 23:48:16","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("13","2023-03-29 23:48:23","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("14","2023-03-29 23:56:05","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("15","2023-03-29 23:56:08","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("16","2023-03-29 23:56:36","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("17","2023-03-29 23:56:52","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("18","2023-03-29 23:57:12","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("19","2023-03-29 23:57:18","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("20","2023-03-29 23:57:20","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("21","2023-03-29 23:57:31","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("22","2023-03-29 23:57:43","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("23","2023-03-30 00:01:52","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("24","2023-03-30 00:02:22","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("25","2023-03-30 00:02:27","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("26","2023-03-30 00:02:34","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("27","2023-03-30 00:02:58","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("28","2023-03-30 00:03:03","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("29","2023-03-30 00:03:18","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("30","2023-03-30 00:04:40","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("31","2023-03-30 00:04:50","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("32","2023-03-30 00:04:54","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("33","2023-03-30 00:04:57","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("34","2023-03-30 00:05:09","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("35","2023-03-30 00:05:17","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("36","2023-03-30 00:05:26","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("37","2023-03-30 00:05:31","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("38","2023-03-30 00:05:56","136","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("39","2023-03-30 00:06:43","136","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("40","2023-03-30 00:07:10","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("41","2023-03-30 00:07:34","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("42","2023-03-30 00:07:37","136","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("43","2023-03-30 00:07:44","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("44","2023-03-30 00:11:08","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("45","2023-03-30 00:11:20","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("46","2023-03-30 00:11:24","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("47","2023-03-30 00:11:29","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("48","2023-03-30 00:11:31","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("49","2023-03-30 00:11:47","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("50","2023-03-30 00:11:57","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("51","2023-03-30 00:12:01","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("52","2023-03-30 00:12:07","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("53","2023-03-30 00:12:35","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("54","2023-03-30 00:12:39","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("55","2023-03-30 00:14:45","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("56","2023-03-30 00:16:06","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("57","2023-03-30 00:23:56","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("58","2023-03-30 00:24:06","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("59","2023-03-30 00:27:27","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("60","2023-03-30 00:27:42","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("61","2023-03-30 00:28:27","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("62","2023-03-30 00:28:36","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("63","2023-03-30 00:28:41","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("64","2023-03-30 00:28:43","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("65","2023-03-30 00:28:46","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("66","2023-03-30 00:29:06","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("67","2023-03-30 00:29:17","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("68","2023-03-30 00:29:20","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("69","2023-03-30 00:29:28","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("70","2023-03-30 00:30:41","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("71","2023-03-30 00:30:45","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("72","2023-03-30 00:30:49","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("73","2023-03-30 00:30:54","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("74","2023-03-30 00:30:57","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("75","2023-03-30 00:31:03","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("76","2023-03-30 00:31:19","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("77","2023-03-30 00:31:28","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("78","2023-03-30 00:38:23","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("79","2023-03-30 00:38:29","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("80","2023-03-30 00:46:36","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("81","2023-03-30 00:47:04","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("82","2023-03-30 00:47:11","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("83","2023-03-30 00:48:06","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("84","2023-03-30 00:48:14","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("85","2023-03-30 00:48:54","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("86","2023-03-30 00:49:06","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("87","2023-03-30 00:49:47","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("88","2023-03-30 00:50:57","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("89","2023-03-30 00:51:25","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("90","2023-03-30 00:52:18","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("91","2023-03-30 00:52:56","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("92","2023-03-30 00:53:08","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("93","2023-03-30 00:53:15","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("94","2023-03-30 00:53:22","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("95","2023-03-30 00:53:24","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("96","2023-03-30 00:53:32","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("97","2023-03-30 00:53:40","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("98","2023-03-30 00:53:43","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("99","2023-03-30 00:53:49","136","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("100","2023-03-30 00:53:53","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("101","2023-03-30 00:53:57","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("102","2023-03-30 00:54:07","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("103","2023-03-30 00:54:29","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("104","2023-03-30 00:54:34","136","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("105","2023-03-30 00:54:38","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("106","2023-03-30 00:54:41","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("107","2023-03-30 00:54:55","136","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("108","2023-03-30 01:11:47","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("109","2023-03-30 01:11:59","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("110","2023-03-30 01:12:02","136","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("111","2023-03-30 01:12:08","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("112","2023-03-30 01:12:18","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("113","2023-03-30 01:15:31","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("114","2023-03-30 01:16:03","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("115","2023-03-30 01:16:11","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("116","2023-03-30 01:20:22","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("117","2023-03-30 02:14:25","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("118","2023-03-30 12:11:42","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("119","2023-03-30 12:11:53","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("120","2023-03-30 12:11:58","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("121","2023-03-30 12:12:02","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("122","2023-03-30 12:19:54","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("123","2023-03-30 12:46:51","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("124","2023-03-30 12:49:56","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("125","2023-03-30 12:50:40","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("126","2023-03-30 12:55:04","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("127","2023-03-30 12:55:58","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("128","2023-03-30 12:56:02","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("129","2023-03-30 12:56:35","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("130","2023-03-30 13:13:12","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("131","2023-03-30 13:13:15","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("132","2023-03-30 13:13:22","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("133","2023-03-30 13:13:27","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("134","2023-03-30 13:13:30","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("135","2023-03-30 13:13:32","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("136","2023-03-30 13:13:42","136","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("137","2023-03-30 13:13:51","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("138","2023-03-30 13:14:05","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("139","2023-03-30 13:14:44","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("140","2023-03-30 13:14:55","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("141","2023-03-30 13:15:13","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("142","2023-03-30 13:15:22","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("143","2023-03-30 13:15:48","136","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("144","2023-03-30 13:15:57","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("145","2023-03-30 13:16:05","136","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("146","2023-03-30 13:17:19","136","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("147","2023-03-30 13:17:26","136","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("148","2023-03-30 13:17:46","136","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("149","2023-03-30 13:17:55","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("150","2023-03-30 13:27:11","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("151","2023-03-30 13:27:18","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("152","2023-03-30 19:32:23","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("153","2023-03-30 19:32:27","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("154","2023-03-31 11:54:58","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("155","2023-03-31 12:16:21","136","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("156","2023-03-31 12:16:23","136","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("157","2023-04-03 23:46:26","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("158","2023-04-03 23:46:28","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("159","2023-04-04 00:22:20","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("160","2023-04-04 00:22:25","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("161","2023-04-05 09:25:43","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("162","2023-04-05 11:01:20","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("163","2023-04-05 11:01:24","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("164","2023-04-05 11:08:44","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("165","2023-04-05 11:09:08","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("166","2023-04-05 11:19:20","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("167","2023-04-05 11:24:45","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("168","2023-04-05 11:39:26","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("169","2023-04-05 11:41:34","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("170","2023-04-05 11:57:12","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("171","2023-04-05 11:58:25","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("172","2023-04-05 17:24:46","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("173","2023-04-05 17:25:19","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("174","2023-04-05 17:25:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("175","2023-04-05 17:27:17","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("176","2023-04-05 17:28:09","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("177","2023-04-05 17:29:10","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("178","2023-04-05 17:29:20","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("179","2023-04-05 17:29:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("180","2023-04-05 17:30:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("181","2023-04-05 17:40:55","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("182","2023-04-05 17:41:32","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("183","2023-04-05 17:41:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("184","2023-04-05 17:42:43","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("185","2023-04-05 17:46:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("186","2023-04-05 17:46:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("187","2023-04-05 17:48:46","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("188","2023-04-05 17:49:22","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("189","2023-04-06 00:47:11","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("190","2023-04-06 00:47:21","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("191","2023-04-06 00:47:45","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("192","2023-04-06 00:47:51","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("193","2023-04-06 15:49:50","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("194","2023-04-06 15:49:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("195","2023-04-06 16:39:56","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("196","2023-04-06 16:40:04","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("197","2023-04-06 16:40:26","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("198","2023-04-06 16:50:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("199","2023-04-06 21:15:02","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("200","2023-04-06 21:15:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("201","2023-04-06 22:48:30","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("202","2023-04-06 22:50:43","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("203","2023-04-06 22:50:47","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("204","2023-04-06 23:01:42","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("205","2023-04-06 23:40:12","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("206","2023-04-06 23:43:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("207","2023-04-06 23:43:58","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("208","2023-04-06 23:44:21","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("209","2023-04-06 23:45:41","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("210","2023-04-06 23:46:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("211","2023-04-06 23:49:49","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("212","2023-04-06 23:50:28","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("213","2023-04-06 23:52:15","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("214","2023-04-06 23:52:18","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("215","2023-04-07 15:02:47","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("216","2023-04-07 15:02:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("217","2023-04-07 15:06:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("218","2023-04-07 15:07:26","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("219","2023-04-07 15:11:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("220","2023-04-07 15:23:37","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("221","2023-04-07 15:33:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("222","2023-04-07 15:34:52","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("223","2023-04-07 19:59:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("224","2023-04-07 19:59:31","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("225","2023-04-07 21:24:27","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("226","2023-04-07 21:50:28","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("227","2023-04-07 21:50:43","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("228","2023-04-07 22:56:26","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("229","2023-04-07 22:57:11","1","2","CREAR","CREACIÓN DE CAI");
INSERT INTO tbl_ms_bitacora VALUES("230","2023-04-07 22:58:10","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("231","2023-04-07 23:39:34","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("232","2023-04-07 23:39:53","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("233","2023-04-07 23:40:03","1","2","ACTUALIZAR","ACTUALIZACIÓN DE PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("234","2023-04-07 23:41:13","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("235","2023-04-08 00:30:08","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("236","2023-04-08 00:44:30","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("237","2023-04-08 00:44:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("238","2023-04-08 00:47:49","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("239","2023-04-08 00:49:00","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("240","2023-04-08 00:49:16","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("241","2023-04-08 00:50:14","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("242","2023-04-08 00:54:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("243","2023-04-08 00:54:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("244","2023-04-08 00:55:00","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("245","2023-04-08 00:56:25","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("246","2023-04-08 00:56:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("247","2023-04-08 01:02:06","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("248","2023-04-08 01:06:20","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("249","2023-04-08 01:06:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("250","2023-04-08 01:19:11","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("251","2023-04-08 15:19:06","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("252","2023-04-08 15:19:31","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("253","2023-04-08 15:19:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("254","2023-04-08 15:19:47","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("255","2023-04-08 15:19:49","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("256","2023-04-08 15:23:01","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("257","2023-04-08 15:23:03","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("258","2023-04-08 15:23:10","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("259","2023-04-08 15:25:36","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("260","2023-04-08 15:25:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("261","2023-04-08 15:25:41","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("262","2023-04-08 15:25:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("263","2023-04-08 15:30:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("264","2023-04-08 15:55:36","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("265","2023-04-08 15:59:56","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("266","2023-04-08 16:01:37","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("267","2023-04-08 16:45:31","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("268","2023-04-09 07:59:33","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("269","2023-04-09 07:59:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("270","2023-04-09 08:00:25","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("271","2023-04-09 08:04:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("272","2023-04-09 08:04:22","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("273","2023-04-09 08:08:51","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("274","2023-04-09 08:17:08","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("275","2023-04-09 08:17:24","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("276","2023-04-09 08:17:41","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("277","2023-04-09 08:18:10","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("278","2023-04-09 08:23:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("279","2023-04-09 08:23:35","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("280","2023-04-09 08:23:46","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("281","2023-04-09 10:23:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("282","2023-04-09 10:28:28","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("283","2023-04-09 10:34:05","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("284","2023-04-09 10:34:14","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("285","2023-04-09 10:38:32","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("286","2023-04-09 10:39:23","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("287","2023-04-09 10:39:38","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("288","2023-04-09 10:41:52","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("289","2023-04-09 10:56:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("290","2023-04-09 10:56:55","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("291","2023-04-09 10:57:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("292","2023-04-09 10:58:08","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("293","2023-04-09 11:03:51","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("294","2023-04-09 11:05:10","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("295","2023-04-09 11:05:23","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("296","2023-04-09 11:05:26","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("297","2023-04-09 11:05:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("298","2023-04-09 11:05:56","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("299","2023-04-09 11:08:23","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("300","2023-04-09 11:08:44","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("301","2023-04-09 11:10:16","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("302","2023-04-09 11:12:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("303","2023-04-09 11:15:56","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("304","2023-04-09 11:16:09","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("305","2023-04-09 11:18:18","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("306","2023-04-09 11:20:26","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("307","2023-04-09 11:24:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("308","2023-04-09 11:24:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("309","2023-04-09 11:29:31","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("310","2023-04-09 11:38:43","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("311","2023-04-09 11:39:00","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("312","2023-04-09 11:40:02","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("313","2023-04-09 11:42:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("314","2023-04-09 16:43:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("315","2023-04-09 16:44:14","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("316","2023-04-09 18:16:03","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("317","2023-04-09 18:16:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("318","2023-04-09 18:17:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("319","2023-04-09 18:19:50","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("320","2023-04-09 18:22:58","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("321","2023-04-09 18:28:10","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("322","2023-04-09 18:29:08","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("323","2023-04-09 18:30:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("324","2023-04-09 18:34:23","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("325","2023-04-09 18:34:48","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("326","2023-04-09 19:45:55","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("327","2023-04-09 19:46:28","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("328","2023-04-09 19:52:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("329","2023-04-09 19:53:08","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("330","2023-04-09 19:54:04","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("331","2023-04-09 19:54:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("332","2023-04-09 19:54:22","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("333","2023-04-09 19:54:44","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("334","2023-04-09 19:54:52","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("335","2023-04-09 19:55:21","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("336","2023-04-09 19:55:26","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("337","2023-04-09 19:55:31","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("338","2023-04-09 19:55:34","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("339","2023-04-09 19:56:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("340","2023-04-09 19:57:04","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("341","2023-04-09 19:57:27","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("342","2023-04-09 19:57:43","1","2","ACTUALIZAR","ACTUALIZACIÓN DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("343","2023-04-09 19:57:52","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("344","2023-04-09 19:58:00","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("345","2023-04-09 19:58:13","1","2","ACTUALIZAR","ACTUALIZACIÓN DE USUARIO");
INSERT INTO tbl_ms_bitacora VALUES("346","2023-04-09 19:58:19","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("347","2023-04-09 19:58:28","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("348","2023-04-09 19:58:42","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("349","2023-04-09 19:58:52","162","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("350","2023-04-09 19:58:55","162","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("351","2023-04-09 19:59:55","162","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("352","2023-04-09 20:00:14","162","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("353","2023-04-09 20:00:47","162","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("354","2023-04-09 20:00:58","162","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("355","2023-04-09 20:02:54","162","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("356","2023-04-09 20:04:27","162","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("357","2023-04-09 23:16:33","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("358","2023-04-09 23:16:36","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("359","2023-04-09 23:20:27","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("360","2023-04-09 23:22:57","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("361","2023-04-09 23:23:36","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("362","2023-04-09 23:26:52","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("363","2023-04-09 23:28:42","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("364","2023-04-09 23:30:56","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("365","2023-04-09 23:34:05","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("366","2023-04-09 23:34:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("367","2023-04-09 23:35:08","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("368","2023-04-09 23:40:28","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("369","2023-04-09 23:44:33","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("370","2023-04-09 23:44:42","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("371","2023-04-09 23:44:47","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("372","2023-04-09 23:44:52","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("373","2023-04-09 23:44:54","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("374","2023-04-09 23:44:56","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("375","2023-04-09 23:56:47","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("376","2023-04-09 23:57:03","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("377","2023-04-09 23:57:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("378","2023-04-09 23:58:13","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("379","2023-04-09 23:58:38","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("380","2023-04-10 00:04:29","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("381","2023-04-10 00:05:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("382","2023-04-10 16:53:08","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("383","2023-04-10 16:53:12","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("384","2023-04-10 16:55:03","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("385","2023-04-10 21:37:29","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("386","2023-04-10 21:37:38","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("387","2023-04-10 21:37:40","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("388","2023-04-12 22:12:46","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("389","2023-04-12 22:20:19","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("390","2023-04-12 22:24:09","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("391","2023-04-12 22:33:52","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("392","2023-04-12 23:18:07","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("393","2023-04-12 23:59:12","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("394","2023-04-12 23:59:57","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("395","2023-04-13 00:00:13","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("396","2023-04-13 00:07:33","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("397","2023-04-13 00:07:35","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("398","2023-04-13 00:07:42","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("399","2023-04-13 00:09:47","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("400","2023-04-13 00:09:59","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("401","2023-04-13 00:10:16","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("402","2023-04-13 00:20:37","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("403","2023-04-13 00:20:53","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("404","2023-04-13 00:24:42","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("405","2023-04-13 00:25:16","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("406","2023-04-13 00:25:19","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("407","2023-04-13 00:25:27","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("408","2023-04-13 00:27:29","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("409","2023-04-13 00:27:55","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("410","2023-04-13 00:27:57","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("411","2023-04-13 00:29:16","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("412","2023-04-13 00:29:25","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("413","2023-04-13 00:35:31","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("414","2023-04-13 00:35:55","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("415","2023-04-13 00:36:42","1","2","ELIMINAR","ELIMINACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("416","2023-04-13 00:37:04","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("417","2023-04-13 00:39:48","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("418","2023-04-13 00:45:20","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("419","2023-04-13 00:45:48","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("420","2023-04-13 00:46:19","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("421","2023-04-13 00:51:22","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("422","2023-04-13 00:53:36","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("423","2023-04-13 00:53:39","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("424","2023-04-13 00:53:43","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("425","2023-04-13 00:57:22","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("426","2023-04-13 01:05:34","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("427","2023-04-13 01:05:43","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("428","2023-04-13 01:07:47","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("429","2023-04-13 01:08:56","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("430","2023-04-13 01:09:20","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("431","2023-04-13 01:18:49","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("432","2023-04-13 01:19:04","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("433","2023-04-13 01:21:18","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("434","2023-04-13 01:25:34","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("435","2023-04-13 01:26:02","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("436","2023-04-13 01:26:12","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("437","2023-04-13 01:30:48","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("438","2023-04-13 01:32:49","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("439","2023-04-13 01:46:03","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("440","2023-04-13 01:46:08","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("441","2023-04-13 01:46:23","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("442","2023-04-13 01:46:33","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("443","2023-04-13 01:47:27","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("444","2023-04-13 01:47:31","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("445","2023-04-13 01:48:13","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("446","2023-04-13 01:48:45","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("447","2023-04-13 01:48:49","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("448","2023-04-13 01:52:13","1","2","CREAR","CREACION DE CLIENTE");
INSERT INTO tbl_ms_bitacora VALUES("449","2023-04-13 22:34:51","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("450","2023-04-13 22:35:03","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("451","2023-04-13 22:35:56","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("452","2023-04-13 22:43:10","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("453","2023-04-13 22:43:32","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("454","2023-04-13 22:43:40","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("455","2023-04-13 22:43:44","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("456","2023-04-13 22:43:48","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("457","2023-04-13 22:44:17","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("458","2023-04-13 22:45:22","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("459","2023-04-13 22:45:32","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("460","2023-04-13 22:46:10","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("461","2023-04-13 22:46:20","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("462","2023-04-13 22:46:32","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("463","2023-04-13 22:46:51","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("464","2023-04-13 22:48:33","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("465","2023-04-13 22:52:21","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("466","2023-04-13 22:52:46","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("467","2023-04-13 22:52:56","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("468","2023-04-13 22:53:08","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("469","2023-04-13 22:53:16","1","2","INGRESO","INGRESO AL MÓDULO PREGUNTAS");
INSERT INTO tbl_ms_bitacora VALUES("470","2023-04-13 22:53:27","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("471","2023-04-13 22:53:46","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");
INSERT INTO tbl_ms_bitacora VALUES("472","2023-04-13 23:33:17","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("473","2023-04-13 23:35:20","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("474","2023-04-13 23:41:40","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("475","2023-04-13 23:42:09","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("476","2023-04-13 23:42:22","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("477","2023-04-13 23:43:36","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("478","2023-04-13 23:43:56","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("479","2023-04-13 23:44:04","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("480","2023-04-13 23:44:54","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("481","2023-04-13 23:45:20","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("482","2023-04-13 23:45:35","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("483","2023-04-13 23:48:08","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("484","2023-04-13 23:49:15","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("485","2023-04-13 23:51:44","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("486","2023-04-14 00:13:49","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("487","2023-04-14 00:13:52","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("488","2023-04-14 00:14:26","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("489","2023-04-14 00:22:08","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("490","2023-04-14 00:22:12","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("491","2023-04-14 00:26:02","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("492","2023-04-14 00:26:07","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("493","2023-04-14 00:26:20","1","2","CERRAR SESIÓN","USUARIO CERRÓ SESIÓN");
INSERT INTO tbl_ms_bitacora VALUES("494","2023-04-14 20:37:12","1","2","INGRESO","INGRESO AL SISTEMA");
INSERT INTO tbl_ms_bitacora VALUES("495","2023-04-14 20:42:55","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("496","2023-04-14 21:31:06","1","2","INGRESO","INGRESO AL MODULO OBJETOS");
INSERT INTO tbl_ms_bitacora VALUES("497","2023-04-14 22:06:54","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("498","2023-04-14 22:08:16","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("499","2023-04-14 22:21:01","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("500","2023-04-14 22:21:40","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("501","2023-04-14 22:22:04","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("502","2023-04-14 22:22:24","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("503","2023-04-14 22:22:34","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("504","2023-04-14 22:23:04","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("505","2023-04-14 22:23:14","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("506","2023-04-14 22:23:29","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("507","2023-04-14 22:23:42","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("508","2023-04-14 22:23:47","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("509","2023-04-14 22:23:57","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("510","2023-04-14 22:26:54","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("511","2023-04-14 22:27:12","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("512","2023-04-14 22:30:39","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("513","2023-04-14 22:31:26","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("514","2023-04-14 22:36:57","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("515","2023-04-14 22:37:12","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("516","2023-04-14 22:37:19","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("517","2023-04-14 22:37:29","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("518","2023-04-14 22:37:53","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("519","2023-04-14 22:37:59","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("520","2023-04-14 22:38:06","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("521","2023-04-14 22:38:19","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("522","2023-04-14 22:39:09","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("523","2023-04-14 22:40:18","1","2","INGRESO","INGRESO AL MODULO COMPRAS");
INSERT INTO tbl_ms_bitacora VALUES("524","2023-04-14 22:40:27","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("525","2023-04-14 22:53:42","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("526","2023-04-14 22:54:28","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("527","2023-04-14 22:54:44","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("528","2023-04-14 22:55:38","1","2","INGRESO","INGRESO AL MÓDULO PROMOCION");
INSERT INTO tbl_ms_bitacora VALUES("529","2023-04-14 22:55:53","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("530","2023-04-14 22:57:38","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("531","2023-04-14 22:58:41","1","2","INGRESO","INGRESO AL MODULO DE ROLES");
INSERT INTO tbl_ms_bitacora VALUES("532","2023-04-14 22:59:01","1","2","INGRESO","INGRESO AL MODULO USUARIOS");
INSERT INTO tbl_ms_bitacora VALUES("533","2023-04-14 22:59:23","1","2","INGRESO","INGRESO AL MÓDULO PARÁMETROS");
INSERT INTO tbl_ms_bitacora VALUES("534","2023-04-14 22:59:35","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("535","2023-04-14 23:00:02","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("536","2023-04-14 23:00:34","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("537","2023-04-14 23:00:37","1","2","INGRESO","INGRESO AL MODULO CLIENTES");
INSERT INTO tbl_ms_bitacora VALUES("538","2023-04-14 23:00:46","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("539","2023-04-14 23:01:15","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("540","2023-04-14 23:01:22","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("541","2023-04-14 23:01:39","1","2","INGRESO","INGRESO AL MODULO VENTAS");
INSERT INTO tbl_ms_bitacora VALUES("542","2023-04-14 23:01:50","1","2","INGRESO","INGRESO AL MÓDULO CONFIGURACIÓN CAI");



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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

INSERT INTO tbl_ms_objetos VALUES("1","INICIO","DASHBOARD","1");
INSERT INTO tbl_ms_objetos VALUES("2","USUARIOS","USUARIOS DEL SISTEMA","1");
INSERT INTO tbl_ms_objetos VALUES("4","PRODUCTOS","TODOS LOS PRODUCTOS","1");
INSERT INTO tbl_ms_objetos VALUES("10","PROMOCION","PROMOCIONES","1");
INSERT INTO tbl_ms_objetos VALUES("11","DESCUENTOS","DESCUENTOS","1");
INSERT INTO tbl_ms_objetos VALUES("12","PREGUNTAS","PREGUNTAS SECRETAS","1");
INSERT INTO tbl_ms_objetos VALUES("13","INVENTARIO","INVENTARIO DE LOS PRODUCTOS","1");
INSERT INTO tbl_ms_objetos VALUES("14","ROLES","","1");
INSERT INTO tbl_ms_objetos VALUES("15","BITÁCORA","","1");
INSERT INTO tbl_ms_objetos VALUES("16","PARÁMETROS","","1");
INSERT INTO tbl_ms_objetos VALUES("17","BACKUP","","1");
INSERT INTO tbl_ms_objetos VALUES("18","OBJETOS","","1");
INSERT INTO tbl_ms_objetos VALUES("20","COMPRAS","","1");
INSERT INTO tbl_ms_objetos VALUES("21","VENTAS","","1");
INSERT INTO tbl_ms_objetos VALUES("22","CLIENTES","","1");
INSERT INTO tbl_ms_objetos VALUES("23","KARDEX","","1");
INSERT INTO tbl_ms_objetos VALUES("24","CAI","","1");



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
INSERT INTO tbl_ms_parametros VALUES("6","NOMBRE_EMPRESA","INVERSIONES UNIFORMES DEL ATLÁNTICO","","","","");
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
) ENGINE=InnoDB AUTO_INCREMENT=537 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

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
INSERT INTO tbl_ms_permisos VALUES("418","1","1","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("419","1","2","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("420","1","4","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("421","1","10","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("422","1","11","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("423","1","12","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("424","1","13","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("425","1","14","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("426","1","15","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("427","1","16","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("428","1","17","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("429","1","18","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("430","1","20","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("431","1","21","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("432","1","22","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("433","1","23","1","1","1","1");
INSERT INTO tbl_ms_permisos VALUES("434","1","24","1","1","1","1");
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
INSERT INTO tbl_ms_roles VALUES("23","nuevorol","d","1");



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

INSERT INTO tbl_ms_usuarios VALUES("1","ADMIN","ADMINISTRADOR","1","8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92","2023-04-14 20:37:12","0","","","admin@atlantico.com","733464113f1d79251461-4ff19d069fb2ec635522-a12faeec9a0c21dd0b33-435908728e5136f3ae80","","2021-08-20 01:34:15","ADMIN","2023-03-22 21:16:11","1");
INSERT INTO tbl_ms_usuarios VALUES("19","ALEXANDER","ALEXANDER AGUILAR","2","3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c","","0","","","alex@hotmail.com","","","2023-02-04 01:16:01","ADMIN","2023-03-22 10:36:01","4");
INSERT INTO tbl_ms_usuarios VALUES("20","ERIKA","ERIKA AYALA","2","18ac3e7343f016890c510e93f935261169d9e3f565436429830faf0934f4f8e4","","0","","","erika3@gmail.com","","","2023-02-08 21:40:58","ADMIN","2023-03-22 10:35:34","2");
INSERT INTO tbl_ms_usuarios VALUES("104","HECTOR","HECTOR BUSTILLOO","2","3ea87a56da3844b420ec2925ae922bc731ec16a4fc44dcbeafdad49b0e61d39c","","2","","","hector@hotmail.com","","ADMIN","2023-03-08 15:22:09","ADMIN","2023-03-22 21:14:43","1");
INSERT INTO tbl_ms_usuarios VALUES("136","JORGE","JORGE ROMERO","2","c7a1efa3453d748fe74f4ec5ea1decee819cdc2898c933d00348507ccf99dfcb","2023-03-30 13:13:42","2","","","jorge@gmail.com","","ADMIN","2023-03-15 20:49:18","ADMIN","2023-03-29 21:35:43","4");
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tbl_producto VALUES("12","TELA","TELA BLANCA","200","30","3","30.00","1","","","","","112");
INSERT INTO tbl_producto VALUES("13","PINTURA","ROJA","10","100","3","20.00","1","","","","","31");



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