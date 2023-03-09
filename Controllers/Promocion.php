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

		// //Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		// //SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		// $dateFecha = date('Y-m-d H:i:s');
		// $intIdUsuario = $_SESSION['idUser'];
		// $intIdObjeto = 2;
		// $request_bitacora = "";

		// $strAccion = "INGRESO";
		// $strDescripcion = "INGRESO AL MODULO USUARIOS";

		// //Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		// $request_bitacora = $this->model->insertUsuarioBitacora(
		// 	$dateFecha,
		// 	$intIdUsuario,
		// 	$intIdObjeto,
		// 	$strAccion,
		// 	$strDescripcion
		// );
	}

	public function setPromocion()
	{
        if ($_POST) {
		//dep($_POST);
		
		if (empty($_POST['txtnombre_promocion']) || empty($_POST['txtfecha_inicio']) || empty($_POST['txtfecha_final']) || empty($_POST['txtprecio_venta'])) {
		$arrResponse = array("msg" => 'Datos incorrectos.');
	    } else {
			$cod_promocion = intval($_POST['cod_promocion']);
		 	$strnombre_promocion = strtoupper(strClean($_POST['txtnombre_promocion']));
			$datefecha_inicio = strClean($_POST['txtfecha_inicio']);
		 	$datefecha_final = strClean($_POST['txtfecha_final']);
		 	$intprecio_venta = intval(strClean($_POST['txtprecio_venta']));
		 	//$request_user = "";
 

				//if ($cod_promocion == 0) {
		 		//$option = 1; //LA OPCIÓN ES 1, ENTONCES ESTARÁ INSERTANDO
		 		// $strPassword =  empty($_POST['txtPassword']) ? hash("SHA256", passGenerator()) : hash("SHA256", $_POST['txtPassword']);

		 			if ($_SESSION['permisosMod']['w']) {
	 				$arrResponse = $this->model->insertPromocion(
							$strnombre_promocion,
							$datefecha_inicio,
		 					$datefecha_final,
		 					$intprecio_venta

		 			);

		 $arrResponse = array('msg' => 'Datos guardados correctamente.');
		 			} //FIN DEL IF DE INSERTAR
		 		// } else {
		 		// 	$option = 2; //SI OPTION ES 2, ENTONCES ESTARÁ ACTUALIZANDO
		 		// 	$strPassword =  empty($_POST['txtPassword']) ? "" : hash("SHA256", $_POST['txtPassword']);
		 		// 	if ($_SESSION['permisosMod']['u']) {
		 		// 		$request_user = $this->model->updateUsuario(
		 		// 			$id_usuario,
		 		// 			$strusuario,
		 		// 			$strnombre_usuario,
		 		// 			$strEmail,
		 		// 			$strPassword,
		 		// 			$intTipoId,
		 		// 			$intestado
		 		// 		);
		 		// 	}

		 	
				// } //FIN DEL ELSE PARA ACTUALIZAR

		 	//    if ($request_user > 0) {
		 	// 
		 	// 	} else {
		 	// 	 		$arrResponse = array('cod_promocion' => true, 'msg' => 'Datos Actualizados correctamente.');
		 	// 	 	}
		 		//  } else if ($request_user == 'exist') {
		 		//  	$arrResponse = array('cod_promocion' => false, 'msg' => '¡Atención! el email o la identificación ya existe, ingrese otro.');
		 	    // } else {
		 		// 	$arrResponse = array("cod_promocion" => false, "msg" => 'No es posible almacenar los datos.');
		 		// } 
		
				
				
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
	    
	    }
		 die();	
	}

	// public function getPromocion()
	// {
	// 	if ($_SESSION['permisosMod']['r']) {
	// 		$arrData = $this->model->selectPromocion();
	// 	//for ($i = 0; $i < count($arrData); $i++) {
				
	// 	$btnEdit = '';
	// 	$btnDelete = '';

				
	// 		if ($_SESSION['permisosMod']['u']) {
	// 		$btnEdit = '<button class="btn btn-primary  btn-sm btnEditPromocion" onClick="fntEditPromocion(this,' . $arrData[$i]['cod_promocion'] . ')" title="Editar promocion"><i class="fas fa-pencil-alt"></i></button>';
	// 	 	} else {
	// 			$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
	// 		}

    //     //     if ($_SESSION['permisosMod']['d']) {
	// 	// 		$btnDelete = '<button class="btn btn-danger btn-sm btnDelPromocion" onClick="fntDelPromocion(' . $arrData[$i]['cod_promocion'] . ')" title="Eliminar promocion"><i class="far fa-trash-alt"></i></button>';
	// 	// 	} else {
	// 	// 		$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
	// 	// 	}

	// 		$arrData['options'] = '<div class="text-center">' . $btnEdit . ' ' . $btnDelete . '</div>';

			
	// 	//}
    //     echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
        


    //     }
			
	// 	die();
	// }


	public function getPromocion()
	{
		if($_SESSION['permisosMod']['r']){
			$arrData = $this->model->selectPromocion();
			for ($i=0; $i < count($arrData); $i++) {
			
				$btnEdit = '';
			 	$btnDelete = '';
			 	
			 	if($_SESSION['permisosMod']['r']){
			 		$btnEdit = '<button class="btn btn-primary  btn-sm btnEditPromocion" onClick="fntEditPromocion(this,'.$arrData[$i]['cod_promocion'].')" title="Editar promocion"><i class="fas fa-pencil-alt"></i></button>';
			 	}
			 	if($_SESSION['permisosMod']['u']){	
			 		$btnDelete = '<button class="btn btn-danger btn-sm btnDelPromocion" onClick="fntDelPromocion('.$arrData[$i]['cod_promocion'].')" title="Eliminar promocion"><i class="far fa-trash-alt"></i></button>';
				}
			 	$arrData[$i]['options'] = '<div class="text-center">'.$btnEdit.' '.$btnDelete.'</div>';
			 }
			echo json_encode($arrData,JSON_UNESCAPED_UNICODE);
		}
		die();
	}










	public function getUsuario($id_usuario)
	{
		if ($_SESSION['permisosMod']['r']) {
			$id_usuario = intval($id_usuario);
			if ($id_usuario > 0) {
				$arrData = $this->model->selectUsuario($id_usuario);
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

				if ($requestDelete) {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado la promocion');

				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al eliminar la promocion.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}


















	public function perfil()
	{
		$data['page_tag'] = "Perfil";
		$data['page_title'] = "Perfil de usuario";
		$data['page_name'] = "perfil";
		$data['page_functions_js'] = "functions_usuarios.js";
		$this->views->getView($this, "perfil", $data);
	}

	public function putPerfil()
	{
		if ($_POST) {
			if (empty($_POST['txtusuario']) || empty($_POST['txtNombre']) || empty($_POST['txtpreguntas_contestadas'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$id_usuario = $_SESSION['idUser'];
				$strusuario = strClean($_POST['txtusuario']);
				$strNombre = strClean($_POST['txtNombre']);
				//$strApellido = strClean($_POST['txtApellido']);
				$intpreguntas_contestadas = intval(strClean($_POST['txtpreguntas_contestadas']));
				$strPassword = "";
				if (!empty($_POST['txtPassword'])) {
					$strPassword = hash("SHA256", $_POST['txtPassword']);
				}
				$request_user = $this->model->updatePerfil(
					$id_usuario,
					$strusuario,
					$strNombre,
					$intpreguntas_contestadas,
					$strPassword
				);
				if ($request_user) {
					sessionUser($_SESSION['idUser']);
					$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
				} else {
					$arrResponse = array("status" => false, "msg" => 'No es posible actualizar los datos.');
				}
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function putDFical()
	{
		if ($_POST) {
			if (empty($_POST['txtNit']) || empty($_POST['txtNombreFiscal']) || empty($_POST['txtDirFiscal'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$id_usuario = $_SESSION['idUser'];
				$strNit = strClean($_POST['txtNit']);
				$strNomFiscal = strClean($_POST['txtNombreFiscal']);
				$strDirFiscal = strClean($_POST['txtDirFiscal']);
				$request_datafiscal = $this->model->updateDataFiscal(
					$id_usuario,
					$strNit,
					$strNomFiscal,
					$strDirFiscal
				);
				if ($request_datafiscal) {
					sessionUser($_SESSION['idUser']);
					$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
				} else {
					$arrResponse = array("status" => false, "msg" => 'No es posible actualizar los datos.');
				}
			}
			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}
}