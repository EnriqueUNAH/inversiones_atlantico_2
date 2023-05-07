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
		getPermisos(MBITACORA);
	}

	public function Bitacora()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Bitacora";
		$data['page_title'] = "BITACORA <small>Inversiones Atlántico</small>";
		$data['page_name'] = "bitacora";
		$data['page_functions_js'] = "function_bitacora.js";
		$this->views->getView($this, "bitacora", $data);
	}


	public function getBitacora()
	{

		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectBitacora();
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}
	public function getBitacoraPorFecha()
	{
		$fechaInicio = $this->input->get("fechaInicio");
		$fechaFin = $this->input->get("fechaFin");

		$this->db->where("fecha BETWEEN '$fechaInicio' AND '$fechaFin'");

		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectBitacoraPorFecha($fechaInicio, $fechaFin);
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}
}
