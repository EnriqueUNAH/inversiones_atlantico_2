<?php

class ProductosModel extends Mysql
{
	private $cod_producto;
	private $strNombreProducto;
	private $strDescripcion;
	private $intCantidadMinima;
	private $intCantidadMaxima;
	private $intCodTipoProducto;
	private $decPrecioVenta;
	private $intStatus;
	private $intExistencia;


	public function __construct()
	{
		parent::__construct();
	}

	public function insertProducto(string $nombre, string $descripcion, int $cantMin, int $CantMax, int $tipoProd, int $precio, int $estado)
	{
		$this->strNombreProducto = $nombre;
		$this->strDescripcion = $descripcion;
		$this->intCantidadMinima = $cantMin;
		$this->intCantidadMaxima= $CantMax;
		$this->intCodTipoProducto = $tipoProd;
		$this->decPrecioVenta = $precio;
		$this->intStatus = $estado;
        $this->strCreadoPor = $_SESSION['elUsuario'];
		$this->fechaCreacion = date('Y-m-d H:i:s');
		$this->intExistencia = 0;
		
		
		$return = 0;

		$sql = "SELECT * FROM tbl_producto WHERE 
					descripcion = '{$this->strDescripcion}' or nombre_producto = '{$this->strNombreProducto}' ";
		$request = $this->select_all($sql);

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_producto(nombre_producto,descripcion,cantidad_minima,cantidad_maxima,cod_tipo_producto,
			precio_venta,estado,creado_por,fecha_creacion,existencia) 
								  VALUES(?,?,?,?,?,?,?,?,?,?)";
			$arrData = array(
				$this->strNombreProducto,
				$this->strDescripcion,
				$this->intCantidadMinima,
				$this->intCantidadMaxima,
				$this->intCodTipoProducto,
				$this->decPrecioVenta,
				$this->intStatus,
				$this->strCreadoPor,
				$this->fechaCreacion,
				$this->intExistencia
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}



	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
	public function insertProductoBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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


	public function selectProductos()
	{
	
		$sql = "SELECT p.cod_producto,p.nombre_producto,p.descripcion,p.cantidad_minima,p.cantidad_maxima,
					   p.precio_venta,p.estado,tp.nombre_tipo_producto
		FROM tbl_producto p 
		INNER JOIN tbl_tipo_producto tp
		ON p.cod_tipo_producto = tp.cod_tipo_producto";
		$request = $this->select_all($sql);
		return $request;
	}

	public function selectTipoProducto()
		{
			// $whereAdmin = "";
			// if($_SESSION['idUser'] != 1 ){
			// 	$whereAdmin = " and cod_genero != 1 ";
			// }
			//EXTRAE ROLES
			$sql = "SELECT * FROM tbl_tipo_producto ";
			$request = $this->select_all($sql);
			return $request;
		}




	//Muestra los datos en el botón ver más
	public function selectProducto(int $cod_producto)
	{
		$this->cod_producto = $cod_producto;
		$sql = "SELECT p.cod_producto,p.nombre_producto,p.descripcion,p.cantidad_minima,p.cantidad_maxima,p.cod_tipo_producto,
		r.nombre_tipo_producto,p.precio_venta,p.estado,p.creado_por,DATE_FORMAT(p.fecha_creacion, '%d-%m-%Y') as fecha_creacion,
		p.modificado_por,p.fecha_modificacion,p.existencia
					FROM tbl_producto p
					INNER JOIN tbl_tipo_producto r
					ON p.cod_tipo_producto = r.cod_tipo_producto
					WHERE p.cod_producto = $this->cod_producto";
		$request = $this->select($sql);
		return $request;
	}





	public function updateProducto(int $cod_producto, string $nombre, string $descripcion, int $cantMin, int $CantMax, int $tipoProd, int $precio, int $estado)
	{
		$this->cod_producto = $cod_producto;
		$this->strNombreProducto = $nombre;
		$this->strDescripcion = $descripcion;
		$this->intCantidadMinima = $cantMin;
		$this->intCantidadMaxima= $CantMax;
		$this->intCodTipoProducto = $tipoProd;
		$this->decPrecioVenta = $precio;
		$this->intStatus = $estado;
		$this->strModificadoPor = $_SESSION['elUsuario'];
		$this->fechaModificacion = date('Y-m-d H:i:s');

		$sql = "SELECT * FROM tbl_producto WHERE nombre_producto = '{$this->strNombreProducto}' AND cod_producto != $this->cod_producto" ;
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_Producto SET nombre_producto=?, descripcion=?, cantidad_minima=? , cantidad_maxima=?, 
			cod_tipo_producto=?, precio_venta=?, estado=?, modificado_por=?, fecha_modificacion=?
							WHERE cod_producto = $this->cod_producto ";
			$arrData = array(
				$this->strNombreProducto,
				$this->strDescripcion,
				$this->intCantidadMinima,
				$this->intCantidadMaxima,
				$this->intCodTipoProducto,
                $this->decPrecioVenta,
                $this->intStatus,
				$this->strModificadoPor,
				$this->fechaModificacion

			);

			$request = $this->update($sql, $arrData);
		} else {
			$request = "exist";
		}
		return $request;
	}

	public function deleteProductos(int $cod_producto)
	{
		$this->cod_producto = $cod_producto;
      
		$sql = "SELECT * FROM tbl_detalle_factura WHERE cod_producto = $this->cod_producto";
		// AQUI LE DEJO LA LINEA DE DETALLE COMPRA XD 
		// $sql = "SELECT * FROM tbl_detalle_compra WHERE cod_producto = $this->cod_producto"; 
		$request = $this->select_all($sql);
		if (empty($request)) {

			$sql = "DELETE FROM tbl_producto WHERE cod_producto = $this->cod_producto";
			$request = $this->delete($sql);
			if ($request) {
				$request = 'ok';
			} else {
				$request = 'error';
			}
		} else {
			$request = 'exist';
		}
		return $request;
		
	}
}
