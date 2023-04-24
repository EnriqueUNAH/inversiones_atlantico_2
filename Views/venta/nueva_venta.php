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
    FROM detalle_temp 
    WHERE detalle_temp.cod_producto = tbl_producto.cod_producto 
    AND (detalle_temp.promo IS NULL OR detalle_temp.promo = '')
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
// Consulta para obtener las promociones
$sql_p = "SELECT cod_promocion, nombre_promocion FROM tbl_promocion where estado = 1";
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


###############################################################################
// Consulta para obtener las promociones
$sql_d = "SELECT cod_descuento, nombre_descuento, porcentaje_descuento FROM tbl_descuento";
$result_d = $conection->query($sql_d);

// Crea un arreglo con los datos obtenidos de la tabla promocion
$descuentos = array();
while ($row_d = $result_d->fetch_assoc()) {
	$descuentos[] = array(
		'cod_descuento' => $row_d['cod_descuento'],
		'nombre_descuento' => $row_d['nombre_descuento'],
		'porcentaje_descuento' => $row_d['porcentaje_descuento']
	);
}

// Libera el resultado de la consulta
$result_d->free();
###############################################################################

?>

<head>
	<meta charset="UTF-8">

	<title>Nueva Venta</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

	<!-- Para las alertas -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
	<!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> -->

	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>

</head>

<body>








	<div class="container">
		<div class="left-column">


			<section id="container">


				<div class="title_page">
					<a href="../../ventas" class="btn_atras ">
						<h2><i class="fas fa-arrow-left"></i>
							ATRÁS</h2>
					</a>
					<h1><i class=""></i> Nueva Venta</h1>
				</div>





				<div class="datos_venta">
					<h4>Datos de Venta</h4>
					<div class="datos">
						<div class="wd50">
							<label>Vendedor</label>
							<!--En la siguiente linea debo colocar la variable de sesion de quien ingreso-->
							<p><?php echo ($_SESSION['userData']['nombre_usuario']); ?></p>

						</div>
						<div class="wd50">
							<label>Acciones</label>
							<div id="acciones_venta">
								<a href="#" class="btn_ok textcenter" id="btn_anular_venta"><i class="fas fa-ban"></i> Cancelar</a>
								<a href="#" class="btn_new textcenter" id="btn_facturar_venta" style="display: none;"><i class="far fa-edit"></i> Facturar</a>



							</div>
						</div>
					</div>
				</div>
				<div class="containerTable">
					<table class="tbl_venta">
						<thead>



							<tr>

								<td> <a href="#" id="add_product_venta" class="link_add"><i class="fas fa-plus"></i> Agregar Producto</a></td>
								<th>
									<!---->
									<select name="select_producto" id="select_producto" class="select-producto" style="width: 200px;">
										<option value="">Productos</option>
										<?php foreach ($productos as $producto) : ?>
											<option value="<?php echo $producto['cod_producto']; ?>"><?php echo $producto['nombre_producto']; ?></option>
										<?php endforeach; ?>
									</select>
									<!---->

								</th>



								<td> <a href="#" id="add_promocion_venta" class="link_add"><i class="fas fa-plus"></i> Agregar Promoción</a></td>
								<th>
									<!---->
									<select name="select_promocion" id="select_promocion" class="select-promocion" style="width: 200px;">
										<option value="">Promociones</option>
										<?php foreach ($promocions as $promocion) : ?>
											<option value="<?php echo $promocion['cod_promocion']; ?>"><?php echo $promocion['nombre_promocion']; ?></option>
										<?php endforeach; ?>
									</select>
									<!---->

								</th>





								<td> <a href="#" id="add_descuento" class="link_add"><i class="fas fa-plus"></i> Agregar Descuento</a></td>
								<th>
									<!---->
									<select name="select_descuento" id="select_descuento" class="select-descuento" style="width: 200px;">
										<option value="">Descuentos</option>
										<?php foreach ($descuentos as $descuento) : ?>
											<option value="<?php echo $descuento['cod_descuento']; ?>"><?php echo $descuento['nombre_descuento'] . ' (' . $descuento['porcentaje_descuento'] . '%)'; ?></option>
										<?php endforeach; ?>
									</select>
									<!---->

								</th>






							</tr>




							<tr>
								<th hidden width="100px">Código</th>
								<th>Descripción</th>
								<th></th>
								<th></th>
								<th>Existencia</th>
								<th width="100px">Cantidad</th>
								<th class="textright">Precio</th>
								<th class="textright">Total</th>
								<th class="textright"></th>
							</tr>


							<tr>
								<td hidden><input type="text" name="txt_cod_promocion" id="txt_cod_promocion"></td>
								<td hidden><input type="text" name="txt_cod_producto" id="txt_cod_producto"></td>
								<td hidden><input type="text" name="txt_cod_descuento" id="txt_cod_descuento"></td>
								<td id="txt_nombre_producto">-</td>
								<td></td>
								<td></td>
								<td id="txt_existencia">-</td>
								<td><input type="text" name="txt_cant_producto" id="txt_cant_producto" value="0" min="1" disabled></td>
								<td id="txt_precio" class="textright">0.00</td>
								<td id="txt_precio_total" class="textright">0.00</td>
								<td> <a href="#"><i></i> </a></td>
							</tr>
							<tr>

								<th colspan="2">Promoción</th>
								<th colspan="2">Descripción</th>
								<th>Cantidad</th>
								<th class="textright">Precio</th>
								<th class="textright">Total</th>
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

			<!-- Termina parte izquierda -->
		</div>
		<!-- Termina parte izquierda -->




		<div class="right-column">
			<section>
				<div class="datos_cliente">
					<div class="action_cliente">
						<h4>Datos del Cliente</h4>
						<a href="#" class="btn_new btn_new_cliente"><i class="fas fa-plus"></i> Nuevo cliente</a>
					</div>
					<form name="form_new_cliente_venta" id="form_new_cliente_venta" class="datos">
						<input type="hidden" name="action" value="addCliente">
						<input type="hidden" id="cod_cliente" name="cod_cliente" value="" required>
						<div class="wd30">
							<label>RTN</label>
							<input type="text" name="rtn_cliente" id="rtn_cliente" required maxlength="14" oninput="validarNumeros(this)">
						</div>


						<div class="wd30">
							<label>Nombre</label>
							<input type="text" name="nom_cliente" id="nom_cliente" oninput="this.value = this.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ]/g, '').toUpperCase()" disabled required>
						</div>

						<div class="wd30">
							<label>Teléfono</label>
							<input type="text" name="tel_cliente" id="tel_cliente" pattern="[1-9]{1}[0-9]{7}" title="Debes ingresar 8 dígitos que no sean todos ceros" required maxlength="8">
						</div>

						<div class="wd100">
							<label>Dirección</label>
							<input type="text" name="dir_cliente" id="dir_cliente" oninput="this.value = this.value.toUpperCase()" disabled required>
						</div>

						<div id="div_registro_cliente" class="wd100">
							<button type="submit" class="btn_save"><i class="far fa-save fa-lg"></i> Guardar</button>
						</div>
					</form>
				</div>


			</section>







			<!-- Termina parte derecha -->
		</div>
	</div>

	<!-- Termina parte derecha -->

















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
	<script>
		function validarNumeros(input) {
			var regex = /^[0-9]+$/;
			if (!regex.test(input.value)) {
				input.setCustomValidity("Solo se permiten números.");
			} else {
				input.setCustomValidity("");
			}
		}
	</script>

</body>

</html>