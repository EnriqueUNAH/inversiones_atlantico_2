<?php

class Productos extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MPRODUCTO);
	}

	public function Productos()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Productos";
		$data['page_title'] = "PRODUCTOS <small>Inversiones Atlántico</small>";
		$data['page_name'] = "productos";
		$data['page_functions_js'] = "functions_productos.js";
		$this->views->getView($this, "productos", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = (MPRODUCTO);
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO PRODUCTOS";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		 $request_bitacora = $this->model->insertProductoBitacora(
	    	$dateFecha,
		 	$intIdUsuario,
		 	$intIdObjeto,
		 	$strAccion,
		 	$strDescripcion
		 );
	}

	public function setProducto()
	{
		if ($_POST) {
			if (empty($_POST['txtnombre']) || empty($_POST['txtdescripcion']) || empty($_POST['intCantidadMin']) ||
				empty($_POST['intCantidadMax']) || empty($_POST['listTipo']) || empty($_POST['intprecio']) ||
				empty($_POST['listStatus'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');

				/*El siguiente else if, sirve para que valide desde el servidor. Que si se ingresa una letra 
				ya sea mayúscula o minúscula, que permita ingresar los datos.
				Al final está el else que mostrará error en caso de que lo insertado sea un número o caracter especial.*/
			} else {


				$cod_producto = intval($_POST['cod_producto']);
				$strNombreProducto = strtoupper(strClean($_POST['txtnombre']));
				$strDescripcion = strtoupper(strClean($_POST['txtdescripcion']));
				$intCantidadMinima = intval(strClean($_POST['intCantidadMin']));
				$intCantidadMaxima = intval(strClean($_POST['intCantidadMax']));
				$intCodTipoProducto = intval(strClean($_POST['listTipo']));
				$decPrecioVenta = (strClean($_POST['intprecio']));
				$intStatus = (strClean($_POST['listStatus']));
				$request_user = "";


			 if ($intCantidadMaxima < $intCantidadMinima) {
					$arrResponse = array("status" => false, "msg" => 'La cantidad máxima tiene que ser mayor a la mínima.');
			} else {


				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MPRODUCTO); //ESTE VALOR VA A CAMBIAR MAS A DELANTE
				$request_bitacora = "";

				if ($cod_producto == 0) {
					$option = 1; //LA OPCIÓN ES 1, ENTONCES ESTARÁ INSERTANDO

					if ($_SESSION['permisosMod']['w']) {
						$request_user = $this->model->insertProducto(
							$strNombreProducto,
							$strDescripcion,
							$intCantidadMinima,
							$intCantidadMaxima,
							$intCodTipoProducto,
							$decPrecioVenta,
							$intStatus
						);


						//
						//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
						$strAccion = "CREAR";
						$strDescripcion = "CREACIÓN DE PRODUCTO : $strNombreProducto ";

						//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
						$request_bitacora = $this->model->insertProductoBitacora(
							$dateFecha,
							$intIdUsuario,
							$intIdObjeto,
							$strAccion,
							$strDescripcion
						);
					} //FIN DEL IF DE INSERTAR


				} else {
					$option = 2; //SI OPTION ES 2, ENTONCES ESTARÁ ACTUALIZANDO
					if ($_SESSION['permisosMod']['u']) {
						$request_user = $this->model->updateProducto(
							$cod_producto,
							$strNombreProducto,
							$strDescripcion,
							$intCantidadMinima,
							$intCantidadMaxima,
							$intCodTipoProducto,
							$decPrecioVenta,
							$intStatus
						);
					}

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
					$strAccion = "ACTUALIZAR";
					$strDescripcion = "ACTUALIZACIÓN DE PRODUCTO";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertProductoBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} //FIN DEL ELSE PARA ACTUALIZAR

				if ($request_user === 'exist') {
					$arrResponse = array('status' => false, 'msg' => '¡Atención! el producto ya existe, ingrese otro.');
				} else if ($request_user > 0) {
					if ($option == 1) {
						$arrResponse = array('status' => true, 'msg' => 'Datos guardados correctamente.');
					} else {
						$arrResponse = array('status' => true, 'msg' => 'Datos Actualizados correctamente.');
					}
				} else {
					$arrResponse = array("status" => false, "msg" => 'No es posible almacenar los datos.');
				}

			}
		}

			echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}



	public function getProductos()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectProductos();
			for ($i = 0; $i < count($arrData); $i++) {
				$btnView = '';
				$btnEdit = '';
				$btnDelete = '';

				if ($arrData[$i]['estado'] == 1) {
					$arrData[$i]['estado'] = '<span class="badge badge-success">ACTIVO</span>';   //Aqui le asigna Activo si es 1
				} else if ($arrData[$i]['estado'] == 2) {
					$arrData[$i]['estado'] = '<span class="badge badge-danger">INACTIVO</span>';
				} else if ($arrData[$i]['estado'] == 3) {
					$arrData[$i]['estado'] = '<span class="badge badge-success">ACTIVO</span>';
				} else if ($arrData[$i]['estado'] == 4) {
					$arrData[$i]['estado'] = '<span class="badge badge-danger">BLOQUEADO</span>';
				}

				if ($_SESSION['permisosMod']['r']) {
					$btnView = '<button class="btn btn-info btn-sm btnViewProducto" onClick="fntViewProducto(' . $arrData[$i]['cod_producto'] . ')" title="Ver producto"><i class="far fa-eye"></i></button>';
				}

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditProducto" onClick="fntEditProducto(this,' . $arrData[$i]['cod_producto'] . ')" title="Editar producto"><i class="fas fa-pencil-alt"></i></button>';
				} else {
					$btnEdit = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-pencil-alt"></i></button>';
				}

				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelProducto" onClick="fntDelProducto(' . $arrData[$i]['cod_producto'] . ')" title="Eliminar producto"><i class="far fa-trash-alt"></i></button>';
				} else {
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="far fa-trash-alt"></i></button>';
				}
				$arrData[$i]['options'] = '<div class="text-center">' . $btnView . ' ' . $btnEdit . ' ' . $btnDelete . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getProducto($cod_producto)
	{
		if ($_SESSION['permisosMod']['r']) {
			$cod_producto = intval($cod_producto);
			if ($cod_producto > 0) {
				$arrData = $this->model->selectProducto($cod_producto);
				if (empty($arrData)) {
					$arrResponse = array('status' => false, 'msg' => 'Datos no encontrados.');
				} else {
					$arrResponse = array('status' => true, 'data' => $arrData);
				}
				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}
		die();
	}

	public function getSelectTipoProducto()
	{
		$htmlOptions = "";
		$arrData = $this->model->selectTipoProducto();
		if (count($arrData) > 0) {
			for ($i = 0; $i < count($arrData); $i++) {
				//   if ($arrData[$i]['cod_genero'] == 1) {
				$htmlOptions .= '<option value="' . $arrData[$i]['cod_tipo_producto'] . '">' . $arrData[$i]['nombre_tipo_producto'] . '</option>';
				// }
			}
		}
		echo $htmlOptions;
		die();
	}




	public function delProductos()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$cod_producto = intval($_POST['cod_producto']);
				$requestNombreProd = $this->model->selectProducto($cod_producto);
				$requestDelete = $this->model->deleteProductos($cod_producto);
				$nombreProd = $requestNombreProd['nombre_producto'];


				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = (MPRODUCTO);
				$request_bitacora = "";

				if ($requestDelete == 'ok') {
					$arrResponse = array('status' => true, 'msg' => 'Se ha eliminado el producto');

					$strAccion = "ELIMINAR";
					$strDescripcion = "ELIMINACIÓN DE PRODUCTO : $nombreProd ";

					//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertProductoBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else if ($requestDelete == 'exist') {
					$arrResponse = array('statusReferencial' => true, 'msg' => 'No es posible eliminar por Integridad Referencial');
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al eliminar el producto.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);

			}
		}

		die();
	}
}
