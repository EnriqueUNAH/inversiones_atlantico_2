<?php

class CaiModel extends Mysql
{
	private $cod_talonario;
	private $intRangoI;
	private $intRangoF;
	private $intRangoA;
	private $intNum;
	private $dateFechaVenc;
	private $strUsuario;



	public function __construct()
	{
		parent::__construct();
	}

	public function insertCai(string $rango_inicial, string $rango_final, string $numero_CAI, string $fecha_vencimiento, int $id_usuario) //En este caso recibe los 2 parámetros que ingresa el usuario
	{																	//Estos parámetros vienen desde el controlador			

		//Se crean estas variables para que reciban los valores que vienen el los parámetros

		$this->intRangoI = $rango_inicial;
		$this->intRangoF = $rango_final;
		$this->intRangoA = $rango_inicial;
		$this->intNum = $numero_CAI;
		$this->dateFechaVenc = $fecha_vencimiento;
		$this->strUsuario = $id_usuario;

		$this->intEstado = 1;

		$return = 0;

		$sql = "SELECT * FROM tbl_configuracion_cai WHERE rango_inicial = '{$this->intRangoI}' or rango_final = '{$this->intRangoF}' "; //El Where es muy importante para poder insertar
		$request = $this->select_all($sql);													//Ese where debe estar de acorde a cada tabla

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_configuracion_cai(rango_inicial,rango_final,rango_actual,numero_CAI,fecha_vencimiento,id_usuario,estado) 
								  VALUES(?,?,?,?,?,?,?)"; //La cantidad de ? debe ser la cantidad de datos que se insertan 
			$arrData = array(							//En este caso: parámetro, valor , creado_por y fecha_creacion
				$this->intRangoI,
				$this->intRangoF,
				$this->intRangoA,
				$this->intNum,
				$this->dateFechaVenc,
				$this->strUsuario,
				1
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}



	//Función para que inserte en bitácora cada vez que se agrega un nuevo parámetro
	public function insertCaiBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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


	public function selectCais()
	{

		$sql = "SELECT p.cod_talonario,p.rango_inicial,p.rango_final,p.rango_actual,p.numero_CAI,p.fecha_vencimiento,
                       p.id_usuario,p.estado, r.usuario
					FROM tbl_ms_usuarios r 
                    INNER JOIN tbl_configuracion_cai p
					ON p.id_usuario = r.id_usuario";
		$request = $this->select_all($sql);
		return $request;
	}
	// Muestra los datos en el botón ver más y también sirve para recuperar los datos a la hora de editar
	public function selectCai(int $cod_talonario)
	{
		$this->cod_talonario = $cod_talonario;
		$sql = "SELECT p.cod_talonario,p.rango_inicial,p.rango_final,p.numero_CAI,p.fecha_vencimiento
	 				FROM tbl_configuracion_cai p
					--  INNER JOIN tbl_ms_usuarios r
					-- ON p.id_usuario = r.id_usuario
	 				WHERE cod_talonario = $this->cod_talonario";
		$request = $this->select($sql);
		return $request;
	}


	public function updateCai(int $cod_talonario, string $rango_inicial, string $rango_final, string $numero_CAI, string $fecha_vencimiento)
	{
		$this->cod_talonario = $cod_talonario;
		$this->intRangoI = $rango_inicial;
		$this->intRangoF = $rango_final;
		// $this->intRangoA = $rango_actual;
		$this->intNum = $numero_CAI;
		$this->dateFechaVenc = $fecha_vencimiento;



		$sql = "SELECT * FROM tbl_configuracion_cai WHERE rango_inicial = '{$this->intRangoI}' AND cod_talonario != $this->cod_talonario ";
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_configuracion_cai SET rango_inicial=?, rango_final=? , numero_CAI=?, fecha_vencimiento=?
							WHERE cod_talonario = $this->cod_talonario ";
			$arrData = array(
				$this->intRangoI,
				$this->intRangoF,
				// $this->intRangoA,
				$this->intNum,
				$this->dateFechaVenc
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
	public function deleteCai(int $cod_talonario)
	{
		$this->cod_talonario = $cod_talonario;
		// $sql = "SELECT * FROM tbl_ms_parametros WHERE id_parametro = $this->intid_parametro";
		// $request = $this->select_all($sql);
		// if (empty($request)) {
		$sql = "DELETE FROM tbl_configuracion_cai WHERE cod_talonario = $this->cod_talonario";
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
