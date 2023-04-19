<?php 
	class DashboardModel extends Mysql
	{
		public function __construct()
		{
			parent::__construct();
		}

		public function cantUsuarios(){
			$sql = "SELECT COUNT(*) as total FROM tbl_ms_usuarios WHERE estado != 0";
			$request = $this->select($sql);
			$total = $request['total']; 
			return $total;
		}
		public function cantClientes(){
			$sql = "SELECT COUNT(*) as total FROM tbl_cliente WHERE estado != 0 ";
			$request = $this->select($sql);
			$total = $request['total']; 
			return $total;
		}
		public function cantProductos(){
			$sql = "SELECT COUNT(*) as total FROM tbl_producto WHERE estado != 0 ";
			$request = $this->select($sql);
			$total = $request['total']; 
			return $total;
		}
		public function cantCompras(){
			$sql = "SELECT COUNT(*) as total FROM tbl_compra WHERE estado != 0 ";
			$request = $this->select($sql);
			$total = $request['total']; 
			return $total;
		}

	}
 ?>