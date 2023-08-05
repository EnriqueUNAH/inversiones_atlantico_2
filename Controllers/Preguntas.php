<?php

class Preguntas extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MPREGUNTA);
	}

	public function Preguntas()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Preguntas";
		$data['page_title'] = "PREGUNTAS <small>Inversiones Atlántico</small>";
		$data['page_name'] = "preguntas";
		$data['page_functions_js'] = "functions_preguntas.js";
		$this->views->getView($this, "preguntas", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = (MPREGUNTA);
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO PREGUNTAS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertPreguntasBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}


	public function setPreguntas()
	{
		if ($_POST) {
			if (empty($_POST['txtpregunta'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$id_pregunta = intval($_POST['id_pregunta']);
				$strpregunta = strtoupper(strClean($_POST['txtpregunta']));
				$request_user = "";


				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MPREGUNTA);               // ([["OJO"]]) HAY QUE CAMBIAR ESTE ID DESPUÉS CUANDO YA AGREGUEMOS TODOS LOS OBJETOS
				$request_bitacora = "";

				if ($id_pregunta == 0) {
					$option = 1; //LA OPCIÓN ES 1, ENTONCES ESTARÁ INSERTANDO

					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertPreguntas(
							$strpregunta

						);

						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "SE CREÓ LA PREGUNTA: $strpregunta";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertPreguntasBitacora(
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
						$request_user = $this->model->updatePreguntas(
							$id_pregunta,
							$strpregunta
						);
					}

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
					$strAccion = "ACTUALIZAR";
					$strDescripcion = "ACTUALIZACIÓN DE PREGUNTA";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertPreguntasBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} //FIN DEL ELSE PARA ACTUALIZAR
				if ($request_user === 'exist') {
					$arrResponse = array('status' => false, 'msg' => '¡Atención! la pregunta ya existe, ingrese otra.');
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







	public function getPreguntas()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectPreguntas();
			for ($i = 0; $i < count($arrData); $i++) {

				$btnEdit = '';
				$btnDelete = '';

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditPreguntas" onClick="fntEditPreguntas(this,' . $arrData[$i]['id_pregunta'] . ')" title="Editar pregunta"><i class="fas fa-pencil-alt"></i></button>';
				}
				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelPreguntas" onClick="fntDelPreguntas(' . $arrData[$i]['id_pregunta'] . ')" title="Eliminar pregunta"><i class="far fa-trash-alt"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center"> ' . $btnDelete . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getPregunta($id_pregunta)
	{
		if ($_SESSION['permisosMod']['r']) {
			$id_pregunta = intval($id_pregunta);
			if ($id_pregunta > 0) {
				$arrData = $this->model->selectPregunta($id_pregunta);
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


	public function delPreguntas()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$id_pregunta = intval($_POST['id_pregunta']);

				$requestNombrePregunta = $this->model->selectPregunta($id_pregunta);
				$requestDelete = $this->model->deletePreguntas($id_pregunta);
				$nombrePregunta = $requestNombrePregunta['pregunta'];


				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MPREGUNTA);

				if ($requestDelete == 'ok') {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado la pregunta');

					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACIÓN DE LA PREGUNTA: $nombrePregunta";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$this->model->insertPreguntasBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else if ($requestDelete == 'exist') {
					$arrResponse = array('statusReferencial' => true, 'msg' => 'No es posible eliminar por Integridad Referencial');

					$strAccion = "ELIMINAR";
					$strDescripcion = "SE INTENTÓ ELIMINAR LA PREGUNTA: ($nombrePregunta), NO SE ELIMINÓ POR INTEGRIDAD REFERENCIAL.";


					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$this->model->insertPreguntasBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al eliminar la pregunta.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}
}
