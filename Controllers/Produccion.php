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

		$arrData = $this->model->selectProduccions();

		for ($i = 0; $i < count($arrData); $i++) {
			$btnView = '';
			$btnEdit = '';
			$btnDelete = '';

			if ($arrData[$i]['estado'] == 1) {
				$arrData[$i]['estado'] = '<span class="badge badge-info">EN PRODUCCIÒN</span>';   //Aqui le asigna Activo si es 1
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

			if ($_SESSION['permisosMod']['d']) {
				$btnDelete = '<button class="btn btn-danger btn-sm btnDelProduccion" onClick="fntDelProduccion(' . $arrData[$i]['cod_produccion'] . ')" title="Anular Producción"><i class="fas fa-ban"></i></button>';
			} else {
				$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-ban"></i></button>';
			}
			// $arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . '</div>';
			$arrData[$i]['options'] = '<div class="text-center"> ' . $btnDelete . '</div>';
		}

		echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		die();
	}





	public function delProduccion()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$intid_produccion = intval($_POST['cod_produccion']);
				$requestDelete = $this->model->deleteProduccion($intid_produccion);

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				// $dateFecha = date('Y-m-d H:i:s');
				// $intIdUsuario = $_SESSION['idUser'];
				// $intIdObjeto = 2;
				// $request_bitacora = "";

				if ($requestDelete) {
					$arrResponse = array('status' => true, 'msg' => 'Se ha anulado la producción');

					// $strAccion = "ELIMINAR";
					// $strDescripcion = "ELIMINACION DE USUARIO";

					// //Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					// $request_bitacora = $this->model->insertParametroBitacora(
					// 	$dateFecha,
					// 	$intIdUsuario,
					// 	$intIdObjeto,
					// 	$strAccion,
					// 	$strDescripcion
					// );
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al anular la producción.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}
}
