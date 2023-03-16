<?php

class Cai extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		// getPermisos(MUSUARIOS);
	}

	public function Cai()
	{
		$data['page_tag'] = "Cai";
		$data['page_title'] = "CONFIGURACION CAI  <small>Inversiones Atlántico</small>";
		$data['page_name'] = "cai";
		$data['page_functions_js'] = "functions_cai.js";
		$this->views->getView($this, "cai", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = 2;
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO CAI";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertCaiBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}

	public function setCai()
	{
		if ($_POST) {
			if (empty($_POST['txtcai']) || empty($_POST['txtvalor'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$id_parametro = intval($_POST['id_parametro']);
				$strparametro = strtoupper(strClean($_POST['txtcai']));
				$strvalor = strClean($_POST['txtvalor']);
				$request_user = "";

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2;                // ([["OJO"]]) HAY QUE CAMBIAR ESTE ID DESPUÉS CUANDO YA AGREGUEMOS TODOS LOS OBJETOS
				$request_bitacora = "";

				if ($id_parametro == 0) {
					$option = 1; //LA OPCIÓN ES 1, ENTONCES ESTARÁ INSERTANDO

					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertParametro(
							$strparametro,
							$strvalor

						);

						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "CREACIÓN DE PARÁMETRO";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertParametroBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					} //FIN DEL IF DE INSERTAR
				} else {
					$option = 2; //SI OPTION ES 2, ENTONCES ESTARÁ ACTUALIZANDO

					if ($_SESSION['permisosMod']['u']) {
						$request_user = $this->model->updateParametro(
							$id_parametro,
							$strparametro,
							$strvalor
						);
					}

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
					$strAccion = "ACTUALIZAR";
					$strDescripcion = "ACTUALIZACIÓN DE PARAMETRO";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertParametroBitacora(
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

	public function getCai()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectCai();
			for ($i = 0; $i < count($arrData); $i++) {
				// $btnView = '';
				$btnEdit = '';
				$btnDelete = '';


				// if ($_SESSION['permisosMod']['r']) {
				// 	$btnView = '<button class="btn btn-info btn-sm btnViewParametro" onClick="fntViewParametro(' . $arrData[$i]['id_parametro'] . ')" title="Ver parametro"><i class="far fa-eye"></i></button>';
				// }

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditCai" onClick="fntEditCai(this,' . $arrData[$i]['cod_talonario'] . ')" title="Editar parametro"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}

				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelCai" onClick="fntDelCai(' . $arrData[$i]['cod_talonario'] . ')" title="Eliminar parametro"><i class="far fa-trash-alt"></i></button>';
				} else {
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center">' . $btnEdit . ' ' . $btnDelete . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getCais($id_parametro)
	 {
	 	if ($_SESSION['permisosMod']['r']) {
	 		$id_parametro = intval($id_parametro);
	 		if ($id_parametro > 0) {
	 			$arrData = $this->model->selectCais($id_parametro);
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

	public function delCai()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$intid_parametro = intval($_POST['id_parametro']);
				$requestDelete = $this->model->deleteParametro($intid_parametro);

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2;
				$request_bitacora = "";

				if ($requestDelete) {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado el parametro');

					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACION DE USUARIO";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertParametroBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al eliminar el parametro.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}
}
