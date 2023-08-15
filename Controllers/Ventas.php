
<?php

class Ventas extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MVENTA);
	}

	public function Ventas()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Ventas";
		$data['page_title'] = "VENTAS <small>Inversiones Atlántico</small>";
		$data['page_name'] = "ventas";
		$data['page_functions_js'] = "functions_ventas.js";
		// $data['page_functions2_js'] = "../Views/venta/js/functions.js";
		$this->views->getView($this, "ventas", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdVenta = $_SESSION['idUser'];
		$intIdObjeto = MVENTA;
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MODULO VENTAS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertVentaBitacora(
			$dateFecha,
			$intIdVenta,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}



	public function getVentas()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectVentas();
			for ($i = 0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';



				if ($_SESSION['permisosMod']['r']) {
					// $btnView = '<button class="btn btn-info view_factura" onclick="view_factura(' . $arrData[$i]['cod_cliente'] . ',' . $arrData[$i]['cod_factura'] . ')" title="Ver Factura"><i class="far fa-eye"></i></button>';

					// $btnView = '<button class="btn_view ver_factura" type="button" cl="' . $arrData[$i]['cod_cliente'] . '" f="' . $arrData[$i]['cod_factura'] . '"><i class="far fa-eye"></i></button>';

					$btnView = '<button class="btn btn-info btn-sm btnViewVenta" onClick="ver_factura(' . $arrData[$i]['cod_cliente'] . ',' . $arrData[$i]['cod_factura'] . ')" title="Ver Factura"><i class="far fa-eye"></i></button>';
				}

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditVenta" onClick="fntEditVenta(this,' . $arrData[$i]['cod_factura'] . ')" title="Editar Venta"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}


				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelVenta" onClick="fntDelVenta(' . $arrData[$i]['cod_factura'] . ')" title="Anular Factura"><i class="fas fa-ban"></i></button>';
				} else {
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-ban"></i></button>';
				}
				if ($arrData[$i]['estado'] == 1) {
					$arrData[$i]['estado'] = '<span class="badge badge-success">FACTURADO</span>';   //Aqui le asigna Activo si es 1
				} else if ($arrData[$i]['estado'] == 2) {
					$arrData[$i]['estado'] = '<span class="badge badge-danger">ANULADA</span>';
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-ban"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnDelete . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getVenta($cod_factura)
	{
		if ($_SESSION['permisosMod']['r']) {
			$cod_factura = intval($cod_factura);
			if ($cod_factura > 0) {
				$arrData = $this->model->selectVenta($cod_factura);
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


	public function delVenta()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$intid_venta = intval($_POST['cod_factura']);
				$requestDelete = $this->model->deleteVenta($intid_venta);

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = MVENTA;
				$request_bitacora = "";

				if ($requestDelete) {
					$arrResponse = array('status' => true, 'msg' => 'Se ha anulado la factura');

					$strAccion = "ANULAR";
					$strDescripcion = "SE ANULÓ LA FACTURA CON EL CÓDIGO: $intid_venta";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertVentaBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al anular la factura.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}



	///////////
}
