<?php
$subtotal 	= 0;
$isv 	 	= 0;
$impuesto 	= 0;
$tl_snisv   = 0;
$total 		= 0;

?>
<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<title>Factura</title>
	<style>
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
		}

		p,
		label,
		span,
		table {
			font-family: 'BrixSansRegular';
			font-size: 9pt;
		}

		.h2 {
			font-family: 'BrixSansBlack';
			font-size: 16pt;
		}

		.h3 {
			font-family: 'BrixSansBlack';
			font-size: 12pt;
			display: block;
			background: #FFF;
			color: #000000;
			text-align: center;
			padding: 6px;
			margin-bottom: 5px;
		}

		#page_pdf {
			width: 95%;
			margin: 15px auto 10px auto;
		}

		#factura_head,
		#factura_cliente,
		#factura_detalle {
			width: 100%;
			margin-bottom: 10px;
		}



		.logo_factura {
			width: 25%;
		}

		.info_empresa {
			width: 50%;
			text-align: center;
		}







		.info_factura {
			width: 50%;
		}

		#factura_factura {
			width: 100%;
			margin-bottom: 10px;
		}

		.cai {
			display: inline-block;
			margin-left: 20px;
		}

		.round p {
			display: inline-block;
			margin-right: 20px;
		}





		.info_cliente {
			width: 100%;
		}

		.datos_cliente {
			width: 100%;
		}

		.datos_cliente tr td {
			width: 50%;
		}

		.datos_cliente {
			padding: 10px 10px 0 10px;
		}

		.datos_cliente label {
			width: 75px;
			display: inline-block;
		}

		.datos_cliente p {
			display: inline-block;
		}

		.textright {
			text-align: right;
		}

		.textleft {
			text-align: left;
		}

		.textcenter {
			text-align: center;
		}

		.round {
			border-radius: 10px;
			border: 1px solid #0a4661;
			overflow: hidden;
			padding-bottom: 15px;
		}

		.round p {
			padding: 0 15px;
		}

		#factura_detalle {
			border-collapse: collapse;
		}

		#factura_detalle thead th {
			background: #FFF;
			color: #000000;
			padding: 5px;
			border: 1px solid #000000;
		}


		#detalle_productos tr:nth-child(even) {
			background: #ededed;
		}

		#detalle_totales span {
			font-family: 'BrixSansBlack';
		}

		.nota {
			font-size: 8pt;
		}

		.label_gracias {
			font-family: verdana;
			font-weight: bold;
			font-style: italic;
			text-align: center;
			margin-top: 20px;
		}

		.anulada {
			position: absolute;
			left: 50%;
			top: 50%;
			transform: translateX(-50%) translateY(-50%);
		}
	</style>
</head>

