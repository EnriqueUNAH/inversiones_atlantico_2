<?php

class BitacoraModel extends Mysql
{
	private $intIdUsuario;
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
	public function insertUsuarioBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
	{

		$this->dateFecha = $fecha;
		$this->intIdUsuario = $idUsuario;
		$this->intIdObjeto = $idObjeto;
		$this->strAccion = $accion;
		$this->strDescripcion = $descripcion;
		$return = 0;

		$query_insert  = "INSERT INTO tbl_ms_bitacora(fecha,id_usuario,id_objeto,accion,descripcion) 
								  VALUES(?,?,?,?,?)";
		$arrData = array(
			$this->dateFecha,
			$this->intIdUsuario,
			$this->intIdObjeto,
			$this->strAccion,
			$this->strDescripcion,
		);
		$request_insert = $this->insert($query_insert, $arrData);
		$return = $request_insert;

		return $return;
	}

	public function selectBitacora()
	{

		$whereAdmin = "";
		if ($_SESSION['idUser'] != 1) {
			$whereAdmin = " and p.id_bitacora != 1 ";
		}
		$sql = "SELECT p.fecha,p.id_usuario,p.id_objeto,p.accion,p.descripcion,r.usuario,o.objeto
			FROM tbl_ms_usuarios r
			INNER JOIN tbl_ms_bitacora p 
			ON p.id_usuario = r.id_usuario
			INNER JOIN tbl_ms_objetos o 
			ON p.id_objeto = o.id_objeto
			WHERE p.id_bitacora != 0 " . $whereAdmin;
		$request = $this->select_all($sql);
		return $request;
	}

	public function selectBitacoraPorFecha(string $inicio, string $final)
	{
		$whereAdmin = "";
		if ($_SESSION['idUser'] != 1) {
			$whereAdmin = " AND p.id_bitacora != 1";
		}
		$sql = "SELECT p.fecha, p.id_usuario, p.id_objeto, p.accion, p.descripcion, r.usuario, o.objeto
				FROM tbl_ms_usuarios r
				INNER JOIN tbl_ms_bitacora p ON p.id_usuario = r.id_usuario
				INNER JOIN tbl_ms_objetos o ON p.id_objeto = o.id_objeto
				WHERE p.id_bitacora != 0" . $whereAdmin . "
				  AND p.fecha BETWEEN '" . $inicio . "' AND '" . $final . "'";

		$request = $this->select_all($sql);
		return $request;
	}
}
