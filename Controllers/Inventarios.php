<?php

class Inventarios extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MPRODUCTOS);
	}

	public function Inventarios()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Inventarios";
		$data['page_title'] = "INVENTARIOS <small>Inversiones Atlántico</small>";
		$data['page_name'] = "inventarios";
		$data['page_functions_js'] = "functions_inventarios.js";
		$this->views->getView($this, "inventarios", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		// $dateFecha = date('Y-m-d H:i:s');
		// $intIdUsuario = $_SESSION['idUser'];
		// $intIdObjeto = 2;
		// $request_bitacora = "";

		// $strAccion = "INGRESO";
		// $strDescripcion = "INGRESO AL MODULO USUARIOS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		// $request_bitacora = $this->model->insertUsuarioBitacora(
		// 	$dateFecha,
		// 	$intIdUsuario,
		// 	$intIdObjeto,
		// 	$strAccion,
		// 	$strDescripcion
		// );
	}


	public function getInventarios()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectInventarios();
			for ($i = 0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';


				if ($arrData[$i]['existencia'] < $arrData[$i]['cantidad_minima']) {
					$badgeClass = 'badge badge-danger';
					$badgeContent = sprintf('<span class="%s" style="padding: 6px 10px; border-radius: 4px; font-size: 18px">%d</span>', $badgeClass, $arrData[$i]['existencia']);
					$arrData[$i]['existencia'] = $badgeContent;
				} else {
					$badgeClass = 'badge badge-success';
					$badgeContent = sprintf('<span class="%s" style="padding: 6px 10px; border-radius: 4px; font-size: 18px">%d</span>', $badgeClass, $arrData[$i]['existencia']);
					$arrData[$i]['existencia'] = $badgeContent;
				}


				if ($_SESSION['permisosMod']['r']) {
					$btnView = '<button class="btn btn-info btn-sm btnViewUsuario" onClick="fntViewUsuario(' . $arrData[$i]['cod_producto'] . ')" title="Ver usuario"><i class="far fa-eye"></i></button>';
				}

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditUsuario" onClick="fntEditUsuario(this,' . $arrData[$i]['cod_producto'] . ')" title="Editar usuario"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}

				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelUsuario" onClick="fntDelUsuario(' . $arrData[$i]['cod_producto'] . ')" title="Eliminar usuario"><i class="far fa-trash-alt"></i></button>';
				} else {
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}
}
