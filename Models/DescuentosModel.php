<?php 

	class DescuentosModel extends Mysql
	{
		private $intIdDescuento;
		private $strNombre;
		private $intCodigo;
		private $intPorcentaje;

		public function __construct()
		{
			parent::__construct();
		}

		public function selectDescuento(){
			$sql = "SELECT cod_descuento, nombre_descuento, porcentaje_descuento
					FROM tbl_descuento";
					$request = $this->select_all($sql);
			return $request;
		}	

		public function insertDescuento(string $nombre, int $porcentaje, int $intCodigo){
			$this->strNombre = $nombre;
			$this->intPorcentaje = $porcentaje;
			$this->intCodigo = $Codigo;
			$return = 0;
			$sql = "SELECT * FROM tbl_descuento WHERE cod_descuento = '{$this->intCodigo}'";
			$request = $this->select_all($sql);
			if(empty($request))
			{
				$query_insert  = "INSERT INTO tbl_descuento(nombre_descuento,
														porcentaje_descuento) 
								  VALUES(?,?,?,?,?,?,?,?)";
	        	$arrData = array(
        						$this->intCodigo,
        						$this->strNombre,
        						$this->intPorcenjate);
	        	$request_insert = $this->insert($query_insert,$arrData);
	        	$return = $request_insert;
			}else{
				$return = "exist";
			}
	        return $return;
		}

		public function updateProducto(int $idproducto, string $nombre, string $descripcion, int $codigo, int $categoriaid, string $precio, int $stock, string $ruta, int $status){
			$this->intIdProducto = $idproducto;
			$this->strNombre = $nombre;
			$this->strDescripcion = $descripcion;
			$this->intCodigo = $codigo;
			$this->intCategoriaId = $categoriaid;
			$this->strPrecio = $precio;
			$this->intStock = $stock;
			$this->strRuta = $ruta;
			$this->intStatus = $status;
			$return = 0;
			$sql = "SELECT * FROM producto WHERE codigo = '{$this->intCodigo}' AND idproducto != $this->intIdProducto ";
			$request = $this->select_all($sql);
			if(empty($request))
			{
				$sql = "UPDATE producto 
						SET categoriaid=?,
							codigo=?,
							nombre=?,
							descripcion=?,
							precio=?,
							stock=?,
							ruta=?,
							status=? 
						WHERE idproducto = $this->intIdProducto ";
				$arrData = array($this->intCategoriaId,
        						$this->intCodigo,
        						$this->strNombre,
        						$this->strDescripcion,
        						$this->strPrecio,
        						$this->intStock,
        						$this->strRuta,
        						$this->intStatus);

	        	$request = $this->update($sql,$arrData);
	        	$return = $request;
			}else{
				$return = "exist";
			}
	        return $return;
		}

		public function selectDescuentos(int $codigo){
			$this->intIdDescuento = $codigo;
			$sql = "SELECT *
					FROM tbl_descuento
					WHERE cod_descuento = $this->intIdDescuento";
			$request = $this->select($sql);
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