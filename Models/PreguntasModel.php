<?php

class PreguntasModel extends Mysql
{
	private $id_pregunta;
	private $strpregunta;

	

	public function __construct()
	{
		parent::__construct();
	}

	public function insertPreguntas(string $pregunta)
	{
		$this->strpregunta = $pregunta;
		$return = 0;

		$sql = "SELECT * FROM tbl_ms_preguntas WHERE pregunta = '{$this->strpregunta}'";
		$request = $this->select_all($sql);

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_ms_preguntas(pregunta) 
								  VALUES(?)";
			$arrData = array(
				$this->strpregunta
				
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}

	

	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
	public function insertPreguntasBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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



	public function selectPreguntas()
	{
		$whereAdmin = "";
		if ($_SESSION['idUser'] != 1) {
			$whereAdmin = " and p.id_pregunta != 1 ";
		}
		$sql = "SELECT p.id_pregunta,p.pregunta 
					FROM tbl_ms_preguntas p
					" . $whereAdmin;
		$request = $this->select_all($sql);
		return $request;
	}


	// Muestra los datos en el botón ver más y también sirve para recuperar los datos a la hora de editar
	public function selectPregunta(int $id_pregunta)
	{
		$this->id_pregunta = $id_pregunta;
		$sql = "SELECT id_pregunta,pregunta
	 				FROM tbl_ms_preguntas
	 					WHERE id_pregunta = $this->id_pregunta";
		$request = $this->select($sql);
		return $request;
	}




	public function updatePreguntas(int $id_pregunta, string $pregunta)
	{

		$this->id_pregunta = $id_pregunta;
		$this->strpregunta= $pregunta;
		
		

		$sql = "SELECT * FROM tbl_ms_preguntas WHERE pregunta = '{$this->strpregunta}' AND id_pregunta != $this->id_pregunta" ;
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_ms_preguntas SET pregunta=?
							WHERE id_pregunta = $this->id_pregunta ";
			$arrData = array(
				$this->strpregunta
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
	public function deletePreguntas(int $id_pregunta)
	{
		$this->id_pregunta = $id_pregunta;
		// $sql = "SELECT * FROM tbl_ms_preguntas WHERE id_pregunta = $this->intid_pregunta";
		// $request = $this->select_all($sql);
		// if (empty($request)) {
		$sql = "DELETE FROM tbl_ms_preguntas WHERE id_pregunta = $this->id_pregunta";
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