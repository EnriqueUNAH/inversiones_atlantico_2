<?php

class ProductosModel extends Mysql
{
	private $intIdProducto;
	private $strNombreProducto;
	private $strDescripcion;
	private $intCantidadMinima;
	private $intCantidadMaxima;
	private $intCodTipoProducto;
	private $decPrecioVenta;
	private $strEstado;
	private $intExistencia;


	public function __construct()
	{
		parent::__construct();
	}

	public function insertProducto(string $usuario, string $nombre, string $email, string $password, int $tipoid, int $status)
	{
		$this->strusuario = $usuario;
		$this->strNombre = $nombre;
		$this->strEmail = $email;
		$this->strPassword = $password;
		$this->intTipoId = $tipoid;
		$this->strCreadoPor = $_SESSION['elUsuario'];
		$this->intStatus = $status;
		$return = 0;

		$sql = "SELECT * FROM tbl_ms_usuarios WHERE 
					correo_electronico = '{$this->strEmail}' or usuario = '{$this->strusuario}' ";
		$request = $this->select_all($sql);

		if (empty($request)) {
			$query_insert  = "INSERT INTO tbl_ms_usuarios(usuario,nombre_usuario,correo_electronico,contrasena,id_rol,creado_por,estado) 
								  VALUES(?,?,?,?,?,?,?)";
			$arrData = array(
				$this->strusuario,
				$this->strNombre,
				$this->strEmail,
				$this->strPassword,
				$this->intTipoId,
				$this->strCreadoPor,
				$this->intStatus
			);
			$request_insert = $this->insert($query_insert, $arrData);
			$return = $request_insert;
		} else {
			$return = "exist";
		}
		return $return;
	}



	//Función para que inserte en bitácora cada vez que se agrega un nuevo usuario
	public function insertUsuarioBitacora(string $fecha, int $idUsuario, int $idObjeto, string $accion, string $descripcion)
	{

		$this->dateFecha = $fecha;
		$this->intIdUsuario = $idUsuario;
		$this->intIdObjeto = $idObjeto;
		$this->strAccion = $accion;
		$this->strDescripcion = $descripcion;
		$return = 0;

		$query_insert  = "INSERT INTO tbl_ms_bitacora(fecha,id_usuario,id_objeto,accion,descripcion) 
								  VALUES(?,?,?,?,?)";
		$arrData = array(
			$this->dateFecha,
			$this->intIdUsuario,
			$this->intIdObjeto,
			$this->strAccion,
			$this->strDescripcion,
		);
		$request_insert = $this->insert($query_insert, $arrData);
		$return = $request_insert;

		return $return;
	}

	// public static function evento_bitacora($id_objeto,$id_usuario,$accion,$descripcion)
	// 	{
	// 		   require ('../clases/Conexion.php');

	// 		   		$sql = "INSERT INTO  tbl_ms_bitacora (Id_objeto, id_usuario,Fecha, Accion , Descripcion)
	// 			 VALUES ('$id_objeto', '$id_usuario' , sysdate(), '$accion', '$descripcion')";

	// 		$resultado = $mysqli->query($sql);
	// 	}



	public function selectProductos()
	{
		//$whereAdmin = "";
		// if ($_SESSION['idUser'] != 1) {
		// 	$whereAdmin = " and p.id_usuario != 1 ";
		// }
		$sql = "SELECT p.cod_producto,p.nombre_producto,p.descripcion,p.cantidad_minima,p.cantidad_maxima,
					   p.precio_venta,p.estado,p.foto,tp.nombre_tipo_producto
		FROM tbl_producto p 
		INNER JOIN tbl_tipo_producto tp
		ON p.cod_tipo_producto = tp.cod_tipo_producto";
		$request = $this->select_all($sql);
		return $request;
	}

	public function selectParametros()
	{
		$whereAdmin = "";
		if ($_SESSION['idUser'] != 1) {
			$whereAdmin = " and p.id_usuario != 1 ";
		}
		$sql = "SELECT id_parametro,parametro,valor 
					FROM tbl_ms_parametros
					
					 " . $whereAdmin;
		$request = $this->select_all($sql);
		return $request;
	}





	//Muestra los datos en el botón ver más
	public function selectUsuario(int $id_usuario)
	{
		$this->intIdUsuario = $id_usuario;
		$sql = "SELECT p.id_usuario,p.usuario,p.nombre_usuario,p.preguntas_contestadas,p.correo_electronico,r.id_rol,r.nombrerol,
		p.estado,p.creado_por,p.modificado_por,p.fecha_modificacion, DATE_FORMAT(p.fecha_creacion, '%d-%m-%Y') as fechaRegistro 
					FROM tbl_ms_usuarios p
					INNER JOIN tbl_ms_roles r
					ON p.id_rol = r.id_rol
					WHERE p.id_usuario = $this->intIdUsuario";
		$request = $this->select($sql);
		return $request;
	}





	public function updateUsuario(int $idUsuario, string $usuario, string $nombre, string $email, string $password, int $tipoid, int $estado)
	{

		$this->intIdUsuario = $idUsuario;
		$this->strusuario = $usuario;
		$this->strNombre = $nombre;
		$this->strEmail = $email;
		$this->strPassword = $password;
		$this->intTipoId = $tipoid;
		$this->strModificadoPor = $_SESSION['elUsuario'];
		$this->fechaModificacion = date('Y-m-d H:i:s');
		$this->intStatus = $estado;

		$sql = "SELECT * FROM tbl_ms_usuarios WHERE (correo_electronico = '{$this->strEmail}' AND id_usuario != $this->intIdUsuario)
										  OR (usuario = '{$this->strusuario}' AND id_usuario != $this->intIdUsuario) ";
		$request = $this->select_all($sql);

		if (empty($request)) {
			if ($this->strPassword  != "") {
				$sql = "UPDATE tbl_ms_usuarios SET usuario=?, nombre_usuario=?, correo_electronico=?, contrasena=?, id_rol=?, modificado_por=?, fecha_modificacion=?, estado=? 
							WHERE id_usuario = $this->intIdUsuario ";
				$arrData = array(
					$this->strusuario,
					$this->strNombre,
					$this->strEmail,
					$this->strPassword,
					$this->intTipoId,
					$this->strModificadoPor,
					$this->fechaModificacion,
					$this->intStatus
				);
			} else {
				$sql = "UPDATE tbl_ms_usuarios SET usuario=?, nombre_usuario=?, correo_electronico=?, id_rol=?, modificado_por=?, fecha_modificacion=?, estado=? 
							WHERE id_usuario = $this->intIdUsuario ";
				$arrData = array(
					$this->strusuario,
					$this->strNombre,
					$this->strEmail,
					$this->intTipoId,
					$this->strModificadoPor,
					$this->fechaModificacion,
					$this->intStatus
				);
			}
			$request = $this->update($sql, $arrData);
		} else {
			$request = "exist";
		}
		return $request;
	}
	public function deleteUsuario(int $intid_usuario)
	{
		$this->intIdUsuario = $intid_usuario;

		$sql = "SELECT * FROM tbl_ms_bitacora WHERE id_usuario = $this->intIdUsuario";
		$request = $this->select_all($sql);
		if (empty($request)) {

			$sql = "DELETE FROM tbl_ms_usuarios WHERE id_usuario = $this->intIdUsuario ";
			$request = $this->delete($sql);
			if ($request) {
				$request = 'ok';
			} else {
				$request = 'error';
			}
		} else {
			$request = 'exist';
		}
		return $request;
	}
}
