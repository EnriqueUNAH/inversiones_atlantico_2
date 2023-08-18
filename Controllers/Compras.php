<?php

class Compras extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MCOMPRA);
	}

	public function Compras()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Compras";
		$data['page_title'] = "COMPRAS <small>Inversiones Atlántico</small>";
		$data['page_name'] = "compras";
		$data['page_functions_js'] = "functions_compras.js";
		$this->views->getView($this, "compras", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = (MCOMPRA);
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO COMPRAS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertCompraBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}


	public function getCompras()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectCompras();
			for ($i = 0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnDelete = '';

				if ($_SESSION['permisosMod']['r']) {
					// $btnView = '<button class="btn btn-info view_factura" onclick="view_factura(' . $arrData[$i]['cod_cliente'] . ',' . $arrData[$i]['cod_factura'] . ')" title="Ver Factura"><i class="far fa-eye"></i></button>';

					// $btnView = '<button class="btn_view ver_factura" type="button" cl="' . $arrData[$i]['cod_cliente'] . '" f="' . $arrData[$i]['cod_factura'] . '"><i class="far fa-eye"></i></button>';

					$btnView = '<button class="btn btn-info btn-sm btnViewCompra" onClick="ver_compra(' . $arrData[$i]['cod_compra'] . ')" title="Ver Compra"><i class="far fa-eye"></i></button>';
				}

				
				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelCompra" onClick="fntDelCompra(' . $arrData[$i]['cod_compra'] . ')" title="Anular Compra"><i class="fas fa-ban"></i></button>';
				} else {
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-ban"></i></button>';
				}
				if ($arrData[$i]['estado'] == 1) {
					$arrData[$i]['estado'] = '<span class="badge badge-success">COMPRADO</span>';   //Aqui le asigna Activo si es 1
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

	public function getCompra($cod_compra)
	{
		if ($_SESSION['permisosMod']['r']) {
			$cod_compra = intval($cod_compra);
			if ($cod_compra > 0) {
				$arrData = $this->model->selectCompra($cod_compra);
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

	public function delCompra()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$cod_compra = intval($_POST['cod_compra']);
				$requestDelete = $this->model->deleteCompra($cod_compra);

				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				 $dateFecha = date('Y-m-d H:i:s');
				 $intIdUsuario = $_SESSION['idUser'];
				 $intIdObjeto = 2;
				 $request_bitacora = "";

				if ($requestDelete) {
					$arrResponse = array('status' => true, 'msg' => 'Se ha anulado la compra');

					$strAccion = "ANULAR";
					$strDescripcion = "SE ANULÓ LA COMPRA CON EL CÓDIGO: $cod_compra";

					 //Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					 $request_bitacora = $this->model->insertCompraBitacora(
					 	$dateFecha,
					 	$intIdUsuario,
					 	$intIdObjeto,
					 	$strAccion,
					 	$strDescripcion
					 );
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al anular la compra.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}


}
