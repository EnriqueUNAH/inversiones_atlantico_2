<?php

class Clientes extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MCLIENTE);
	}

	public function Clientes()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Clientes";
		$data['page_title'] = "CLIENTES <small>Inversiones Atlántico</small>";
		$data['page_name'] = "clientes";
		$data['page_functions_js'] = "functions_clientes.js";
		$this->views->getView($this, "clientes", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = 2;
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MODULO CLIENTES";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertClientesBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}

	public function setCliente()
	{
		if ($_POST) {
			if (empty($_POST['txtRtn']) || empty($_POST['txtNombres']) || empty($_POST['txtTelefono'])  || empty($_POST['txtEmail']) || empty($_POST['txtDireccion']) || empty($_POST['listGenero'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');

				/*El siguiente else if, sirve para que valide desde el servidor. Que si se ingresa una letra 
				ya sea mayúscula o minúscula, que permita ingresar los datos.
				Al final está el else que mostrará error en caso de que lo insertado sea un número o caracter especial.*/
			} else {


				$cod_cliente = intval($_POST['cod_cliente']);
				$strRtn = intval(strClean($_POST['txtRtn']));
				$strNombres = strtoupper(strClean($_POST['txtNombres']));
				$intTelefono = intval(strClean($_POST['txtTelefono']));
				$strEmail = strtolower(strClean($_POST['txtEmail']));
				$strDireccion = strtoupper(strClean($_POST['txtDireccion']));
				$cod_genero = (strClean($_POST['listGenero']));
				$request_user = "";

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2; //ESTE VALOR VA A CAMBIAR MAS A DELANTE
				$request_bitacora = "";

				if ($cod_cliente == 0) {
					$option = 1; //LA OPCIÓN ES 1, ENTONCES ESTARÁ INSERTANDO
					//$strPassword =  empty($_POST['txtPassword']) ? hash("SHA256", passGenerator()) : hash("SHA256", $_POST['txtPassword']);
					//$strPassword = hash("SHA256", $_POST['txtPassword']);



					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertCliente(
							$strRtn,
							$strNombres,
							$intTelefono,
							$strEmail,
							$strDireccion,
							$cod_genero

						);

						//
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "CREACION DE CLIENTE";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertClientesBitacora(
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
						$request_user = $this->model->updateCliente(
							$cod_cliente,
							$strRtn,
							$strNombres,
							$intTelefono,
							$strEmail,
							$strDireccion,
							$cod_genero
						);
					}

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
					$strAccion = "ACTUALIZAR";
					$strDescripcion = "ACTUALIZACIÓN DE CLIENTE";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertClientesBitacora(
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




	public function getClientes()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectClientes();
			for ($i = 0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';


				if ($_SESSION['permisosMod']['r']) {
					$btnView = '<button class="btn btn-info btn-sm btnViewCliente" onClick="fntViewCliente(' . $arrData[$i]['cod_cliente'] . ')" title="Ver cliente"><i class="far fa-eye"></i></button>';
				}

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditCliente" onClick="fntEditCliente(this,' . $arrData[$i]['cod_cliente'] . ')" title="Editar cliente"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}

				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelCliente" onClick="fntDelCliente(' . $arrData[$i]['cod_cliente'] . ')" title="Eliminar cliente"><i class="far fa-trash-alt"></i></button>';
				} else {
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getCliente($cod_cliente)
	{
		if ($_SESSION['permisosMod']['r']) {
			$cod_cliente = intval($cod_cliente);
			if ($cod_cliente > 0) {
				$arrData = $this->model->selectCliente($cod_cliente);
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


	public function getSelectGenero()
	{
		$htmlOptions = "";
		$arrData = $this->model->selectGenero();
		if (count($arrData) > 0) {
			for ($i = 0; $i < count($arrData); $i++) {
				//   if ($arrData[$i]['cod_genero'] == 1) {
				$htmlOptions .= '<option value="' . $arrData[$i]['cod_genero'] . '">' . $arrData[$i]['nombre_genero'] . '</option>';
				// }
			}
		}
		echo $htmlOptions;
		die();
	}






	public function delCliente()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$cod_cliente = intval($_POST['cod_cliente']);
				$requestDelete = $this->model->deleteCliente($cod_cliente);

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2;
				$request_bitacora = "";

				if ($requestDelete) {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado el cliente');

					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACION DE CLIENTE";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertClientesBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al eliminar cliente.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}
}
