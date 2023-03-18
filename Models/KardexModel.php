<?php

class KardexModel extends Mysql
{
	private $intIdUsuario;
	private $strusuario;
	private $strNombre;
	private $strApellido;
	

	public function __construct()
	{
		parent::__construct();
	}


	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
	public function insertKardexBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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

	public function selectKardex()
	{
		$whereAdmin = "";
		if ($_SESSION['idUser'] != 1) {
			$whereAdmin = " and p.cod_kardex != 1 ";
		}

    	$sql = "SELECT p.fecha,p.cod_tipo_movimiento,p.cod_producto,r.nombre_movimiento,o.nombre_producto
			FROM tbl_tipo_movimiento r
			INNER JOIN tbl_kardex p 
			ON p.cod_tipo_movimiento = r.cod_tipo_movimiento
			INNER JOIN tbl_producto o 
			ON p.cod_producto = o.cod_producto;
			-- WHERE p.cod_kardex != 0 " . $whereAdmin;
		$request = $this->select_all($sql);
		return $request;
	}


}