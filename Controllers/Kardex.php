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
		getPermisos(MUSUARIOS);
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