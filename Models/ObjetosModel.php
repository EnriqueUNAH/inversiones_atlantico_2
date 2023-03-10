<?php

class ObjetosModel extends Mysql
{
	private $id_objeto;
	private $strobjeto;
	private $strdescripcion;

	public function __construct()
	{
		parent::__construct();
	}

	public function insertObjetos(string $objeto, string $descripcion)
	{
		$this->strobjeto = $objeto;
		$this->strdescripcion = $descripcion;
		$return = 0;

		$sql = "SELECT * FROM tbl_ms_objetos WHERE objeto = '{$this->strobjeto}'";
		$request = $this->select_all($sql);

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_ms_objetos(objeto,descripcion) 
								  VALUES(?,?)";
			$arrData = array(
				$this->strobjeto,
				$this->strdescripcion,
				
				
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}

	

	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
	public function insertObjetosBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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

	
		


	public function selectObjetos()
	{
		$whereAdmin = "";
		if ($_SESSION['idUser'] != 1) {
			$whereAdmin = " and p.id_objeto!= 1 ";
		}
		$sql = "SELECT id_objeto,objeto,descripcion
					FROM tbl_ms_objetos 
					" . $whereAdmin;
		$request = $this->select_all($sql);
		return $request;
	}



	//Muestra los datos en el botón ver más
	public function selectObjeto(int $id_objeto)
	
		{
			$this->id_objeto = $id_objeto;
			$sql = "SELECT id_objeto,objeto,descripcion
						 FROM tbl_ms_objetos
							 WHERE id_objeto = $this->id_objeto";
			$request = $this->select($sql);
			return $request;
		}
	






		public function updateObjetos(int $id_objeto, string $objeto, string $descripcion)
		{
	
			$this->id_objeto = $id_objeto;
			$this->strobjeto = $objeto;
			$this->strdescripcion = $descripcion;
	
			$sql = "SELECT * FROM tbl_ms_objetos WHERE objeto = '{$this->strobjeto}' AND id_objeto != $this->id_objeto" ;
			$request = $this->select_all($sql);
	
			if (empty($request)) {
	
				$sql = "UPDATE tbl_ms_objetos SET objeto=?, descripcion=? 
								WHERE id_objeto = $this->id_objeto ";
				$arrData = array(
					$this->strobjeto,
					$this->strdescripcion,
				);
	
				$request = $this->update($sql, $arrData);
			} else {
				$request = "exist";
			}
			return $request;
		}


	public function deleteObjetos(int $id_objeto)
	{
		$this->id_objeto = $id_objeto;
		// $sql = "SELECT * FROM tbl_ms_parametros WHERE id_parametro = $this->intid_parametro";
		// $request = $this->select_all($sql);
		// if (empty($request)) {
		$sql = "DELETE FROM tbl_ms_objetos WHERE id_objeto = $this->id_objeto";
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
