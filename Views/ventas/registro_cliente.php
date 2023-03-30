<?php
session_start();

include "conexion.php";

if (!empty($_POST)) {
	$alert = '';
	if (empty($_POST['nombre']) || empty($_POST['telefono']) || empty($_POST['direccion'])) {
		$alert = '<p class="msg_error">Todos los campos son obligatorios.</p>';
	} else {

		$rtn         = $_POST['rtn'];
		$nombre      = $_POST['nombre'];
		$telefono    = $_POST['telefono'];
		$direccion   = $_POST['direccion'];
		$usuario_id  = $_SESSION['idUser'];

		$result = 0;

		if (is_numeric($rtn) and $rtn != 0) {
			$query = mysqli_query($conection, "SELECT * FROM tbl_cliente WHERE rtn = '$rtn' ");
			$result = mysqli_fetch_array($query);
		}

		if ($result > 0) {
			$alert = '<p class="msg_error">El número de rtn ya existe.</p>';
		} else {
			$query_insert = mysqli_query($conection, "INSERT INTO cliente(rtn,nombre,telefono,direccion,usuario_id)
														VALUES('$rtn','$nombre','$telefono','$direccion','$usuario_id')");

			if ($query_insert) {
				$alert = '<p class="msg_save">Cliente guardado correctamente.</p>';
			} else {
				$alert = '<p class="msg_error">Error al guardar el cliente.</p>';
			}
		}
	}
	mysqli_close($conection);
}



?>

<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<?php include "includes/scripts.php"; ?>
	<title>Registro Cliente</title>
</head>

<body>
	<?php include "includes/header.php"; ?>
	<section id="container">

		<div class="form_register">
			<h1><i class="fas fa-user-plus"></i> Registro cliente</h1>
			<hr>
			<div class="alert"><?php echo isset($alert) ? $alert : ''; ?></div>

			<form action="" method="post">
				<label for="rtn">rtn</label>
				<input type="number" name="rtn" id="rtn" placeholder="Número de rtn">
				<label for="nombre">Nombre</label>
				<input type="text" name="nombre" id="nombre" placeholder="Nombre completo">
				<label for="telefono">Teléfono</label>
				<input type="number" name="telefono" id="telefono" placeholder="Teléfono">
				<label for="direccion">Dirección</label>
				<input type="text" name="direccion" id="direccion" placeholder="Dirección completa">
				<button type="submit" class="btn_save"><i class="far fa-save fa-lg"></i> Guardar Cliente</button>

			</form>

		</div>


	</section>
	<?php include "includes/footer.php"; ?>
</body>

</html>