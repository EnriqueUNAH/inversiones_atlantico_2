<?php
class Logout extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();

		//Insertar en bitacora
		if ($intIdUsuario = $_SESSION['idUser']) {
			//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 
			$dateFecha = date('Y-m-d H:i:s');
			$intIdUsuario = $_SESSION['idUser'];
			$intIdObjeto = 2;
			$request_bitacora = "";
			$strAccion = "CERRAR SESIÓN";
			$strDescripcion = "USUARIO CERRÓ SESIÓN";
			//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
			$request = $this->model->insertSalirBitacora($dateFecha, $intIdUsuario, $intIdObjeto, $strAccion, $strDescripcion);
		}
		session_unset();
		session_destroy();
		header('location: ' . base_url() . '/login');
		die();
	}
}
