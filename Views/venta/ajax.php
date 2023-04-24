<?php

include "conexion.php";
session_start();
//print_r($_POST);exit;

if (!empty($_POST)) {







	// if (isset($_POST["valor_descuento"])) {
	// 	$valor_descuento = $_POST["valor_descuento"];

	// 	// Actualizar la tabla tbl_descuento
	// 	$sql = "UPDATE tbl_descuento SET porcentaje_descuento='$valor_descuento' WHERE nombre_descuento='descuento'";

	// 	if ($conection->query($sql) === TRUE) {
	// 		echo "Descuento actualizado correctamente";
	// 	} else {
	// 		echo "Error al actualizar descuento: " . $conection->error;
	// 	}
	// }







	//Extraer datos de la promocion
	if ($_POST['action'] == 'infoPromocion') {
		$producto_id = $_POST['promocion'];

		$query = mysqli_query($conection, "SELECT cod_promocion,nombre_promocion,fecha_inicio,fecha_final,precio_venta FROM tbl_promocion
												WHERE cod_promocion = $producto_id ");
		mysqli_close($conection);

		$result = mysqli_num_rows($query);
		if ($result > 0) {
			$data = mysqli_fetch_assoc($query);
			echo json_encode($data, JSON_UNESCAPED_UNICODE);
			exit;
		}
		echo 'error';
		exit;
	}

	//Extraer datos del descuento
	if ($_POST['action'] == 'infoDescuento') {
		$producto_id = $_POST['descuento'];

		$query = mysqli_query($conection, "SELECT cod_descuento,nombre_descuento,porcentaje_descuento FROM tbl_descuento
											WHERE cod_descuento = $producto_id ");
		mysqli_close($conection);

		$result = mysqli_num_rows($query);
		if ($result > 0) {
			$data = mysqli_fetch_assoc($query);
			echo json_encode($data, JSON_UNESCAPED_UNICODE);
			exit;
		}
		echo 'error';
		exit;
	}










	//Extraer datos del producto
	if ($_POST['action'] == 'infoProducto') {
		$producto_id = $_POST['producto'];

		$query = mysqli_query($conection, "SELECT cod_producto,nombre_producto,existencia,precio_venta FROM tbl_producto
												WHERE cod_producto = $producto_id AND estado = 1");
		mysqli_close($conection);

		$result = mysqli_num_rows($query);
		if ($result > 0) {
			$data = mysqli_fetch_assoc($query);
			echo json_encode($data, JSON_UNESCAPED_UNICODE);
			exit;
		}
		echo 'error';
		exit;
	}


	//Eliminar producto
	if ($_POST['action'] == 'delProduct') {
		if (empty($_POST['producto_id']) || !is_numeric($_POST['producto_id'])) {
			echo 'error';
		} else {
			$idproducto = $_POST['producto_id'];
			$query_delete = mysqli_query($conection, "UPDATE producto SET estado = 0 WHERE cod_producto = $idproducto ");
			mysqli_close($conection);

			if ($query_delete) {
				echo 'ok';
			} else {
				echo 'error';
			}
		}
		echo 'error';
		exit;
	}

	// Buscar Cliente
	if ($_POST['action'] == 'searchCliente') {
		if (!empty($_POST['cliente'])) {

			$rtn = $_POST['cliente'];
			$query = mysqli_query($conection, "SELECT * FROM tbL_cliente WHERE rtn LIKE '$rtn' and estado = 1 ");
			mysqli_close($conection);
			$result = mysqli_num_rows($query);

			$data = '';
			if ($result > 0) {
				$data = mysqli_fetch_assoc($query);
			} else {
				$data = 0;
			}
			echo json_encode($data, JSON_UNESCAPED_UNICODE);
		}
		exit;
	}



	//Registra Cliente - Ventas
	if ($_POST['action'] == 'addCliente') {
		$rtn       = $_POST['rtn_cliente'];
		$nombre    = $_POST['nom_cliente'];
		$telefono  = $_POST['tel_cliente'];
		$direccion = $_POST['dir_cliente'];
		$usuario_id = $_SESSION['idUser'];

		$query_insert = mysqli_query($conection, "INSERT INTO tbl_cliente(
														rtn,nombres,telefono,direccion,id_usuario)
													VALUES('$rtn','$nombre','$telefono','$direccion','$usuario_id')");
		if ($query_insert) {
			$codCliente = mysqli_insert_id($conection);
			$msg = $codCliente;
		} else {
			$msg = 'error';
		}
		mysqli_close($conection);
		echo $msg;
		exit;
	}



	//Agregar producto al detalle temporal
	if ($_POST['action'] == 'addProductoDetalle') {
		if (empty($_POST['producto']) || empty($_POST['cantidad'])) {
			echo 'error';
		} else {
			$cod_producto = $_POST['producto'];
			$cantidad 	 = $_POST['cantidad'];
			$token 		 = md5($_SESSION['idUser']);

			$query_isv = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'impuesto'");
			$result_isv = mysqli_num_rows($query_isv);
			$resultado = mysqli_fetch_assoc($query_isv);


			$query_detalle_temp 	= mysqli_query($conection, "CALL add_detalle_temp($cod_producto,$cantidad,'$token')");
			$result = mysqli_num_rows($query_detalle_temp);

			$detalleTabla = '';
			$sub_total  = 0;
			$isv 		= 0;
			$total 		= 0;
			$arrayData = array();

			if ($result > 0) {
				// if ($result_isv > 0) {
				// 	$info_isv =  mysqli_fetch_assoc($query_isv);
				// 	$isv = $info_isv['isv'];
				// }
				$isv = $resultado['valor'];


				while ($data = mysqli_fetch_assoc($query_detalle_temp)) {
					$precioTotal = round($data['cantidad'] * $data['precio_venta'], 2);
					$sub_total 	 = round($sub_total + $precioTotal, 2);
					$total 	 	 = round($total + $precioTotal, 2);

					$detalleTabla .= '<tr>
											<td>' . $data['cod_producto'] . '</td>
										
											<td colspan="2">' . $data['nombre_producto'] . '</td>
											<td class="textcenter">' . $data['cantidad'] . '</td>
											<td class="textright">' . $data['precio_venta'] . '</td>
											<td class="textright">' . $precioTotal . '</td>
											<td class="">
												<a class="link_delete" href="#" onclick="event.preventDefault(); del_product_detalle(' . $data['cod_detalle_factura'] . ');"><i class="far fa-trash-alt"></i></a>
											</td>
										</tr>';
				}

				$impuesto 	= round($sub_total * ($isv / 100), 2);
				$tl_snisv 	= round($sub_total - $impuesto, 2);
				$total 		= round($tl_snisv + $impuesto, 2);

				$detalleTotales = '
									
				
										<tr>
											<td colspan="5" class="textright">SUBTOTAL L.</td>
											<td class="textright">' . $tl_snisv . '</td>
										</tr>
									
										<tr>
											<td colspan="5" class="textright">ISV (' . $isv . '%)</td>
											<td class="textright">' . $impuesto . '</td>
										</tr>
										<tr>
											<td colspan="5" class="textright">TOTAL L.</td>
											<td class="textright">' . $total . '</td>
										</tr>';

				$arrayData['detalle'] = $detalleTabla;
				$arrayData['totales'] = $detalleTotales;

				echo json_encode($arrayData, JSON_UNESCAPED_UNICODE);
			} else {
				echo 'error';
			}
			mysqli_close($conection);
		}
		exit;
	}


	if ($_POST['action'] == 'addPromocionDetalle') {
		if (empty($_POST['promocion'])) {
			echo 'error';
		} else {
			$cod_promocion = $_POST['promocion'];
			$token 		 = md5($_SESSION['idUser']);

			$query_isv = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'impuesto'");
			$result_isv = mysqli_num_rows($query_isv);
			$resultado = mysqli_fetch_assoc($query_isv);


			$query_detalle_temp 	= mysqli_query($conection, "CALL add_promocion_detalle_temp($cod_promocion,'$token')");
			$result = mysqli_num_rows($query_detalle_temp);

			$detalleTabla = '';
			$sub_total  = 0;
			$isv 		= 0;
			$total 		= 0;
			$arrayData = array();

			if ($result > 0) {

				$isv = $resultado['valor'];


				while ($data = mysqli_fetch_assoc($query_detalle_temp)) {
					$precioTotal = round($data['cantidad'] * $data['precio_venta'], 2);
					$sub_total 	 = round($sub_total + $precioTotal, 2);
					$total 	 	 = round($total + $precioTotal, 2);

					$detalleTabla .= '<tr>
											<td>' . $data['cod_producto'] . '</td>
											<td colspan="2">' . $data['promo'] . '</td>
											<td colspan="2">' . $data['nombre_producto'] . '</td>
											<td class="textcenter">' . $data['cantidad'] . '</td>
											<td class="textright">' . $data['precio_venta'] . '</td>
											<td class="textright">' . $precioTotal . '</td>
											<td class="">
											</td>
										</tr>';
				}

				$impuesto 	= round($sub_total * ($isv / 100), 2);
				$tl_snisv 	= round($sub_total - $impuesto, 2);
				$total 		= round($tl_snisv + $impuesto, 2);

				$detalleTotales = '
									
				
										<tr>
											<td colspan="5" class="textright">SUBTOTAL L.</td>
											<td class="textright">' . $tl_snisv . '</td>
										</tr>
									
										<tr>
											<td colspan="5" class="textright">ISV (' . $isv . '%)</td>
											<td class="textright">' . $impuesto . '</td>
										</tr>
										<tr>
											<td colspan="5" class="textright">TOTAL L.</td>
											<td class="textright">' . $total . '</td>
										</tr>';

				$arrayData['detalle'] = $detalleTabla;
				$arrayData['totales'] = $detalleTotales;

				echo json_encode($arrayData, JSON_UNESCAPED_UNICODE);
			} else {
				echo 'error';
			}
			mysqli_close($conection);
		}
		exit;
	}

	if ($_POST['action'] == 'addDescuentoDetalle') {
		if (empty($_POST['descuento'])) {
			echo 'error';
		} else {
			$cod_descuento = $_POST['descuento'];
			// $token 		 = md5($_SESSION['idUser']);

			// $query_isv = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'impuesto'");
			// $result_isv = mysqli_num_rows($query_isv);
			// $resultado = mysqli_fetch_assoc($query_isv);

			$query_por = mysqli_query($conection, "SELECT porcentaje_descuento FROM tbl_descuento where cod_descuento = $cod_descuento");
			$result_por = mysqli_num_rows($query_por);
			$resultado_por = mysqli_fetch_assoc($query_por);

			$porcent_descuento = $resultado_por['porcentaje_descuento'];



			$query_detalle_temp 	= mysqli_query($conection, "UPDATE tbl_porcentaje_descuento SET porcentaje_descuento = $porcent_descuento where cod = 1;
			");
			$result_por = mysqli_num_rows($query_detalle_temp);

			$detalleTabla = '';
			$sub_total  = 0;
			$isv 		= 0;
			$total 		= 0;
			$arrayData = array();

			if ($result_por > 0) {

				$isv = $resultado['valor'];


				while ($data = mysqli_fetch_assoc($query_detalle_temp)) {
					$precioTotal = round($data['cantidad'] * $data['precio_venta'], 2);
					$sub_total 	 = round($sub_total + $precioTotal, 2);
					$total 	 	 = round($total + $precioTotal, 2);

					$detalleTabla .= '<tr>
											<td>' . $data['cod_producto'] . '</td>
											<td colspan="2">' . $data['promo'] . '</td>
											<td colspan="2">' . $data['nombre_producto'] . '</td>
											<td class="textcenter">' . $data['cantidad'] . '</td>
											<td class="textright">' . $data['precio_venta'] . '</td>
											<td class="textright">' . $precioTotal . '</td>
											<td class="">
											</td>
										</tr>';
				}

				$impuesto 	= round($sub_total * ($isv / 100), 2);
				$tl_snisv 	= round($sub_total - $impuesto, 2);
				$total 		= round($tl_snisv + $impuesto, 2);

				$detalleTotales = '
									
				
										<tr>
											<td colspan="5" class="textright">SUBTOTAL L.</td>
											<td class="textright">' . $tl_snisv . '</td>
										</tr>
									
										<tr>
											<td colspan="5" class="textright">ISV (' . $isv . '%)</td>
											<td class="textright">' . $impuesto . '</td>
										</tr>
										<tr>
											<td colspan="5" class="textright">TOTAL L.</td>
											<td class="textright">' . $total . '</td>
										</tr>';

				$arrayData['detalle'] = $detalleTabla;
				$arrayData['totales'] = $detalleTotales;

				echo json_encode($arrayData, JSON_UNESCAPED_UNICODE);
			} else {
				echo 'error';
			}
			mysqli_close($conection);
		}
		exit;
	}













	///////////////////////////////////////////
	//Extrae datos del detalle_temp
	if ($_POST['action'] == 'serchForDetalle') {
		if (empty($_POST['user'])) {
			echo 'error';
		} else {

			$token = md5($_SESSION['idUser']);

			$query = mysqli_query($conection, "SELECT tmp.cod_detalle_factura,
														 tmp.token_user,
														 tmp.cantidad,
														 tmp.precio_venta,
														 tmp.promo,
														 tmp.cant_multi,
														 p.cod_producto,
														 p.nombre_producto
													FROM detalle_temp tmp
													INNER JOIN tbl_producto p
													ON tmp.cod_producto = p.cod_producto
													WHERE token_user = '$token' 
													ORDER BY tmp.cod_detalle_factura ASC");

			$result = mysqli_num_rows($query);

			$query_isv = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'impuesto'");
			$result_isv = mysqli_num_rows($query_isv);
			$resultado = mysqli_fetch_assoc($query_isv);

			$query_descuento = mysqli_query($conection, "SELECT porcentaje_descuento FROM tbl_porcentaje_descuento");
			$result_descuento = mysqli_num_rows($query_descuento);
			$resultado_descuento = mysqli_fetch_assoc($query_descuento);

			$detalleTabla = '';
			$sub_total  = 0;
			$isv 		= 0;
			$total 		= 0;
			$arrayData = array();

			if ($result > 0) {
				// if ($result_isv > 0) {
				// 	$info_isv =  mysqli_fetch_assoc($query_isv);
				// 	$isv = $info_isv['isv'];
				// }
				$porcentaje_descuento = $resultado_descuento['porcentaje_descuento'];
				$isv = $resultado['valor'];
				while ($data = mysqli_fetch_assoc($query)) {
					$precioTotal = round($data['cant_multi'] * $data['precio_venta'], 2);
					$sub_total 	 = round($sub_total + $precioTotal, 2);
					$total 	 	 = round($total + $precioTotal, 2);

					$detalleTabla .= '<tr>
											<td>' . $data['cod_producto'] . '</td>
											<td colspan="2">' . $data['promo'] . '</td>
											<td colspan="2">' . $data['nombre_producto'] . '</td>
											<td class="textcenter">' . $data['cantidad'] . '</td>
											<td class="textright">' . $data['precio_venta'] . '</td>
											<td class="textright">' . $precioTotal . '</td>
											<td class="">
												<a class="link_delete" href="#" onclick="event.preventDefault(); del_product_detalle(' . $data['cod_detalle_factura'] . ');"><i class="far fa-trash-alt"></i></a>
											</td>
										</tr>';
				}
				// $porcen_descuento = 20;
				$descuento = round($sub_total  * (($porcentaje_descuento / 100)), 2);

				$tl_snisv 	= round($sub_total  / (1 + ($isv / 100)), 2);
				$impuesto 	= round($tl_snisv * ($isv / 100), 2);
				// $total 		= round($tl_snisv + $impuesto, 2);
				$total 		= round($tl_snisv + $impuesto - $descuento, 2);
				$detalleTotales = '
				<tr>
				<td colspan="5" class="textright">DESCUENTO (' . ($porcentaje_descuento == (int)$porcentaje_descuento ? number_format($porcentaje_descuento, 0) : number_format($porcentaje_descuento, 2)) . '%) </td>

											<td class="textright">' . "- L. " . $descuento . '</td>
										</tr>
				<tr>
											<td colspan="5" class="textright">SUBTOTAL </td>
											<td class="textright">' . " L. " . $tl_snisv . '</td>
										</tr>
										<tr>
											<td colspan="5" class="textright">ISV (' . $isv . '%)</td>
											<td class="textright">' . " L. " . $impuesto . '</td>
										</tr>
										<tr>
											<td colspan="5" class="textright">TOTAL </td>
											<td class="textright">' . " L. " . $total . '</td>
										</tr>';

				$arrayData['detalle'] = $detalleTabla;
				$arrayData['totales'] = $detalleTotales;

				echo json_encode($arrayData, JSON_UNESCAPED_UNICODE);
			} else {
				echo 'error';
			}
			mysqli_close($conection);
		}
		exit;
	}

	if ($_POST['action'] == 'delProductoDetalle') {
		if (empty($_POST['id_detalle'])) {
			echo 'error';
		} else {

			$id_detalle = $_POST['id_detalle'];
			$token 		= md5($_SESSION['idUser']);


			$query_isv = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'impuesto'");
			$result_isv = mysqli_num_rows($query_isv);
			$resultado = mysqli_fetch_assoc($query_isv);



			$query_detalle_temp 	= mysqli_query($conection, "CALL del_detalle_temp($id_detalle,'$token')");
			$result = mysqli_num_rows($query_detalle_temp);

			$detalleTabla = '';
			$sub_total  = 0;
			$isv 		= 0;
			$total 		= 0;
			$arrayData = array();

			if ($result > 0) {
				// if ($result_isv > 0) {
				// 	$info_isv =  mysqli_fetch_assoc($query_isv);
				// 	$isv = $info_isv['isv'];
				// }
				$isv = $resultado['valor'];
				while ($data = mysqli_fetch_assoc($query_detalle_temp)) {
					$precioTotal = round($data['cantidad'] * $data['precio_venta'], 2);
					$sub_total 	 = round($sub_total + $precioTotal, 2);
					$total 	 	 = round($total + $precioTotal, 2);

					$detalleTabla .= '<tr>
											<td>' . $data['cod_producto'] . '</td>
											
											<td colspan="2">' . $data['nombre_producto'] . '</td>
											<td class="textcenter">' . $data['cantidad'] . '</td>
											<td class="textright">' . $data['precio_venta'] . '</td>
											<td class="textright">' . $precioTotal . '</td>
											<td class="">
												<a class="link_delete" href="#" onclick="event.preventDefault(); del_product_detalle(' . $data['cod_detalle_factura'] . ');"><i class="far fa-trash-alt"></i></a>
											</td>
										</tr>';
				}

				$impuesto 	= round($sub_total * ($isv / 100), 2);
				$tl_snisv 	= round($sub_total - $impuesto, 2);
				$total 		= round($tl_snisv + $impuesto, 2);

				$detalleTotales = '<tr>
											<td colspan="5" class="textright">SUBTOTAL L.</td>
											<td class="textright">' . $tl_snisv . '</td>
										</tr>
										<tr>
											<td colspan="5" class="textright">isv (' . $isv . '%)</td>
											<td class="textright">' . $impuesto . '</td>
										</tr>
										<tr>
											<td colspan="5" class="textright">TOTAL L.</td>
											<td class="textright">' . $total . '</td>
										</tr>';

				$arrayData['detalle'] = $detalleTabla;
				$arrayData['totales'] = $detalleTotales;

				echo json_encode($arrayData, JSON_UNESCAPED_UNICODE);
			} else {
				echo 'error';
			}
			mysqli_close($conection);
		}
		exit;
	}

	// Anular Venta
	if ($_POST['action'] == 'anularVenta') {
		$token = md5($_SESSION['idUser']);

		// Eliminar los registros del usuario actual de la tabla detalle_temp
		$query_del = mysqli_query($conection, "DELETE FROM detalle_temp WHERE token_user = '$token' ");

		// Actualizar el porcentaje de descuento en la tabla tbl_porcentaje_descuento
		// Esto me sirve para manejar el valor del descuento.
		$query_upd = mysqli_query($conection, "UPDATE tbl_porcentaje_descuento SET porcentaje_descuento = 0 WHERE cod = 1");

		mysqli_close($conection);

		if ($query_del && $query_upd) {
			echo 'ok';
		} else {
			echo 'error';
		}

		exit;
	}

	// Procesar Venta
	if ($_POST['action'] == 'procesarVenta') {

		if (empty($_POST['cod_cliente'])) {
			$cod_cliente = 5;
		} else {
			$cod_cliente = $_POST['cod_cliente'];
		}
		##############################################################################
		$token 		= md5($_SESSION['idUser']);
		// $usuario 	= $_SESSION['idUser'];


		$usuario 	= ($_SESSION['idUser']);

		$query = mysqli_query($conection, "SELECT * FROM detalle_temp WHERE token_user = '$token' ");
		$result = mysqli_num_rows($query);

		if ($result > 0) {
			$query_procesar = mysqli_query($conection, "call procesar_venta($usuario,$cod_cliente,'$token')");
			$result_detalle = mysqli_num_rows($query_procesar);

			if ($result_detalle > 0) {
				$data	= mysqli_fetch_assoc($query_procesar);
				echo json_encode($data, JSON_UNESCAPED_UNICODE);
			} else {
				echo "error";
			}
		} else {
			echo "error";
		}
		mysqli_close($conection);
		exit;
	}

	// Info Factura
	if ($_POST['action'] == 'infoFactura') {
		if (!empty($_POST['cod_factura'])) {

			$cod_factura = $_POST['cod_factura'];
			$query = mysqli_query($conection, "SELECT * FROM tbl_factura WHERE cod_factura = '$cod_factura' AND estado = 1");
			mysqli_close($conection);

			$result = mysqli_num_rows($query);
			if ($result > 0) {

				$data = mysqli_fetch_assoc($query);
				echo json_encode($data, JSON_UNESCAPED_UNICODE);
				exit;
			}
		}
		echo "error";
		exit;
	}


	// Anular Factura
	if ($_POST['action'] == 'anularFactura') {

		if (!empty($_POST['cod_factura'])) {
			$cod_factura = $_POST['cod_factura'];

			$query_anular 	= mysqli_query($conection, "CALL anular_factura($cod_factura)");
			mysqli_close($conection);
			$result = mysqli_num_rows($query_anular);
			if ($result > 0) {
				$data	= mysqli_fetch_assoc($query_anular);
				echo json_encode($data, JSON_UNESCAPED_UNICODE);
				exit;
			}
		}
		echo "error";
		exit;
	}
}

exit;
