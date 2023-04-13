<?php
session_start();
include "conexion.php";
?>

<?php include "includes/scripts.php"; ?>

<!DOCTYPE html>
<html lang="es">
<?php


// Haz la consulta
$sql = "SELECT cod_producto, nombre_producto FROM tbl_producto";
$result = $conection->query($sql);

// Crea un arreglo con los datos obtenidos de la base de datos
$productos = array();
while ($row = $result->fetch_assoc()) {
	$productos[] = array(
		'cod_producto' => $row['cod_producto'],
		'nombre_producto' => $row['nombre_producto']
	);
}

// Libera el resultado de la consulta
$result->free();
?>

<head>
	<meta charset="UTF-8">

	<title>Nueva Compra</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>




</head>

<body>


	<section id="container">

		<div class="title_page">
			<a href="../../compras" class="btn_atras ">
				<h2><i class="fas fa-arrow-left"></i>
					ATRÁS</h2>
			</a>

		</div>
		<div class="title_page">
			<h1><i class="fas fa-cube"></i> Nueva Compra</h1>
		</div>
		<!--
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
					<input type="text" name="rtn_cliente" id="rtn_cliente">
				</div>
				<div class="wd30">
					<label>Nombre</label>
					<input type="text" name="nom_cliente" id="nom_cliente" disabled required>
				</div>
				<div class="wd30">
					<label>Teléfono</label>
					<input type="number" name="tel_cliente" id="tel_cliente" disabled required>
				</div>
				<div class="wd100">
					<label>Dirección</label>
					<input type="text" name="dir_cliente" id="dir_cliente" disabled required>
				</div>
				<div id="div_registro_cliente" class="wd100">
					<button type="submit" class="btn_save"><i class="far fa-save fa-lg"></i> Guardar</button>
				</div>
			</form>
		</div> -->

		<div class="datos_venta">
			<h4>Datos de Compra</h4>
			<div class="datos">
				<div class="wd50">
					<label>Comprador</label>
					<!--En la siguiente linea debo colocar la variable de sesion de quien ingreso-->
					<p><?php echo ($_SESSION['userData']['nombre_usuario']); ?></p>

				</div>
				<div class="wd50">
					<label>Acciones</label>
					<div id="acciones_venta">
						<a href="#" class="btn_ok textcenter" id="btn_anular_venta"><i class="fas fa-ban"></i> Cancelar</a>
						<a href="#" class="btn_new textcenter" id="btn_facturar_compra" style="display: none;"><i class="far fa-edit"></i> Comprar</a>
					</div>
				</div>
			</div>
		</div>
		<div class="containerTable">
			<table class="tbl_venta">
				<thead>



					<tr>

						<th>
							<!---->
							<select name="select_producto_c" id="select_producto_c" class="select-producto" style="width: 200px;">
								<option value="">Seleccione un producto</option>
								<?php foreach ($productos as $producto) : ?>
									<option value="<?php echo $producto['cod_producto']; ?>"><?php echo $producto['nombre_producto']; ?></option>
								<?php endforeach; ?>
							</select>
							<!---->



						<td> <a href="#" id="add_product_venta" class="link_add"><i class="fas fa-plus"></i> Agregar</a></td>
						</th>
					</tr>

					<tr>
						<th hidden width="100px">Código</th>
						<th>Descripción</th>
						<th></th>
						<th>Existencia</th>
						<th width="100px">Cantidad</th>
						<th class="textright">Precio</th>
						<th class="textright">Precio Total</th>
						<th class="textright"></th>
					</tr>


					<tr>
						<td hidden><input type="text" name="txt_cod_producto" id="txt_cod_producto"></td>
						<td id="txt_nombre_producto">-</td>
						<td></td>
						<td id="txt_existencia">-</td>
						<td><input type="text" name="txt_cant_producto" id="txt_cant_producto" value="0" min="1" disabled></td>

						<td><input type="text" name="txt_precio" id="txt_precio" min="1" disabled></td>


						<td id="txt_precio_total" class="textright">0.00</td>
						<td> <a href="#"><i></i> </a></td>
					</tr>
					<tr>
						<th>Código</th>
						<th colspan="2">Descripción</th>
						<th>Cantidad</th>
						<th class="textright">Precio</th>
						<th class="textright">Precio Total</th>
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
	<script>
		$(document).ready(function() {
			$('.select-producto').select2({
				placeholder: 'Seleccione un producto',
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