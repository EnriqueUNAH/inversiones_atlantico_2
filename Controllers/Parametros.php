<?php

class Parametros extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MPARAMETRO);
	}

	public function Parametros()
	{
		$data['page_tag'] = "Parametros";
		$data['page_title'] = "PARÁMETROS <small>Inversiones Atlántico</small>";
		$data['page_name'] = "parámetros";
		$data['page_functions_js'] = "functions_parametros.js";
		$this->views->getView($this, "parametros", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = (MPARAMETRO);
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO PARÁMETROS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertParametroBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}

	public function setParametro()
	{
		if ($_POST) {
			if (empty($_POST['txtparametro']) || empty($_POST['txtvalor'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$id_parametro = intval($_POST['id_parametro']);
				$strparametro = strtoupper(strClean($_POST['txtparametro']));
				$strvalor = strClean($_POST['txtvalor']);
				$request_user = "";

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MPARAMETRO);               // ([["OJO"]]) HAY QUE CAMBIAR ESTE ID DESPUÉS CUANDO YA AGREGUEMOS TODOS LOS OBJETOS
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
						$strDescripcion = "CREACIÓN DE PARÁMETRO: $strparametro";

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

					$arrParametroAnterior = $this->model->selectParametro($id_parametro); //Arreglo que obtiene los datos.
					$valorParametroAnterior = $arrParametroAnterior['valor']; //Se obtiene el dato del campo: valor.

					if ($_SESSION['permisosMod']['u']) {

						$request_user = $this->model->updateParametro(
							$id_parametro,
							$strparametro,
							$strvalor
						);
					}

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
					$strAccion = "ACTUALIZAR";
					$strDescripcion = "ACTUALIZACIÓN DEL VALOR DEL PARÁMETRO: ($strparametro) VALOR ANTERIOR:($valorParametroAnterior) VALOR NUEVO: ($strvalor)";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertParametroBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} //FIN DEL ELSE PARA ACTUALIZAR

				if ($request_user === 'exist') {
					$arrResponse = array('status' => false, 'msg' => '¡Atención! el parámetro ya existe, ingrese otra.');
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

	public function getParametros()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectParametros();
			for ($i = 0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';


				if ($_SESSION['permisosMod']['r']) {
					$btnView = '<button class="btn btn-info btn-sm btnViewParametro" onClick="fntViewParametro(' . $arrData[$i]['id_parametro'] . ')" title="Ver parametro"><i class="far fa-eye"></i></button>';
				}

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditParametro" onClick="fntEditParametro(this,' . $arrData[$i]['id_parametro'] . ')" title="Editar parametro"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}

				// if ($_SESSION['permisosMod']['d']) {
				// 	$btnDelete = '<button class="btn btn-danger btn-sm btnDelParametro" onClick="fntDelParametro(' . $arrData[$i]['id_parametro'] . ')" title="Eliminar parametro"><i class="far fa-trash-alt"></i></button>';
				// } else {
				// 	$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
				// }
				$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getParametro($id_parametro)
	{
		if ($_SESSION['permisosMod']['r']) {
			$id_parametro = intval($id_parametro);
			if ($id_parametro > 0) {
				$arrData = $this->model->selectParametro($id_parametro);
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

	public function delParametro()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$intid_parametro = intval($_POST['id_parametro']);
				$requestDelete = $this->model->deleteParametro($intid_parametro);

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MPARAMETRO);
				$request_bitacora = "";

				if ($requestDelete) {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado el parametro');

					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACIÓN DE PARÁMETRO";

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
