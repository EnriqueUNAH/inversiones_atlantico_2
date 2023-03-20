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


//Función para que inserte en bitácora cada vez que un usuario cierre sesion
public function insertSalirBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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
		$this->strDescripcion
	);
	$request_insert = $this->insert($query_insert, $arrData);
	$return = $request_insert;

	return $return;
}


	// public function updateUltimaConexion(int $idUsuario)
	// {
	// 	$this->intIdUsuario = $idUsuario;
	// 	$this->dateFecha = date('Y-m-d H:i:s');

	// 	$sql = "UPDATE tbl_ms_usuarios SET fecha_ultima_conexion=? WHERE id_usuario=?";

	// 	$arrData = array(
	// 		$this->dateFecha,
	// 		$this->intIdUsuario
	// 	);

	// 	$request = $this->update($sql, $arrData);
	// 	return $request;
	// }
}
