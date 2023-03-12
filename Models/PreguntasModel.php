<?php

class PreguntasModel extends Mysql
{
	private $id_pregunta;
	private $strpregunta;
	

	public function __construct()
	{
		parent::__construct();
	}

	public function insertPregunta(string $pregunta) //En este caso recibe los 2 parámetros que ingresa el usuario
	{																	//Estos parámetros vienen desde el controlador			

		//Se crean estas variables para que reciban los valores que vienen el los parámetros
		$this->strpregunta = $pregunta;

		$return = 0;

		$sql = "SELECT * FROM tbl_ms_preguntas WHERE pregunta = '{$this->strpregunta}' "; //El Where es muy importante para poder insertar
		$request = $this->select_all($sql);													//Ese where debe estar de acorde a cada tabla

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_ms_preguntas(pregunta) 
								  VALUES(?)"; //La cantidad de ? debe ser la cantidad de datos que se insertan 
			$arrData = array(							//En este caso: parámetro, valor , creado_por y fecha_creacion
				$this->strpregunta
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}



	//Función para que inserte en bitácora cada vez que se agrega un nuevo parámetro
	public function insertpreguntaBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
	{
		$this->dateFecha = $fecha;
		$this->intIdUsuario = $idUsuario;
		$this->intIdObjeto = $idObjeto;
		$this->strAccion = $accion;
		$this->strDescripcion = $descripcion;
		$return = 0;

		$query_insert  = "INSERT INTO tbl_ms_bitacora(fecha,id_pregunta,id_objeto,accion,descripcion) 
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


	public function selectpreguntas()
	{
		$whereAdmin = "";
		if ($_SESSION['idUser'] != 1) {
			$whereAdmin = " and p.id_pregunta != 1 ";
		}
		$sql = "SELECT id_pregunta,pregunta
					FROM tbl_ms_preguntas
					
					 " . $whereAdmin;
		$request = $this->select_all($sql);
		return $request;
	}
	// Muestra los datos en el botón ver más y también sirve para recuperar los datos a la hora de editar
	public function selectpregunta(int $id_pregunta)
	{
		$this->id_pregunta = $id_pregunta;
		$sql = "SELECT id_pregunta,pregunta
	 				FROM tbl_ms_preguntas 
	 					WHERE id_pregunta = $this->id_pregunta";
		$request = $this->select($sql);
		return $request;
	}


	public function updatepregunta(int $id_pregunta, string $pregunta)
	{
		$this->id_pregunta = $id_pregunta;
		$this->strpregunta = $pregunta;

		$sql = "SELECT * FROM tbl_ms_preguntas WHERE pregunta = '{$this->strpregunta}' AND id_pregunta != $this->id_pregunta ";
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
	public function deletepregunta(int $id_pregunta)
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
