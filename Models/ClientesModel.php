<?php 
class ClientesModel extends Mysql
{
	private $intIdUsuario;
	private $strusuario;
	private $strNombre;
	private $strApellido;
	private $intTelefono;
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

	public function insertCliente(string $usuario, string $nombre, string $apellido, int $telefono, string $email, string $password, int $tipoid, string $nit, string $nomFiscal, string $dirFiscal){

		$this->strusuario = $usuario;
		$this->strNombre = $nombre;
		$this->strApellido = $apellido;
		$this->intTelefono = $telefono;
		$this->strEmail = $email;
		$this->strPassword = $password;
		$this->intTipoId = $tipoid;
		$this->strNit = $nit;
		$this->strNomFiscal = $nomFiscal;
		$this->strDirFiscal = $dirFiscal;

		$return = 0;
		$sql = "SELECT * FROM persona WHERE 
				correo_electronico = '{$this->strEmail}' or usuario = '{$this->strusuario}' ";
		$request = $this->select_all($sql);

		if(empty($request))
		{
			$query_insert  = "INSERT INTO persona(usuario,nombres,apellidos,telefono,correo_electronico,password,id_rol,nit,nombrefiscal,direccionfiscal) 
							  VALUES(?,?,?,?,?,?,?,?,?,?)";
        	$arrData = array($this->strusuario,
    						$this->strNombre,
    						$this->strApellido,
    						$this->intTelefono,
    						$this->strEmail,
    						$this->strPassword,
    						$this->intTipoId,
    						$this->strNit,
    						$this->strNomFiscal,
    						$this->strDirFiscal);
        	$request_insert = $this->insert($query_insert,$arrData);
        	$return = $request_insert;
		}else{
			$return = "exist";
		}
        return $return;
	}

	public function selectClientes()
	{
		$sql = "SELECT idpersona,usuario,nombres,apellidos,telefono,correo_electronico,status 
				FROM persona 
				WHERE id_rol = ".RCLIENTES." and status != 0 "; 
		$request = $this->select_all($sql);
		return $request;
	}

	public function selectCliente(int $idpersona){
		$this->intIdUsuario = $idpersona;
		$sql = "SELECT idpersona,usuario,nombres,apellidos,telefono,correo_electronico,nit,nombrefiscal,direccionfiscal,status, DATE_FORMAT(fecha_creacion, '%d-%m-%Y') as fechaRegistro 
				FROM persona
				WHERE idpersona = $this->intIdUsuario and id_rol = ".RCLIENTES;
		$request = $this->select($sql);
		return $request;
	}

	public function updateCliente(int $idUsuario, string $usuario, string $nombre, string $apellido, int $telefono, string $email, string $password, string $nit, string $nomFiscal, string $dirFiscal){

		$this->intIdUsuario = $idUsuario;
		$this->strusuario = $usuario;
		$this->strNombre = $nombre;
		$this->strApellido = $apellido;
		$this->intTelefono = $telefono;
		$this->strEmail = $email;
		$this->strPassword = $password;
		$this->strNit = $nit;
		$this->strNomFiscal = $nomFiscal;
		$this->strDirFiscal = $dirFiscal;

		$sql = "SELECT * FROM persona WHERE (email_user = '{$this->strEmail}' AND idpersona != $this->intIdUsuario)
									  OR (usuario = '{$this->strusuario}' AND idpersona != $this->intIdUsuario) ";
		$request = $this->select_all($sql);

		if(empty($request))
		{
			if($this->strPassword  != "")
			{
				$sql = "UPDATE persona SET usuario=?, nombres=?, apellidos=?, telefono=?, email_user=?, password=?, nit=?, nombrefiscal=?, direccionfiscal=? 
						WHERE idpersona = $this->intIdUsuario ";
				$arrData = array($this->strusuario,
        						$this->strNombre,
        						$this->strApellido,
        						$this->intTelefono,
        						$this->strEmail,
        						$this->strPassword,
        						$this->strNit,
        						$this->strNomFiscal,
        						$this->strDirFiscal);
			}else{
				$sql = "UPDATE persona SET usuario=?, nombres=?, apellidos=?, telefono=?, email_user=?, nit=?, nombrefiscal=?, direccionfiscal=? 
						WHERE idpersona = $this->intIdUsuario ";
				$arrData = array($this->strusuario,
        						$this->strNombre,
        						$this->strApellido,
        						$this->intTelefono,
        						$this->strEmail,
        						$this->strNit,
        						$this->strNomFiscal,
        						$this->strDirFiscal);
			}
			$request = $this->update($sql,$arrData);
		}else{
			$request = "exist";
		}
		return $request;
	}

	public function deleteCliente(int $intIdpersona)
	{
		$this->intIdUsuario = $intIdpersona;
		$sql = "UPDATE persona SET status = ? WHERE idpersona = $this->intIdUsuario ";
		$arrData = array(0);
		$request = $this->update($sql,$arrData);
		return $request;
	}
}

 ?>