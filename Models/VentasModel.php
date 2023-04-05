<?php

class VentasModel extends Mysql
{
	private $intIdUsuario;
	private $strusuario;
	private $strNombre;
	private $strApellido;
	private $intpreguntas_contestadas;
	private $strEmail;
	private $strPassword;
	private $strToken;
	private $intTipoId;
	private $intStatus;
	private $strNit;
	private $strNomFiscal;
	private $strDirFiscal;

	public function __construct()
	{
		parent::__construct();
	}



	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
	// public function insertVentaBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
	// {

	// 	$this->dateFecha = $fecha;
	// 	$this->intIdUsuario = $idUsuario;
	// 	$this->intIdObjeto = $idObjeto;
	// 	$this->strAccion = $accion;
	// 	$this->strDescripcion = $descripcion;
	// 	$return = 0;

	// 	$query_insert  = "INSERT INTO tbl_ms_bitacora(fecha,id_usuario,id_objeto,accion,descripcion) 
	// 							  VALUES(?,?,?,?,?)";
	// 	$arrData = array(
	// 		$this->dateFecha,
	// 		$this->intIdUsuario,
	// 		$this->intIdObjeto,
	// 		$this->strAccion,
	// 		$this->strDescripcion,
	// 	);
	// 	$request_insert = $this->insert($query_insert, $arrData);
	// 	$return = $request_insert;

	// 	return $return;
	// }



	public function selectVentas()
	{

		$sql = "SELECT f.cod_factura,f.numero_factura,f.fecha,u.usuario,f.cod_cliente,f.estado,f.totalfactura,f.subtotal,f.isv,f.porcentaje_isv
					FROM tbl_factura f 
					INNER JOIN tbl_ms_usuarios u
					ON f.id_usuario = u.id_usuario
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
}
