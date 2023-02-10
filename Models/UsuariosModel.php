<?php 

	class UsuariosModel extends Mysql
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

		public function insertUsuario(string $usuario, string $nombre, int $preguntas_contestadas, string $email, string $password, int $tipoid, int $status){

			$this->strusuario = $usuario;
			$this->strNombre = $nombre;
			//$this->strApellido = $apellido;
			$this->intpreguntas_contestadas = $preguntas_contestadas;
			$this->strEmail = $email;
			$this->strPassword = $password;
			$this->intTipoId = $tipoid;
			$this->intStatus = $status;
			$return = 0;

			$sql = "SELECT * FROM tbl_ms_usuarios WHERE 
					correo_electronico = '{$this->strEmail}' or usuario = '{$this->strusuario}' ";
			$request = $this->select_all($sql);

			if(empty($request))
			{
				$query_insert  = "INSERT INTO tbl_ms_usuarios(usuario,nombre_usuario,preguntas_contestadas,correo_electronico,contrasena,id_rol,status) 
								  VALUES(?,?,?,?,?,?,?)";
	        	$arrData = array($this->strusuario,
        						$this->strNombre,
        						//$this->strApellido,
        						$this->intpreguntas_contestadas,
        						$this->strEmail,
        						$this->strPassword,
        						$this->intTipoId,
			$this->intStatus);
	        	$request_insert = $this->insert($query_insert,$arrData);
	        	$return = $request_insert;
			}else{
				$return = "exist";
			}
	        return $return;
		}

		public function selectUsuarios()
		{
			$whereAdmin = "";
			if($_SESSION['idUser'] != 1 ){
				$whereAdmin = " and p.id_usuario != 1 ";
			}
			$sql = "SELECT p.id_usuario,p.usuario,p.nombre_usuario,p.preguntas_contestadas,p.correo_electronico,p.status,r.id_rol,r.nombrerol 
					FROM tbl_ms_usuarios p 
					INNER JOIN tbl_ms_roles r
					ON p.id_rol = r.id_rol
					WHERE p.status != 0 ".$whereAdmin;
					$request = $this->select_all($sql);
					return $request;
		}
		//Muestra los datos en el botón ver más
		public function selectUsuario(int $id_usuario){
			$this->intIdUsuario = $id_usuario;
			$sql = "SELECT p.id_usuario,p.usuario,p.nombre_usuario,p.preguntas_contestadas,p.correo_electronico,r.id_rol,r.nombrerol,p.status, DATE_FORMAT(p.fecha_creacion, '%d-%m-%Y') as fechaRegistro 
					FROM tbl_ms_usuarios p
					INNER JOIN tbl_ms_roles r
					ON p.id_rol = r.id_rol
					WHERE p.id_usuario = $this->intIdUsuario";
			$request = $this->select($sql);
			return $request;
		}

		public function updateUsuario(int $idUsuario, string $usuario, string $nombre, string $email, string $password, int $tipoid, int $status){

			$this->intIdUsuario = $idUsuario;
			$this->strusuario = $usuario;
			$this->strNombre = $nombre;
			//$this->strApellido = $apellido;
			//$this->intpreguntas_contestadas = $preguntas_contestadas;
			$this->strEmail = $email;
			$this->strPassword = $password;
			$this->intTipoId = $tipoid;
			$this->intStatus = $status;

			$sql = "SELECT * FROM tbl_ms_usuarios WHERE (correo_electronico = '{$this->strEmail}' AND id_usuario != $this->intIdUsuario)
										  OR (usuario = '{$this->strusuario}' AND id_usuario != $this->intIdUsuario) ";
			$request = $this->select_all($sql);

			if(empty($request))
			{
				if($this->strPassword  != "") 
				{
					$sql = "UPDATE tbl_ms_usuarios SET usuario=?, nombre_usuario=?, preguntas_contestadas=?, correo_electronico=?, contrasena=?, id_rol=?, status=? 
							WHERE id_usuario = $this->intIdUsuario ";
					$arrData = array($this->strusuario,
	        						$this->strNombre,
	        						//$this->strApellido,
	        						$this->intpreguntas_contestadas,
	        						$this->strEmail,
	        						$this->strPassword,
	        						$this->intTipoId,
	        						$this->intStatus);
				}else{
					$sql = "UPDATE tbl_ms_usuarios SET usuario=?, nombre_usuario=?, preguntas_contestadas=?, correo_electronico=?, id_rol=?, status=? 
							WHERE id_usuario = $this->intIdUsuario ";
					$arrData = array($this->strusuario,
	        						$this->strNombre,
	        						//$this->strApellido,
	        						$this->intpreguntas_contestadas,
	        						$this->strEmail,
	        						$this->intTipoId,
	        						$this->intStatus);
				}
				$request = $this->update($sql,$arrData);
			}else{
				$request = "exist";
			}
			return $request;
		
		}
		public function deleteUsuario(int $intid_usuario)
		{
			$this->intIdUsuario = $intid_usuario;
			$sql = "UPDATE tbl_ms_usuarios SET status = ? WHERE id_usuario = $this->intIdUsuario ";
			$arrData = array(0);
			$request = $this->update($sql,$arrData);
			return $request;
		}










		
		public function updatePerfil(int $idUsuario, string $usuario, string $nombre, int $preguntas_contestadas, string $password){
			$this->intIdUsuario = $idUsuario;
			$this->strusuario = $usuario;
			$this->strNombre = $nombre;
			//$this->strApellido = $apellido;
			$this->intpreguntas_contestadas = $preguntas_contestadas;
			$this->strPassword = $password;

			if($this->strPassword != "")
			{
				$sql = "UPDATE tbl_ms_usuarios SET usuario=?, nombre_usuario=?, preguntas_contestadas=?, contrasena=? 
						WHERE id_usuario = $this->intIdUsuario ";
				$arrData = array($this->strusuario,
								$this->strNombre,
								//$this->strApellido,
								$this->intpreguntas_contestadas,
								$this->strPassword);
			}else{
				$sql = "UPDATE tbl_ms_usuarios SET usuario=?, nombre_usuario=?, preguntas_contestadas=? 
						WHERE id_usuario = $this->intIdUsuario ";
				$arrData = array($this->strusuario,
								$this->strNombre,
								//$this->strApellido,
								$this->intpreguntas_contestadas);
			}
			$request = $this->update($sql,$arrData);
		    return $request;
		}

		public function updateDataFiscal(int $idUsuario, string $strNit, string $strNomFiscal, string $strDirFiscal){
			$this->intIdUsuario = $idUsuario;
			$this->strNit = $strNit;
			$this->strNomFiscal = $strNomFiscal;
			$this->strDirFiscal = $strDirFiscal;
			$sql = "UPDATE tbl_ms_usuarios SET nit=?, nombrefiscal=?, direccionfiscal=? 
						WHERE id_usuario = $this->intIdUsuario ";
			$arrData = array($this->strNit,
							$this->strNomFiscal,
							$this->strDirFiscal);
			$request = $this->update($sql,$arrData);
		    return $request;
		}

	}
 ?>