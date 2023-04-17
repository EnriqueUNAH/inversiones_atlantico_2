<?php
include "conexion.php";
session_start();

?>

<?php include "includes/scripts.php"; ?>


<!DOCTYPE html>
<html lang="es">
<?php

###############################################################################
// Consulta para obtener los productos
$sql = "SELECT cod_producto, nombre_producto 
FROM tbl_producto 
WHERE cod_tipo_producto = 4 
AND NOT EXISTS (
    SELECT 1 
    FROM detalle_temp_pr 
    WHERE detalle_temp_pr.cod_producto = tbl_producto.cod_producto
);
"; //Cuando sea un PRODUCTO TERMINADO Y NO EXISTA EN DETALLE_TEMP
//OJO, puede que se cambie el 4 si se cambia algo en la Base de Datos.
$result = $conection->query($sql);

// Crea un arreglo con los datos obtenidos de la tabla productos
$productos = array();
while ($row = $result->fetch_assoc()) {
	$productos[] = array(
		'cod_producto' => $row['cod_producto'],
		'nombre_producto' => $row['nombre_producto']
	);
}

// Libera el resultado de la consulta
$result->free();
###############################################################################

###############################################################################
// Consulta para obtener los insumos
$sql = "SELECT cod_producto, nombre_producto 
FROM tbl_producto 
WHERE cod_tipo_producto = 3 
AND NOT EXISTS (
    SELECT 1 
    FROM detalle_temp_pr 
    WHERE detalle_temp_pr.cod_producto = tbl_producto.cod_producto
);
"; //Cuando sea un PRODUCTO TERMINADO Y NO EXISTA EN DETALLE_TEMP
//OJO, puede que se cambie el 4 si se cambia algo en la Base de Datos.
$result = $conection->query($sql);

// Crea un arreglo con los datos obtenidos de la tabla productos
$insumos = array();
while ($row = $result->fetch_assoc()) {
	$insumos[] = array(
		'cod_producto' => $row['cod_producto'],
		'nombre_producto' => $row['nombre_producto']
	);
}

// Libera el resultado de la consulta
$result->free();
###############################################################################

###############################################################################
// Consulta para obtener las promociones
$sql_p = "SELECT cod_promocion, nombre_promocion FROM tbl_promocion";
$result_p = $conection->query($sql_p);

// Crea un arreglo con los datos obtenidos de la tabla promocion
$promocions = array();
while ($row_p = $result_p->fetch_assoc()) {
	$promocions[] = array(
		'cod_promocion' => $row_p['cod_promocion'],
		'nombre_promocion' => $row_p['nombre_promocion']
	);
}

// Libera el resultado de la consulta
$result_p->free();
###############################################################################


?>

<head>
	<meta charset="UTF-8">

	<title>Nueva Producción</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>




</head>

<body>







	<div class="containerTable">
		<div class="title_page">
			<a href="../../produccion" class="btn_atras ">
				<h2><i class="fas fa-arrow-left"></i>
					ATRÁS</h2>
			</a>

		</div>
		<div class="title_page">

			<h1><i class=""></i> Nueva Producción</h1>
		</div>

		<div class="datos_venta">
			<h4>Datos de Producción</h4>
			<div class="datos">
				<div class="wd50">
					<label>Usuario</label>
					<!--En la siguiente linea debo colocar la variable de sesion de quien ingreso-->
					<p><?php echo ($_SESSION['userData']['nombre_usuario']); ?></p>

				</div>
				<div class="wd50">
					<label>Acciones</label>
					<div id="acciones_venta">
						<a href="#" class="btn_ok textcenter" id="btn_anular_venta"><i class="fas fa-ban"></i> Cancelar</a>
						<a href="#" class="btn_new textcenter" id="btn_facturar_venta" style="display: none;"><i class="far fa-edit"></i> Enviar a Producción</a>
					</div>
				</div>
			</div>
		</div>

		<table class="tbl_venta">
			<thead>

				<tr>

					<!-- <td> <a href="#" id="add_product_ventaa" class="link_add"><i class="fas fa-plus"></i> Agregar Producto</a></td> -->

					<th>
						<h4>Seleccione el Producto a Producir</h4><BR>
						<!---->
						<select name="select_producto" id="select_productffo" class="select-productfo" style="width: 200px;">
							<option value="">Productos</option>
							<?php foreach ($productos as $producto) : ?>
								<option value="<?php echo $producto['cod_producto']; ?>"><?php echo $producto['nombre_producto']; ?></option>
							<?php endforeach; ?>
						</select>

						<!---->

					</th>


					<th>
						<h4>Cantidad</h4><BR>
						<input type="num" name="txt_cantidad_producto" id="txt_cantidad_producto" value="1" min="1">
					</th>


				</tr>
			</thead>
		</table>
	</div>












	<section id="container">




		<div class="containerTable">
			<table class="tbl_venta">


				<thead>

					<tr>

						<td> <a href="#" id="add_product_venta" class="link_add"><i class="fas fa-plus"></i> Agregar</a></td>
						<th>
							<h4>Seleccione los Insumos Necesarios</h4><BR>
							<!---->
							<select name="select_producto" id="select_producto" class="select-producto" style="width: 200px;">
								<option value="">Insumos</option>
								<?php foreach ($insumos as $insumo) : ?>
									<option value="<?php echo $insumo['cod_producto']; ?>"><?php echo $insumo['nombre_producto']; ?></option>
								<?php endforeach; ?>
							</select>
							<!---->

						</th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>

					</tr>


					<tr>
						<th>Descripción</th>
						<th></th>
						<th></th>
						<th>Existencia</th>
						<th width="100px">Cantidad</th>
						<th class="textright"></th>
					</tr>


					<tr>
						<td hidden><input type="text" name="txt_cod_producto" id="txt_cod_producto"></td>
						<td id="txt_nombre_producto">-</td>
						<td></td>
						<td></td>
						<td id="txt_existencia">-</td>
						<td><input type="text" name="txt_cant_producto" id="txt_cant_producto" value="0" min="1" disabled></td>

						<td> <a href="#"><i></i> </a></td>
					</tr>
					<tr>
						<th>Código</th>
						<th colspan="2">Descripción</th>
						<!-- <th></th> -->
						<th>Cantidad</th>
						<th> Eliminar</th>
					</tr>
				</thead>



				<tbody id="detalle_venta">
					<!-- CONTENIDO AJAX -->
				</tbody>
				<tfoot id="detalle_totales">
					<!-- CONTENIDO AJAX -->
				</tfoot>
			</table>

		</div>
	</section>


	<!-- Sirve para buscar el nombre del producto dentro del select -->
	<!-- <script>
		$(document).ready(function() {
			$('.select-producto').select2({
				placeholder: 'Productos',
				allowClear: true,
				language: {
					noResults: function() {
						return 'No se encontraron resultados';
					}
				}
			});
		});
	</script> -->
	<!-- Sirve para buscar el nombre del producto dentro del select -->
	<!-- SIN PLACE HOLDER -->
	<script>
		$(document).ready(function() {
			$('.select-producto').select2({
				allowClear: true,
				language: {
					noResults: function() {
						return 'No se encontraron resultados';
					}
				}
			});
		});
	</script>


	<script type="text/javascript">
		$(document).ready(function() {
			var usuarioid = '<?php echo $_SESSION['idUser']; ?>';
			serchForDetalle(usuarioid);

		});
	</script>

</body>

</html>