<body>
	<?php echo $anulada; ?>
	<div id="page_pdf">
		<table id="factura_head">
			<tr>
				<td class="logo_factura">
					<div>
						<img src="data:image/png;base64,<?php echo $logoBase64; ?>">
					</div>
				</td>
				<td class="info_empresa">
					<?php






					//OBTENER ISV
					$query_isv = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'impuesto'");
					$re_isv = mysqli_fetch_assoc($query_isv);

					//OBTENER NOMBRE EMPRESA
					$query_nombre = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'nombre_empresa'");
					$re_Nombre = mysqli_fetch_assoc($query_nombre);

					//OBTENER RAZON SOCIAL
					$query_razon = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'razon_social'");
					$re_RazonSocial = mysqli_fetch_assoc($query_razon);

					//OBTENER DIRECCIÓN
					$query_direccion = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'direccion'");
					$re_Direccion = mysqli_fetch_assoc($query_direccion);

					//OBTENER RTN
					$query_rtn = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'rtn'");
					$re_RTN = mysqli_fetch_assoc($query_rtn);

					//OBTENER TELÉFONO
					$query_telefono = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'telefono_empresa'");
					$re_Telefono = mysqli_fetch_assoc($query_telefono);

					//OBTENER CORREO
					$query_correo = mysqli_query($conection, "SELECT valor FROM tbl_ms_parametros where parametro = 'admin_correo'");
					$re_Correo = mysqli_fetch_assoc($query_correo);


					//OBTENER LOS VALORES EN VARIABLES
					$r_Nombre = $re_Nombre['valor'];
					$r_RazonSocial = $re_RazonSocial['valor'];
					$r_Direccion = $re_Direccion['valor'];
					$r_RTN = $re_RTN['valor'];
					$r_Telefono = $re_Telefono['valor'];
					$r_Correo = $re_Correo['valor'];

					if ($result_config > 0) {
						$isv = $re_isv['valor'];
					?>
						<div>
							<span class="h2"><?php echo ($r_Nombre); ?></span>
							<p><?php echo ($r_RazonSocial); ?></p>
							<p><?php echo ($r_Direccion); ?></p>
							<p>RTN: <?php echo ($r_RTN); ?></p>
							<p>Teléfono: <?php echo ($r_Telefono); ?></p>
							<p> <?php echo ($r_Correo); ?></p>
						</div>
					<?php
					}
					?>
				</td>

			</tr>

		</table>



		<table id="factura_factura">
			<tr>
				<td class="info_factura">
					<table class="datos_cliente">
						<div class="round">
							<span class="h3">Factura</span>
							<p>No. Factura: <strong><?php echo $factura['numero_factura']; ?></strong></p>
							<p class="cai">CAI: <strong><?php echo $factura['cai']; ?></strong></p>
							<p>Fecha: <?php echo $factura['fecha']; ?></p>
							<p>Hora: <?php echo $factura['hora']; ?></p>
							<p>Vendedor: <?php echo $factura['vendedor']; ?></p>
						</div>
					</table>
				</td>
			</tr>
		</table>



		<table id="factura_cliente">
			<tr>
				<td class="info_cliente">
					<div class="round">
						<span class="h3">Cliente</span>
						<table class="datos_cliente">
							<tr>
								<td><label>RTN:</label>
									<p><?php echo $factura['rtn']; ?></p>
								</td>
								<td><label>Teléfono:</label>
									<p><?php
										if ($factura['telefono'] == 0) {
											echo "";
										} else {
											echo $factura['telefono'];
										}

										?></p>
								</td>
							</tr>
							<tr>
								<td><label>Nombre:</label>
									<p><?php echo $factura['nombres']; ?></p>
								</td>
								<td><label>Dirección:</label>
									<p><?php echo $factura['direccion']; ?></p>
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<table id="factura_detalle">
			<thead>
				<tr>
					<th width="50px">Cant.</th>
					<th class="textleft">Promoción</th>
					<th class="textleft">Descripción</th>
					<th class="textright" width="150px">Precio Unitario.</th>
					<th class="textright" width="150px"> Precio Total</th>
				</tr>
			</thead>
			<tbody id="detalle_productos">

				<?php

				if ($result_detalle > 0) {

					while ($row = mysqli_fetch_assoc($query_productos)) {
				?>
						<tr>
							<td class="textcenter"><?php echo $row['cantidad']; ?></td>
							<td><?php echo $row['promocion']; ?></td>
							<td><?php echo $row['nombre_producto']; ?></td>
							<td class="textright"><?php echo $row['precio_venta']; ?></td>
							<td class="textright"><?php echo $row['precio_total']; ?></td>
						</tr>
				<?php
						$precio_total = $row['precio_total'];
						$subtotal = round($subtotal + $precio_total, 2);
					}
				}
				// $descuento = round($subtotal  / (1 + ($isv / 100)), 2);
				// $sub_total	= round($subtotal  / (1 + ($isv / 100)), 2);
				// $impuesto 	= round($tl_snisv * ($isv / 100), 2);
				// $totalpagar 		= round($tl_snisv + $impuesto, 2);
				if ($query_totales_factura) {
					$fila = mysqli_fetch_assoc($query_totales_factura);
					$descuento = $fila['descuento'];
					$sub_total = $fila['subtotal'];
					$impuesto = $fila['isv'];
					$totalpagar = $fila['totalfactura'];
				}
				?>
			</tbody>
			<tfoot id="detalle_totales">
				<tr>
					<td colspan="3" class="textright"><span>DESCUENTOS </span></td>
					<td class="textright"><span><?php echo "- L." . $descuento; ?></span></td>
				</tr>
				<tr>
					<td colspan="3" class="textright"><span>SUBTOTAL L.</span></td>
					<td class="textright"><span><?php echo $sub_total; ?></span></td>
				</tr>

				<tr>
					<td colspan="3" class="textright"><span>ISV (<?php echo $isv; ?> %)</span></td>
					<td class="textright"><span><?php echo $impuesto; ?></span></td>
				</tr>
				<tr>
					<td colspan="3" class="textright"><span>TOTAL L.</span></td>
					<td class="textright"><span><?php echo $totalpagar; ?></span></td>
				</tr>
			</tfoot>
		</table>
		<div>











			<!-- <p class="nota">Si usted tiene preguntas sobre esta factura, <br>pongase en contacto con nombre, teléfono y Email</p> -->
			<h4 class="label_gracias">LA FACTURA ES BENEFICIO DE TODOS "EXÍJALA"</h4>
		</div>
	</div>
</body>

</html>