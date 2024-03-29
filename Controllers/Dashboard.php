<?php 

	class Dashboard extends Controllers{
		public function __construct()
		{
			parent::__construct();
			session_start();
			//session_regenerate_id(true);
			if(empty($_SESSION['login']))
			{
				header('Location: '.base_url().'/login');
				die();
			}
			getPermisos(MINICIO);
		}

		public function dashboard()
		{
			$data['page_id'] = 2;
			$data['page_tag'] = "Inicio - Inversiones Atlantico";
			$data['page_title'] = "Inicio - Inversiones Atlantico";
			$data['page_name'] = "inicio";
			$data['page_functions_js'] = "functions_dashboard.js";
			$data['usuarios'] = $this->model->cantUsuarios();
			$data['clientes'] = $this->model->cantClientes();
			$data['productos'] = $this->model->cantProductos();
			$data['compras'] = $this->model->cantCompras();

			$anio = date('Y');
			$mes = date('m');
			//$data['pagosMes'] = $this->model->selectPagosMes($anio,$mes);
			//dep($data['pagosMes']);exit;
			//$data['ventasAnio'] = $this->model->selectVentasAnio($anio);
			//dep($data['ventasAnio']);exit;
			if( $_SESSION['userData']['id_rol'] == RCLIENTES ){
				$this->views->getView($this,"dashboardCliente",$data);
			}else{
				$this->views->getView($this,"dashboard",$data);
			}
		}

		// public function tipoPagoMes(){
		// 	if($_POST){
		// 		$grafica = "tipoPagoMes";
		// 		$nFecha = str_replace(" ","",$_POST['fecha']);
		// 		$arrFecha = explode('-',$nFecha);
		// 		$mes = $arrFecha[0];
		// 		$anio = $arrFecha[1];
		// 		$pagos = $this->model->selectPagosMes($anio,$mes);
		// 		$script = getFile("Template/Modals/graficas",$pagos);
		// 		echo $script;
		// 		die();
		// 	}
		// }
		// public function ventasMes(){
		// 	if($_POST){
		// 		$grafica = "ventasMes";
		// 		$nFecha = str_replace(" ","",$_POST['fecha']);
		// 		$arrFecha = explode('-',$nFecha);
		// 		$mes = $arrFecha[0];
		// 		$anio = $arrFecha[1];
		// 		$pagos = $this->model->selectVentasMes($anio,$mes);
		// 		$script = getFile("Template/Modals/graficas",$pagos);
		// 		echo $script;
		// 		die();
		// 	}
		// }
		// public function ventasAnio(){
		// 	if($_POST){
		// 		$grafica = "ventasAnio";
		// 		$anio = intval($_POST['anio']);
		// 		$pagos = $this->model->selectVentasAnio($anio);
		// 		$script = getFile("Template/Modals/graficas",$pagos);
		// 		echo $script;
		// 		die();
		// 	}
		// }

	}
