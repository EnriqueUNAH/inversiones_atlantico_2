<?php

class Roles extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		//session_regenerate_id(true);
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}
		getPermisos(MROL);
	}

	public function Roles()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_id'] = 3;
		$data['page_tag'] = "Roles Usuario";
		$data['page_name'] = "rol_usuario";
		$data['page_title'] = "Roles Usuario <small>Inversiones Atlantico</small>";
		$data['page_functions_js'] = "functions_roles.js";
		$this->views->getView($this, "roles", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = 2;
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MODULO DE ROLES";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertRolBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}

	public function getRoles()
	{
		if ($_SESSION['permisosMod']['r']) {
			$btnView = '';
			$btnEdit = '';
			$btnDelete = '';
			$arrData = $this->model->selectRoles();


			for ($i = 0; $i < count($arrData); $i++) {

				if ($arrData[$i]['estado'] == 1) {
					$arrData[$i]['estado'] = '<span class="badge badge-success">ACTIVO</span>';
				} else {
					$arrData[$i]['estado'] = '<span class="badge badge-danger">INACTIVO</span>';
				}

				if ($_SESSION['permisosMod']['u'] and ($arrData[$i]['id_rol'] > 2)) { //Uso el mayor que 2 porque Administrador es 1 y Default es 2
					$btnView = '<button class="btn btn-secondary btn-sm btnPermisosRol" onClick="fntPermisos(' . $arrData[$i]['id_rol'] . ')" title="Permisos"><i class="fas fa-key"></i></button>';
					$btnEdit = '<button class="btn btn-primary btn-sm btnEditRol" onClick="fntEditRol(' . $arrData[$i]['id_rol'] . ')" title="Editar"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnView = '<button class="btn btn-secondary btn-sm btnPermisosRol disabled" title="Permisos"><i class="fas fa-key"></i></button>';
					$btnEdit = '<button class="btn btn-primary btn-sm btnEditRol disabled" title="Editar"><i class="fas fa-pencil-alt"></i></button>';
				}


				if ($_SESSION['permisosMod']['d'] and $arrData[$i]['id_rol'] > 2) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelRol" onClick="fntDelRol(' . $arrData[$i]['id_rol'] . ')" title="Eliminar"><i class="far fa-trash-alt"></i></button>
					</div>';
				} else {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelRol disabled" title="Eliminar"><i class="far fa-trash-alt"></i></button>
					</div>';
				}

				$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getSelectRoles()
	{
		$htmlOptions = "";
		$arrData = $this->model->selectRoles();
		if (count($arrData) > 0) {
			for ($i = 0; $i < count($arrData); $i++) {
				if ($arrData[$i]['estado'] == 1) {
					$htmlOptions .= '<option value="' . $arrData[$i]['id_rol'] . '">' . $arrData[$i]['nombrerol'] . '</option>';
				}
			}
		}
		echo $htmlOptions;
		die();
	}

	public function getRol(int $id_rol)
	{
		if ($_SESSION['permisosMod']['r']) {
			$intid_rol = intval(strClean($id_rol));
			if ($intid_rol > 0) {
				$arrData = $this->model->selectRol($intid_rol);
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

	public function setRol()
	{
		$intid_rol = intval($_POST['id_rol']);
		$strRol =  strClean($_POST['txtNombre']);
		$strDescipcion = strClean($_POST['txtDescripcion']);
		$intStatus = intval($_POST['listStatus']);
		$request_rol = "";
		if ($intid_rol == 0) {
			//Crear
			if ($_SESSION['permisosMod']['w']) {
				$request_rol = $this->model->insertRol($strRol, $strDescipcion, $intStatus);
				$option = 1;
			}
		} else {
			//Actualizar
			if ($_SESSION['permisosMod']['u']) {
				$request_rol = $this->model->updateRol($intid_rol, $strRol, $strDescipcion, $intStatus);
				$option = 2;
			}
		}

		if ($request_rol > 0) {
			if ($option == 1) {
				$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');
			} else {
				$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
			}
		} else if ($request_rol == 'exist') {

			$arrResponse = array('status' => false, 'msg' => '¡Atención! El Rol ya existe.');
		} else {
			$arrResponse = array("status" => false, "msg" => 'No es posible almacenar los datos.');
		}
		echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		die();
	}

	public function delRol()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$intid_rol = intval($_POST['id_rol']);
				$requestDelete = $this->model->deleteRol($intid_rol);
				if ($requestDelete == 'ok') {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado el Rol');
				} else if ($requestDelete == 'exist') {
					$arrResponse = array('status' => false, 'msg' => 'No es posible eliminar un Rol asociado a usuarios.');
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al eliminar el Rol.');
				}
				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}
		die();
	}
}
