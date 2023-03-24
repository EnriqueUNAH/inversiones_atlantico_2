<?php 
class DescuentosModel extends Mysql
{
	// private $intIdUsuario;
	private $intCodigo;
	private $strNombre;
	// private $strApellido;
	// private $intPorcentaje;
	// private $strEmail;
	// private $strPassword;
	// private $strToken;
	// private $intTipoId;
	// private $intStatus;
	// private $strNit;
	// private $strNomFiscal;
	// private $strDirFiscal;

	public function __construct()
	{
		parent::__construct();
	}	

	public function insertDescuento(string $identificacion, string $nombre, int $Porcentaje){

		$this->intCodigo = $identificacion;
		$this->strNombre = $nombre;
		$this->intPorcentaje = $Porcentaje;

		$return = 0;
		$sql = "SELECT * FROM tbl_descuento WHERE 
				cod_descuento = '{$this->intCodigo}'";
		$request = $this->select_all($sql);

		if(empty($request))
		{
			$query_insert  = "INSERT INTO tbl_descuento(cod_descuento,nombre_descuento,porcentaje_descuento) 
							  VALUES(?,?,?,?,?,?,?,?,?,?)";
        	$arrData = array($this->intCodigo,
    						$this->strNombre,
    						$this->intPorcentaje);
        	$request_insert = $this->insert($query_insert,$arrData);
        	$return = $request_insert;
		}else{
			$return = "exist";
		}
        return $return;
	}

	public function selectDescuentos()
	{
		$sql = "SELECT * 
				FROM tbl_descuento";
		$request = $this->select_all($sql);
		return $request;
	}

	public function selectDescuento(int $idpersona){
		$this->intIdUsuario = $idpersona;
		$sql = "SELECT * 
				FROM tbl_descuento
				WHERE cod_descuento = '$this->intIdUsuario'";
		$request = $this->select($sql);
		return $request;
	}

	public function updateDescuento(int $idUsuario, string $identificacion, string $nombre, int $Porcentaje){

		$this->intIdUsuario = $idUsuario;
		$this->intCodigo = $identificacion;
		$this->strNombre = $nombre;
		$this->intPorcentaje = $Porcentaje;

		$sql = "SELECT * FROM tbl_descuento WHERE (cod_descuento = '$this->intCodigo') ";
		$request = $this->select_all($sql);

		if(empty($request))
		{
			if($this->intCodigo  != "")
			{
				$sql = "UPDATE tbl_descuento SET cod_descuento=?, nombre_descuento=?, porcentaje_descuento=? 
						WHERE cod_descuento = $this->intIdUsuario ";
				$arrData = array($this->intCodigo,
        						$this->strNombre,
        						$this->intPorcentaje);
			}else{
				$sql = "UPDATE tbl_descuento SET cod_descuento=?, nombres_descuento=?, porcentaje_descuento=? 
						WHERE cod_descuento = $this->intIdUsuario ";
				$arrData = array($this->intCodigo,
        						$this->strNombre,
        						$this->intPorcentaje);
			}
			$request = $this->update($sql,$arrData);
		}else{
			$request = "exist";
		}
		return $request;
	}

	public function deleteDescuento(int $idproducto){
		$this->intIdDescuento = $idproducto;
		$sql = "DELETE FROM tbl_descuento where cod_descuento = $this->intIdDescuento";
		$arrData = array(0);
		$request = $this->delete($sql,$arrData);
		return $request;
	}
}

 ?>