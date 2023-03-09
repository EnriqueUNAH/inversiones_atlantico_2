<?php

class ParametrosModel extends Mysql
{
	private $intIdParametro;
	private $strparametro;
	private $strvalor;
	// private $strApellido;
	// private $intpreguntas_contestadas;
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

	public function insertParametro(string $parametro, string $valor)
	{
		$this->strparametro = $parametro;
		$this->strvalor = $valor;

		// $this->strCreadoPor = $_SESSION['elUsuario'];

		$return = 0;
		//$sql = "SELECT * FROM tbl_ms_roles WHERE nombrerol = '{$this->strRol}' ";


		$sql = "SELECT * FROM tbl_ms_parametros WHERE parametro = '{$this->strparametro}' ";
		$request = $this->select_all($sql);

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_ms_parametros(parametro,valor) 
								  VALUES(?,?)";
			$arrData = array(
				$this->strparametro,
				$this->strvalor
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}



	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
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
			$this->strDescripcion,
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
	// Muestra los datos en el botón ver más
	public function selectParametro(int $id_parametro)
	{
		$this->intIdParametro = $id_parametro;
		$sql = "SELECT id_parametro,parametro,valor 
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


		// $sql = "SELECT * FROM tbl_ms_usuarios WHERE (correo_electronico = '{$this->strEmail}' AND id_usuario != $this->intIdUsuario)
		// OR (usuario = '{$this->strusuario}' AND id_usuario != $this->intIdUsuario) ";

		$sql = "SELECT * FROM tbl_ms_parametros WHERE id_parametro != $this->intIdParametro
										  OR (parametro = '{$this->strparametro}' AND id_parametro != $this->intIdParametro) ";
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_ms_parametros SET parametro=?, valor=? 
							WHERE id_parametro = $this->intIdParametro ";
			$arrData = array(
				$this->strparametro,
				$this->strvalor
			);

			$request = $this->update($sql, $arrData);
		} else {
			$request = "exist";
		}
		return $request;
	}

	// ESTE SI VA, PERO LO DEBO MODIFICAR
	public function deleteParametro(int $intid_usuario)
	{
		$this->intIdParametro = $intid_parametro;
		$sql = "UPDATE tbl_ms_parametros SET estado = ? WHERE id_usuario = $this->intIdUsuario ";
		$arrData = array(0);
		$request = $this->update($sql, $arrData);
		return $request;
	}
}
