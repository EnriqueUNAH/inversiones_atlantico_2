<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
    <link rel="stylesheet" href="assets/css/styles.css">
</head>

<body>
    <?php
    include('db.php');
    session_start();
    $usuario = $_SESSION['us'];
    $_SESSION['usuario'] = $usuario;

    $consulta = "SELECT * FROM tbl_ms_usuarios where usuario = '$usuario'";
    $resultado = mysqli_query($conexion, $consulta);
    $filas = mysqli_num_rows($resultado);

    if ($filas) {
        include('../Login/preguntas_recuperar.php');
    } else {

        echo '<script>Swal.fire("Error", "EL USUARIO NO EXISTE", "error").then(() => {window.location.href = "../../login";});</script>';
    }
    ?>

</body>

</html>