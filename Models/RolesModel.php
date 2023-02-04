<?php 

	class RolesModel extends Mysql
	{
		public $intid_rol;
		public $strRol;
		public $strDescripcion;
		public $intStatus;

		public function __construct()
		{
			parent::__construct();
		}

		public function selectRoles()
		{
			$whereAdmin = "";
			if($_SESSION['idUser'] != 1 ){
				$whereAdmin = " and id_rol != 1 ";
			}
			//EXTRAE ROLES
			$sql = "SELECT * FROM tbl_ms_roles WHERE status != 0".$whereAdmin;
			$request = $this->select_all($sql);
			return $request;
		}

		public function selectRol(int $id_rol)
		{
			//BUSCAR ROLE
			$this->intid_rol = $id_rol;
			$sql = "SELECT * FROM tbl_ms_roles WHERE id_rol = $this->intid_rol";
			$request = $this->select($sql);
			return $request;
		}

		public function insertRol(string $rol, string $descripcion, int $status){

			$return = "";
			$this->strRol = $rol;
			$this->strDescripcion = $descripcion;
			$this->intStatus = $status;

			$sql = "SELECT * FROM tbl_ms_roles WHERE nombrerol = '{$this->strRol}' ";
			$request = $this->select_all($sql);

			if(empty($request))
			{
				$query_insert  = "INSERT INTO tbl_ms_roles(nombrerol,descripcion,status) VALUES(?,?,?)";
	        	$arrData = array($this->strRol, $this->strDescripcion, $this->intStatus);
	        	$request_insert = $this->insert($query_insert,$arrData);
	        	$return = $request_insert;
			}else{
				$return = "exist";
			}
			return $return;
		}	

		public function updateRol(int $id_rol, string $rol, string $descripcion, int $status){
			$this->intid_rol = $id_rol;
			$this->strRol = $rol;
			$this->strDescripcion = $descripcion;
			$this->intStatus = $status;

			$sql = "SELECT * FROM tbl_ms_roles WHERE nombrerol = '$this->strRol' AND id_rol != $this->intid_rol";
			$request = $this->select_all($sql);

			if(empty($request))
			{
				$sql = "UPDATE tbl_ms_roles SET nombrerol = ?, descripcion = ?, status = ? WHERE id_rol = $this->intid_rol ";
				$arrData = array($this->strRol, $this->strDescripcion, $this->intStatus);
				$request = $this->update($sql,$arrData);
			}else{
				$request = "exist";
			}
		    return $request;			
		}

		public function deleteRol(int $id_rol)
		{
			$this->intid_rol = $id_rol;
			$sql = "SELECT * FROM tbl_ms_usuarios WHERE id_rol = $this->intid_rol";
			$request = $this->select_all($sql);
			if(empty($request))
			{
				$sql = "UPDATE tbl_ms_roles SET status = ? WHERE id_rol = $this->intid_rol ";
				$arrData = array(0);
				$request = $this->update($sql,$arrData);
				if($request)
				{
					$request = 'ok';	
				}else{
					$request = 'error';
				}
			}else{
				$request = 'exist';
			}
			return $request;
		}
	}
 ?>