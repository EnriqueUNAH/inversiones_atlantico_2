<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>

	<!-- Para las alertas -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
	<!-- Para las alertas -->

	<link rel="stylesheet" href="assets/css/styles.css">


</head>

<body></body>

</html>


<?php
include '../php/Connet.php';


$restorePoint = SGBD::limpiarCadena($_POST['restorePoint']);
$sql = explode(";", file_get_contents($restorePoint));
$totalErrors = 0;
set_time_limit(60);
$con = mysqli_connect(SERVER, USER, PASS, BD);
$con->query("SET FOREIGN_KEY_CHECKS=0");
for ($i = 0; $i < (count($sql) - 1); $i++) {
	if ($con->query($sql[$i] . ";")) {
	} else {
		$totalErrors++;
	}
}
$con->query("SET FOREIGN_KEY_CHECKS=1");
$con->close();
if ($totalErrors <= 0) {
	// echo "Restauración completada con éxito";
	//header("location:../php/index.php"); 
	echo '<script>
		Swal.fire({
			icon: "success",
			title: "Restauración Exitosa",
			showConfirmButton: true,
		}).then(() => {
			window.location.href = "../php/index.php";
		});
	</script>';
?>


<?php
} else {
	echo "Ocurrio un error inesperado, no se pudo hacer la restauración completamente";
}
