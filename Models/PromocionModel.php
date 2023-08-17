<?php

class PromocionModel extends Mysql
{
	private $cod_promocion;
	private $strnombre_promocion;
	private $datefecha_inicio;
	private $datefecha_final;
	private $intprecio_venta;
	private $intStatus;



	public function __construct()
	{
		parent::__construct();
	}

	public function insertPromocion(string $nombre_promocion, string $fecha_inicio, string $fecha_final, int $precio_venta, int $estado)
	{
		$this->strnombre_promocion = $nombre_promocion;
		$this->datefecha_inicio = $fecha_inicio;
		$this->datefecha_final = $fecha_final;
		$this->intprecio_venta = $precio_venta;
		$this->intStatus = $estado;
		$return = 0;

		$sql = "SELECT * FROM tbl_promocion WHERE nombre_promocion = '{$this->strnombre_promocion}'";
		$request = $this->select_all($sql);

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_promocion(nombre_promocion,fecha_inicio,fecha_final,precio_venta) 
								  VALUES(?,?,?,?)";
			$arrData = array(
				$this->strnombre_promocion,
				$this->datefecha_inicio,
				$this->datefecha_final,
				$this->intprecio_venta,
				$this->intStatus

			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}



	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
	public function insertPromocionBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
	{

		$this->dateFecha = $fecha;
		$this->intIdUsuario = $idUsuario;
		$this->intIdObjeto = $idObjeto;
		$this->strAccion = $accion;
		$this->strDescripcion = $descripcion;
		$this->intEstado = 1;
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



	public function selectPromocion()
	{

		$sql = "SELECT p.cod_promocion,p.nombre_promocion,p.fecha_inicio,p.fecha_final,p.precio_venta, p.estado
					FROM tbl_promocion p
					";
		$request = $this->select_all($sql);
		return $request;
	}


	// Muestra los datos en el botón ver más y también sirve para recuperar los datos a la hora de editar
	public function selectPromocion1(int $cod_promocion)
	{
		$this->cod_promocion = $cod_promocion;
		$sql = "SELECT cod_promocion,nombre_promocion,fecha_inicio,fecha_final,precio_venta,estado
	 				FROM tbl_promocion
	 					WHERE cod_promocion = $this->cod_promocion";
		$request = $this->select($sql);
		return $request;
	}




	public function updatePromocion(int $cod_promocion, string $nombre_promocion, string $fecha_inicio, string $fecha_final, int $precio_venta, int $estado)
	{

		$this->cod_promocion = $cod_promocion;
		$this->strnombre_promocion = $nombre_promocion;
		$this->datefecha_inicio = $fecha_inicio;
		$this->datefecha_final = $fecha_final;
		$this->intprecio_venta = $precio_venta;
		$this->intStatus = $estado;

		$sql = "SELECT * FROM tbl_promocion WHERE nombre_promocion = '{$this->strnombre_promocion}' AND cod_promocion != $this->cod_promocion";
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_promocion SET nombre_promocion=?, fecha_inicio=? , fecha_final=?, precio_venta=?, estado=?
							WHERE cod_promocion = $this->cod_promocion ";
			$arrData = array(
				$this->strnombre_promocion,
				$this->datefecha_inicio,
				$this->datefecha_final,
				$this->intprecio_venta,
				$this->intStatus
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
	public function deletePromocion(int $cod_promocion)
	{
		$sql = "call anular_promocion($cod_promocion)";
		$request = $this->select_all($sql);
		return $request;
	}
}
