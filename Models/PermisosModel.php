<?php

class PermisosModel extends Mysql
{
	public $intIdpermiso;
	public $intid_rol;
	public $intid_objeto;
	public $r;
	public $w;
	public $u;
	public $d;

	public function __construct()
	{
		parent::__construct();
	}

	public function selectModulos()
	{
		$sql = "SELECT * FROM tbl_ms_objetos WHERE estado != 0";
		$request = $this->select_all($sql);
		return $request;
	}
	public function selectPermisosRol(int $id_rol)
	{
		$this->intid_rol = $id_rol;
		$sql = "SELECT * FROM tbl_ms_permisos WHERE id_rol = $this->intid_rol";
		$request = $this->select_all($sql);
		return $request;
	}

	public function deletePermisos(int $id_rol)
	{
		$this->intid_rol = $id_rol;
		$sql = "DELETE FROM tbl_ms_permisos WHERE id_rol = $this->intid_rol";
		$request = $this->delete($sql);
		return $request;
	}

	public function insertPermisos(int $id_rol, int $id_objeto, int $r, int $w, int $u, int $d)
	{
		$this->intid_rol = $id_rol;
		$this->intid_objeto = $id_objeto;
		$this->r = $r;
		$this->w = $w;
		$this->u = $u;
		$this->d = $d;
		$query_insert  = "INSERT INTO tbl_ms_permisos(id_rol,id_objeto,r,w,u,d) VALUES(?,?,?,?,?,?)";
		$arrData = array($this->intid_rol, $this->intid_objeto, $this->r, $this->w, $this->u, $this->d);
		$request_insert = $this->insert($query_insert, $arrData);
		return $request_insert;
	}

	public function permisosModulo(int $id_rol)
	{
		$this->intid_rol = $id_rol;
		$sql = "SELECT p.id_rol,
						   p.id_objeto,
						   m.objeto as modulo,
						   p.r,
						   p.w,
						   p.u,
						   p.d 
					FROM tbl_ms_permisos p 
					INNER JOIN tbl_ms_objetos m
					ON p.id_objeto = m.id_objeto
					WHERE p.id_rol = $this->intid_rol";
		$request = $this->select_all($sql);
		$arrPermisos = array();
		for ($i = 0; $i < count($request); $i++) {
			$arrPermisos[$request[$i]['id_objeto']] = $request[$i];
		}
		return $arrPermisos;
	}

	public function getRol(int $id_rol)
	{
		$this->intid_rol = $id_rol;
		$sql = "SELECT * FROM tbl_ms_roles WHERE id_rol = $this->intid_rol";
		$request = $this->select($sql);
		return $request;
	}
}
