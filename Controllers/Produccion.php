<?php

class Produccion extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}
		// getPermisos(MProduccion);
	}

	public function Produccion()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Produccion";
		$data['page_title'] = "Produccion <small>Inversiones Atlántico</small>";
		$data['page_name'] = "Produccion";
		$data['page_functions_js'] = "function_Produccion.js";
		$this->views->getView($this, "Produccion", $data);
	}


	public function getProduccion()
	{

		$arrData = $this->model->selectProduccion();

		for ($i = 0; $i < count($arrData); $i++) {
			$btnView = '';
			$btnEdit = '';
			$btnDelete = '';

			if ($arrData[$i]['estado'] == 1) {
				$arrData[$i]['estado'] = '<span class="badge badge-success">TERMINADO</span>';   //Aqui le asigna Activo si es 1
			} else if ($arrData[$i]['estado'] == 2) {
				$arrData[$i]['estado'] = '<span class="badge badge-danger">ANULADO</span>';
			} else if ($arrData[$i]['estado'] == 3) {
				$arrData[$i]['estado'] = '<span class="badge badge-info">EN PRODUCCIÒN</span>';
			} else if ($arrData[$i]['estado'] == 4) {
				$arrData[$i]['estado'] = '<span class="badge badge-success">TERMINADO</span>';
			}

			// if ($_SESSION['permisosMod']['r']) {
			// 	$btnView = '<button class="btn btn-info btn-sm btnViewProducto" onClick="fntViewProducto(' . $arrData[$i]['cod_producto'] . ')" title="Ver producto"><i class="far fa-eye"></i></button>';
			// }

			// if ($_SESSION['permisosMod']['u']) {
			// 	$btnEdit = '<button class="btn btn-primary  btn-sm btnEditProducto" onClick="fntEditProducto(this,' . $arrData[$i]['cod_producto'] . ')" title="Editar producto"><i class="fas fa-pencil-alt"></i></button>';
			// } else {
			// 	$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
			// }

			// if ($_SESSION['permisosMod']['d']) {
			// 	$btnDelete = '<button class="btn btn-danger btn-sm btnDelProducto" onClick="fntDelProducto(' . $arrData[$i]['cod_producto'] . ')" title="Eliminar producto"><i class="far fa-trash-alt"></i></button>';
			// } else {
			// 	$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
			// }
			$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . '</div>';
		}

		echo json_encode($arrData, JSON_UNESCAPED_UNICODE);



		die();
	}
}
