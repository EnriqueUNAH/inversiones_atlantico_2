<?php 
	class Descuentos extends Controllers{
		public function __construct()
		{
			parent::__construct();
			session_start();
			if(empty($_SESSION['login']))
			{
				header('Location: '.base_url().'/login');
				die();
			}
			//  getPermisos(MDESCUENTOS);
		}

		public function Descuentos()
		{
			if(empty($_SESSION['permisosMod']['r'])){
				header("Location:".base_url().'/dashboard');
			}
			$data['page_tag'] = "Descuentos";
			$data['page_title'] = "DESCUENTOS <small>Inversiones Atlantico</small>";
			$data['page_name'] = "descuentos";
			$data['page_functions_js'] = "functions_descuentos.js";
			$this->views->getView($this,"descuentos",$data);
		}

		public function getDescuento($cod){
			// if($_SESSION['permisosMod']['r']){
				$cod_descuento = intval($cod);
					$arrData = $this->model->selectDescuentos($cod_descuento);
					if(!empty($arrData)){
						for ($i=0; $i < count($arrImg); $i++) { 
							$arrImg[$i]['url_image'] = media().'/images/uploads/'.$arrImg[$i]['img'];
						}
						$arrResponse = array('status' => true, 'data' => $arrData);
					 }else{
						$arrResponse = array('status' => false, 'msg' => 'Datos no encontrados.');
					 	$arrData['images'] = $arrImg;
					 }
					echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
				// }
			}
			// die();

		public function getDescuentos()
		{
			if($_SESSION['permisosMod']['r']){
				$arrData = $this->model->selectDescuento();
				for ($i=0; $i < count($arrData); $i++) {
					$btnView = '';
					$btnEdit = '';
					$btnDelete = '';

					// if($arrData[$i]['cod_descuento'] == 1)
					// {
					// 	$arrData[$i]['cod_descuento'] = '<span></span>';
					// }else{
					// 	$arrData[$i]['cod_descuento'] = '<span></span>';
					// }

					// $arrData[$i]['porcentaje_descuento'] = SMONEY.' '.formatMoney($arrData[$i]['porcentaje_descuento']);
					if($_SESSION['permisosMod']['r']){
						// $btnView = '<button class="btn btn-info btn-sm" onClick="fntViewInfo('.$arrData[$i]['cod_descuento'].')" title="Ver producto"><i class="far fa-eye"></i></button>';
					}
					if($_SESSION['permisosMod']['u']){
						$btnEdit = '<button class="btn btn-primary  btn-sm" onClick="fntEditInfo(this,'.$arrData[$i]['cod_descuento'].')" title="Editar Descuento"><i class="fas fa-pencil-alt"></i></button>';
					}
					if($_SESSION['permisosMod']['d']){	
						$btnDelete = '<button class="btn btn-danger btn-sm" onClick="fntDelInfo('.$arrData[$i]['cod_descuento'].')" title="Eliminar Descuento"><i class="far fa-trash-alt"></i></button>';
					}
					$arrData[$i]['options'] = '<div class="text-center">'.$btnView.' '.$btnEdit.' '.$btnDelete.'</div>';
				}
				echo json_encode($arrData,JSON_UNESCAPED_UNICODE);
			}
			die();
		}

		public function setDescuentos(){
			if($_POST){
				if(empty($_POST['txtNombre']) || empty($_POST['cod_descuento']) || empty($_POST['listDescuento']) || empty($_POST['txtPorcentaje']) )
				{
					$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
				}else{
					
					$cod_porcentaje = intval($_POST['cod_porcentaje']);
					$strNombre = ($_POST['txtNombre']);
					$intPorcentaje = ($_POST['txtPorcentaje']);
					$request_descuento = "";

					$ruta = strtolower(clear_cadena($strNombre));
					$ruta = str_replace(" ","-",$ruta);

					if($cod_porcentaje == 0)
					{
						$option = 1;
						if($_SESSION['permisosMod']['w']){
							$request_descuento = $this->model->insertDescuento($strNombre, 
																		$intPorcentaje,$cod_porcentaje);
						}
					}else{
						$option = 2;
						if($_SESSION['permisosMod']['u']){
							$request_descuento = $this->model->updateDescuento($cod_porcentaje,
																		$strNombre,
																		$intPorcentaje);
						}
					}
					if($request_descuento > 0 )
					{
						if($option == 1){
							$arrResponse = array('status' => true, 'cod_descuento' => $request_descuento, 'msg' => 'Datos guardados correctamente.');
						}else{
							$arrResponse = array('status' => true, 'cod_descuento' => $idProducto, 'msg' => 'Datos Actualizados correctamente.');
						}
					}else if($request_descuento == 'exist'){
						$arrResponse = array('status' => false, 'msg' => '¡Atención! ya existe un descuento con el Código Ingresado.');		
					}else{
						$arrResponse = array("status" => false, "msg" => 'No es posible almacenar los datos.');
					}
				}
				echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
			}
			die();
		}






	public function setImage(){
		if($_POST){
			if(empty($_POST['cod_descuento'])){
				$arrResponse = array('status' => false, 'msg' => 'Error de dato.');
			}else{
				$idProducto = intval($_POST['cod_descuento']);
				$foto      = $_FILES['foto'];
				$imgNombre = 'pro_'.md5(date('d-m-Y H:i:s')).'.jpg';
				$request_image = $this->model->insertImage($cod_descuento,$imgNombre);
				if($request_image){
					$uploadImage = uploadImage($foto,$imgNombre);
					$arrResponse = array('status' => true, 'imgname' => $imgNombre, 'msg' => 'Archivo cargado.');
				}else{
					$arrResponse = array('status' => false, 'msg' => 'Error de carga.');
				}
			}
			echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
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
}

 ?>