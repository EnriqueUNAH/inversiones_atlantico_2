<?php 
class DescuentosModel extends Mysql
{
	// private $intIdUsuario;
	private $cod_descuento;
	private $strNombre;
	// private $strApellido;
	private $intPorcentaje;
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

	public function insertDescuento(string $nombre, FLOAT $Porcentaje) //En este caso recibe los 2 parámetros que ingresa el usuario
	{																	//Estos parámetros vienen desde el controlador			

		//Se crean estas variables para que reciban los valores que vienen el los parámetros
		$this->strNombre = $nombre;
		$this->intPorcentaje = $Porcentaje;

		$return = 0;

		$sql = "SELECT * FROM tbl_descuento WHERE cod_descuento = '{$this->strNombre}' "; //El Where es muy importante para poder insertar
		$request = $this->select_all($sql);													//Ese where debe estar de acorde a cada tabla

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_descuento(nombre_descuento,porcentaje_descuento) 
								  VALUES(?,?)"; //La cantidad de ? debe ser la cantidad de datos que se insertan 
			$arrData = array(							//En este caso: parámetro, valor , creado_por y fecha_creacion
				$this->strNombre,
				$this->intPorcentaje,
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}

    //Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
    public function insertDescuentoBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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






	public function selectDescuentos()
	{
		$sql = "SELECT cod_descuento,nombre_descuento,porcentaje_descuento  
				FROM tbl_descuento where cod_descuento != 16 ";
		$request = $this->select_all($sql);
		return $request;
	}

	public function selectDescuento(int $cod_descuento){
		$this->Cod_descuento = $cod_descuento;
		$sql = "SELECT cod_descuento,nombre_descuento,porcentaje_descuento 
				FROM tbl_descuento
				WHERE cod_descuento = '$this->Cod_descuento'";
		$request = $this->select($sql);
		return $request;
	}

	public function updateDescuento(int $cod_descuento, string $nombre, float $Porcentaje)
	{
		$this->cod_descuento = $cod_descuento;
		$this->strNombre = $nombre;
		$this->intPorcentaje = $Porcentaje;

		$sql = "SELECT nombre_descuento,porcentaje_descuento FROM tbl_descuento WHERE cod_descuento = '{$this->strNombre}'";
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_descuento SET nombre_descuento=?, porcentaje_descuento=?
							WHERE cod_descuento = $this->cod_descuento ";
			$arrData = array(
				$this->strNombre,
				$this->intPorcentaje
			);

			$request = $this->update($sql, $arrData);
		} else {
			$request = "exist";
		}
		return $request;
	}

	public function deleteDescuento(int $cod_descuento){
		$this->cod_descuento = $cod_descuento;
		$sql = "DELETE FROM tbl_descuento where cod_descuento = $this->cod_descuento";
		$arrData = array(0);
		$request = $this->delete($sql,$arrData);
		return $request;
	}
}
