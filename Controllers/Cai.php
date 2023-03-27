<?php 

class Cai extends Controllers{
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

	public function Cai()
	{
		if(empty($_SESSION['permisosMod']['r'])){
			header("Location:".base_url().'/dashboard');
		}
		$data['page_tag'] = "Cai";
		$data['page_title'] = "CAI <small>Inversines del Atlantico</small>";
		$data['page_name'] = "cai";
		$data['page_functions_js'] = "functions_cai.js";
		$this->views->getView($this,"cai",$data);
	}

	public function setCai()
	{
		if (isset($_POST)) {
			if (empty($_POST['txtRangoIni']) || empty($_POST['txtRangoFin']) || empty($_POST['txtRangoAct']) || empty($_POST['txtCai']) ) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				//$cod_talonario= ($_POST['txtIdCodigo']);
				$rango_inicial = (($_POST['txtRangoIni']));
				$rango_final = ($_POST['txtRangoFin']);
				$rango_actual = (($_POST['txtRangoAct']));
				$numero_CAI = ($_POST['txtCai']);
				$fecha_vencimiento = ($_POST['txtFecha']);
				$request_user = "";

				$dateFecha = date('Y-m-d H:i:s');
				// $intIdUsuario = $_SESSION['idUser'];
				// $intIdObjeto = 2;                
				// $request_bitacora = "";

				if (empty($_POST['txtIdCodigo'])) {
					$option = 2;
					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertCai(
							$rango_inicial,
							$rango_final,
							$rango_actual,
							$numero_CAI
						);

						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "CREACIÓN DE CAI";

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
					$cod_talonario= ($_POST['txtIdCodigo']);
					$rango_inicial = (($_POST['txtRangoIni']));
					$rango_final = ($_POST['txtRangoFin']);
					$rango_actual = (($_POST['txtRangoAct']));
					$numero_CAI = ($_POST['txtCai']);
					$fecha_vencimiento = ($_POST['txtFecha']);
					if ($_SESSION['permisosMod']['u']) {
						$request_user = $this->model->updateCai(
							$cod_talonario,
							$rango_inicial,
							$rango_final,
							$rango_actual,
							$numero_CAI,
							$fecha_vencimiento
						);
						$option = 1;
					}

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
					$strAccion = "ACTUALIZAR";
					$strDescripcion = "ACTUALIZACIÓN DE CAI";

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
		

public function getCais()
{
	if($_SESSION['permisosMod']['r']){
		$arrData = $this->model->selectCais();
		for ($i=0; $i < count($arrData); $i++) {
			$btnView = '';
			$btnEdit = '';
			$btnDelete = '';
			if($_SESSION['permisosMod']['r']){
				$btnView = '<button class="btn btn-info btn-sm" onClick="fntViewInfo('.$arrData[$i]['cod_talonario'].')" title="Ver CAI"><i class="far fa-eye"></i></button>';
			}
			if($_SESSION['permisosMod']['u']){
				$btnEdit = '<button class="btn btn-primary  btn-sm" onClick="fntEditInfo(this,'.$arrData[$i]['cod_talonario'].')" title="Editar CAI"><i class="fas fa-pencil-alt"></i></button>';
			}
			if($_SESSION['permisosMod']['d']){	
				$btnDelete = '<button class="btn btn-danger btn-sm" onClick="fntDelInfo('.$arrData[$i]['cod_talonario'].')" title="Eliminar CAI"><i class="far fa-trash-alt"></i></button>';
			}
			$arrData[$i]['options'] = '<div class="text-center">'.$btnEdit.' '.$btnDelete.'</div>';
		}
		echo json_encode($arrData,JSON_UNESCAPED_UNICODE);
	}
	die();
}

	public function getCai($cod_talonario){
		if($_SESSION['permisosMod']['r']){
			if($cod_talonario > 0)
			{
				$arrData = $this->model->selectCai($cod_talonario);
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

	public function delCai(){
		if($_POST){
			// if($_SESSION['permisosMod']['d']){
				$intIdproducto = intval($_POST['cod_talonario']);
				$requestDelete = $this->model->deleteCai($intIdproducto);
				if($requestDelete)
				{
					$arrResponse = array('numero_CAI' => '','msg' => 'Se ha eliminado el cai');
				}else{
					$arrResponse = array('numero_CAI' => false, 'msg' => 'Error al eliminar el cai.');
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