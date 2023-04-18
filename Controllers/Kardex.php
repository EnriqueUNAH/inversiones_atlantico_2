<?php

class Kardex extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}
		getPermisos(MKARDEX);
	}

	public function Kardex()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Kardex";
		$data['page_title'] = "KARDEX <small>Inversiones Atlántico</small>";
		$data['page_name'] = "kardex";
		$data['page_functions_js'] = "functions_kardex.js";
		$this->views->getView($this, "kardex", $data);
		
		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = (MKARDEX);
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO DE KARDEX";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertKardexBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}


	public function getKardex()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectKardex();
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}
}
