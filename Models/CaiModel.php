<?php 
class CaiModel extends Mysql
{
	private $intcod;
	private $intRangoIni;
	private $intRangoFin;
	private $intRangoActual;
	private $strCai;
	private $dateFecha;

	public function __construct()
	{
		parent::__construct();
	}	

	public function insertCai(int $ranini, int $ranfin, int $ranact, int $cai)
	{			

		$this->rango_inicial = $ranini;
		$this->rango_final = $ranfin;
		$this->rango_actual = $ranact;
		$this->numero_CAI = $cai;

		$return = 0;

		$sql = "SELECT * FROM tbl_configuracion_cai WHERE cod_talonario = '{$this->numero_CAI}' "; //El Where es muy importante para poder insertar
		$request = $this->select_all($sql);													//Ese where debe estar de acorde a cada tabla

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_configuracion_cai(rango_inicial,rango_final,rango_actual,numero_CAI,fecha_vencimiento) 
								  VALUES(?,?,?,?,NOW())";
			$arrData = array(					
				$this->rango_inicial,
				$this->rango_final,
				$this->rango_actual,
				$this->numero_CAI
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}

	public function selectCais()
	{
		$sql = "SELECT cod_talonario,rango_inicial,rango_final,rango_actual,numero_CAI,fecha_vencimiento  
				FROM tbl_configuracion_cai";
		$request = $this->select_all($sql);
		return $request;
	}

	public function selectCai(int $cod_talonario){
		$this->intIdCod = $cod_talonario;
		$sql = "SELECT rango_inicial,rango_final,rango_actual,numero_CAI
				FROM tbl_configuracion_cai
				WHERE cod_talonario = '$this->intIdCod'";
		$request = $this->select($sql);
		return $request;
	}

	public function updateCai(int $cod_talonario, int $rango_inicial, int $rango_final, int $rango_actual, string $numero_CAI, date $fecha)
	{
		$this->intcod=$cod_talonario;
		$this->intRangoIni = $rango_inicial;
		$this->intRangoFin = $rango_final;
		$this->intRangoActual = $rango_actual;
		$this->strCai=$numero_CAI;
		$this->dateFecha=$fecha;

		$sql = "SELECT rango_inicial,rango_final,rango_actual,numero_CAI,fecha_vencimiento FROM tbl_configuraicon_cai WHERE cod_talonario = '{$this->strCai}'";
		$request = $this->select_all($sql);

		if (empty($request)) {

			$sql = "UPDATE tbl_configuracion_cai SET rango_inicial=?, rango_final=?, rango_actual=?, numero_CAI=?,fecha_vencimiento=?
							WHERE cod_talonario = $this->intCodigo ";
			$arrData = array(
				$this->strNombre,
				$this->intPorcentaje
			);

			$request = $this->update($sql, $arrData);
		} else {
			$request = "exist";
		}
		return $request;
	}

	public function deleteCai(int $idproducto){
		$this->intIdCai = $idproducto;
		$sql = "DELETE FROM tbl_configuracion_cai where cod_talonario = $this->intIdCai";
		$arrData = array(0);
		$request = $this->delete($sql,$arrData);
		return $request;
	}
}

 ?>