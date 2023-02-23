<?php

class Bitacora extends Controllers
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

	public function Bitacora()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Bitacora";
		$data['page_title'] = "BITACORA <small>Inversiones Atlántico</small>";
		$data['page_name'] = "bitacora";
		$data['page_functions_js'] = "functions_bitacora.js";
		$this->views->getView($this, "bitacora", $data);
	}


}
