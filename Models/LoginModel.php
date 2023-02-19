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
			$sql = "SELECT id_usuario,estado FROM tbl_ms_usuarios WHERE 
					usuario = '$this->strUsuario' and  
					contrasena = '$this->strPassword' and 
					estado != 0 ";
			$request = $this->select($sql);
			return $request;
		}

		public function sessionLogin(int $iduser){
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

		public function getUserEmail(string $strEmail){
			$this->strUsuario = $strEmail;
			$sql = "SELECT id_usuario,nombre_usuario,estado FROM tbl_ms_usuarios WHERE 
					correo_electronico = '$this->strUsuario' and  
					estado = 1 ";
			$request = $this->select($sql);
			return $request;
		}

		public function setTokenUser(int $idpersona, string $token){
			$this->intIdUsuario = $idpersona;
			$this->strToken = $token;
			$sql = "UPDATE tbl_ms_usuarios SET token = ? WHERE id_usuario = $this->intIdUsuario ";
			$arrData = array($this->strToken);
			$request = $this->update($sql,$arrData);
			return $request;
		}

		public function getUsuario(string $email, string $token){
			$this->strUsuario = $email;
			$this->strToken = $token;
			$sql = "SELECT id_usuario FROM tbl_ms_usuarios WHERE 
					correo_electronico = '$this->strUsuario' and 
					token = '$this->strToken' and 					
					estado = 1 ";
			$request = $this->select($sql);
			return $request;
		}

		public function insertPassword(int $idPersona, string $password){
			$this->intIdUsuario = $idPersona;
			$this->strPassword = $password;
			$sql = "UPDATE tbl_ms_usuarios SET contrasena = ?, token = ? WHERE id_usuario = $this->intIdUsuario ";
			$arrData = array($this->strPassword,"");
			$request = $this->update($sql,$arrData);
			return $request;
		}
	}
