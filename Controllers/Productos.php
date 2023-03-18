<?php

class Productos extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MPRODUCTOS);
	}

	public function Productos()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Productos";
		$data['page_title'] = "PRODUCTOS <small>Inversiones Atlántico</small>";
		$data['page_name'] = "productos";
		$data['page_functions_js'] = "functions_productos.js";
		$this->views->getView($this, "productos", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		// $dateFecha = date('Y-m-d H:i:s');
		// $intIdUsuario = $_SESSION['idUser'];
		// $intIdObjeto = 2;
		// $request_bitacora = "";

		// $strAccion = "INGRESO";
		// $strDescripcion = "INGRESO AL MODULO USUARIOS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		// $request_bitacora = $this->model->insertUsuarioBitacora(
		// 	$dateFecha,
		// 	$intIdUsuario,
		// 	$intIdObjeto,
		// 	$strAccion,
		// 	$strDescripcion
		// );
	}

	public function setProducto()
	{
		if ($_POST) {
			if (empty($_POST['txtNombre_Producto']) || empty($_POST['txtDescripcion']) || empty($_POST['listStatus'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');

				/*El siguiente else if, sirve para que valide desde el servidor. Que si se ingresa una letra 
				ya sea mayúscula o minúscula, que permita ingresar los datos.
				Al final está el else que mostrará error en caso de que lo insertado sea un número o caracter especial.*/
			} else if (preg_match('/^[a-zA-Z]+$/', $_POST['txtNombre_Producto']) || preg_match('/^[a-zA-Z]+$/', $_POST['txtDescripcion'])) {


				$id_usuario = intval($_POST['cod_producto']);
				$strusuario = strtoupper(strClean($_POST['txtusuario']));
				$strnombre_usuario = strtoupper(strClean($_POST['txtnombre_usuario']));
				$strEmail = strtolower(strClean($_POST['txtEmail']));
				$intTipoId = intval(strClean($_POST['listid_rol']));
				$intestado = intval(strClean($_POST['listStatus']));
				$contrasena = (strClean($_POST['txtPassword']));
				$request_user = "";

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2; //ESTE VALOR VA A CAMBIAR MAS A DELANTE
				$request_bitacora = "";

				if ($id_usuario == 0) {
					$option = 1; //LA OPCIÓN ES 1, ENTONCES ESTARÁ INSERTANDO
					$strPassword =  empty($_POST['txtPassword']) ? hash("SHA256", passGenerator()) : hash("SHA256", $_POST['txtPassword']);

					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertUsuario(
							$strusuario,
							$strnombre_usuario,
							$strEmail,
							$strPassword,
							$intTipoId,
							$intestado
						);


						//
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "CREACION DE USUARIO";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertUsuarioBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					} //FIN DEL IF DE INSERTAR


				} else {
					$option = 2; //SI OPTION ES 2, ENTONCES ESTARÁ ACTUALIZANDO
					$strPassword =  empty($_POST['txtPassword']) ? "" : hash("SHA256", $_POST['txtPassword']);
					if ($_SESSION['permisosMod']['u']) {
						$request_user = $this->model->updateUsuario(
							$id_usuario,
							$strusuario,
							$strnombre_usuario,
							$strEmail,
							$strPassword,
							$intTipoId,
							$intestado
						);
					}

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
					$strAccion = "ACTUALIZAR";
					$strDescripcion = "ACTUALIZACIÓN DE USUARIO";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertUsuarioBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} //FIN DEL ELSE PARA ACTUALIZAR

				if ($request_user > 0) {
					if ($option == 1) {


						$dataUsuario = array(
							'nombreUsuario' => $strnombre_usuario,
							'usuario' => $strusuario,
							'email' => $strEmail,
							'asunto' => 'Mostrar cuenta - ' . NOMBRE_REMITENTE,
							'contrasena' => $contrasena
						);


						$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');

						//
					} else {
						$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
					}
				} else if ($request_user == 'exist') {
					$arrResponse = array('status' => false, 'msg' => '¡Atención! el email o la identificación ya existe, ingrese otro.');
				} else {
					$arrResponse = array("status" => false, "msg" => 'No es posible almacenar los datos.');
				}
			} else {
				$arrResponse = array("status" => false, "msg" => 'No se pueden ingresar números ni caracteres especiales');
			}

			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getProductos()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectProductos();
			for ($i = 0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';

				if ($arrData[$i]['estado'] == 1) {
					$arrData[$i]['estado'] = '<span class="badge badge-success">ACTIVO</span>';   //Aqui le asigna Activo si es 1
				} else if ($arrData[$i]['estado'] == 2) {
					$arrData[$i]['estado'] = '<span class="badge badge-danger">INACTIVO</span>';
				} else if ($arrData[$i]['estado'] == 3) {
					$arrData[$i]['estado'] = '<span class="badge badge-info">NUEVO</span>';
				} else if ($arrData[$i]['estado'] == 4) {
					$arrData[$i]['estado'] = '<span class="badge badge-danger">BLOQUEADO</span>';
				}

				if ($_SESSION['permisosMod']['r']) {
					$btnView = '<button class="btn btn-info btn-sm btnViewUsuario" onClick="fntViewUsuario(' . $arrData[$i]['cod_producto'] . ')" title="Ver usuario"><i class="far fa-eye"></i></button>';
				}

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditUsuario" onClick="fntEditUsuario(this,' . $arrData[$i]['cod_producto'] . ')" title="Editar usuario"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}

				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelUsuario" onClick="fntDelUsuario(' . $arrData[$i]['cod_producto'] . ')" title="Eliminar usuario"><i class="far fa-trash-alt"></i></button>';
				} else {
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getUsuario($id_usuario)
	{
		if ($_SESSION['permisosMod']['r']) {
			$id_usuario = intval($id_usuario);
			if ($id_usuario > 0) {
				$arrData = $this->model->selectUsuario($id_usuario);
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

	public function delUsuario()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$intid_usuario = intval($_POST['id_usuario']);
				$requestDelete = $this->model->deleteUsuario($intid_usuario);

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2;
				$request_bitacora = "";

				if ($requestDelete == 'ok') {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado el usuario');

					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACION DE USUARIO";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertUsuarioBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else if ($requestDelete == 'exist') {
					$requestUsuarioInactivo = $this->model->updateUsuarioInactivo($intid_usuario);
					$arrResponse = array('statusReferencial' => true, 'msg' => 'No es posible eliminar por Integridad Referencial');
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al eliminar el usuario.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}
}
