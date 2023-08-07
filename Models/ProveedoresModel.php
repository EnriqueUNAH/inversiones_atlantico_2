<?php

class ProveedoresModel extends Mysql
{
	private $cod_proveedor;
	private $strRtn;
	private $strNombres;
	private $intTelefono;
	private $strEmail;
	private $strDireccion;



	public function __construct()
	{
		parent::__construct();
	}

	public function insertProveedor(int $rtn, string $nombres, int $telefono, string $correo_electronico, string $direccion)
	{
		$this->strRtn = $rtn;
		$this->strNombres = $nombres;
		$this->intTelefono = $telefono;
		$this->strEmail = $correo_electronico;
		$this->strDireccion = $direccion;
		// $this->cod_genero = $cod_genero;
		$this->strCreadoPor = $_SESSION['elUsuario'];
		$this->fechaCreacion = date('Y-m-d H:i:s');

		$return = 0;

		$sql = "SELECT * FROM tbl_proveedor WHERE 
					 nombres = '{$this->strNombres}' ";
		$request = $this->select_all($sql);

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_proveedor(rtn,nombres,telefono,correo_electronico,direccion,creado_por,fecha_creacion) 
								  VALUES(?,?,?,?,?,?,?)";
			$arrData = array(
				$this->strRtn,
				$this->strNombres,
				$this->intTelefono,
				$this->strEmail,
				$this->strDireccion,
				// $this->cod_genero,
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



	//Función para que inserte en bitácora cada vez que se agrega un nuevo Proveedor
	public function insertProveedoresBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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




	public function selectProveedores()
	{
		// $whereAdmin = "";
		// if ($_SESSION['idUser'] != 1) {
		// 	$whereAdmin = " and p.cod_proveedor != 1 ";
		// }
		$sql = "SELECT p.cod_proveedor,p.rtn,p.nombres,p.telefono,p.correo_electronico,p.direccion
					FROM tbl_proveedor p where cod_proveedor != 5;
					-- INNER JOIN tbl_genero r
					-- ON p.cod_genero = r.cod_genero
					-- WHERE p.estado != 0
                     ";
		$request = $this->select_all($sql);
		return $request;
	}


	// public function selectGenero()
	// 	{
	// 		// $whereAdmin = "";
	// 		// if($_SESSION['idUser'] != 1 ){
	// 		// 	$whereAdmin = " and cod_genero != 1 ";
	// 		// }
	// 		//EXTRAE ROLES
	// 		$sql = "SELECT * FROM tbl_genero ";
	// 		$request = $this->select_all($sql);
	// 		return $request;
	// 	}


	//Muestra los datos en el botón ver más
	public function selectProveedor(int $cod_proveedor)
	{
		$this->cod_proveedor = $cod_proveedor;
		$sql = "SELECT p.cod_proveedor,p.rtn,p.nombres,p.telefono,p.correo_electronico,p.direccion,
		p.creado_por, DATE_FORMAT(p.fecha_creacion, '%Y-%m-%d %H:%i:%s') as fecha_creacion ,p.modificado_por,p.fecha_modificacion
					FROM tbl_proveedor p
					WHERE p.cod_proveedor = $this->cod_proveedor";
		$request = $this->select($sql);
		return $request;
	}

	public function updateProveedor(int $cod_proveedor, int $rtn, string $nombres, int $telefono, string $correo_electronico, string $direccion)
	{

		$this->cod_proveedor = $cod_proveedor;
		$this->strRtn = $rtn;
		$this->strNombres = $nombres;
		$this->intTelefono = $telefono;
		$this->strEmail = $correo_electronico;
		$this->strDireccion = $direccion;
		// $this->cod_genero = $cod_genero;
		$this->strModificadoPor = $_SESSION['elUsuario'];
		$this->fechaModificacion = date('Y-m-d H:i:s');


		$sql = "SELECT * FROM tbl_proveedor WHERE nombres = '{$this->strNombres}' AND cod_proveedor != $this->cod_proveedor";
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_proveedor SET rtn=?, nombres=?, telefono=?, correo_electronico=?, direccion=?, modificado_por=?, fecha_modificacion=?
							WHERE cod_proveedor = $this->cod_proveedor ";
			$arrData = array(
				$this->strRtn,
				$this->strNombres,
				$this->intTelefono,
				$this->strEmail,
				$this->strDireccion,
				// $this->cod_genero,
				$this->strModificadoPor,
				$this->fechaModificacion

			);

			$request = $this->update($sql, $arrData);
		} else {
			$request = "exist";
		}
		return $request;
	}



	public function deleteProveedor(int $cod_proveedor)
	{
		$this->cod_proveedor = $cod_proveedor;

		$sql = "SELECT * FROM tbl_compra WHERE cod_proveedor = $this->cod_proveedor";
		$request = $this->select_all($sql);
		if (empty($request)) {

			$sql = "DELETE FROM tbl_proveedor WHERE cod_proveedor = $this->cod_proveedor ";
			$request = $this->delete($sql);
			if ($request) {
				$request = 'ok';
			} else {
				$request = 'error';
			}
		} else {
			$request = 'exist';
		}
		return $request;
	}
}
