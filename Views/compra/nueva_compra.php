<?php
session_start();
include "conexion.php";
?>

<?php include "includes/scripts.php"; ?>

<?php include "../../Views/Template/header_admin2.php"; ?>


<?php
###############################################################################
// Consulta para obtener los productos
$sql = "SELECT cod_producto, nombre_producto 
FROM tbl_producto 
WHERE cod_tipo_producto = 3
AND NOT EXISTS (
    SELECT 1 
    FROM detalle_temp 
    WHERE detalle_temp.cod_producto = tbl_producto.cod_producto
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
// Consulta para obtener los proveedores
$sql = "SELECT cod_proveedor, nombres 
FROM tbl_proveedor ";
$result = $conection->query($sql);

// Crea un arreglo con los datos obtenidos de la tabla proveedores
$proveedores = array();
while ($row = $result->fetch_assoc()) {
	$proveedores[] = array(
		'cod_proveedor' => $row['cod_proveedor'],
		'nombres' => $row['nombres']
	);
}

// Libera el resultado de la consulta
$result->free();
###############################################################################
?>


<head>
	<meta charset="UTF-8">

	<title>Nueva Compra</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>


	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>

</head>

<body>

	<script>
		function validaNumericos(event) {
			if (event.charCode >= 48 && event.charCode <= 57) {
				return true;
			}
			return false;
		}
	</script>
	 <script>
    //Para que no pueda copiar ni pegar
    function borrarPegado(event) {
      event.preventDefault();
      document.execCommand("insertText", false, "");
    }
  </script>

	<section id="container">

		<!--<div class="title_page">
			<a href="../../compras" class="btn_atras ">
				<h2><i class="fas fa-arrow-left"></i>
					ATRÁS</h2>
			</a> -->

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
				<!-- fecha -->
				<div class="50">
					<label>Fecha</label>
					<input type="text" id="fecha" readonly disabled required>
				</div>

				<?php
				// Obtener la fecha actual en formato Y-m-d
				date_default_timezone_set('America/Guatemala'); // Establece la zona horaria
				$fecha_actual = date('Y-m-d');
				?>

				<script>
					// Rellenar el input con la fecha actual obtenida en PHP
					document.getElementById('fecha').value = '<?php echo $fecha_actual; ?>';
				</script>


				<!-- hora -->
				<div class="wd50">
					<label>Hora</label>
					<input type="text" id="hora" readonly disabled required>

				</div>

				<?php
				// Obtener la hora actual en formato HH:mm:ss
				date_default_timezone_set('America/Guatemala'); // Establece la zona horaria, cámbiala según tu ubicación
				$hora_actual = date('H:i:s');
				?>
				<script>
					// Rellenar el input con la hora actual obtenida en PHP
					document.getElementById('hora').value = '<?php echo $hora_actual; ?>';

					// Actualizar la hora cada segundo (opcional)
					function actualizarHora() {
						var inputHora = document.getElementById('hora');
						var now = new Date();
						var hora = ("0" + now.getHours()).slice(-2);
						var minutos = ("0" + now.getMinutes()).slice(-2);
						var segundos = ("0" + now.getSeconds()).slice(-2);
						var horaCompleta = hora + ":" + minutos + ":" + segundos;
						inputHora.value = horaCompleta;
					}

					setInterval(actualizarHora, 1000); // Actualizar cada segundo
				</script>

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

						<th width="100px">Cantidad</th>
						<th width="100px">Precio</th>
						<th class="textright">Precio Total</th>
						<th class="textright"></th>
					</tr>




					<tr>
						<td hidden><input type="text" name="txt_cod_producto" id="txt_cod_producto"></td>
						<td id="txt_nombre_producto">-</td>
						<td></td>

						<td><input type="text" name="txt_cant_producto" id="txt_cant_producto" value="0" min="1" disabled onkeypress='return validaNumericos(event)' onpaste="return borrarPegado(event)"></td>

						<td><input type="text" name="txt_precio" id="txt_precio" value="0" min="1" disabled onkeypress='return validaNumericos(event)' onpaste="return borrarPegado(event)"></td>

						<!--<td id="txt_precio_total" class="textright"></td> -->
						<td><input type="textright" id="txt_precio_total" placeholder="" readonly></td>
						<td> <a href="#"><i></i> </a></td>
					</tr>

					<script>
						// Función que realiza la multiplicación y muestra el resultado en tiempo real
						function calcularPrecioTotal() {
							var cantidad = parseFloat(document.getElementById('txt_cant_producto').value);
							var precioUnitario = parseFloat(document.getElementById('txt_precio').value);

							// Verificar que ambos campos de entrada contengan números válidos
							if (!isNaN(cantidad) && !isNaN(precioUnitario)) {
								var precioTotal = cantidad * precioUnitario;
								document.getElementById('txt_precio_total').value = precioTotal.toFixed(2); // Mostrar solo 2 decimales
							} else {
								document.getElementById('txt_precio_total').value = "Ingrese Precio y cantidad";
							}
						}

						// Agregar listeners a los campos de entrada para llamar a la función calcularPrecioTotal en cada cambio
						document.getElementById('txt_cant_producto').addEventListener('input', calcularPrecioTotal);
						document.getElementById('txt_precio').addEventListener('input', calcularPrecioTotal);
					</script>



					<tr>
						<th>Código</th>
						<th colspan="2">Descripción</th>
						<th>Cantidad</th>
						<th> Precio </th>
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

	<section id="containerTable">
		<table class="tbl_venta">
			<thead>
				<tr>
					<!-- <td> <a href="#" id="add_product_ventaa" class="link_add"><i class="fas fa-plus"></i> Agregar Producto</a></td> -->
					<th>
						<h4>Seleccione el Proveedor</h4><BR>
						<!---->
						<select name="select_proveedor" id="select_proveedor" class="select-proveedor" style="width: 200px;">
							<option value="">Proveedor</option>
							<?php foreach ($proveedores as $proveedor) : ?>
								<option value="<?php echo $proveedor['cod_proveedor']; ?>"><?php echo $proveedor['nombres']; ?></option>
							<?php endforeach; ?>
						</select>
						<!---->
					</th>
					<!-- <th>
						<h4>Cantidad</h4><BR>
						<input type="num" name="cantidad_producto" id="cantidad_producto" value="1" min="1">
					</th> -->
				</tr>
			</thead>
		</table>
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
<?php include "../../Views/Template/footer_admin2.php"; ?>

</html>