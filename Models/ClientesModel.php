<?php

class ClientesModel extends Mysql
{
	private $cod_cliente;
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

	public function insertUsuario(string $usuario, string $nombre, string $email, string $password, int $tipoid, int $status)
	{
		$this->strusuario = $usuario;
		$this->strNombre = $nombre;
		$this->strEmail = $email;
		$this->strPassword = $password;
		$this->intTipoId = $tipoid;
		$this->strCreadoPor = $_SESSION['elUsuario'];
		$this->intStatus = $status;
		$return = 0;

		$sql = "SELECT * FROM tbl_ms_usuarios WHERE 
					correo_electronico = '{$this->strEmail}' or usuario = '{$this->strusuario}' ";
		$request = $this->select_all($sql);

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_ms_usuarios(usuario,nombre_usuario,correo_electronico,contrasena,id_rol,creado_por,estado) 
								  VALUES(?,?,?,?,?,?,?)";
			$arrData = array(
				$this->strusuario,
				$this->strNombre,
				$this->strEmail,
				$this->strPassword,
				$this->intTipoId,
				$this->strCreadoPor,
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

	// public static function evento_bitacora($id_objeto,$id_usuario,$accion,$descripcion)
	// 	{
	// 		   require ('../clases/Conexion.php');

	// 		   		$sql = "INSERT INTO  tbl_ms_bitacora (Id_objeto, id_usuario,Fecha, Accion , Descripcion)
	// 			 VALUES ('$id_objeto', '$id_usuario' , sysdate(), '$accion', '$descripcion')";

	// 		$resultado = $mysqli->query($sql);
	// 	}



	public function selectClientes()
	{
		$whereAdmin = "";
		if ($_SESSION['idUser'] != 1) {
			$whereAdmin = " and p.cod_cliente != 1 ";
		}
		$sql = "SELECT p.cod_cliente,p.rtn,p.nombres,p.apellidos,p.telefono,p.correo_electronico,p.direccion 
					FROM tbl_cliente p 
					-- INNER JOIN tbl_ms_roles r
					-- ON p.id_rol = r.id_rol
					-- WHERE p.estado != 0
                     " . $whereAdmin;
		$request = $this->select_all($sql);
		return $request;
	}

	//Muestra los datos en el botón ver más
	public function selectCliente(int $cod_cliente)
	{
		$this->cod_cliente= $cod_cliente;
		$sql = "SELECT p.cod_cliente,p.rtn,p.nombres,p.apellidos,p.telefono,p.correo_electronico,p.direccion,DATE_FORMAT(p.fecha_registro, '%d-%m-%Y'),
		p.cod_genero,p.estado,p.creado_por,DATE_FORMAT(p.fecha_creacion, '%d-%m-%Y'),p.modificado_por,p.fecha_modificacion 
					FROM tbl_cliente p
					-- INNER JOIN tbl_ms_roles r
					-- ON p.id_rol = r.id_rol
					WHERE p.cod_cliente = $this->cod_cliente";
		$request = $this->select($sql);
		return $request;
	}





	public function updateUsuario(int $idUsuario, string $usuario, string $nombre, string $email, string $password, int $tipoid, int $estado)
	{

		$this->intIdUsuario = $idUsuario;
		$this->strusuario = $usuario;
		$this->strNombre = $nombre;
		$this->strEmail = $email;
		$this->strPassword = $password;
		$this->intTipoId = $tipoid;
		$this->strModificadoPor = $_SESSION['elUsuario'];
		$this->fechaModificacion = date('Y-m-d H:i:s');
		$this->intStatus = $estado;

		$sql = "SELECT * FROM tbl_ms_usuarios WHERE (correo_electronico = '{$this->strEmail}' AND id_usuario != $this->intIdUsuario)
										  OR (usuario = '{$this->strusuario}' AND id_usuario != $this->intIdUsuario) ";
		$request = $this->select_all($sql);

		if (empty($request)) {
			if ($this->strPassword  != "") {
				$sql = "UPDATE tbl_ms_usuarios SET usuario=?, nombre_usuario=?, correo_electronico=?, contrasena=?, id_rol=?, modificado_por=?, fecha_modificacion=?, estado=? 
							WHERE id_usuario = $this->intIdUsuario ";
				$arrData = array(
					$this->strusuario,
					$this->strNombre,
					$this->strEmail,
					$this->strPassword,
					$this->intTipoId,
					$this->strModificadoPor,
					$this->fechaModificacion,
					$this->intStatus
				);
			} else {
				$sql = "UPDATE tbl_ms_usuarios SET usuario=?, nombre_usuario=?, correo_electronico=?, id_rol=?, modificado_por=?, fecha_modificacion=?, estado=? 
							WHERE id_usuario = $this->intIdUsuario ";
				$arrData = array(
					$this->strusuario,
					$this->strNombre,
					$this->strEmail,
					$this->intTipoId,
					$this->strModificadoPor,
					$this->fechaModificacion,
					$this->intStatus
				);
			}
			$request = $this->update($sql, $arrData);
		} else {
			$request = "exist";
		}
		return $request;
	}
	public function deleteUsuario(int $intid_usuario)
	{
		$this->intIdUsuario = $intid_usuario;

		$sql = "SELECT * FROM tbl_ms_bitacora WHERE id_usuario = $this->intIdUsuario";
		$request = $this->select_all($sql);
		if (empty($request)) {

			$sql = "DELETE FROM tbl_ms_usuarios WHERE id_usuario = $this->intIdUsuario ";
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

	public function updateUsuarioInactivo(int $idUsuario)
	{
		$this->intid_Usuario = $idUsuario;

		$sql = "SELECT * FROM tbl_ms_usuarios WHERE id_usuario = $this->intid_Usuario";
		$request = $this->select_all($sql);

		if ($request) {
			$sql = "UPDATE tbl_ms_usuarios SET estado = ? WHERE id_usuario = $this->intid_Usuario ";
			$arrData = array(2);
			$request = $this->update($sql, $arrData);
		}
		return $request;
	}






	public function updatePerfil(int $idUsuario, string $usuario, string $nombre, int $preguntas_contestadas, string $password)
	{
		$this->intIdUsuario = $idUsuario;
		$this->strusuario = $usuario;
		$this->strNombre = $nombre;
		//$this->strApellido = $apellido;
		$this->intpreguntas_contestadas = $preguntas_contestadas;
		$this->strPassword = $password;

		if ($this->strPassword != "") {
			$sql = "UPDATE tbl_ms_usuarios SET usuario=?, nombre_usuario=?, preguntas_contestadas=?, contrasena=? 
						WHERE id_usuario = $this->intIdUsuario ";
			$arrData = array(
				$this->strusuario,
				$this->strNombre,
				//$this->strApellido,
				$this->intpreguntas_contestadas,
				$this->strPassword
			);
		} else {
			$sql = "UPDATE tbl_ms_usuarios SET usuario=?, nombre_usuario=?, preguntas_contestadas=? 
						WHERE id_usuario = $this->intIdUsuario ";
			$arrData = array(
				$this->strusuario,
				$this->strNombre,
				//$this->strApellido,
				$this->intpreguntas_contestadas
			);
		}
		$request = $this->update($sql, $arrData);
		return $request;
	}

	public function updateDataFiscal(int $idUsuario, string $strNit, string $strNomFiscal, string $strDirFiscal)
	{
		$this->intIdUsuario = $idUsuario;
		$this->strNit = $strNit;
		$this->strNomFiscal = $strNomFiscal;
		$this->strDirFiscal = $strDirFiscal;
		$sql = "UPDATE tbl_ms_usuarios SET nit=?, nombrefiscal=?, direccionfiscal=? 
						WHERE id_usuario = $this->intIdUsuario ";
		$arrData = array(
			$this->strNit,
			$this->strNomFiscal,
			$this->strDirFiscal
		);
		$request = $this->update($sql, $arrData);
		return $request;
	}
}
