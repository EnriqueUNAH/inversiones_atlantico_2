<?php

class Usuarios extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MUSUARIO);
	}

	public function Usuarios()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Usuarios";
		$data['page_title'] = "USUARIOS <small>Inversiones Atlántico</small>";
		$data['page_name'] = "usuarios";
		$data['page_functions_js'] = "functions_usuarios.js";
		$this->views->getView($this, "usuarios", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = (MUSUARIO);
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO USUARIOS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertUsuarioBitacora(
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
			$id_usuarioo = intval($_POST['id_usuario']);
			if (empty($_POST['txtusuario']) || empty($_POST['txtnombre_usuario']) || empty($_POST['txtEmail']) || empty($_POST['listid_rol']) || empty($_POST['listStatus'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			}

			//


			elseif ($id_usuarioo < 1 and empty($_POST['txtPassword'])) {
				$arrResponse = array("status" => false, "msg" => 'La contraseña no debe estar vacia');
			} elseif ($id_usuarioo < 1 and !preg_match('/^(?=.*[a-z]).+$/', $_POST['txtPassword'])) {
				$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener al menos una minúscula.');
			} elseif ($id_usuarioo < 1 and !preg_match('/^(?=.*[A-Z]).+$/', $_POST['txtPassword'])) {
				$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener al menos una mayúscula.');
			} elseif ($id_usuarioo < 1 and !preg_match('/^(?=.*[^\da-zA-Z]).+$/', $_POST['txtPassword'])) {
				$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener al menos un caracter especial.');
			} elseif ($id_usuarioo < 1 and !preg_match('/^.{6,}.+$/', $_POST['txtPassword'])) {
				$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener tener una longitud mínima de 6 caracteres.');
			}

			//
			//elseif (isset($_POST['txtPassword']) and $id_usuarioo > 0) {
			//
			// elseif ($id_usuarioo >= 1 and !preg_match('/^(?=.*[a-z]).+$/', $_POST['txtPassword'])) {
			// 	$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener al menos una minúsculaaaaa.');
			// } elseif ($id_usuarioo >= 1 and !preg_match('/^(?=.*[A-Z]).+$/', $_POST['txtPassword'])) {
			// 	$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener al menos una mayúsculaaaa.');
			// } elseif ($id_usuarioo >= 1 and !preg_match('/^(?=.*[^\da-zA-Z]).+$/', $_POST['txtPassword'])) {
			// 	$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener al menos un carácter especialaaaa.');
			// } elseif ($id_usuarioo >= 1 and !preg_match('/^.{6,}.+$/', $_POST['txtPassword'])) {
			// 	$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener tener una longitud mínima de 6 caractereaaas.');
			// }
			//
			//}
			//

			/*El siguiente else if, sirve para que valide desde el servidor. Que si se ingresa una letra 
				ya sea mayúscula o minúscula, que permita ingresar los datos.
				Al final está el else que mostrará error en caso de que lo insertado sea un número o caracter especial.*/
			##############################
			else if (preg_match('/^[a-zA-Z]+$/', $_POST['txtusuario']) || preg_match('/^[a-zA-Z]+$/', $_POST['txtnombre_usuario'])) {


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
				$intIdObjeto = (MUSUARIO); //ESTE VALOR VA A CAMBIAR MAS A DELANTE
				$request_bitacora = "";



				//CUANDO ESTÁ INSERTANDO
				#############################################################################################
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
						$strDescripcion = "CREACIÓN DE USUARIO: $strusuario ";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertUsuarioBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					} //FIN DEL IF DE INSERTAR



					//CUANDO ESTÁ ACTUALIZANDO
					###############################################################################################
				} else {
					$option = 2; //SI OPTION ES 2, ENTONCES ESTARÁ ACTUALIZANDO


					$arrDatosUsuario = $this->model->selectUsuario($id_usuario); //Arreglo que obtiene los datos.
					$nombreAnterior = $arrDatosUsuario['nombre_usuario']; //Se obtiene el dato del campo.
					$emailAnterior = $arrDatosUsuario['correo_electronico']; //Se obtiene el dato del campo.
					$rolAnterior = $arrDatosUsuario['nombrerol']; //Se obtiene el dato del campo.
					$estadoAnterior = $arrDatosUsuario['estado']; //Se obtiene el dato del campo.



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


					
if($strnombre_usuario != $nombreAnterior){
				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
				$strAccion = "ACTUALIZAR";
				$strDescripcion = "ACTUALIZACIÓN DE USUARIO:  ($strusuario) NOMBRE DE USUARIO ANTERIOR:($nombreAnterior) VALOR NUEVO: ($strnombre_usuario) ";

				//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
				$request_bitacora = $this->model->insertUsuarioBitacora(
					$dateFecha,
					$intIdUsuario,
					$intIdObjeto,
					$strAccion,
					$strDescripcion
				);
}
	
if($strEmail != $emailAnterior){
				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
				$strAccion = "ACTUALIZAR";
				$strDescripcion = "ACTUALIZACIÓN DE USUARIO:  ($strusuario) CORREO ANTERIOR:($emailAnterior) VALOR NUEVO: ($strEmail) ";

				//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
				$request_bitacora = $this->model->insertUsuarioBitacora(
					$dateFecha,
					$intIdUsuario,
					$intIdObjeto,
					$strAccion,
					$strDescripcion
				);
}

if($intTipoId != $rolAnterior){
				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
				$strAccion = "ACTUALIZAR";
				$strDescripcion = "ACTUALIZACIÓN DE USUARIO:  ($strusuario) ROL ANTERIOR:($rolAnterior) VALOR NUEVO: ($intTipoId) ";

				//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
				$request_bitacora = $this->model->insertUsuarioBitacora(
					$dateFecha,
					$intIdUsuario,
					$intIdObjeto,
					$strAccion,
					$strDescripcion
				);
}

if($intestado != $estadoAnterior){
	//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
	$strAccion = "ACTUALIZAR";
	$strDescripcion = "ACTUALIZACIÓN DE USUARIO:  ($strusuario) ESTADO ANTERIOR:($estadoAnterior) VALOR NUEVO: ($intestado) ";

	//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
	$request_bitacora = $this->model->insertUsuarioBitacora(
		$dateFecha,
		$intIdUsuario,
		$intIdObjeto,
		$strAccion,
		$strDescripcion
	);
}

				} //FIN DEL ELSE PARA ACTUALIZAR
				if ($request_user === 'exist') {
					$arrResponse = array('status' => false, 'msg' => '¡Atención! el email o la identificación ya existe, ingrese otro.');
				} else if ($request_user === 'admin') {
					$arrResponse = array('status' => false, 'msg' => '¡Atención! el usuario Administrador no se puede inactivar.');
				} else if ($request_user > 0) {
					if ($option == 1) {


						$dataUsuario = array(
							'nombreUsuario' => $strnombre_usuario,
							'usuario' => $strusuario,
							'email' => $strEmail,
							'asunto' => 'Mostrar cuenta - ' . NOMBRE_REMITENTE,
							'contrasena' => $contrasena
						);



						// try {
						//MANDA CORREO
						################################################################################
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

	public function getUsuarios()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectUsuarios();
			for ($i = 0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';
				$btnReinicio = '';

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
					$btnView = '<button class="btn btn-info btn-sm btnViewUsuario" onClick="fntViewUsuario(' . $arrData[$i]['id_usuario'] . ')" title="Ver usuario"><i class="far fa-eye"></i></button>';
				}


				//if ($_SESSION['permisosMod']['u']) {
				if ($_SESSION['idUser'] == 1) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditUsuario" onClick="fntEditUsuario(this,' . $arrData[$i]['id_usuario'] . ')" title="Editar usuario"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}
				############################
				if ($_SESSION['idUser'] == 1) {
					$btnReinicio = '<button class="btn btn-Warning btn-sm btnReinicioUsuario" onClick="fntReinicioUsuario(' . $arrData[$i]['id_usuario'] . ')" title="Reiniciar Contraseña"><i class="fas fa-sync-alt"></i></button>';
				}
				//sendMailLocal($dataUsuario, 'email_usuarioReinicio'); //ENVIAR CORREO

				############################


				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelUsuario" onClick="fntDelUsuario(' . $arrData[$i]['id_usuario'] . ')" title="Eliminar usuario"><i class="far fa-trash-alt"></i></button>';
				} else {
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . ' ' . $btnReinicio . '</div>';
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
				$requestNombreUsuario = $this->model->selectUsuario($intid_usuario);
				$requestDelete = $this->model->deleteUsuario($intid_usuario);
				$nombreUsuario = $requestNombreUsuario['usuario'];

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MUSUARIO);
				$request_bitacora = "";

				if ($requestDelete == 'ok') {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado el usuario');

					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACIÓN DE USUARIO : $nombreUsuario ";

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




	public function reiniciarContrasena()
	{
		if ($_POST) {



			// if ($_SESSION['permisosMod']['d']) {
			$intid_usuario = intval($_POST['id_usuario']);
			$password1 = passGenerator();
			$strPassword =  hash("SHA256", $password1);
			$requestReinicio = $this->model->reinicioContrasena($intid_usuario, $strPassword);


			$arrData = $this->model->selectUsuario($intid_usuario);
			$email = $arrData['correo_electronico'];


			$dataUsuario = array(
				'email' => $email,
				'asunto' => 'Reinicio de Contraseña - ' . NOMBRE_REMITENTE,
				'contrasena' => $password1
			);
			if ($requestReinicio) {
				$arrResponse = array('status' => true, 'msg' => 'Se ha reiniciado la contraseña');
				sendMailLocal($dataUsuario, 'email_usuarioReinicio'); //ENVIAR CORREO
			} else {
				$arrResponse = array('status' => false, 'msg' => 'Error al reiniciar la contraseña');
			}

			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		// }

		die();
	}















	// public function perfil()
	// {
	// 	$data['page_tag'] = "Perfil";
	// 	$data['page_title'] = "Perfil de usuario";
	// 	$data['page_name'] = "perfil";
	// 	$data['page_functions_js'] = "functions_usuarios.js";
	// 	$this->views->getView($this, "perfil", $data);
	// }

	// public function putPerfil()
	// {
	// 	if ($_POST) {
	// 		if (empty($_POST['txtusuario']) || empty($_POST['txtNombre']) || empty($_POST['txtpreguntas_contestadas'])) {
	// 			$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
	// 		} else {
	// 			$id_usuario = $_SESSION['idUser'];
	// 			$strusuario = strClean($_POST['txtusuario']);
	// 			$strNombre = strClean($_POST['txtNombre']);
	// 			//$strApellido = strClean($_POST['txtApellido']);
	// 			$intpreguntas_contestadas = intval(strClean($_POST['txtpreguntas_contestadas']));
	// 			$strPassword = "";
	// 			if (!empty($_POST['txtPassword'])) {
	// 				$strPassword = hash("SHA256", $_POST['txtPassword']);
	// 			}
	// 			$request_user = $this->model->updatePerfil(
	// 				$id_usuario,
	// 				$strusuario,
	// 				$strNombre,
	// 				$intpreguntas_contestadas,
	// 				$strPassword
	// 			);
	// 			if ($request_user) {
	// 				sessionUser($_SESSION['idUser']);
	// 				$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
	// 			} else {
	// 				$arrResponse = array("status" => false, "msg" => 'No es posible actualizar los datos.');
	// 			}
	// 		}
	// 		echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
	// 	}
	// 	die();
	// }

	// public function putDFical()
	// {
	// 	if ($_POST) {
	// 		if (empty($_POST['txtNit']) || empty($_POST['txtNombreFiscal']) || empty($_POST['txtDirFiscal'])) {
	// 			$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
	// 		} else {
	// 			$id_usuario = $_SESSION['idUser'];
	// 			$strNit = strClean($_POST['txtNit']);
	// 			$strNomFiscal = strClean($_POST['txtNombreFiscal']);
	// 			$strDirFiscal = strClean($_POST['txtDirFiscal']);
	// 			$request_datafiscal = $this->model->updateDataFiscal(
	// 				$id_usuario,
	// 				$strNit,
	// 				$strNomFiscal,
	// 				$strDirFiscal
	// 			);
	// 			if ($request_datafiscal) {
	// 				sessionUser($_SESSION['idUser']);
	// 				$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
	// 			} else {
	// 				$arrResponse = array("status" => false, "msg" => 'No es posible actualizar los datos.');
	// 			}
	// 		}
	// 		echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
	// 	}
	// 	die();
	// }
}
