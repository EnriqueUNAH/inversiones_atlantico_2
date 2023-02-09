<?php
include('db.php');
$pregunta=($_POST[ 'pregunta' ]);
$respuesta = ($_POST[ 'respuesta' ]);
$id=$id_="";

$consultar = mysqli_query( $conexion , "SELECT id_pregunta,pregunta FROM tbl_ms_preguntas WHERE pregunta='$pregunta'" );
while ($otra=mysqli_fetch_array( $consultar )) {
    # code...
    $id=$otra['id_pregunta'];
    $pregunta_=$otra['pregunta'];
}


$consultar_ = mysqli_query( $conexion , "SELECT id_pregunta,respuesta FROM tbl_ms_preguntas_usuario WHERE respuesta='$respuesta'" );
while ($otra_=mysqli_fetch_array( $consultar_ )) {
    # code...
    $id_=$otra_['id_pregunta'];
    $respuesta_=$otra_['respuesta'];
}

if ($id==$id_) {
    # code...
    include('cambiar_contrasena_recu.php');
}else{
    echo '<script>alert("RESPUESTA INCORRECTA");</script>';
    include('preguntas_recuperar.php');
}
?>