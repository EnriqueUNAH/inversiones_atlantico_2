<?php

class Proveedores extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MPROVEEDOR);
	}

	public function Proveedores()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Proveedores";
		$data['page_title'] = "PROVEEDORES <small>Inversiones Atlántico</small>";
		$data['page_name'] = "proveedores";
		$data['page_functions_js'] = "functions_proveedores.js";
		$this->views->getView($this, "proveedores", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = (MPROVEEDOR);
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO PROVEEDORES";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertProveedoresBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}

	public function setProveedor()
	{
		if ($_POST) {
			if (empty($_POST['txtNombres'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');

				/*El siguiente else if, sirve para que valide desde el servidor. Que si se ingresa una letra 
				ya sea mayúscula o minúscula, que permita ingresar los datos.
				Al final está el else que mostrará error en caso de que lo insertado sea un número o caracter especial.*/
			} else {


				$cod_proveedor = intval($_POST['cod_proveedor']);
				$strRtn = $_POST['txtRtn'];
				$strNombres = strtoupper(strClean($_POST['txtNombres']));
				$intTelefono = intval(strClean($_POST['txtTelefono']));
				$strEmail = strtolower(strClean($_POST['txtEmail']));
				$strDireccion = strtoupper(strClean($_POST['txtDireccion']));
				// $cod_genero = (strClean($_POST['listGenero']));
				$request_user = "";

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MPROVEEDOR); //ESTE VALOR VA A CAMBIAR MAS A DELANTE
				$request_bitacora = "";

				if ($cod_proveedor == 0) {
					$option = 1; //LA OPCIÓN ES 1, ENTONCES ESTARÁ INSERTANDO
					//$strPassword =  empty($_POST['txtPassword']) ? hash("SHA256", passGenerator()) : hash("SHA256", $_POST['txtPassword']);
					//$strPassword = hash("SHA256", $_POST['txtPassword']);



					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertProveedor(
							$strRtn,
							$strNombres,
							$intTelefono,
							$strEmail,
							$strDireccion
							// $cod_genero

						);

						//
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "CREACIÓN DE PROVEEDOR: $strNombres";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertProveedoresBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					} //FIN DEL IF DE INSERTAR


				} else {
					$option = 2; //SI OPTION ES 2, ENTONCES ESTARÁ ACTUALIZANDO

					$requestProveedor = $this->model->selectProveedor($cod_proveedor);
					$nombreProveedor = $requestProveedor['nombres'];
					$rtnAnterior = $requestProveedor['rtn'];
					$telefonoAnterior = $requestProveedor['telefono'];
					$emailAnterior = $requestProveedor['correo_electronico'];
					$direccionAnterior = $requestProveedor['direccion'];




					if ($_SESSION['permisosMod']['u']) {
						$request_user = $this->model->updateProveedor(
							$cod_proveedor,
							$strRtn,
							$strNombres,
							$intTelefono,
							$strEmail,
							$strDireccion
							// $cod_genero
						);
					}






					if ($strNombres != $nombreProveedor) {
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
						$strAccion = "ACTUALIZAR";
						$strDescripcion = "ACTUALIZACIÓN DE PROVEEDOR:  ($nombreProveedor) VALOR NUEVO:($strNombres) ";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertProveedoresBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					}

					if ($strRtn != $rtnAnterior) {
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
						$strAccion = "ACTUALIZAR";
						$strDescripcion = "ACTUALIZACIÓN DE PROVEEDOR: ($strNombres) RTN ANTERIOR:($rtnAnterior) VALOR NUEVO: ($strRtn) ";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertProveedoresBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					}

					if ($intTelefono != $telefonoAnterior) {
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
						$strAccion = "ACTUALIZAR";
						$strDescripcion = "ACTUALIZACIÓN DE PROVEEDOR: ($strNombres) TELÉFONO ANTERIOR:($telefonoAnterior) VALOR NUEVO: ($intTelefono) ";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertProveedoresBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					}



					if ($strEmail != $emailAnterior) {
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
						$strAccion = "ACTUALIZAR";
						$strDescripcion = "ACTUALIZACIÓN DE PROVEEDOR: ($strNombres) CORREO ANTERIOR:($emailAnterior) VALOR NUEVO: ($strEmail) ";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertProveedoresBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					}


					if ($strDireccion != $direccionAnterior) {
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
						$strAccion = "ACTUALIZAR";
						$strDescripcion = "ACTUALIZACIÓN DE PROVEEDOR: ($strNombres) DIRECCIÓN ANTERIOR:($direccionAnterior) VALOR NUEVO: ($strDireccion) ";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertProveedoresBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					}
				} //FIN DEL ELSE PARA ACTUALIZAR

				if ($request_user === 'exist') {
					$arrResponse = array('status' => false, 'msg' => '¡Atención! el proveedor ya existe, ingrese otro.');
				} else if ($request_user > 0) {
					if ($option == 1) {
						$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');
					} else {
						$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
					}
				} else {
					$arrResponse = array("status" => false, "msg" => 'No es posible almacenar los datos.');
				}
			}

			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}




	public function getProveedores()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectProveedores();
			for ($i = 0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';


				if ($_SESSION['permisosMod']['r']) {
					$btnView = '<button class="btn btn-info btn-sm btnViewProveedor" onClick="fntViewProveedor(' . $arrData[$i]['cod_proveedor'] . ')" title="Ver proveedor"><i class="far fa-eye"></i></button>';
				}

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditProveedor" onClick="fntEditProveedor(this,' . $arrData[$i]['cod_proveedor'] . ')" title="Editar proveedor"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}

				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelProveedor" onClick="fntDelProveedor(' . $arrData[$i]['cod_proveedor'] . ')" title="Eliminar proveedor"><i class="far fa-trash-alt"></i></button>';
				} else {
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getProveedor($cod_proveedor)
	{
		if ($_SESSION['permisosMod']['r']) {
			$cod_proveedor = intval($cod_proveedor);
			if ($cod_proveedor > 0) {
				$arrData = $this->model->selectProveedor($cod_proveedor);
				if (empty($arrData)) {
					$arrResponse = array('status' => false, 'msg' => 'Datos no encontrados.');
				} else {
					$arrResponse = array('status' => true, 'data' => $arrData);
				}
				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}
		die();
	}


	// public function getSelectGenero()
	// {
	// 	$htmlOptions = "";
	// 	$arrData = $this->model->selectGenero();
	// 	if (count($arrData) > 0) {
	// 		for ($i = 0; $i < count($arrData); $i++) {
	// 			//   if ($arrData[$i]['cod_genero'] == 1) {
	// 			$htmlOptions .= '<option value="' . $arrData[$i]['cod_genero'] . '">' . $arrData[$i]['nombre_genero'] . '</option>';
	// 			// }
	// 		}
	// 	}
	// 	echo $htmlOptions;
	// 	die();
	// }





	public function delProveedor()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$cod_proveedor = intval($_POST['cod_proveedor']);
				$requestProveedor = $this->model->selectProveedor($cod_proveedor);
				$requestDelete = $this->model->deleteProveedor($cod_proveedor);
				$nombreProveedor = $requestProveedor['nombres'];

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MPROVEEDOR);
				$request_bitacora = "";

				if ($requestDelete == 'ok') {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado el proveedor');

					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACIÓN DE PROVEEDOR: $nombreProveedor";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertProveedoresBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else if ($requestDelete == 'exist') {
					$arrResponse = array('statusReferencial' => true, 'msg' => 'No es posible eliminar por Integridad Referencial');
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al eliminar el proveedor.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}
}
