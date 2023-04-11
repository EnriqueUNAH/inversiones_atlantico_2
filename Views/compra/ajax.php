<?php

include "conexion.php";
session_start();
//print_r($_POST);exit;

if (!empty($_POST)) {

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



	//Agregar producto al detalle temporal
	if ($_POST['action'] == 'addProductoDetalle') {
		if (empty($_POST['producto']) || empty($_POST['cantidad'])) {
			echo 'error';
		} else {
			$cod_producto = $_POST['producto'];
			$cantidad 	 = $_POST['cantidad'];
			// $token 		 = md5($_SESSION['idUser']);
			$token 		 = md5(321);

			$query_isv = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'impuesto'");
			$result_isv = mysqli_num_rows($query_isv);
			$resultado = mysqli_fetch_assoc($query_isv);


			$query_detalle_temp 	= mysqli_query($conection, "CALL add_detalle_temp_c($cod_producto,$cantidad,'$token')");
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
														 p.cod_producto,
														 p.nombre_producto
													FROM detalle_temp tmp
													INNER JOIN tbl_producto p
													ON tmp.cod_producto = p.cod_producto
													WHERE token_user = '$token' ");

			$result = mysqli_num_rows($query);

			$query_isv = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'impuesto'");
			$result_isv = mysqli_num_rows($query_isv);
			$resultado = mysqli_fetch_assoc($query_isv);



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
				while ($data = mysqli_fetch_assoc($query)) {
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

	if ($_POST['action'] == 'delProductoDetalle') {
		if (empty($_POST['id_detalle'])) {
			echo 'error';
		} else {

			$id_detalle = $_POST['id_detalle'];
			// $token 		= md5($_SESSION['idUser']);
			$token 		 = md5(321);

			$query_isv = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'impuesto'");
			$result_isv = mysqli_num_rows($query_isv);
			$resultado = mysqli_fetch_assoc($query_isv);



			$query_detalle_temp 	= mysqli_query($conection, "CALL del_detalle_temp_c($id_detalle,'$token')");
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

		// $token 		 = md5($_SESSION['idUser']);
		$token 		 = md5(321);

		$query_del = mysqli_query($conection, "DELETE FROM detalle_temp WHERE token_user = '$token' ");
		mysqli_close($conection);
		if ($query_del) {
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
		// $token 		= md5($_SESSION['idUser']);
		// $usuario 	= $_SESSION['idUser'];

		$token 		= md5(321);
		$usuario 	= 1;

		$query = mysqli_query($conection, "SELECT * FROM detalle_temp_c WHERE token_user = '$token' ");
		$result = mysqli_num_rows($query);

		if ($result > 0) {
			$query_procesar = mysqli_query($conection, "CALL procesar_compra($usuario,'$token')");
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

	// Cambiar contraseña
	if ($_POST['action'] == 'changePassword') {

		if (!empty($_POST['passActual']) && !empty($_POST['passNuevo'])) {
			$password = md5($_POST['passActual']);
			$newPass  = md5($_POST['passNuevo']);
			$idUser   = $_SESSION['idUser'];

			$code 		= '';
			$msg    	= '';
			$arrData 	= array();

			$query_user = mysqli_query($conection, "SELECT * FROM tbl_ms_usuarios 
														WHERE clave = '$password' and idusuario = $idUser ");
			$result 	 = mysqli_num_rows($query_user);
			if ($result > 0) {
				$query_update = mysqli_query($conection, "UPDATE tbl_ms_usuarios SET clave = '$newPass' WHERE idusuario = $idUser ");
				mysqli_close($conection);

				if ($query_update) {
					$code = '00';
					$msg = "Su contraseña se ha actualizado con éxito.";
				} else {
					$code = '2';
					$msg = "No es posible cambiar su contraseña.";
				}
			} else {
				$code = '1';
				$msg = "La contraseña actual es incorrecta.";
			}
			$arrData = array('cod' => $code, 'msg' => $msg);
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		} else {
			echo "error";
		}
		exit;
	}
}

exit;
