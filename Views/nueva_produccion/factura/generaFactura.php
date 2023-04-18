<?php

//print_r($_REQUEST);
//exit;
//echo base64_encode('2');
//exit;
// session_start();
// if (empty($_SESSION['active'])) {
// 	header('location: ../');
// }

include "../conexion.php";
require_once '../pdf/vendor/autoload.php';

use Dompdf\Dompdf;

if (empty($_REQUEST['f'])) {
	echo "No es posible generar detalles.";
} else {
	// $cod_cliente = $_REQUEST['cl'];
	$cod_produccion = $_REQUEST['f'];
	$anulada = '';

	// $query_config   = mysqli_query($conection, "SELECT * FROM configuracion");
	// $result_config  = mysqli_num_rows($query_config);
	// if ($result_config > 0) {
	// 	$configuracion = mysqli_fetch_assoc($query_config);
	// }


	$query = mysqli_query($conection, "SELECT f.cod_produccion,f.cantidad, DATE_FORMAT(f.fecha, '%d/%m/%Y') as fecha, DATE_FORMAT(f.fecha,'%H:%i:%s') as  hora, f.estado,
												v.nombre_usuario as vendedor,
												cl.nombre_producto
										FROM tbl_produccion f	
										INNER JOIN tbl_ms_usuarios v
										ON f.id_usuario = v.id_usuario
										INNER JOIN tbl_producto cl
										ON f.cod_producto = cl.cod_producto
										WHERE f.cod_produccion = $cod_produccion");

	$result = mysqli_num_rows($query);
	if ($result > 0) {
		$logoBinario = file_get_contents('img/logo.png');
		$logoBase64 = base64_encode($logoBinario);

		$anuladoBinario = file_get_contents('img/anulado.png');
		$anuladoBase64 = base64_encode($anuladoBinario);

		$produccion = mysqli_fetch_assoc($query);
		$no_produccion = $produccion['cod_produccion'];

		if ($produccion['estado'] == 2) {
			//$anulada = '<img class="anulada" src="img/anulado.png" alt="Anulada">';
			$anulada = '<img class="anulada" src="data:image/png;base64,' . $anuladoBase64 . '" alt="Anulada">';
		}


		//$logo = '/img/logo.png';
		$query_productos = mysqli_query($conection, "SELECT p.nombre_producto,dt.cantidad FROM tbl_produccion f
		INNER JOIN tbl_detalle_produccion dt
		ON f.cod_produccion = dt.cod_produccion
		INNER JOIN tbl_producto p
		ON dt.cod_producto = p.cod_producto
		WHERE f.cod_produccion = $cod_produccion");
		$result_detalle = mysqli_num_rows($query_productos);

		ob_start();
		include(dirname('__FILE__') . '/factura.php');
		$html = ob_get_clean();

		// instantiate and use the dompdf class
		$dompdf = new Dompdf();

		$dompdf->loadHtml($html);
		// (Optional) Setup the paper size and orientation
		$dompdf->setPaper('letter', 'portrait');
		// Render the HTML as PDF
		$dompdf->render();
		// Output the generated PDF to Browser
		$dompdf->stream('nueva_produccion_' . $cod_produccion . '.pdf', array('Attachment' => 0));
		exit;
	}
}
