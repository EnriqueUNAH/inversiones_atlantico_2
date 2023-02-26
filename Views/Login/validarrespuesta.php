<head>
    <script src="../../Assets/js/plugins/sweetalert.min.js"></script>

</head>
<?php
session_start();
$usuario=$_SESSION['us'];


include('db.php');
$pregunta = ($_POST['pregunta']);
$respuesta = ($_POST['respuesta']);
$id = $id_ = "";

$consultar = mysqli_query($conexion, "SELECT id_pregunta,pregunta FROM tbl_ms_preguntas WHERE pregunta='$pregunta'");
while ($otra = mysqli_fetch_array($consultar)) {
    # code...
    $id = $otra['id_pregunta'];
    $pregunta_ = $otra['pregunta'];
}

$consultar_usuario = mysqli_query($conexion, "SELECT id_usuario FROM tbl_ms_usuarios WHERE usuario='$usuario'");
while ($otra__ = mysqli_fetch_array($consultar_usuario)) {
   # code...
    $id_usuario = $otra__['id_usuario'];
 }

$consultar_ = mysqli_query($conexion, "SELECT id_pregunta,respuesta,id_usuario FROM tbl_ms_preguntas_usuario WHERE respuesta='$respuesta' and id_usuario='$id_usuario'");
while ($otra_ = mysqli_fetch_array($consultar_)) {
    # code...
    $id_ = $otra_['id_pregunta'];
    $respuesta_ = $otra_['respuesta'];
    $id__usuario=$otra_['id_usuario'];
}

if ($id == $id_ && $id__usuario==$id_usuario) {
    # code...
    include('cambiar_contrasena_recu.php');
} else {

    echo '<script>alert("RESPUESTA INCORRECTA");</script>';
    include('../Login/preguntas_recuperar.php');
}
