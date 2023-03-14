<?php

class Promocion extends Controllers
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

	public function Promocion()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Promocion";
		$data['page_title'] = "PROMOCION <small>Inversiones Atlántico</small>";
		$data['page_name'] = "promocion";
		$data['page_functions_js'] = "functions_promocion.js";
		$this->views->getView($this, "promocion", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = 2;
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO PARÁMETROS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertPromocionBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}


	public function setPromocion()
	{
		if ($_POST) {
			if (empty($_POST['txtnombre_promocion']) || empty($_POST['txtfecha_inicio']) || empty($_POST['txtfecha_final']) || empty($_POST['txtprecio_venta'])) {
				$arrResponse = array("status" => false,"msg" => 'Datos incorrectos.');
				} else {
					$cod_promocion = intval($_POST['cod_promocion']);
					$strnombre_promocion = strtoupper(strClean($_POST['txtnombre_promocion']));
					$datefecha_inicio = strClean($_POST['txtfecha_inicio']);
					$datefecha_final = strClean($_POST['txtfecha_final']);
					$intprecio_venta = intval(strClean($_POST['txtprecio_venta']));
					$request_user = "";

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2;                // ([["OJO"]]) HAY QUE CAMBIAR ESTE ID DESPUÉS CUANDO YA AGREGUEMOS TODOS LOS OBJETOS
				$request_bitacora = "";

				if ($cod_promocion == 0) {
					$option = 1; //LA OPCIÓN ES 1, ENTONCES ESTARÁ INSERTANDO

					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertPromocion(
							$strnombre_promocion,
							$datefecha_inicio,
		 					$datefecha_final,
		 					$intprecio_venta

						);

						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "CREACIÓN DE PROMOCION";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertPromocionBitacora(
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
						$request_user = $this->model->updatePromocion(
							$cod_promocion,
							$strnombre_promocion,
							$datefecha_inicio,
		 					$datefecha_final,
		 					$intprecio_venta
						);
					}

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
					$strAccion = "ACTUALIZAR";
					$strDescripcion = "ACTUALIZACIÓN DE PROMOCION";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertPromocionBitacora(
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







	public function getPromocion()
	{
		if($_SESSION['permisosMod']['r']){
			$arrData = $this->model->selectPromocion();
			for ($i=0; $i < count($arrData); $i++) {
			
				$btnEdit = '';
			 	$btnDelete = '';
			 	
			 	if($_SESSION['permisosMod']['u']){
			 		$btnEdit = '<button class="btn btn-primary  btn-sm btnEditPromocion" onClick="fntEditPromocion(this,'.$arrData[$i]['cod_promocion'].')" title="Editar promocion"><i class="fas fa-pencil-alt"></i></button>';
			 	}
			 	if($_SESSION['permisosMod']['d']){	
			 		$btnDelete = '<button class="btn btn-danger btn-sm btnDelPromocion" onClick="fntDelPromocion('.$arrData[$i]['cod_promocion'].')" title="Eliminar promocion"><i class="far fa-trash-alt"></i></button>';
				}
			 	$arrData[$i]['options'] = '<div class="text-center">'.$btnEdit.' '.$btnDelete.'</div>';
			 }
			echo json_encode($arrData,JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getPromocion1($cod_promocion)
	{
		if ($_SESSION['permisosMod']['r']) {
			$cod_promocion = intval($cod_promocion);
			if ($cod_promocion > 0) {
				$arrData = $this->model->selectPromocion1($cod_promocion);
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


	public function delPromocion()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$cod_promocion = intval($_POST['cod_promocion']);
				$requestDelete = $this->model->deletePromocion($cod_promocion);

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2;
				$request_bitacora = "";

				if ($requestDelete) {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado la promocion');

					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACION DE PROMOCION";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertPromocionBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al eliminar la promocion.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}



}