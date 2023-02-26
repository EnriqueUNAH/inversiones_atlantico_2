<head>
    <script src="../../Assets/js/plugins/sweetalert.min.js"></script>

</head>
<?php
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
/*
$id = 1
$pregunta_ = comidaFavorita
$id_ = 1
$respuesta_ = POLLO
*/

$consultar_ = mysqli_query($conexion, "SELECT id_pregunta,respuesta FROM tbl_ms_preguntas_usuario WHERE respuesta='$respuesta'");
while ($otra_ = mysqli_fetch_array($consultar_)) {
    # code...
    $id_ = $otra_['id_pregunta'];
    $respuesta_ = $otra_['respuesta'];
}

if ($id == $id_) { //FALTA Y ID_USUARIO ES IGUAL A USUARIO (O ALGO ASI)
    # code...
    include('cambiar_contrasena_recu.php');
} else {

    echo '<script>swal({
        title: "ERROR",
        text: "RESPUESTA INCORRECTA",
        type: "error"
    }).then(function() {
        window.location = "preguntas_recuperar.php";
    });</script>';
}
