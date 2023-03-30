<?php 

class Resultado extends Controllers{
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
		// getPermisos(MCLIENTES);
	}

	public function Resultado()
	{
		if(empty($_SESSION['permisosMod']['r'])){
			header("Location:".base_url().'/dashboard');
		}
		$data['page_tag'] = "Resultado";
		$data['page_title'] = "RESULTADO PRODUCCION <small>Inversines del Atlantico</small>";
		$data['page_name'] = "resultado";
		$data['page_functions_js'] = "functions_resultado.js";
		$this->views->getView($this,"resultado",$data);
	}

	public function setResultado()
	{
		if (isset($_POST)) {
			if (empty($_POST['txtCantidad']) || empty($_POST['txtDescripcion'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$cod_producto= ($_POST['txtCodigo']);
				$intCantidad = (($_POST['txtCantidad']));
				$strDescripcion = ($_POST['txtDescripcion']);
				$request_user = "";

				// $dateFecha = date('Y-m-d H:i:s');
				// $intIdUsuario = $_SESSION['idUser'];
				// $intIdObjeto = 2;                
				// $request_bitacora = "";

				if (empty($_POST['txtCodigo'])) {
					$option = 2;
					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertResultado(
							$intCantidad,
							$strDescripcion
						);

						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "CREACIÓN DE DESCUENTO";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						// $request_bitacora = $this->model->insertParametroBitacora(
						// 	$dateFecha,
						// 	$intIdUsuario,
						// 	$intIdObjeto,
						// 	$strAccion,
						// 	$strDescripcion
						//);
					} //FIN DEL IF DE INSERTAR
				}else{

					$cod_producto= ($_POST['txtCodigo']);
					$intCantidad = (($_POST['txtCantidad']));
					$strDescripcion = ($_POST['txtDescripcion']);
					if ($_SESSION['permisosMod']['u']) {
						$request_user = $this->model->updateResultado(
							$cod_producto,
							$intCantidad,
							$strDescripcion
						);
						$option = 1;
					}

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
					$strAccion = "ACTUALIZAR";
					$strDescripcion = "ACTUALIZACIÓN DE DESCUENTO";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					// $request_bitacora = $this->model->insertParametroBitacora(
					// 	$dateFecha,
					// 	$intIdUsuario,
					// 	$intIdObjeto,
					// 	$strAccion,
					// 	$strDescripcion
					// );
				} //FIN DEL ELSE PARA ACTUALIZAR

				if($request_user > 0){
					if ($option == 2){
						$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');
					}else{
						$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
					}
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			// die();
		}
	}
}
		

	public function getResultado()
	{
		if($_SESSION['permisosMod']['r']){
			$arrData = $this->model->selectResultados();
			for ($i=0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';
				if($_SESSION['permisosMod']['r']){
					$btnView = '<button class="btn btn-info btn-sm" onClick="fntViewInfo('.$arrData[$i]['cod_producto'].')" title="Ver producto"><i class="far fa-eye"></i></button>';
				}
				if($_SESSION['permisosMod']['u']){
					$btnEdit = '<button class="btn btn-primary  btn-sm" onClick="fntEditInfo(this,'.$arrData[$i]['cod_producto'].')" title="Editar producto"><i class="fas fa-pencil-alt"></i></button>';
				}
				if($_SESSION['permisosMod']['d']){	
					$btnDelete = '<button class="btn btn-danger btn-sm" onClick="fntDelInfo('.$arrData[$i]['cod_producto'].')" title="Eliminar producto"><i class="far fa-trash-alt"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center"></div>';
			}
			echo json_encode($arrData,JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getResultados($cod_producto){
		if($_SESSION['permisosMod']['r']){
			if($cod_producto > 0)
			{
				$arrData = $this->model->selectResultado($cod_producto);
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

	public function delProducto(){
		if($_POST){
			// if($_SESSION['permisosMod']['d']){
				$intIdproducto = intval($_POST['cod_producto']);
				$requestDelete = $this->model->deleteDescuento($intIdproducto);
				if($requestDelete)
				{
					$arrResponse = array('nombre_descuento' => '','msg' => 'Se ha eliminado el descuento');
				}else{
					$arrResponse = array('nombre_descuento' => false, 'msg' => 'Error al eliminar el descuento.');
				}
				echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
			// }

		}
		die();
	}
		// }
		
	// }



}

?>