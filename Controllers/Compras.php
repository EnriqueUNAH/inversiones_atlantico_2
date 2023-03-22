<?php

class Compras extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MUSUARIOS);
	}

	public function Compras()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Compras";
		$data['page_title'] = "COMPRAS <small>Inversiones Atlántico</small>";
		$data['page_name'] = "compras";
		$data['page_functions_js'] = "functions_compras.js";
		$this->views->getView($this, "compras", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = 2;
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MODULO COMPRAS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertCompraoBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}

	public function setUsuario()
	{
		if ($_POST) {
			if (empty($_POST['txtusuario']) || empty($_POST['txtnombre_usuario']) || empty($_POST['txtEmail']) || empty($_POST['listid_rol']) || empty($_POST['listStatus']) || empty($_POST['txtPassword'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');

				/*El siguiente else if, sirve para que valide desde el servidor. Que si se ingresa una letra 
				ya sea mayúscula o minúscula, que permita ingresar los datos.
				Al final está el else que mostrará error en caso de que lo insertado sea un número o caracter especial.*/
			} else if (preg_match('/^[a-zA-Z]+$/', $_POST['txtusuario']) || preg_match('/^[a-zA-Z]+$/', $_POST['txtnombre_usuario'])) {


				$id_usuario = intval($_POST['id_usuario']);
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
					//$strPassword =  empty($_POST['txtPassword']) ? hash("SHA256", passGenerator()) : hash("SHA256", $_POST['txtPassword']);
					$strPassword = hash("SHA256", $_POST['txtPassword']);



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



						// try {
						sendMailLocal($dataUsuario, 'email_usuario'); //ENVIAR CORREO
						$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');
						// } catch (Exception $e) {
						// 	$arrResponse = array('status' => false, 'msg' => 'No se puedo enviar el correo .Datos se guardaron correctamente.');
						// }


						// $resultadoEnvioCorreo = sendMailLocal($dataUsuario, 'email_usuario');
						// if ($resultadoEnvioCorreo === false) {
						// 	$arrResponse = array('status' => false, 'msg' => 'No se pudo enviar el correo. Los datos se guardaron correctamente.');
						// } else {
						// 	$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');
						// }



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

	public function getCompras()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectCompras();
			for ($i = 0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';

				if ($_SESSION['permisosMod']['r']) {
					$btnView = '<button class="btn btn-info btn-sm btnViewCompra" onClick="fntViewCompra(' . $arrData[$i]['cod_compra'] . ')" title="Ver compra"><i class="far fa-eye"></i></button>';
				}
				// if($_SESSION['permisosMod']['u']){
				// 	if(($_SESSION['idUser'] == 1 and $_SESSION['userData']['id_rol'] == 1) ||
				// 		($_SESSION['userData']['id_rol'] == 1 and $arrData[$i]['id_rol'] != 1) ){
				// 		$btnEdit = '<button class="btn btn-primary  btn-sm btnEditUsuario" onClick="fntEditUsuario(this,'.$arrData[$i]['id_usuario'].')" title="Editar usuario"><i class="fas fa-pencil-alt"></i></button>';
				// 	}else{
				// 		$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				// 	}
				// }
				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditCompra" onClick="fntEditCompra(this,' . $arrData[$i]['cod_compra'] . ')" title="Editar compra"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}
				// if($_SESSION['permisosMod']['d']){
				// 	if(($_SESSION['idUser'] == 1 and $_SESSION['userData']['id_rol'] == 1) ||
				// 		($_SESSION['userData']['id_rol'] == 1 and $arrData[$i]['id_rol'] != 1) and
				// 		($_SESSION['userData']['id_usuario'] != $arrData[$i]['id_usuario'] )
				// 		 ){
				// 		$btnDelete = '<button class="btn btn-danger btn-sm btnDelUsuario" onClick="fntDelUsuario('.$arrData[$i]['id_usuario'].')" title="Eliminar usuario"><i class="far fa-trash-alt"></i></button>';
				// 	}else{
				// 		$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
				// 	}
				// }
				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelCompra" onClick="fntDelCompra(' . $arrData[$i]['cod_compra'] . ')" title="Eliminar compra"><i class="far fa-trash-alt"></i></button>';
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


















	public function perfil()
	{
		$data['page_tag'] = "Perfil";
		$data['page_title'] = "Perfil de usuario";
		$data['page_name'] = "perfil";
		$data['page_functions_js'] = "functions_usuarios.js";
		$this->views->getView($this, "perfil", $data);
	}

	public function putPerfil()
	{
		if ($_POST) {
			if (empty($_POST['txtusuario']) || empty($_POST['txtNombre']) || empty($_POST['txtpreguntas_contestadas'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$id_usuario = $_SESSION['idUser'];
				$strusuario = strClean($_POST['txtusuario']);
				$strNombre = strClean($_POST['txtNombre']);
				//$strApellido = strClean($_POST['txtApellido']);
				$intpreguntas_contestadas = intval(strClean($_POST['txtpreguntas_contestadas']));
				$strPassword = "";
				if (!empty($_POST['txtPassword'])) {
					$strPassword = hash("SHA256", $_POST['txtPassword']);
				}
				$request_user = $this->model->updatePerfil(
					$id_usuario,
					$strusuario,
					$strNombre,
					$intpreguntas_contestadas,
					$strPassword
				);
				if ($request_user) {
					sessionUser($_SESSION['idUser']);
					$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
				} else {
					$arrResponse = array("status" => false, "msg" => 'No es posible actualizar los datos.');
				}
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function putDFical()
	{
		if ($_POST) {
			if (empty($_POST['txtNit']) || empty($_POST['txtNombreFiscal']) || empty($_POST['txtDirFiscal'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$id_usuario = $_SESSION['idUser'];
				$strNit = strClean($_POST['txtNit']);
				$strNomFiscal = strClean($_POST['txtNombreFiscal']);
				$strDirFiscal = strClean($_POST['txtDirFiscal']);
				$request_datafiscal = $this->model->updateDataFiscal(
					$id_usuario,
					$strNit,
					$strNomFiscal,
					$strDirFiscal
				);
				if ($request_datafiscal) {
					sessionUser($_SESSION['idUser']);
					$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
				} else {
					$arrResponse = array("status" => false, "msg" => 'No es posible actualizar los datos.');
				}
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}
}