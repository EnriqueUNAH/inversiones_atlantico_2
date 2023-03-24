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
		// getPermisos(MCLIENTES);
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
	}

	public function setDescuento(){
		// error_reporting(0);
		if($_POST){
			if(empty($_POST['txtIdCodigo']) || empty($_POST['txtNombre']) || empty($_POST['txtPorcentaje']))
			{
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			}else{ 
				// $idUsuario = intval($_POST['idUsuario']);
				$intCodigo = ($_POST['txtIdCodigo']);
				$strNombre = (($_POST['txtNombre']));
				$intPorcentaje = (($_POST['txtPorcentaje']));
				$request_user = "";
				// if($idUsuario == 0)
				// {
					// $option = 1;
					// $strPassword =  empty($_POST['txtPassword']) ? passGenerator() : $_POST['txtPassword'];
					// $strPasswordEncript = hash("SHA256",$strPassword);
					if($_SESSION['permisosMod']['w']){
						$request_user = $this->model->insertDescuento($intCodigo,
																			$strNombre,  
																			$intPorcentaje);
					}
					// $option = 2;
					// $strPassword =  empty($_POST['txtPassword']) ? "" : hash("SHA256",$_POST['txtPassword']);
					if($_SESSION['permisosMod']['u']){
						$request_user = $this->model->updateDescuento($idUsuario,
																	$intCodigo, 
																	$strNombre, 
																	$intPorcentaje);
					}
				}

				// if($request_user > 0 )
				// {
				// 	if($option == 1){
				// 		$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');
				// 		$nombreUsuario = $strNombre.' '.$strApellido;
				// 		$dataUsuario = array('nombreUsuario' => $nombreUsuario,
				// 							 'email' => $strEmail,
				// 							 'password' => $strPassword,
				// 							 'asunto' => 'Bienvenido a tu tienda en línea');
				// 		sendEmail($dataUsuario,'email_bienvenida');
				// 	}else{
				// 		$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
				// 	}
				// }else if($request_user == 'exist'){
				// 	$arrResponse = array('status' => false, 'msg' => '¡Atención! el email o la identificación ya existe, ingrese otro.');		
				// }else{
				// 	$arrResponse = array("status" => false, "msg" => 'No es posible almacenar los datos.');
				// }
			}
			echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
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

	public function getDescuento($idpersona){
		if($_SESSION['permisosMod']['r']){
			$idusuario = intval($idpersona);
			if($idusuario > 0)
			{
				$arrData = $this->model->selectDescuento($idusuario);
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
			// if($_SESSION['permisosMod']['d']){
				$intIdproducto = intval($_POST['cod_descuento']);
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