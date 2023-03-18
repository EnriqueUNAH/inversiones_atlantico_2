<?php

class InventariosModel extends Mysql
{
	private $intIdProducto;
	private $strNombreProducto;
	private $strDescripcion;
	private $intCantidadMinima;
	private $intCantidadMaxima;
	private $intCodTipoProducto;
	private $decPrecioVenta;
	private $strEstado;
	private $intExistencia;




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

	// public static function evento_bitacora($id_objeto,$id_usuario,$accion,$descripcion)
	// 	{
	// 		   require ('../clases/Conexion.php');

	// 		   		$sql = "INSERT INTO  tbl_ms_bitacora (Id_objeto, id_usuario,Fecha, Accion , Descripcion)
	// 			 VALUES ('$id_objeto', '$id_usuario' , sysdate(), '$accion', '$descripcion')";

	// 		$resultado = $mysqli->query($sql);
	// 	}



	public function selectInventarios()
	{
		//$whereAdmin = "";
		// if ($_SESSION['idUser'] != 1) {
		// 	$whereAdmin = " and p.id_usuario != 1 ";
		// }
		$sql = "SELECT p.cod_producto,p.nombre_producto,p.descripcion,p.cantidad_minima,p.cantidad_maxima,
					   p.precio_venta,p.estado,p.foto,p.existencia,tp.nombre_tipo_producto
		FROM tbl_producto p 
		INNER JOIN tbl_tipo_producto tp
		ON p.cod_tipo_producto = tp.cod_tipo_producto";
		$request = $this->select_all($sql);
		return $request;
	}

	public function selectParametros()
	{
		$whereAdmin = "";
		if ($_SESSION['idUser'] != 1) {
			$whereAdmin = " and p.id_usuario != 1 ";
		}
		$sql = "SELECT id_parametro,parametro,valor 
					FROM tbl_ms_parametros
					
					 " . $whereAdmin;
		$request = $this->select_all($sql);
		return $request;
	}
}
