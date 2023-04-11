<?php

class VentasModel extends Mysql
{
	private $intIdUsuario;


	public function __construct()
	{
		parent::__construct();
	}



	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
	public function insertVentaBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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



	public function selectVentas()
	{

		$sql = "SELECT f.cod_factura,f.numero_factura,f.fecha,u.usuario,f.estado,f.totalfactura,f.subtotal,f.isv,f.porcentaje_isv,cl.nombres,cl.cod_cliente
					FROM tbl_ms_usuarios u
					INNER JOIN tbl_factura f 
					ON f.id_usuario = u.id_usuario
					INNER JOIN tbl_cliente cl
					ON cl.cod_cliente = f.cod_cliente
					WHERE f.estado != 0 ";
		$request = $this->select_all($sql);
		return $request;
	}
	//Muestra los datos en el botón ver más
	public function selectVenta(int $id_usuario)
	{
		$this->intCodFactura = $cod_factura;
		$sql = "SELECT p.id_usuario,p.usuario,p.nombre_usuario,p.preguntas_contestadas,p.correo_electronico,r.id_rol,r.nombrerol,
		p.fecha_ultima_conexion,p.fecha_vencimiento,p.primer_ingreso,
		p.estado,p.creado_por,p.modificado_por,p.fecha_modificacion, DATE_FORMAT(p.fecha_creacion, '%Y-%m-%d %H:%i:%s') as fechaRegistro 
					FROM tbl_ms_usuarios p
					INNER JOIN tbl_ms_roles r
					ON p.id_rol = r.id_rol
					WHERE p.id_usuario = $this->intIdUsuario";
		$request = $this->select($sql);
		return $request;
	}



	public function deleteVenta(int $id_factura)
	{

		$sql = "call anular_factura($id_factura)";
		$request = $this->select_all($sql);
		return $request;
	}
}
