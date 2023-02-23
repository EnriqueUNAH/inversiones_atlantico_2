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
			if (empty($_POST['txtEmail']) || empty($_POST['txtPassword'])) {
				$arrResponse = array('' => false, 'msg' => 'Error de datos');
			} else {
				$strUsuario  =  strtolower(strClean($_POST['txtEmail']));
				$strPassword = hash("SHA256", $_POST['txtPassword']);
				$requestUser = $this->model->loginUser($strUsuario, $strPassword);
				if (empty($requestUser)) {
					$arrResponse = array('' => false, 'msg' => 'El usuario o la contraseña es incorrecto.');
				} else {
					$arrData = $requestUser;
					if ($arrData['estado'] == 1) {
						$_SESSION['idUser'] = $arrData['id_usuario'];
						$_SESSION['login'] = true;
						$_SESSION['elUsuario'] = $arrData['usuario'];

						$arrData = $this->model->sessionLogin($_SESSION['idUser']);
						sessionUser($_SESSION['idUser']);
						$arrResponse = array('status' => true, 'msg' => 'ok');
					} else if ($arrData['estado'] == 3) { //CUANDO EL ESTADO SEA NUEVO
						//$_SESSION['idUser'] = $arrData['id_usuario'];
						header("Location: ../Views/Login/preguntasPrimeraVez.php");
						exit();
					} else {
						$arrResponse = array('status' => false, 'msg' => 'Usuario inactivo.');
					}
				}
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
				$strUsuario  =  strtolower(strClean($_POST['txtEmailReset']));
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
						try {
							$sendEmail = sendMailLocal($dataUsuario, 'email_cambioPassword');
							$arrResponse = array('status' => true, 'msg' => 'Se ha enviado un email a tu cuenta de correo');
						} catch (Exception $e) {
							$arrResponse = array(
								'status' => false,
								'msg' => 'No es posible realizar el proceso. Error en el envío de correo: ' . $e->getMessage()
							);
						}
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

	public function resetPassPreguntaaaa()
	{
		if ($_POST) {
			if (empty($_POST['txtEmailReset'])) {
				$_SESSION['error'] = 'Error de datos';
			} else {
				$strEmail = strtolower(strClean($_POST['txtEmailReset']));
				$arrData = $this->model->getUserEmail($strEmail);

				if (empty($arrData)) {
					$_SESSION['error'] = 'Usuario no existente.';
				} else {
					$_SESSION['email'] = $strEmail;
					header('Location: ' . base_url() . '/Views/Login/route.php');
					exit;
				}
			}
		}
	}
	public function resetPassPregunta()
	{
		if ($_POST) {
			error_reporting(0);

			if (empty($_POST['txtEmailReset'])) {
				$arrResponse = array('' => false, 'msg' => 'Error de datos');
			} else {
				$token = token();
				$strEmail  =  strtolower(strClean($_POST['txtEmailReset']));
				$arrData = $this->model->getUserEmail($strEmail);

				if (empty($arrData)) {
					$arrResponse = array('' => false, 'msg' => 'Usuario no existente.');
				} else {
					$id_usuario = $arrData['id_usuario'];
					$nombreUsuario = $arrData['usuario'];

					$url_recovery = base_url() . '/Login/confirmUser/' . $strEmail . '/' . $token;
					$requestUpdate = $this->model->setTokenUser($id_usuario, $token);

					$dataUsuario = array(
						'nombre_usuario' => $nombreUsuario,
						'email' => $strEmail,
						'asunto' => 'Recuperar cuenta - ' . NOMBRE_REMITENTE,
						'url_recovery' => $url_recovery
					);
					if ($requestUpdate) {
						$sendEmail = sendMailLocal($dataUsuario, 'email_cambioPassword');

						if ($sendEmail) {
							$arrResponse = array(
								'' => true,
								'msg' => 'Se ha enviado un email a tu cuenta de correo para cambiar tu contraseña.'
							);
						} else {
							$arrResponse = array(
								'' => false,
								'msg' => 'No es posible realizar el proceso'
							);
						}
					} else {
						$arrResponse = array(
							'' => false,
							'msg' => 'No es posible realizar el proceso, intenta más tarde.'
						);
					}
				}
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}



	public function confirmUser(string $params)
	{

		if (empty($params)) {
			header('Location: ' . base_url());
		} else {
			$arrParams = explode(',', $params);
			$strEmail = strClean($arrParams[0]);
			$strToken = strClean($arrParams[1]);
			$arrResponse = $this->model->getUsuario($strEmail, $strToken);
			if (empty($arrResponse)) {
				header("Location: " . base_url());
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
