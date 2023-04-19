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
	$cod_inventario = $_REQUEST['f'];
	$anulada = '';

	$query_config   = mysqli_query($conection, "SELECT * FROM configuracion");
	$result_config  = mysqli_num_rows($query_config);
	if ($result_config > 0) {
		$configuracion = mysqli_fetch_assoc($query_config);
	}


	$query = mysqli_query($conection, " SELECT   
	p.nombre_producto, 
	tm.nombre_movimiento,
	k.fecha, k.cantidad
  FROM 
	tbl_producto p
	INNER JOIN  tbl_kardex k
	  ON k.cod_producto = p.cod_producto 
	INNER JOIN tbl_tipo_movimiento tm
	  ON k.cod_tipo_movimiento = tm.cod_tipo_movimiento
  WHERE 
	k.cod_producto = $cod_inventario;");

	$result = mysqli_num_rows($query);
	if ($result > 0) {
		$logoBinario = file_get_contents('img/logo.png');
		$logoBase64 = base64_encode($logoBinario);

		$anuladoBinario = file_get_contents('img/anulado.png');
		$anuladoBase64 = base64_encode($anuladoBinario);

		// $inventario = mysqli_fetch_assoc($query);
		// $cod_iinventario = $inventario['cod_producto'];

		// if ($inventario['estado'] == 2) {
		// 	//$anulada = '<img class="anulada" src="img/anulado.png" alt="Anulada">';
		// 	$anulada = '<img class="anulada" src="data:image/png;base64,' . $anuladoBase64 . '" alt="Anulada">';
		// }


		//$logo = '/img/logo.png';
		$query_productos = mysqli_query($conection, " SELECT   
		p.nombre_producto, 
		tm.nombre_movimiento,
		k.fecha, k.cantidad
	  FROM 
		tbl_producto p
		INNER JOIN  tbl_kardex k
		  ON k.cod_producto = p.cod_producto 
		INNER JOIN tbl_tipo_movimiento tm
		  ON k.cod_tipo_movimiento = tm.cod_tipo_movimiento
	  WHERE 
		k.cod_producto = $cod_inventario");
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
		$dompdf->stream('inventario_' . $cod_inventario . '.pdf', array('Attachment' => 0));
		exit;
	}
}
