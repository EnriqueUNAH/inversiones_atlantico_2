<?php

class ProduccionModel extends Mysql
{
	private $intIdProduccion;
	private $strusuario;
	private $strNombre;
	private $strApellido;
	private $intpreguntas_contestadas;
	private $strEmail;
	private $strPassword;
	private $strToken;
	private $intTipoId;
	private $intStatus;
	private $strNit;
	private $strNomFiscal;
	private $strDirFiscal;

	public function __construct()
	{
		parent::__construct();
	}


	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario


	public function selectProduccion()
	{


		$sql = "SELECT pr.cod_producto,pr.fecha,pr.estado,pr.cantidad,p.nombre_producto,u.nombre_usuario
			FROM tbl_ms_usuarios u
			INNER JOIN tbl_produccion pr ON pr.id_usuario = u.id_usuario
			INNER JOIN tbl_producto p ON pr.cod_producto = p.cod_producto";
		$request = $this->select_all($sql);
		return $request;
	}
}
