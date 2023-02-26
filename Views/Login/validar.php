<?php
include('db.php');

session_start();
$usuario = $_SESSION['us'];
$_SESSION['usuario'] = $usuario;
// echo "El usuario es: " . $usuario;

# Consulto si existe el usuario
$consulta = "SELECT * FROM tbl_ms_usuarios where usuario = '$usuario'";
$resultado = mysqli_query($conexion, $consulta);
$filas = mysqli_num_rows($resultado);

if ($filas) {
    include('../Login/preguntas_recuperar.php');
} else {
    echo '<script>alert("SU USUARIO NO EXISTE");</script>';
    include("login.php");
}
