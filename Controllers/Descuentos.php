<?php 

class Descuentos extends Controllers{
	public function __construct()
	{
		parent::__construct();
		session_start();
		//session_regenerate_id(true);
		if(empty($_SESSION['login']))
		{
			header('Location: '.base_url().'/login');
			die();
		}
		 getPermisos(MDESCUENTO);
	}

	public function Descuentos()
	{
		if(empty($_SESSION['permisosMod']['r'])){
			header("Location:".base_url().'/dashboard');
		}
		$data['page_tag'] = "Descuentos";
		$data['page_title'] = "DESCUENTOS <small>Inversines del Atlantico</small>";
		$data['page_name'] = "descuentos";
		$data['page_functions_js'] = "functions_descuentos.js";
		$this->views->getView($this,"descuentos",$data);

        //Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = (MDESCUENTO);
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO DE DESCUENTOS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertDescuentoBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);



	}

	public function setDescuento()
	{
		if (isset($_POST)) {
			if (empty($_POST['txtNombre']) || empty($_POST['txtPorcentaje'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$cod_descuento = intval($_POST['cod_descuento']);
				$strnombre = strtoupper(strClean($_POST['txtNombre']));
				$intPorcentaje = ($_POST['txtPorcentaje']);
				$request_user = "";

				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MDESCUENTO);                
				$request_bitacora = "";

				if ($cod_descuento == 0) {
					$option = 1;

					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertDescuento(
							$strnombre,
							$intPorcentaje

						);

						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "CREACIÓN DE DESCUENTO: $strnombre";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertDescuentoBitacora(
							$dateFecha,
						 	$intIdUsuario,
						 	$intIdObjeto,
						 	$strAccion,
						 	$strDescripcion
						);
					} //FIN DEL IF DE INSERTAR
				}else{
                    $option = 2;

					$requestDescuento = $this->model->selectDescuento($cod_descuento);
				    $nombreDesc = $requestDescuento['nombre_descuento'];
					$porcentajeAnterior = $requestDescuento['porcentaje_descuento'];

					if ($_SESSION['permisosMod']['u']) {
						$request_user = $this->model->updateDescuento(
							$cod_descuento,
							$strnombre,
							$intPorcentaje
						);
						
					}

					if ($strnombre != $nombreDesc) {
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
						$strAccion = "ACTUALIZAR";
						$strDescripcion = "ACTUALIZACIÓN DE DESCUENTO:  ($nombreDesc)  VALOR NUEVO: ($strnombre) ";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertDescuentoBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					}


					if ($intPorcentaje != $porcentajeAnterior) {
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
						$strAccion = "ACTUALIZAR";
						$strDescripcion = "ACTUALIZACIÓN DE PRODUCTOS:  ($strnombre) PORCENTAJE DEL PRODUCTO ANTERIOR:($porcentajeAnterior) VALOR NUEVO: ($intPorcentaje) ";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertDescuentoBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					}

				

				} //FIN DEL ELSE PARA ACTUALIZAR

				if ($request_user === 'exist') {
					$arrResponse = array('status' => false, 'msg' => '¡Atención! el proveedor ya existe, ingrese otro.');
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












		

	public function getDescuentos()
	{
		if($_SESSION['permisosMod']['r']){
			$arrData = $this->model->selectDescuentos();
			for ($i=0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';
				if($_SESSION['permisosMod']['r']){
					$btnView = '<button class="btn btn-info btn-sm" onClick="fntViewInfo('.$arrData[$i]['cod_descuento'].')" title="Ver descuento"><i class="far fa-eye"></i></button>';
				}
				if($_SESSION['permisosMod']['u']){
					$btnEdit = '<button class="btn btn-primary  btn-sm" onClick="fntEditInfo(this,'.$arrData[$i]['cod_descuento'].')" title="Editar descuento"><i class="fas fa-pencil-alt"></i></button>';
				}
				if($_SESSION['permisosMod']['d']){	
					$btnDelete = '<button class="btn btn-danger btn-sm" onClick="fntDelInfo('.$arrData[$i]['cod_descuento'].')" title="Eliminar descuento"><i class="far fa-trash-alt"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center">'.$btnEdit.' '.$btnDelete.'</div>';
			}
			echo json_encode($arrData,JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getDescuento($cod_descuento){
		if($_SESSION['permisosMod']['r']){
			if($cod_descuento > 0)
			{
				$arrData = $this->model->selectDescuento($cod_descuento);
				if(empty($arrData))
				{
					$arrResponse = array('status' => false, 'msg' => 'Datos no encontrados.');
				}else{
					$arrResponse = array('status' => true, 'data' => $arrData);
				}
				echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
			}
		}
		die();
	}

	public function delDescuento(){
		if($_POST){
			if($_SESSION['permisosMod']['d']){
				$cod_descuento = intval($_POST['cod_descuento']);
				$requestDescuento = $this->model->selectDescuento($cod_descuento);
				$requestDelete = $this->model->deleteDescuento($cod_descuento);
				$nombreDesc = $requestDescuento['nombre_descuento'];
				
				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MDESCUENTO);
				$request_bitacora = "";


				if($requestDelete == 'ok') {
					$arrResponse = array('nombre_descuento' => '','msg' => 'Se ha eliminado el descuento');


					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACIÓN DE DESCUENTO: $nombreDesc ";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertDescuentoBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);



				}else{
					$arrResponse = array('nombre_descuento' => false, 'msg' => 'Error al eliminar el descuento.');
				}
				echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
			}

		}
		die();
	}
		// }
		
	// }



}
