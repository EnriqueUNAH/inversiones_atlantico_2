<?php
session_start();
include "conexion.php";
?>


<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<?php include "includes/scripts.php"; ?>
	<title>Lista de productos</title>
</head>

<body>
	<?php include "includes/header.php"; ?>
	<section id="container">
		<?php
		$busqueda = '';
		$search_proveedor = '';
		if (empty($_REQUEST['busqueda']) && empty($_REQUEST['proveedor'])) {
			header("location: lista_producto.php");
		}
		if (!empty($_REQUEST['busqueda'])) {
			$busqueda = strtolower($_REQUEST['busqueda']);
			$where = " ( p.cod_producto LIKE '%$busqueda%' OR p.nombre_producto LIKE '%$busqueda%') AND p.estado = 1 ";
			$buscar = 'busqueda=' . $busqueda;
		}


		?>

		<h1><i class="fas fa-cube"></i> Lista de productos</h1>
		<a href="registro_producto.php" class="btn_new btnNewProducto"><i class="fas fa-plus"></i> Registrar producto</a>

		<form action="buscar_productos.php" method="get" class="form_search">
			<input type="text" name="busqueda" id="busqueda" placeholder="Buscar" value="<?php echo $busqueda; ?>">
			<button type="submit" class="btn_search"><i class="fas fa-search"></i></button>
		</form>
		<div class="containerTable">
			<table>
				<tr>
					<th>Código</th>
					<th>Descripción</th>
					<th>Precio</th>
					<th>Existencia</th>
					<th>
						<?php
						$pro = 0;


						$query_proveedor = mysqli_query($conection, "SELECT * FROM proveedor WHERE estado = 1
																ORDER BY proveedor ASC");
						$result_proveedor = mysqli_num_rows($query_proveedor);
						?>
						<select name="proveedor" id="search_proveedor">
							<option value="" selected>PROVEEDOR</option>
							<?php

							while ($proveedor = mysqli_fetch_array($query_proveedor)) {
								if ($pro == $proveedor["codproveedor"]) {
							?>
									<option value="<?php echo $proveedor["codproveedor"]; ?>" selected><?php echo $proveedor["proveedor"] ?></option>
								<?php
								} else {
								?>
									<option value="<?php echo $proveedor["codproveedor"]; ?>"><?php echo $proveedor["proveedor"] ?></option>
							<?php
								}
								# code...
							}

							?>
						</select>

					</th>
					<th>Foto</th>
					<th>Acciones</th>
				</tr>
				<?php
				//Paginador
				$sql_registe = mysqli_query($conection, "SELECT COUNT(*) as total_registro FROM tbl_producto as p
																WHERE $where ");
				$result_register = mysqli_fetch_array($sql_registe);
				$total_registro = $result_register['total_registro'];

				$por_pagina = 50;

				if (empty($_GET['pagina'])) {
					$pagina = 1;
				} else {
					$pagina = $_GET['pagina'];
				}

				$desde = ($pagina - 1) * $por_pagina;
				$total_paginas = ceil($total_registro / $por_pagina);

				$query = mysqli_query($conection, "SELECT p.cod_producto, p.nombre_producto, p.precio, p.existencia, pr.proveedor, p.foto
											FROM tbl_producto p
											INNER JOIN proveedor pr
											ON p.proveedor = pr.codproveedor
											WHERE  $where
											ORDER BY p.cod_producto DESC LIMIT $desde,$por_pagina
				");

				mysqli_close($conection);

				$result = mysqli_num_rows($query);
				if ($result > 0) {

					while ($data = mysqli_fetch_array($query)) {
						if ($data['foto'] != 'img_producto.png') {
							$foto = 'img/uploads/' . $data['foto'];
						} else {
							$foto = 'img/' . $data['foto'];
						}

				?>
						<tr class="row<?php echo $data["cod_producto"]; ?>">
							<td><?php echo $data["cod_producto"]; ?></td>
							<td><?php echo $data["nombre_producto"]; ?></td>
							<td class="celPrecio"><?php echo $data["precio_venta"]; ?></td>
							<td class="celExistencia"><?php echo $data["existencia"]; ?></td>
							<td><?php echo $data["proveedor"]; ?></td>
							<td class="img_producto"><img src="<?php echo $foto; ?>" alt="<?php echo $data["nombre_producto"]; ?>"></td>

							<td>
								<a class="link_add add_product" product="<?php echo $data["cod_producto"]; ?>" href="#"><i class="fas fa-plus"></i> Agregar</a>
								|
								<a class="link_edit" href="editar_producto.php?id=<?php echo $data["cod_producto"]; ?>"><i class="far fa-edit"></i> Editar</a>
								|
								<a class="link_delete del_product" href="#" product="<?php echo $data["cod_producto"]; ?>"><i class="far fa-trash-alt"></i> Eliminar</a>
							</td>

						</tr>
				<?php
					}
				}
				?>


			</table>
		</div>
		<?php
		if ($total_paginas != 0) {
		?>
			<div class="paginador">
				<ul>
					<?php
					if ($pagina != 1) {
					?>
						<li><a href="?pagina=<?php echo 1; ?>&<?php echo $buscar; ?>"><i class="fas fa-step-backward"></i></a></li>
						<li><a href="?pagina=<?php echo $pagina - 1; ?>&<?php echo $buscar; ?>"><i class="fas fa-backward"></i></a></li>
					<?php
					}
					for ($i = 1; $i <= $total_paginas; $i++) {
						# code...
						if ($i == $pagina) {
							echo '<li class="pageSelected">' . $i . '</li>';
						} else {
							echo '<li><a href="?pagina=' . $i . '&' . $buscar . '">' . $i . '</a></li>';
						}
					}

					if ($pagina != $total_paginas) {
					?>
						<li><a href="?pagina=<?php echo $pagina + 1; ?>&<?php echo $buscar; ?>"><i class="fas fa-forward"></i></a></li>
						<li><a href="?pagina=<?php echo $total_paginas; ?>&<?php echo $buscar; ?>"><i class="fas fa-step-forward"></i></a></li>
					<?php } ?>
				</ul>
			</div>
		<?php } ?>

	</section>
	<?php include "includes/footer.php"; ?>
</body>

</html>