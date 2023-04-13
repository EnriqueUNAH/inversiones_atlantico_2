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


		$sql = "SELECT producto,fecha,usuario,estado,cantidad
			FROM produccion		
			WHERE cod_produccion != 0 ";
		$request = $this->select_all($sql);
		return $request;
	}
}
