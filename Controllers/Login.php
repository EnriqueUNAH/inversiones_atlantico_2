<?php

class Login extends Controllers
{
	public function __construct()
	{
		session_start();
		if (isset($_SESSION['login'])) {
			header('Location: ' . base_url() . '/dashboard');
			die();
		}
		parent::__construct();
	}

	public function login()
	{
		$data['page_tag'] = "Login - Inversiones Atlántico";
		$data['page_title'] = "INVERSIONES ATLÁNTICO";
		$data['page_name'] = "login";
		$data['page_functions_js'] = "functions_login.js";
		$this->views->getView($this, "login", $data);
	}

	public function loginUser()
	{
		//dep($_POST);
		if ($_POST) {
			//Cuando alguno de los campos va vacio
			if (empty($_POST['txtEmail']) || empty($_POST['txtPassword'])) {
				$arrResponse = array('' => false, 'msg' => 'Error de datos');

				//CUANDO LOS DOS INPUTS LLEVAN ALGUN DATO
			} else if (preg_match('/^[a-zA-Z]+$/', $_POST['txtEmail'])) {
				$strUsuario  =  strtoupper(strClean($_POST['txtEmail']));
				$strPassword = hash("SHA256", $_POST['txtPassword']);
				$requestUser = $this->model->loginUser($strUsuario, $strPassword);
				$requestId = $this->model->getUserId($strUsuario);

				//SI LA PETICION AL MODELO PARA OBTENER UN USUARIO QUE COINCIDA 
				//CON EL USUARIO INGRESADO ES VACIA, ENTONCES ESE USUARIO NO EXISTE EN
				//LA BASE DE DATOS, POR ESO DEBE HACER LO SIGUIENTE
				if (empty($requestUser)) { //Si no existe un usuario con esa contrasena, entonces:


					if (empty($requestId)) {  //SI EL USUARIO NO EXISTE EN LA BASE DE DATOS
						$arrResponse = array('' => false, 'msg' => 'El usuario o la contraseña es incorrecto.');
					} else { //SI EL USUARIO EXISTE PERO LA CONTRASENA FUE MAL INGRESADA
						$arrDataRolUsuario = $requestId;
						$_SESSION['idUserRol'] = $arrDataRolUsuario['id_usuario'];
						$idUserRolVar = $_SESSION['idUserRol'];

						$requestParametro = $this->model->getParametroIntentos();
						$arrDataParametro = $requestParametro;
						$valor = $arrDataParametro['valor'];
						// Contador de intentos fallidos
						$_SESSION['fallidos'] = ($_SESSION['fallidos'] ?? 0) + 1;


						if ($idUserRolVar != 1) { //IF PARA VER SI USUARIO ES ADMIN
							if ($_SESSION['fallidos'] > $valor) {
								// Bloquear al usuario después de los intentos fallidos segun el parametro
								$arrDataa = $requestId;

								$miUsuario = $arrDataa['id_usuario'];

								$requestU = $this->model->setEstado($miUsuario);
								$arrResponse = array('statusBloqueado' => true, 'msg' => 'USUARIO BLOQUEADO');
							} else {
								$arrResponse = array('' => false, 'msg' => 'El usuario o la contraseña es incorrecto.');
							}
						} else {
							$arrResponse = array('' => false, 'msg' => 'El usuario o la contraseña es incorrecto.');
						}
						//FIN IF
					}



					//SI SE ENCUENTRA UN USUARIO QUE COINCIDA CON LA CONTRASENA
					//ENTOCES EL USUARIO YA PUEDE INGRESAR AL SISTEMA
				} else {
					$arrData = $requestUser;
					if ($arrData['estado'] == 1) {
						$_SESSION['idUser'] = $arrData['id_usuario'];
						$_SESSION['login'] = true;
						$_SESSION['elUsuario'] = $arrData['usuario'];
						$_SESSION['fallidos'] = 0;
						$arrData = $this->model->sessionLogin($_SESSION['idUser']);
						sessionUser($_SESSION['idUser']);
						$arrResponse = array('status' => true, 'msg' => 'ok');

						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
						//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
						$dateFecha = date('Y-m-d H:i:s');
						$intIdUsuario = $_SESSION['idUser'];
						$intIdObjeto = 2;
						$request_bitacora = "";

						$strAccion = "INGRESO";
						$strDescripcion = "INGRESO AL SISTEMA";


						$request_creacion = $this->model->updateUltimaConexion($intIdUsuario);



						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertUsuarioBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					} else if ($arrData['estado'] == 3) { //CUANDO EL ESTADO SEA NUEVO
						//$_SESSION['idUser'] = $arrData['id_usuario'];
						//session_start();
						$_SESSION['usuarioNuevo'] = $strUsuario;
						$arrResponse = array('statusNuevo' => true, 'msg' => 'Usuario NUEVO, debe contestar preguntas secretas');
					} else if ($arrData['estado'] == 4) { //CUANDO EL ESTADO SEA BLOQUEADO
						$arrResponse = array('statusBloqueado' => true, 'msg' => 'USUARIO BLOQUEADO');
					} else {
						$arrResponse = array('status' => false, 'msg' => 'Usuario inactivo.');
					}
				}
			} else {
				$arrResponse = array('status' => false, 'msg' => 'No se permiten caracteres especiales.');
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function resetPass()
	{
		if ($_POST) {
			error_reporting(0);

			if (empty($_POST['txtEmailReset'])) {
				$arrResponse = array('status' => false, 'msg' => 'Error de datos');
			} else {
				$token = token();
				$strUsuario  =  strtoupper(strClean($_POST['txtEmailReset']));
				$arrData = $this->model->getUserEmail($strUsuario);

				if (empty($arrData)) {
					$arrResponse = array('status' => false, 'msg' => 'Usuario no existente.');
				} else {
					$id_usuario = $arrData['id_usuario'];
					$nombreUsuario = $arrData['usuario'];
					$correo = $arrData['correo_electronico'];

					$url_recovery = base_url() . '/Login/confirmUser/' . $correo . '/' . $token;
					$requestUpdate = $this->model->setTokenUser($id_usuario, $token);

					$dataUsuario = array(
						'nombre_usuario' => $nombreUsuario,
						'email' => $correo,
						'asunto' => 'Recuperar cuenta - ' . NOMBRE_REMITENTE,
						'url_recovery' => $url_recovery
					);

					if ($requestUpdate) {

						sendMailLocal($dataUsuario, 'email_cambioPassword');
						$arrResponse = array('status' => true, 'msg' => 'Se ha enviado un email a tu cuenta de correo.');

						// $arrResponse = array(
						// 	'status' => false,
						// 	'msg' => 'No es posible realizar el proceso. Error en el envío de correo: '
						// );
					} else {
						$arrResponse = array(
							'status' => false,
							'msg' => 'No es posible realizar el proceso, intenta más tarde.'
						);
					}
				}
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function resetPassPregunta()
	{
		if ($_POST) {
			error_reporting(0);

			if (empty($_POST['txtEmailReset'])) {
				$arrResponse = array('status' => false, 'msg' => 'Error de datos');
			} else {

				$strUsuario  =  strtoupper(strClean($_POST['txtEmailReset']));
				$arrData = $this->model->getUserEmail($strUsuario);

				if (empty($arrData)) {
					$arrResponse = array('status' => false, 'msg' => 'Usuario no existente.');
				} else {
					session_start();
					$_SESSION['us'] = $strUsuario;
					$arrResponse = array('status' => true, 'msg' => 'Ir a preguntas secretas');
				}
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}



	public function confirmUser(string $params)
	{

		if (empty($params)) {
			header('Location: ' . base_url() . '/login');
		} else {
			$arrParams = explode(',', $params);
			$strEmail = strClean($arrParams[0]);
			$strToken = strClean($arrParams[1]);
			$arrResponse = $this->model->getUsuario($strEmail, $strToken);
			if (empty($arrResponse)) {
				header("Location: " . base_url() . '/login');
			} else {
				$data['page_tag'] = "Cambiar contraseña";
				$data['page_name'] = "cambiar_contrasenia";
				$data['page_title'] = "Cambiar Contraseña";
				$data['correo_electronico'] = $strEmail;
				$data['token'] = $strToken;
				$data['id_usuario'] = $arrResponse['id_usuario'];
				$data['page_functions_js'] = "functions_login.js";



				$this->views->getView($this, "cambiar_password", $data);
			}
		}
		die();
	}

	public function setPassword()
	{

		if (empty($_POST['id_usuario']) || empty($_POST['txtEmail']) || empty($_POST['txtToken']) || empty($_POST['txtPassword']) || empty($_POST['txtPasswordConfirm'])) {

			$arrResponse = array(
				'' => false,
				'msg' => 'Error de datos'
			);
		} else {
			$intid_usuario = intval($_POST['id_usuario']);
			$strPassword = $_POST['txtPassword'];
			$strPasswordConfirm = $_POST['txtPasswordConfirm'];
			$strEmail = strClean($_POST['txtEmail']);
			$strToken = strClean($_POST['txtToken']);

			if ($strPassword != $strPasswordConfirm) {
				$arrResponse = array(
					'' => false,
					'msg' => 'Las contraseñas no son iguales.'
				);
			} elseif (!preg_match('/^(?=.*[a-z]).+$/', $_POST['txtPassword'])) {
				$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener al menos una minúscula.');
			} elseif (!preg_match('/^(?=.*[A-Z]).+$/', $_POST['txtPassword'])) {
				$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener al menos una mayúscula.');
			} elseif (!preg_match('/^(?=.*[^\da-zA-Z]).+$/', $_POST['txtPassword'])) {
				$arrResponse = array("status" => false, "msg" => 'La contraseña debe contener al menos un caracter especial.');
			} else {
				$arrResponseUser = $this->model->getUsuario($strEmail, $strToken);
				if (empty($arrResponseUser)) {
					$arrResponse = array(
						'' => false,
						'msg' => 'Erro de datos.'
					);
				} else {
					$strPassword = hash("SHA256", $strPassword);
					$requestPass = $this->model->insertPassword($intid_usuario, $strPassword);

					if ($requestPass) {

						$requestEstado = $this->model->updateEstado($intid_usuario); //Para que al recuperar contraseña pase a estado Activo

						$arrResponse = array(
							'status' => true,
							'msg' => 'Contraseña actualizada con éxito.'
						);
					} else {
						$arrResponse = array(
							'' => false,
							'msg' => 'No es posible realizar el proceso, intente más tarde.'
						);
					}
				}
			}
		}
		echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		die();
	}
}
