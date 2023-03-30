<?php

session_start();

include "conexion.php";

if (!empty($_POST)) {
	$alert = '';
	if (empty($_POST['nombre']) || empty($_POST['telefono']) || empty($_POST['direccion'])) {
		$alert = '<p class="msg_error">Todos los campos son obligatorios.</p>';
	} else {

		$cod_cliente  = $_POST['id'];
		$rtn        = $_POST['rtn'];
		$nombre     = $_POST['nombre'];
		$telefono   = $_POST['telefono'];
		$direccion  = $_POST['direccion'];

		$result = 0;

		if (is_numeric($rtn) and $rtn != 0) {
			$query = mysqli_query($conection, "SELECT * FROM tbl_cliente
													WHERE (rtn = '$rtn' AND cod_cliente != $cod_cliente)
													");

			$result = mysqli_fetch_array($query);
			$result = count($result);
		}

		if ($result > 0) {
			$alert = '<p class="msg_error">El rtn ya existe, ingrese otro.</p>';
		} else {

			if ($rtn == '') {
				$rtn = 0;
			}

			$sql_update = mysqli_query($conection, "UPDATE cliente
															SET rtn = $rtn, nombre='$nombre',telefono='$telefono',direccion='$direccion'
															WHERE cod_cliente= $cod_cliente ");

			if ($sql_update) {
				$alert = '<p class="msg_save">Cliente actualizado correctamente.</p>';
			} else {
				$alert = '<p class="msg_error">Error al actualizar el cliente.</p>';
			}
		}
	}
}

//Mostrar Datos
if (empty($_REQUEST['id'])) {
	header('Location: lista_clientes.php');
	mysqli_close($conection);
}
$cod_cliente = $_REQUEST['id'];

$sql = mysqli_query($conection, "SELECT *	FROM tbl_cliente WHERE cod_cliente= $cod_cliente and estado=1 ");
mysqli_close($conection);
$result_sql = mysqli_num_rows($sql);

if ($result_sql == 0) {
	header('Location: lista_clientes.php');
} else {

	while ($data = mysqli_fetch_array($sql)) {
		# code...
		$cod_cliente   = $data['cod_cliente'];
		$rtn         = $data['rtn'];
		$nombre      = $data['nombre'];
		$telefono    = $data['telefono'];
		$direccion   = $data['direccion'];
	}
}

?>

<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<?php include "includes/scripts.php"; ?>
	<title>Actualizar Cliente</title>
</head>

<body>
	<?php include "includes/header.php"; ?>
	<section id="container">

		<div class="form_register">
			<h1><i class="far fa-edit"></i> Actualizar cliente</h1>
			<hr>
			<div class="alert"><?php echo isset($alert) ? $alert : ''; ?></div>

			<form action="" method="post">
				<input type="hidden" name="id" value="<?php echo $cod_cliente; ?>">
				<label for="rtn">rtn</label>
				<input type="number" name="rtn" id="rtn" placeholder="Número de rtn" value="<?php echo $rtn; ?>">
				<label for="nombre">Nombre</label>
				<input type="text" name="nombre" id="nombre" placeholder="Nombre completo" value="<?php echo $nombre; ?>">
				<label for="telefono">Teléfono</label>
				<input type="number" name="telefono" id="telefono" placeholder="Teléfono" value="<?php echo $telefono; ?>">
				<label for="direccion">Dirección</label>
				<input type="text" name="direccion" id="direccion" placeholder="Dirección completa" value="<?php echo $direccion; ?>">
				<button type="submit" class="btn_save"><i class="far fa-edit"></i> Actualizar Cliente</button>

			</form>


		</div>


	</section>
	<?php include "includes/footer.php"; ?>
</body>

</html>