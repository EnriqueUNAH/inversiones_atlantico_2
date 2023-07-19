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
                id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
                SET a = 1;
                
                SET registros = (SELECT COUNT(*) FROM tbl_detalle_produccion WHERE cod_produccion = no_factura);
                
                IF registros > 0 THEN
                	INSERT INTO tbl_tmp(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM tbl_detalle_produccion WHERE cod_produccion = no_factura;
                    
                    WHILE a <= registros DO
                    	SELECT cod_prod,cant_prod INTO codproducto,cant_producto FROM tbl_tmp WHERE id = a;
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
                id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
                SET a = 1;
                
                SET registros = (SELECT COUNT(*) FROM tbl_promocion_producto WHERE cod_promocion = no_factura);
                
                IF registros > 0 THEN
                	INSERT INTO tbl_tmp_p(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM tbl_promocion_producto WHERE cod_promocion = no_factura;
                    
                    WHILE a <= registros DO
                    	SELECT cod_prod,cant_prod INTO codproducto,cant_producto FROM tbl_tmp_p WHERE id = a;
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
                id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
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
                id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
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
            	SELECT cod_prod,cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser WHERE id = a;
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
                id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                cod_prod BIGINT,
                cant_prod int);
                
        SET registros = (SELECT COUNT(*) FROM detalle_temp_p WHERE token_user = token);
        
        IF registros > 0 THEN
        	INSERT INTO tbl_tmp_tokenuser_p(cod_prod,cant_prod) SELECT cod_producto,cantidad FROM detalle_temp_p WHERE token_user = token;
            
            INSERT INTO tbl_promocion(id_usuario) VALUES(cod_usuario);
            SET factura = LAST_INSERT_ID();
            
            INSERT INTO tbl_promocion_producto(cod_promocion,cod_producto,cantidad) SELECT (factura) as cod_promocion, cod_producto,cantidad FROM detalle_temp_p WHERE token_user = token;
	 
            WHILE a <= registros DO
            	SELECT cod_prod,cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser_p WHERE id = a;
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
                id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
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
            	SELECT cod_prod,cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser WHERE id = a;
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
