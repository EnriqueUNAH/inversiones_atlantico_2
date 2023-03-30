<?php

class Objetos extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MOBJETO);
	}

	public function Objetos()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Objetos";
		$data['page_title'] = "OBJETOS <small>Inversiones Atlántico</small>";
		$data['page_name'] = "objetos";
		$data['page_functions_js'] = "functions_objetos.js";
		$this->views->getView($this, "objetos", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = 2;
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MODULO OBJETOS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertObjetosBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}

	public function setObjeto()
	{
		if ($_POST) {
			if (empty($_POST['txtobjeto']) || empty($_POST['txtdescripcion'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$id_objeto = intval($_POST['id_objeto']);
				$strobjeto = strtoupper(strClean($_POST['txtobjeto']));
				$strdescripcion = strtoupper(strClean($_POST['txtdescripcion']));
				$request_user = "";

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2;
				$request_bitacora = "";

				if ($id_objeto == 0) {
					$option = 1; //LA OPCIÓN ES 1, ENTONCES ESTARÁ INSERTANDO
					//$strPassword =  empty($_POST['txtPassword']) ? hash("SHA256", passGenerator()) : hash("SHA256", $_POST['txtPassword']);

					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertObjetos(
							$strobjeto,
							$strdescripcion,

						);

						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "CREACION DE OBJETO";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertObjetosBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					} //FIN DEL IF DE INSERTAR
				} else {
					$option = 2; //SI OPTION ES 2, ENTONCES ESTARÁ ACTUALIZANDO
					//$strPassword =  empty($_POST['txtPassword']) ? "" : hash("SHA256", $_POST['txtPassword']);
					if ($_SESSION['permisosMod']['u']) {
						$request_user = $this->model->updateObjetos(
							$id_objeto,
							$strobjeto,
							$strdescripcion,

						);
					}

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
					$strAccion = "ACTUALIZAR";
					$strDescripcion = "ACTUALIZACIÓN DE OBJETO";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertObjetosBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} //FIN DEL ELSE PARA ACTUALIZAR

				if ($request_user > 0) {
					if ($option == 1) {
						$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');
					} else {
						$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
					}
				} else if ($request_user == 'exist') {
					$arrResponse = array('status' => false, 'msg' => '¡Atención! el email o la identificación ya existe, ingrese otro.');
				} else {
					$arrResponse = array("status" => false, "msg" => 'No es posible almacenar los datos.');
				}
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getObjetos()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectObjetos();
			for ($i = 0; $i < count($arrData); $i++) {

				$btnEdit = '';
				//$btnDelete = '';

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditObjeto" onClick="fntEditObjeto(this,' . $arrData[$i]['id_objeto'] . ')" title="Editar objeto"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}

				// if ($_SESSION['permisosMod']['d']) {
				// 	$btnDelete = '<button class="btn btn-danger btn-sm btnDelObjeto" onClick="fntDelObjeto(' . $arrData[$i]['id_objeto'] . ')" title="Eliminar objeto"><i class="far fa-trash-alt"></i></button>';
				// } else {
				// 	$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
				// }

				$arrData[$i]['options'] = '<div class="text-center">' . $btnEdit . ' </div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getObjeto($id_objeto)
	{
		if ($_SESSION['permisosMod']['r']) {
			$id_objeto = intval($id_objeto);
			if ($id_objeto > 0) {
				$arrData = $this->model->selectObjeto($id_objeto);
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

	public function delObjeto()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$id_objeto = intval($_POST['id_objeto']);
				$requestDelete = $this->model->deleteObjetos($id_objeto);

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2;
				$request_bitacora = "";

				if ($requestDelete) {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado el Objeto');

					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACION DE OBJETO";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertObjetosBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al eliminar el Objeto.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}
}
