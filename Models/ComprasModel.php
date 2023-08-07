<?php

class ComprasModel extends Mysql
{
	private $cod_compra;
	private $intTotal_pagado;
	private $datefecha;
	private $intIsv;
	private $cod_detalle_compra;
	private $intPrecio_compra;
	private $intCantidad;
	private $cod_producto;

	public function __construct()
	{
		parent::__construct();
	}


	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
	public function insertCompraBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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


	public function selectCompras()
	{
		// $whereAdmin = "";
		// if ($_SESSION['idUser'] != 1) {
		// 	$whereAdmin = " and p.cod_compra != 1 ";
		// }
		$sql = "SELECT p.cod_compra,p.total_pagado,p.fecha,p.id_usuario,r.usuario,p.estado,pro.nombres
					FROM tbl_proveedor pro

					INNER JOIN tbl_compra p 
					ON p.cod_proveedor = pro.cod_proveedor

					INNER JOIN tbl_ms_usuarios r
					ON p.id_usuario = r.id_usuario
					WHERE p.estado != 0 ";
		$request = $this->select_all($sql);
		return $request;
	}

	//Muestra los datos en el botón ver más
	public function selectCompra(int $cod_compra)
	{
		$this->cod_compra = $cod_compra;
		$sql = "SELECT p.id_usuario,p.usuario,p.nombre_usuario,p.preguntas_contestadas,p.correo_electronico,r.id_rol,r.nombrerol,
		p.fecha_ultima_conexion,p.fecha_vencimiento,p.primer_ingreso,
		p.estado,p.creado_por,p.modificado_por,p.fecha_modificacion, DATE_FORMAT(p.fecha_creacion, '%d-%m-%Y') as fechaRegistro 
					FROM tbl_ms_usuarios p
					INNER JOIN tbl_ms_roles r
					ON p.id_rol = r.id_rol
					WHERE p.id_usuario = $this->intIdUsuario";
		$request = $this->select($sql);
		return $request;
	}


	public function deleteCompra(int $cod_compra)
	{

		$sql = "call anular_compra($cod_compra)";
		$request = $this->select_all($sql);
		return $request;
	}
}
