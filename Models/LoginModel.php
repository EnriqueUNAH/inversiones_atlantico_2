<?php

class LoginModel extends Mysql
{
	private $intIdUsuario;
	private $strUsuario;
	private $strPassword;
	private $strToken;

	public function __construct()
	{
		parent::__construct();
	}
	/////////////////////////CAMBIE LINEA 20
	public function loginUser(string $usuario, string $password)
	{
		$this->strUsuario = $usuario;
		$this->strPassword = $password;
		$sql = "SELECT id_usuario,usuario,estado FROM tbl_ms_usuarios WHERE 
					usuario = '$this->strUsuario' and  
					contrasena = '$this->strPassword' and 
					estado != 0 ";
		$request = $this->select($sql);
		return $request;
	}

	public function sessionLogin(int $iduser)
	{
		$this->intIdUsuario = $iduser;
		//BUSCAR ROLE 
		$sql = "SELECT p.id_usuario,
							p.usuario,
							p.nombre_usuario,						
							p.preguntas_contestadas,
							p.correo_electronico,		
							r.id_rol,r.nombrerol,
							p.estado 
					FROM tbl_ms_usuarios p
					INNER JOIN tbl_ms_roles r
					ON p.id_rol = r.id_rol
					WHERE p.id_usuario = $this->intIdUsuario";
		$request = $this->select($sql);
		$_SESSION['userData'] = $request;
		return $request;
	}

	public function getUserEmail(string $strEmail)
	{
		$this->strUsuario = $strEmail;
		$sql = "SELECT id_usuario,nombre_usuario,correo_electronico,estado FROM tbl_ms_usuarios WHERE 
					usuario = '$this->strUsuario' and  
					estado != 2";
		$request = $this->select($sql);
		return $request;
	}
	public function getParametroIntentos()
	{

		$sql = "SELECT valor FROM tbl_ms_parametros WHERE 
					id_parametro = 1";
		$request = $this->select($sql);
		return $request;
	}
	public function getUserId(string $Usuario)
	{
		$this->strUsuario = $Usuario;
		$sql = "SELECT id_usuario FROM tbl_ms_usuarios WHERE 
					usuario = '$this->strUsuario'";
		$request = $this->select($sql);
		return $request;
	}
	public function setTokenUser(int $idpersona, string $token)
	{
		$this->intIdUsuario = $idpersona;
		$this->strToken = $token;
		$sql = "UPDATE tbl_ms_usuarios SET token = ? WHERE id_usuario = $this->intIdUsuario ";
		$arrData = array($this->strToken);
		$request = $this->update($sql, $arrData);
		return $request;
	}

	public function setEstado(int $Usuario)
	{
		$this->intUsuario = $Usuario;

		$sql = "UPDATE tbl_ms_usuarios SET estado = ? WHERE id_usuario = $this->intUsuario ";
		$arrData = array(4);
		$request = $this->update($sql, $arrData);
		return $request;
	}
	//CUANDO RECUPERA POR CORREO Y SU ESTADO DEBE PASAR A ACTIVO
	public function updateEstado(int $Usuario)
	{
		$this->intUsuario = $Usuario;

		$sql = "UPDATE tbl_ms_usuarios SET estado = ? WHERE id_usuario = $this->intUsuario ";
		$arrData = array(1);
		$request = $this->update($sql, $arrData);
		return $request;
	}

	public function getUsuario(string $email, string $token)
	{
		$this->strUsuario = $email;
		$this->strToken = $token;
		$sql = "SELECT id_usuario FROM tbl_ms_usuarios WHERE 
					correo_electronico = '$this->strUsuario' and 
					token = '$this->strToken' and 					
					estado != 2 "; //Diferente de 2 porque es el Estado Inactivo
		$request = $this->select($sql);
		return $request;
	}

	public function insertPassword(int $idPersona, string $password)
	{
		$this->intIdUsuario = $idPersona;
		$this->strPassword = $password;
		$sql = "UPDATE tbl_ms_usuarios SET contrasena = ?, token = ? WHERE id_usuario = $this->intIdUsuario ";
		$arrData = array($this->strPassword, "");
		$request = $this->update($sql, $arrData);
		return $request;
	}

	//Función para que inserte en bitácora cada vez que ingresa un usuario al sistema
	public function insertUsuarioBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
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





	//
	public function updateUltimaConexion(int $idUsuario)
	{
		$this->intIdUsuario = $idUsuario;
		$this->dateFecha = date('Y-m-d H:i:s');

		$sql = "UPDATE tbl_ms_usuarios SET fecha_ultima_conexion=? WHERE id_usuario=?";

		$arrData = array(
			$this->dateFecha,
			$this->intIdUsuario
		);

		$request = $this->update($sql, $arrData);
		return $request;
	}
	//






}
