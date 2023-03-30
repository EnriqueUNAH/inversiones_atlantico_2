<?php

class ClientesModel extends Mysql
{
	private $cod_cliente;
	private $strRtn;
	private $strNombres;
	private $strApellidos;
	private $intTelefono;
	private $strEmail;
	private $strDireccion;
	private $cod_genero;
	

	public function __construct()
	{
		parent::__construct();
	}

	public function insertCliente(int $rtn, string $nombres, string $apellidos, int $telefono, string $correo_electronico, string $direccion, int $cod_genero)
	{
		$this->strRtn = $rtn;
		$this->strNombres = $nombres;
		$this->strApellidos = $apellidos;
		$this->intTelefono = $telefono;
		$this->strEmail = $correo_electronico;
		$this->strDireccion = $direccion;
		$this->cod_genero = $cod_genero;
		$this->strCreadoPor = $_SESSION['elUsuario'];
		$this->fechaCreacion = date('Y-m-d H:i:s');
		
		$return = 0;

		$sql = "SELECT * FROM tbl_cliente WHERE 
					correo_electronico = '{$this->strEmail}' or nombres = '{$this->strNombres}' ";
		$request = $this->select_all($sql);

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_cliente(rtn,nombres,apellidos,telefono,correo_electronico,direccion,cod_genero,creado_por,fecha_creacion) 
								  VALUES(?,?,?,?,?,?,?,?,?)";
			$arrData = array(
				$this->strRtn,
				$this->strNombres,
				$this->strApellidos,
				$this->intTelefono,
				$this->strEmail,
				$this->strDireccion,
				$this->cod_genero,
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



	//Función para que inserte en bitácora cada vez que se agrega un nuevo Cliente
	public function insertClientesBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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




	public function selectClientes()
	{
		$whereAdmin = "";
		if ($_SESSION['idUser'] != 1) {
			$whereAdmin = " and p.cod_cliente != 1 ";
		}
		$sql = "SELECT p.cod_cliente,p.rtn,p.nombres,p.apellidos,p.telefono,p.correo_electronico,p.direccion
					FROM tbl_cliente p 
					-- INNER JOIN tbl_genero r
					-- ON p.cod_genero = r.cod_genero
					-- WHERE p.estado != 0
                     " . $whereAdmin;
		$request = $this->select_all($sql);
		return $request;
	}


	public function selectGenero()
		{
			$whereAdmin = "";
			if($_SESSION['idUser'] != 1 ){
				$whereAdmin = " and cod_genero != 1 ";
			}
			//EXTRAE ROLES
			$sql = "SELECT * FROM tbl_genero ".$whereAdmin;
			$request = $this->select_all($sql);
			return $request;
		}


	//Muestra los datos en el botón ver más
	public function selectCliente(int $cod_cliente)
	{
		$this->cod_cliente= $cod_cliente;
		$sql = "SELECT p.cod_cliente,p.rtn,p.nombres,p.apellidos,p.telefono,p.correo_electronico,p.direccion,
		p.cod_genero,r.nombre_genero,p.creado_por, DATE_FORMAT(p.fecha_creacion, '%Y-%m-%d %H:%i:%s') as fecha_creacion ,p.modificado_por,p.fecha_modificacion
					FROM tbl_genero r
					INNER JOIN tbl_cliente p
					ON p.cod_genero = r.cod_genero
					WHERE p.cod_cliente = $this->cod_cliente";
		$request = $this->select($sql);
		return $request;
	}

	public function updateCliente(int $cod_cliente,int $rtn, string $nombres, string $apellidos, int $telefono, string $correo_electronico, string $direccion, int $cod_genero)
	{

		$this->cod_cliente = $cod_cliente;
		$this->strRtn = $rtn;
		$this->strNombres = $nombres;
		$this->strApellidos = $apellidos;
		$this->intTelefono = $telefono;
		$this->strEmail = $correo_electronico;
		$this->strDireccion = $direccion;
		$this->cod_genero = $cod_genero;
		$this->strModificadoPor = $_SESSION['elUsuario'];
		$this->fechaModificacion = date('Y-m-d H:i:s');
		

		$sql = "SELECT * FROM tbl_cliente WHERE nombres = '{$this->strNombres}' AND cod_cliente != $this->cod_cliente" ;
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_cliente SET rtn=?, nombres=?, apellidos=? , telefono=?, correo_electronico=?, direccion=?, Cod_genero=?, modificado_por=?, fecha_modificacion=?
							WHERE cod_cliente = $this->cod_cliente ";
			$arrData = array(
				$this->strRtn ,
				$this->strNombres,
				$this->strApellidos,
				$this->intTelefono,
				$this->strEmail,
                $this->strDireccion,
                $this->cod_genero,
				$this->strModificadoPor,
				$this->fechaModificacion

			);

			$request = $this->update($sql, $arrData);
		} else {
			$request = "exist";
		}
		return $request;
	}



	public function deleteCliente(int $cod_cliente)
	{
		$this->cod_cliente = $cod_cliente;
		// $sql = "SELECT * FROM tbl_ms_parametros WHERE id_parametro = $this->intid_parametro";
		// $request = $this->select_all($sql);
		// if (empty($request)) {
		$sql = "DELETE FROM tbl_cliente WHERE cod_cliente = $this->cod_cliente";
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
