<?php
include('db.php');
$usuario = strtoupper($_POST['txtEmailReset']);
session_start();
$_SESSION['usuario'] = $usuario;

# Consulto si existe el usuario
$consulta="SELECT * FROM tbl_ms_usuarios where usuario = '$usuario'";
$resultado= mysqli_query( $conexion , $consulta );
$filas = mysqli_num_rows( $resultado );

if ($filas){
    include('../Login/preguntas_recuperar.php');
}else{
    echo '<script>alert("SU USUARIO NO EXISTE");</script>';
    include ("login.php");
}         
?>




    <!-- The javascript plugin to display page loading on top-->
    <script src="<?= media(); ?>/js/plugins/pace.min.js"></script>
    <script type="text/javascript" src="<?= media();?>/js/plugins/sweetalert.min.js"></script>
    <script src="<?= media(); ?>/js/<?= $data['page_functions_js']; ?>"></script>
