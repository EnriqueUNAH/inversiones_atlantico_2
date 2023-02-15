<?php 

	class Usuarios extends Controllers{
		public function __construct()
		{
			parent::__construct();
			session_start();
			if(empty($_SESSION['login']))
			{
				header('Location: '.base_url().'/login');
				die();
			}
			getPermisos(MUSUARIOS);
		}

		public function Usuarios()
		{
			if(empty($_SESSION['permisosMod']['r'])){
				header("Location:".base_url().'/dashboard');
			}
			$data['page_tag'] = "Usuarios";
			$data['page_title'] = "USUARIOS <small>Inversiones Atlántico</small>";
			$data['page_name'] = "usuarios";
			$data['page_functions_js'] = "functions_usuarios.js";
			$this->views->getView($this,"usuarios",$data);
		}

		public function setUsuario(){
			if($_POST){			
				if(empty($_POST['txtusuario']) || empty($_POST['txtnombre_usuario']) || empty($_POST['txtEmail']) || empty($_POST['listid_rol']) || empty($_POST['listStatus']) )
				{
					$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
				}else{ 
					$id_usuario = intval($_POST['id_usuario']);
					$strusuario = strClean($_POST['txtusuario']);
					$strnombre_usuario = ucwords(strClean($_POST['txtnombre_usuario']));
					//$strApellido = ucwords(strClean($_POST['txtApellido']));
					//$intpreguntas_contestadas = 0;
					$strEmail = strtolower(strClean($_POST['txtEmail']));
					$intTipoId = intval(strClean($_POST['listid_rol']));
					$intestado = intval(strClean($_POST['listStatus']));
					$request_user = "";
					if($id_usuario == 0)
					{
						$option = 1;
						$strPassword =  empty($_POST['txtPassword']) ? hash("SHA256",passGenerator()) : hash("SHA256",$_POST['txtPassword']);

						if($_SESSION['permisosMod']['w']){
							$request_user = $this->model->insertUsuario($strusuario,
																				$strnombre_usuario, 
																				$strEmail,
																				$strPassword, 
																				$intTipoId, 
																				$intestado );
						}
					}else{
						$option = 2;
						$strPassword =  empty($_POST['txtPassword']) ? "" : hash("SHA256",$_POST['txtPassword']);
						if($_SESSION['permisosMod']['u']){
							$request_user = $this->model->updateUsuario($id_usuario,
																		$strusuario, 
																		$strnombre_usuario,
																		$strEmail,
																		$strPassword, 
																		$intTipoId, 
																		$intestado);
						}

					}

					if($request_user > 0 )
					{
						if($option == 1){
							$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');
						}else{
							$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
						}
					}else if($request_user == 'exist'){
						$arrResponse = array('status' => false, 'msg' => '¡Atención! el email o la identificación ya existe, ingrese otro.');		
					}else{
						$arrResponse = array("status" => false, "msg" => 'No es posible almacenar los datos.');
					}
				}
				echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
			}
			die();
		}

		public function getUsuarios()
		{
			if($_SESSION['permisosMod']['r']){
				$arrData = $this->model->selectUsuarios();
				for ($i=0; $i < count($arrData); $i++) {
					$btnView = '';
					$btnEdit = '';
					$btnDelete = '';

					if($arrData[$i]['estado'] == 1)
					{
						$arrData[$i]['estado'] = '<span class="badge badge-success">ACTIVO</span>';   //Aqui le asigna Activo si es 1
					}else if($arrData[$i]['estado'] == 2){
						$arrData[$i]['estado'] = '<span class="badge badge-danger">INACTIVO</span>';
					}else if($arrData[$i]['estado'] == 3){
						$arrData[$i]['estado'] = '<span class="badge badge-info">NUEVO</span>';
					}

					if($_SESSION['permisosMod']['r']){
						$btnView = '<button class="btn btn-info btn-sm btnViewUsuario" onClick="fntViewUsuario('.$arrData[$i]['id_usuario'].')" title="Ver usuario"><i class="far fa-eye"></i></button>';
					}
					if($_SESSION['permisosMod']['u']){
						if(($_SESSION['idUser'] == 1 and $_SESSION['userData']['id_rol'] == 1) ||
							($_SESSION['userData']['id_rol'] == 1 and $arrData[$i]['id_rol'] != 1) ){
							$btnEdit = '<button class="btn btn-primary  btn-sm btnEditUsuario" onClick="fntEditUsuario(this,'.$arrData[$i]['id_usuario'].')" title="Editar usuario"><i class="fas fa-pencil-alt"></i></button>';
						}else{
							$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
						}
					}
					if($_SESSION['permisosMod']['d']){
						if(($_SESSION['idUser'] == 1 and $_SESSION['userData']['id_rol'] == 1) ||
							($_SESSION['userData']['id_rol'] == 1 and $arrData[$i]['id_rol'] != 1) and
							($_SESSION['userData']['id_usuario'] != $arrData[$i]['id_usuario'] )
							 ){
							$btnDelete = '<button class="btn btn-danger btn-sm btnDelUsuario" onClick="fntDelUsuario('.$arrData[$i]['id_usuario'].')" title="Eliminar usuario"><i class="far fa-trash-alt"></i></button>';
						}else{
							$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
						}
					}
					$arrData[$i]['options'] = '<div class="text-center">'.$btnView.' '.$btnEdit.' '.$btnDelete.'</div>';
				}
				echo json_encode($arrData,JSON_UNESCAPED_UNICODE);
			}
			die();
		}

		public function getUsuario($id_usuario){
			if($_SESSION['permisosMod']['r']){
				$id_usuario = intval($id_usuario);
				if($id_usuario > 0)
				{
					$arrData = $this->model->selectUsuario($id_usuario);
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

		public function delUsuario()
		{
			if($_POST){
				if($_SESSION['permisosMod']['d']){
					$intid_usuario = intval($_POST['id_usuario']);
					$requestDelete = $this->model->deleteUsuario($intid_usuario);
					if($requestDelete)
					{
						$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado el usuario');
					}else{
						$arrResponse = array('status' => false, 'msg' => 'Error al eliminar el usuario.');
					}
					echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
				}
			}
			die();
		}

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		public function perfil(){
			$data['page_tag'] = "Perfil";
			$data['page_title'] = "Perfil de usuario";
			$data['page_name'] = "perfil";
			$data['page_functions_js'] = "functions_usuarios.js";
			$this->views->getView($this,"perfil",$data);
		}

		public function putPerfil(){
			if($_POST){
				if(empty($_POST['txtusuario']) || empty($_POST['txtNombre']) || empty($_POST['txtpreguntas_contestadas']) )
				{
					$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
				}else{
					$id_usuario = $_SESSION['idUser'];
					$strusuario = strClean($_POST['txtusuario']);
					$strNombre = strClean($_POST['txtNombre']);
					//$strApellido = strClean($_POST['txtApellido']);
					$intpreguntas_contestadas = intval(strClean($_POST['txtpreguntas_contestadas']));
					$strPassword = "";
					if(!empty($_POST['txtPassword'])){
						$strPassword = hash("SHA256",$_POST['txtPassword']);
					}
					$request_user = $this->model->updatePerfil($id_usuario,
																$strusuario, 
																$strNombre,															
																$intpreguntas_contestadas, 
																$strPassword);
					if($request_user)
					{
						sessionUser($_SESSION['idUser']);
						$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
					}else{
						$arrResponse = array("status" => false, "msg" => 'No es posible actualizar los datos.');
					}
				}
				echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
			}
			die();
		}

		public function putDFical(){
			if($_POST){
				if(empty($_POST['txtNit']) || empty($_POST['txtNombreFiscal']) || empty($_POST['txtDirFiscal']) )
				{
					$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
				}else{
					$id_usuario = $_SESSION['idUser'];
					$strNit = strClean($_POST['txtNit']);
					$strNomFiscal = strClean($_POST['txtNombreFiscal']);
					$strDirFiscal = strClean($_POST['txtDirFiscal']);
					$request_datafiscal = $this->model->updateDataFiscal($id_usuario,
																		$strNit,
																		$strNomFiscal, 
																		$strDirFiscal);
					if($request_datafiscal)
					{
						sessionUser($_SESSION['idUser']);
						$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
					}else{
						$arrResponse = array("status" => false, "msg" => 'No es posible actualizar los datos.');
					}
				}
				echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
			}
			die();
		}

	}
 ?>