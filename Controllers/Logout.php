<?php
class Logout extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		$intIdUsuario = $_SESSION['idUser'];
		$request = $this->model->updateUltimaConexion($intIdUsuario);


		session_unset();
		session_destroy();
		header('location: ' . base_url() . '/login');
		die();
	}
}
