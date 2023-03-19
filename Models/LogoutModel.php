<?php

class LogoutModel extends Mysql
{
	private $intIdParametro;
	private $strparametro;
	private $strvalor;

	public function __construct()
	{
		parent::__construct();
	}





	public function updateUltimaConexion(int $idUsuario)
	{
		$this->intIdUsuario = $idUsuario;
		$this->dateFecha = date('Y-m-d H:i:s');

		$sql = "UPDATE tbl_ms_usuarios SET fecha_ultima_conexion=? WHERE id_usuario=?";

		$arrData = array(
			$this->dateFecha,
			$this->intIdUsuario
		);

		$request = $this->update($sql, $arrData);
		return $request;
	}
}
