<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>

    <link rel="stylesheet" href="assets/css/styles.css">


</head>

<body></body>

</html>

<?php
session_start();

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

include('db.php');
$nombre = strtoupper($_POST['name']);
$usuario = strtoupper($_POST['username']);
$_SESSION['name'] = $usuario;
$contrasena = ($_POST['password']);
$hash = hash("SHA256", $_POST['password']);
$correo = ($_POST['email']);
$fechaC = date('Y-m-d');
$fecha_v = date('Y-m-d');


$consulta = "SELECT Max(id_usuario) FROM tbl_ms_usuarios";
$result = mysqli_query($conexion, $consulta);
$row = mysqli_fetch_array($result);
$max = $row[0];
$filas = $max + 1;

//id bitacora
$consulta_bita = "SELECT * FROM tbl_ms_bitacora";
$resultado_bita = mysqli_query($conexion, $consulta_bita);
$filas_bi = mysqli_num_rows($resultado_bita);
$filas_bbitacora = $filas_bi + 1;

#Consulta para saber si el usuario ya existe
$consulta_ = "SELECT Usuario FROM tbl_ms_usuarios WHERE Usuario='$usuario'";
$resultado_ = mysqli_query($conexion, $consulta_);
$filas_ = mysqli_num_rows($resultado_);

#Consulta para saber el parametro de fecha vencimiento
$consulta_Parametro_fecha = "SELECT VALOR FROM tbl_ms_parametros where id_parametro = '4'";
$resultado_Parametro_fecha = mysqli_query($conexion, $consulta_Parametro_fecha);
while ($valor_fecha = mysqli_fetch_array($resultado_Parametro_fecha)) {
    $parametro_fecha = $valor_fecha['VALOR'];
}

//consulta si el coreo ya existe
$consultaCoreeo = "SELECT correo_electronico FROM tbl_ms_usuarios WHERE correo_electronico='$correo'";
$resultado_Correo = mysqli_query($conexion, $consultaCoreeo);
$_filas_ = mysqli_num_rows($resultado_Correo);

//sumo 30 días
$fecha_v = date("Y-m-d", strtotime($fecha_v . "+ $parametro_fecha days"));


#Confirmar contraseña
$conformarContra = $_POST['password1'];


if ($filas_) {
    echo '<script>Swal.fire("Error", "EL USUARIO YA EXISTE", "error");</script>';
    include('../Login/autoRegistro.php');
} elseif ($contrasena != $conformarContra) {
    echo '<script>Swal.fire("Error", "CONTRASEÑAS NO COINCIDEN", "error");</script>';
    include('../Login/autoRegistro.php');
} elseif ($_filas_) { ?>
    <script>
        alert("Correo Electronico ya existente");
        location.href = "../Login/autoRegistro.php";
    </SCRipt>
<?php
} else {
    $contrasenaA = $contrasena;
    $insertar = "INSERT INTO tbl_ms_usuarios VALUES('$filas','$usuario','$nombre','3','$hash','$fechaC','0','0','$fecha_v','$correo','asdad','$usuario','$fechaC','$usuario','$fechaC','2')";
    mysqli_query($conexion, $insertar);

    /* $bitacora="INSERT INTO tbl_ms_bitacora VALUES('$filas_bbitacora','$fechaC','$filas','3','AUTOREGISTRO','AUTOREGISTRO DE USUARIO DESDE EL LOGIN')";
        mysqli_query( $conexion , $bitacora );
      */

    echo '<script>alert("USUARIO CREADO EXITOSAMENTE");</script>';

?>
    <script>
        location.href = "../../login";
    </SCRipt>
<?php


}
mysqli_close($conexion);

?>