<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
	
    <!-- Para las alertas -->
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
	    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
    <!-- Para las alertas -->
    
    <link rel="stylesheet" href="assets/css/styles.css">


</head>

<body></body>

</html>

<?php
include('db.php');
session_start();
// $usuario = $_SESSION['usuario'];
$usuario = $_SESSION['usuarioNuevo'];



$hash = hash("SHA256", $_POST['password']);

$contrasena = hash("SHA256", $_POST['password']);
$contrasena_ = hash("SHA256", $_POST['password1']);
$fechaC = date('Y-m-d');

$consulta = "SELECT * FROM tbl_ms_bitacora";

$resultado = mysqli_query($conexion, $consulta);
$filas = mysqli_num_rows($resultado);
$filas = $filas + 1;

#select ID_USUARIO
$consulta_id = "SELECT ID_USUARIO FROM tbl_ms_usuarios WHERE Usuario='$usuario'";
$resultado_id = mysqli_query($conexion, $consulta_id);
$filas_id = mysqli_num_rows($resultado_id);

if ($contrasena == $contrasena_) {
    # code...
    $actualizarContra = "UPDATE tbl_ms_usuarios SET contrasena = '$contrasena_' WHERE usuario='$usuario'";
    // $actualizarEstado = "UPDATE tbl_ms_usuarios SET ESTADO = '1' WHERE Usuario='$usuario'";

    //$bitacora="INSERT INTO tbl_bitacora VALUES('$filas','$fechaC','$filas_id','$filas_id','VALIDACION DE CONTRASEÑA','VALIDAR CONTRASEÑA POR RECUPERACION')";

    mysqli_query($conexion, $actualizarContra);
    // mysqli_query($conexion, $actualizarEstado);

    // mysqli_query( $conexion , $bitacora );

    //    $bitacora="INSERT INTO tbl_ms_bitacora(fecha,id_usuario,id_objeto,accion,descripcion) VALUES(now(),'$filas_id','2','CAMBIO DE CONTRASEÑA','CAMBIO DE CONTRAEÑA MEDIANTE PREGUNTAS') ";
    //    mysqli_query( $conexion , $bitacora );

    // echo '<script>alert("CONTRASEÑA CAMBIADA CON EXITO");</script>';

?>
    <!-- <script>
        location.href = "../../login";
    </SCRipt> -->

<script>
                    Swal.fire({
              title: "Contraseña cambiada con éxito",
              icon: "success",
              confirmButtonText: "OK",
            }).then(() => {
                location.href = "../../login";
            });
        
    </SCRipt>


<?php
} else {
    # code...
    echo '<script>alert("Contraseña Invalida No coinciden");</script>';
    include('cambiar_contrasena_recu.php');
}

?>