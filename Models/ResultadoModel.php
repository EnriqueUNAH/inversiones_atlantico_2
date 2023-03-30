<?php 
class ResultadoModel extends Mysql
{
	// private $intIdUsuario;
	private $intCodigo;
	private $intCantidad;
	// private $strApellido;
	private $strDescripcion;
	// private $strEmail;
	// private $strPassword;
	// private $strToken;
	// private $intTipoId;
	// private $intStatus;
	// private $strNit;
	// private $strNomFiscal;
	// private $strDirFiscal;

	public function __construct()
	{
		parent::__construct();
	}	

	public function insertResultado(int $cod_producto, string $descripcion) //En este caso recibe los 2 parámetros que ingresa el usuario
	{																	//Estos parámetros vienen desde el controlador			

		//Se crean estas variables para que reciban los valores que vienen el los parámetros
		$this->intCodigo = $cod_producto;
		$this->strDescripcion= $descripcion;

		$return = 0;

		$sql = "SELECT * FROM tbl_resultado_produccion WHERE cod_producto = '{$this->strDescripcion}' "; //El Where es muy importante para poder insertar
		$request = $this->select_all($sql);													//Ese where debe estar de acorde a cada tabla

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_resultado_produccion(cantidad,descripcion) 
								  VALUES(?,?)"; //La cantidad de ? debe ser la cantidad de datos que se insertan 
			$arrData = array(							//En este caso: parámetro, valor , creado_por y fecha_creacion
				$this->intCantidad,
				$this->strDesripcion,
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}

	public function selectResultados()
	{
		$sql = "SELECT cod_producto, cantidad, descripcion  
				FROM tbl_resultado_produccion";
		$request = $this->select_all($sql);
		return $request;
	}

	public function selectResultado(int $cod_producto){
		$this->intIdCod_producto = $cod_producto;
		$sql = "SELECT cod_producto, cantidad, descripcion
				FROM tbl_resultado_produccion
				WHERE cod_producto = '$this->intIdCod_producto'";
		$request = $this->select($sql);
		return $request;
	}

	public function updateResultado(int $cod, int $cantidad, string $descripcion)
	{
		$this->intCodigo = $cod;
		$this->intCantidad = $cantidad;
		$this->strDescripcion = $descripcion;

		$sql = "SELECT cantidad,descripcion FROM tbl_resultado_produccion WHERE cod_producto = '{$this->strDescripcion}'";
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_resultado_produccion SET cantidad=?, desripcion=?
							WHERE cod_producto = $this->intCodigo ";
			$arrData = array(
				$this->intCantidad,
				$this->strDescripcion
			);

			$request = $this->update($sql, $arrData);
		} else {
			$request = "exist";
		}
		return $request;
	}

	public function deleteResultado(int $idproducto){
		$this->intIdProducto = $idproducto;
		$sql = "DELETE FROM tbl_resultado_produccion where cod_procucto = $this->intIdProductos";
		$arrData = array(0);
		$request = $this->delete($sql,$arrData);
		return $request;
	}
}

 ?>