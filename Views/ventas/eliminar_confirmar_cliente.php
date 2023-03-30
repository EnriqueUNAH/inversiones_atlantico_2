<?php
session_start();
if ($_SESSION['rol'] != 1 and $_SESSION['rol'] != 2) {
	header("location: ./");
}
include "conexion.php";

if (!empty($_POST)) {
	if (empty($_POST['cod_cliente'])) {
		header("location: lista_clientes.php");
		mysqli_close($conection);
	}

	$cod_cliente = $_POST['cod_cliente'];

	//$query_delete = mysqli_query($conection,"DELETE FROM usuari WHERE idusuario =$idusuario ");
	$query_delete = mysqli_query($conection, "UPDATE cliente SET estado = 0 WHERE cod_cliente = $cod_cliente ");
	mysqli_close($conection);
	if ($query_delete) {
		header("location: lista_clientes.php");
	} else {
		echo "Error al eliminar";
	}
}




if (empty($_REQUEST['id'])) {
	header("location: lista_clientes.php");
	mysqli_close($conection);
} else {

	$cod_cliente = $_REQUEST['id'];

	$query = mysqli_query($conection, "SELECT * FROM tbl_cliente	WHERE cod_cliente = $cod_cliente ");
	mysqli_close($conection);
	$result = mysqli_num_rows($query);

	if ($result > 0) {
		while ($data = mysqli_fetch_array($query)) {
			# code...
			$rtn    = $data['rtn'];
			$nombre = $data['nombre'];
		}
	} else {
		header("location: lista_clientes.php");
	}
}


?>

<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<?php include "includes/scripts.php"; ?>
	<title>Eliminar Cliente</title>
</head>

<body>
	<?php include "includes/header.php"; ?>
	<section id="container">
		<div class="data_delete">
			<i class="fas fa-user-times fa-7x" style="color: #e66262"></i>
			<br><br>
			<h2>¿Está seguro de eliminar el siguiente registro?</h2>
			<p>Nombre del Cliente: <span><?php echo $nombre; ?></span></p>
			<p>rtn: <span><?php echo $rtn; ?></span></p>

			<form method="post" action="">
				<input type="hidden" name="cod_cliente" value="<?php echo $cod_cliente; ?>">
				<a href="lista_clientes.php" class="btn_cancel"><i class="fas fa-ban"></i> Cancelar</a>
				<button type="submit" class="btn_ok"><i class="far fa-trash-alt"></i> Eliminar</button>
			</form>
		</div>


	</section>
	<?php include "includes/footer.php"; ?>
</body>

</html>