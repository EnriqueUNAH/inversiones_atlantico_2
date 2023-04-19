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


	public function selectProduccions()
	{


		$sql = "SELECT pr.cod_produccion,pr.cod_producto,pr.fecha,pr.estado,pr.cantidad,p.nombre_producto,u.nombre_usuario
			FROM tbl_ms_usuarios u
			INNER JOIN tbl_produccion pr ON pr.id_usuario = u.id_usuario
			INNER JOIN tbl_producto p ON pr.cod_producto = p.cod_producto";
		$request = $this->select_all($sql);
		return $request;
	}



	public function deleteProduccion(int $id_produccion)
	{

		$sql = "call anular_produccion($id_produccion)";
		$request = $this->select_all($sql);
		return $request;
	}



	public function deleteProduccionP(int $id_produccion)
	{
		$this->intCod_Produccion = $id_produccion;
		$sql = "UPDATE tbl_produccion SET estado = ? WHERE cod_produccion = $this->intCod_Produccion ";
		$arrData = array(4);
		$request = $this->update($sql, $arrData);
		return $request;
	}


	// public function finProduccion(int $idProduccion, int $cantidad, int $idProducto)
	// {
	// 	$this->intCod_Produccion = $idProduccion;
	// 	$this->intCantidad = $cantidad;
	// 	$this->intCod_Producto = $idProducto;
	// 	$return = 0;

	// 	// Actualizar estado en la tabla tbl_produccion
	// 	$query_produccion = "UPDATE tbl_produccion SET estado = 3 WHERE cod_produccion = ?";
	// 	$arrData_produccion = array($this->intCod_Produccion);
	// 	$request_produccion = $this->update($query_produccion, $arrData_produccion);

	// 	// Actualizar existencia en la tabla tbl_producto
	// 	$query_producto = "UPDATE tbl_producto SET existencia = existencia + ? WHERE cod_producto = $this->intCod_Producto";
	// 	$arrData_producto = array($this->intCantidad);
	// 	$request_producto = $this->update($query_producto, $arrData_producto);

	// 	// Insertar en la tabla tbl_ms_bitacora
	// 	// $query_insert  = "INSERT INTO tbl_ms_bitacora(fecha,id_usuario,id_objeto,accion,descripcion) 
	// 	// 				  VALUES(?,?,?,?,?)";
	// 	// $arrData = array(
	// 	// 	$this->dateFecha,
	// 	// 	$this->intIdUsuario,
	// 	// 	$this->intIdObjeto,
	// 	// 	$this->strAccion,
	// 	// 	$this->strDescripcion,
	// 	// );
	// 	// $request_insert = $this->insert($query_insert, $arrData);

	// 	// Si ambas consultas de actualización tuvieron éxito y la inserción también, entonces retornar 1
	// 	// if ($request_produccion && $request_producto && $request_insert) {   EJEMPLO PARA CUANDO SE AGREGUE BITACORA
	// 	if ($request_produccion && $request_producto) {
	// 		$return = 1;
	// 	}

	// 	return $return;
	// }

	public function finProduccion(int $idProduccion, int $cantidad, int $idProducto)
	{
		$this->intCod_Produccion = $idProduccion;
		$this->intCantidad = $cantidad;
		$this->intCod_Producto = $idProducto;
		$return = 0;

		// Actualizar estado en la tabla tbl_produccion
		$query_produccion = "UPDATE tbl_produccion SET estado = 3 WHERE cod_produccion = ?";
		$arrData_produccion = array($this->intCod_Produccion);
		$request_produccion = $this->update($query_produccion, $arrData_produccion);

		// Actualizar existencia en la tabla tbl_producto
		$query_producto = "UPDATE tbl_producto SET existencia = existencia + ? WHERE cod_producto = ?";
		$arrData_producto = array($this->intCantidad, $this->intCod_Producto);
		$request_producto = $this->update($query_producto, $arrData_producto);

		// Insertar en la tabla tbl_kardex
		$query_kardex = "INSERT INTO tbl_kardex (cod_producto, cantidad, fecha, cod_tipo_movimiento) 
                     VALUES(?, ?, NOW(), 1)";
		$arrData_kardex = array($this->intCod_Producto, $this->intCantidad);
		$request_kardex = $this->insert($query_kardex, $arrData_kardex);

		// Insertar en la tabla tbl_ms_bitacora
		/*
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
    */

		// Si ambas consultas de actualización tuvieron éxito y la inserción también, entonces retornar 1
		if ($request_produccion && $request_producto && $request_kardex /*&& $request_insert*/) {
			$return = 1;
		}

		return $return;
	}
}
