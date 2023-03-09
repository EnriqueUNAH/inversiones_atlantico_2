<?php

class ParametrosModel extends Mysql
{
	private $intIdParametro;
	private $strparametro;
	private $strvalor;

	public function __construct()
	{
		parent::__construct();
	}

	public function insertParametro(string $parametro, string $valor) //En este caso recibe los 2 parámetros que ingresa el usuario
	{																	//Estos parámetros vienen desde el controlador			

		//Se crean estas variables para que reciban los valores que vienen el los parámetros
		$this->strparametro = $parametro;
		$this->strvalor = $valor;
		$this->strCreadoPor = $_SESSION['elUsuario'];
		$this->fechaCreacion = date('Y-m-d H:i:s');

		$return = 0;

		$sql = "SELECT * FROM tbl_ms_parametros WHERE parametro = '{$this->strparametro}' "; //El Where es muy importante para poder insertar
		$request = $this->select_all($sql);													//Ese where debe estar de acorde a cada tabla

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_ms_parametros(parametro,valor,creado_por,fecha_creacion) 
								  VALUES(?,?,?,?)"; //La cantidad de ? debe ser la cantidad de datos que se insertan 
			$arrData = array(							//En este caso: parámetro, valor , creado_por y fecha_creacion
				$this->strparametro,
				$this->strvalor,
				$this->strCreadoPor,
				$this->fechaCreacion
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}



	//Función para que inserte en bitácora cada vez que se agrega un nuevo parámetro
	public function insertParametroBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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
	// Muestra los datos en el botón ver más y también sirve para recuperar los datos a la hora de editar
	public function selectParametro(int $id_parametro)
	{
		$this->intIdParametro = $id_parametro;
		$sql = "SELECT id_parametro,parametro,valor,creado_por,fecha_creacion,modificado_por,fecha_modificacion
	 				FROM tbl_ms_parametros 
	 					WHERE id_parametro = $this->intIdParametro";
		$request = $this->select($sql);
		return $request;
	}


	public function updateParametro(int $idParametro, string $parametro, string $valor)
	{
		$this->intIdParametro = $idParametro;
		$this->strparametro = $parametro;
		$this->strvalor = $valor;
		$this->strModificadoPor = $_SESSION['elUsuario'];
		$this->fechaModificacion = date('Y-m-d H:i:s');


		$sql = "SELECT * FROM tbl_ms_parametros WHERE parametro = '{$this->strparametro}' AND id_parametro != $this->intIdParametro ";
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_ms_parametros SET parametro=?, valor=? , modificado_por=?, fecha_modificacion=?
							WHERE id_parametro = $this->intIdParametro ";
			$arrData = array(
				$this->strparametro,
				$this->strvalor,
				$this->strModificadoPor,
				$this->fechaModificacion
			);

			$request = $this->update($sql, $arrData);
		} else {
			$request = "exist";
		}
		return $request;
	}

	//OJO TODO EL DELETE PUEDE QUE EN ALGUNOS CASOS NO FUNCIONE POR INTEGRIDAD REFERENCIAL. 
	//VEREMOS CÓMO HACERLO USANDO EL TRY CATCH, DESPUÉS. 
	//POR AHORA LO IMPORTANTE ES QUE FUNCIONE TODO LO DEMÁS.
	public function deleteParametro(int $id_parametro)
	{
		$this->intid_parametro = $id_parametro;
		// $sql = "SELECT * FROM tbl_ms_parametros WHERE id_parametro = $this->intid_parametro";
		// $request = $this->select_all($sql);
		// if (empty($request)) {
		$sql = "DELETE FROM tbl_ms_parametros WHERE id_parametro = $this->intid_parametro";
		$request = $this->delete($sql);
		if ($request) {
			$request = 'ok';
		} else {
			$request = 'error';
		}
		// } else {
		// 	$request = 'exist';
		// }
		return $request;
	}
}
