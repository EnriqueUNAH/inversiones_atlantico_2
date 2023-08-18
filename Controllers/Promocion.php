<?php

class Promocion extends Controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . base_url() . '/login');
			die();
		}

		getPermisos(MPROMOCION);
	}

	public function Promocion()
	{
		if (empty($_SESSION['permisosMod']['r'])) {
			header("Location:" . base_url() . '/dashboard');
		}
		$data['page_tag'] = "Promocion";
		$data['page_title'] = "PROMOCION <small>Inversiones Atlántico</small>";
		$data['page_name'] = "promocion";
		$data['page_functions_js'] = "functions_promocion.js";
		$this->views->getView($this, "promocion", $data);

		//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
		//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
		$dateFecha = date('Y-m-d H:i:s');
		$intIdUsuario = $_SESSION['idUser'];
		$intIdObjeto = (MPROMOCION);
		$request_bitacora = "";

		$strAccion = "INGRESO";
		$strDescripcion = "INGRESO AL MÓDULO PROMOCIÓN";

		//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
		$request_bitacora = $this->model->insertPromocionBitacora(
			$dateFecha,
			$intIdUsuario,
			$intIdObjeto,
			$strAccion,
			$strDescripcion
		);
	}


	public function setPromocion()
	{
		if ($_POST) {
			if (empty($_POST['txtnombre_promocion']) || empty($_POST['txtfecha_inicio']) || empty($_POST['txtfecha_final']) || empty($_POST['txtprecio_venta'])) {
				$arrResponse = array("status" => false, "msg" => 'Datos incorrectos.');
			} else {
				$cod_promocion = intval($_POST['cod_promocion']);
				$strnombre_promocion = strtoupper(strClean($_POST['txtnombre_promocion']));
				$datefecha_inicio = strClean($_POST['txtfecha_inicio']);
				$datefecha_final = strClean($_POST['txtfecha_final']);
				$intprecio_venta = intval(strClean($_POST['txtprecio_venta']));
				$intStatus = (strClean($_POST['listStatus']));
				$dateFecha = date('Y-m-d H:i:s');
				$request_user = "";

				if ($datefecha_final < $datefecha_inicio) {
					$arrResponse = array("status" => false, "msg" => 'La fecha final tiene que ser mayor a la de inicio.');
				} else {

					//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
					//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
					$dateFecha = date('Y-m-d H:i:s');
					$intIdUsuario = $_SESSION['idUser'];
					$intIdObjeto = (MPROMOCION);                // ([["OJO"]]) HAY QUE CAMBIAR ESTE ID DESPUÉS CUANDO YA AGREGUEMOS TODOS LOS OBJETOS
					$request_bitacora = "";

					if ($cod_promocion == 0) {
						$option = 1; //LA OPCIÓN ES 1, ENTONCES ESTARÁ INSERTANDO

						if ($_SESSION['permisosMod']['w']) {
							$request_user = $this->model->insertPromocion(
								$strnombre_promocion,
								$datefecha_inicio,
								$datefecha_final,
								$intprecio_venta,
								$intStatus

							);

							//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté insertando
							$strAccion = "CREAR";
							$strDescripcion = "CREACIÓN DE PROMOCION";

							//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
							$request_bitacora = $this->model->insertPromocionBitacora(
								$dateFecha,
								$intIdUsuario,
								$intIdObjeto,
								$strAccion,
								$strDescripcion
							);
						} //FIN DEL IF DE INSERTAR
					} else {
						$option = 2; //SI OPTION ES 2, ENTONCES ESTARÁ ACTUALIZANDO


						$arrDatosPromo = $this->model->selectPromocion1($cod_promocion); //Arreglo que obtiene los datos.
						$nombreAnterior = $arrDatosPromo['nombre_promocion']; //Se obtiene el dato del campo.
						$fechaInicioAnterior = $arrDatosPromo['fecha_inicio']; //Se obtiene el dato del campo.
						$fechaFinalAnterior = $arrDatosPromo['fecha_final']; //Se obtiene el dato del campo.
						$precioAnterior = $arrDatosPromo['precio_venta']; //Se obtiene el dato del campo.
						$estadoAnterior = $arrDatosPromo['estado']; //Se obtiene el dato del campo.


						if ($_SESSION['permisosMod']['u']) {
							$request_user = $this->model->updatePromocion(
								$cod_promocion,
								$strnombre_promocion,
								$datefecha_inicio,
								$datefecha_final,
								$intprecio_venta,
								$intStatus
							);
						}

						if ($strnombre_promocion != $nombreAnterior) {
							//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
							$strAccion = "ACTUALIZAR";
							$strDescripcion = "ACTUALIZACIÓN DE PROMOCIÓN: NOMBRE DE PROMOCIÓN ANTERIOR:($nombreAnterior) NOMBRE NUEVO: ($strnombre_promocion) ";

							//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
							$this->model->insertPromocionBitacora(
								$dateFecha,
								$intIdUsuario,
								$intIdObjeto,
								$strAccion,
								$strDescripcion
							);
						}
						$datefecha_inicio2 = date('Y-m-d H:i:s', strtotime($datefecha_inicio));
						if ($datefecha_inicio2 != $fechaInicioAnterior) {
							//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
							$strAccion = "ACTUALIZAR";
							$strDescripcion = "ACTUALIZACIÓN DE PROMOCIÓN:  ($strnombre_promocion) FECHA INICIO ANTERIOR:($fechaInicioAnterior) FECHA NUEVA: ($datefecha_inicio2)  ";

							//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
							$this->model->insertPromocionBitacora(
								$dateFecha,
								$intIdUsuario,
								$intIdObjeto,
								$strAccion,
								$strDescripcion
							);
						}
						$datefecha_final2 = date('Y-m-d H:i:s', strtotime($datefecha_final));
						if ($datefecha_final2 != $fechaFinalAnterior) {
							//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
							$strAccion = "ACTUALIZAR";
							$strDescripcion = "ACTUALIZACIÓN DE PROMOCIÓN:  ($strnombre_promocion) FECHA FINAL ANTERIOR:($fechaFinalAnterior) FECHA NUEVA: ($datefecha_final2)  ";

							//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
							$this->model->insertPromocionBitacora(
								$dateFecha,
								$intIdUsuario,
								$intIdObjeto,
								$strAccion,
								$strDescripcion
							);
						}
						if ($intprecio_venta != $precioAnterior) {
							//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
							$strAccion = "ACTUALIZAR";
							$strDescripcion = "ACTUALIZACIÓN DE PROMOCIÓN:  ($strnombre_promocion) PRECIO DE VENTA ANTERIOR:($precioAnterior) PRECIO NUEVO: ($intprecio_venta)  ";

							//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
							$this->model->insertPromocionBitacora(
								$dateFecha,
								$intIdUsuario,
								$intIdObjeto,
								$strAccion,
								$strDescripcion
							);
						}
						if ($intStatus != $estadoAnterior) {
							//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora 	en caso de que se esté ACTUALIZANDO
							$strAccion = "ACTUALIZAR";

							if ($intStatus == 1) {
								$intStatus = "ACTIVO";
							} else if ($intStatus == 2) {
								$intestado = "INACTIVO";
							}

							if ($estadoAnterior == 1) {
								$estadoAnterior = "ACTIVO";
							} else if ($estadoAnterior == 2) {
								$estadoAnterior = "INACTIVO";
							}

							$strDescripcion = "ACTUALIZACIÓN DE PROMOCIÓN:  ($strnombre_promocion) ESTADO ANTERIOR:($estadoAnterior) ESTADO NUEVO: ($intestado) ";

							//Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
							$request_bitacora = $this->model->insertPromocionBitacora(
								$dateFecha,
								$intIdUsuario,
								$intIdObjeto,
								$strAccion,
								$strDescripcion
							);
						}
					} //FIN DEL ELSE PARA ACTUALIZAR

					if ($request_user === 'exist') {
						$arrResponse = array('status' => false, 'msg' => '¡Atención! la promoción ya existe, ingrese otra.');
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



	public function getPromocion()
	{
		if ($_SESSION['permisosMod']['r']) {
			$arrData = $this->model->selectPromocion();
			for ($i = 0; $i < count($arrData); $i++) {

				$btnEdit = '';
				$btnDelete = '';

				if ($_SESSION['permisosMod']['u']) {
					$btnEdit = '<button class="btn btn-primary  btn-sm btnEditPromocion" onClick="fntEditPromocion(this,' . $arrData[$i]['cod_promocion'] . ')" title="Editar promocion"><i class="fas fa-pencil-alt"></i></button>';
				}

				if ($_SESSION['permisosMod']['d']) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelPromocion" onClick=" fntDelPromocion(' . $arrData[$i]['cod_promocion'] . ')" title="Anular promocion"><i class="fas fa-ban"></i></button>';
				} else {
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-ban"></i></button>';
				}
				if ($arrData[$i]['estado'] == 1) {
					$btnDelete = '<button class="btn btn-danger btn-sm btnDelPromocion" onClick=" fntDelPromocion(' . $arrData[$i]['cod_promocion'] . ')" title="Anular promocion"><i class="fas fa-ban"></i></button>';

					$arrData[$i]['estado'] = '<span class="badge badge-success">ACTIVO</span>';   //Aqui le asigna Activo si es 1
				} else if ($arrData[$i]['estado'] == 2) {
					$arrData[$i]['estado'] = '<span class="badge badge-danger">INACTIVO</span>';
					$btnDelete = '<button class="btn btn-secondary btn-sm" disabled ><i class="fas fa-ban"></i></button>';
				}




				$arrData[$i]['options'] = '<div class="text-center">' . $btnEdit . ' ' . $btnDelete . '</div>';
			}
			echo json_encode($arrData, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	public function getPromocion1($cod_promocion)
	{
		if ($_SESSION['permisosMod']['r']) {
			$cod_promocion = intval($cod_promocion);
			if ($cod_promocion > 0) {
				$arrData = $this->model->selectPromocion1($cod_promocion);
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


	public function delPromocion()
	{
		if ($_POST) {
			if ($_SESSION['permisosMod']['d']) {
				$cod_promocion = intval($_POST['cod_promocion']);
				$arrDatosPromocion = $this->model->selectPromocion1($cod_promocion);
				$requestDelete = $this->model->deletePromocion($cod_promocion);
				$nombrePromocion = $arrDatosPromocion['nombre_promocion'];


				//Estas variables almacenan los valores que se van a ingresar a la tabla bitátora
				//SE PUEDEN USAR PARA INSERTAR O ACTUALIZAR PORQUE SERÍAN LOS MISMOS DATOS
				$dateFecha = date('Y-m-d H:i:s');
				$intIdUsuario = $_SESSION['idUser'];
				$intIdObjeto = 2;
				$request_bitacora = "";



				if ($requestDelete) {


					$arrResponse = array('status' => true, 'msg' => 'Se ha anulado la promocion');

					$strAccion = "ANULAR";
					$strDescripcion = "SE ANULÓ LA PROMOCIÓN: $nombrePromocion";

					// //Manda al modelo los parámetros para que se encargue de insertar en la tabla Bitácora
					$request_bitacora = $this->model->insertPromocionBitacora(
						$dateFecha,
						$intIdUsuario,
						$intIdObjeto,
						$strAccion,
						$strDescripcion
					);
				} else {
					$arrResponse = array('status' => false, 'msg' => 'Error al anular la promocion.');
				}

				echo json_encode($arrResponse, JSON_UNESCAPED_UNICODE);
			}
		}

		die();
	}
}
