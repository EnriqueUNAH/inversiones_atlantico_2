<?php
include('db.php');
$respuesta = strtoupper(($_POST['respuesta']));
$pregunta = ($_POST['pregunta']);
$fechaC = date('Y-m-d');

$consulta = "SELECT * FROM tbl_ms_usuarios";
$resultado = mysqli_query($conexion, $consulta);
$filas = mysqli_num_rows($resultado);

$consultar = mysqli_query($conexion, "SELECT Usuario FROM tbl_ms_usuarios WHERE Id_Usuario=$filas");
while ($otra = mysqli_fetch_array($consultar)) {
    # code...
    $nombre = $otra['Usuario'];
}


$consultar_ = mysqli_query($conexion, "SELECT Id_Pregunta FROM tbl_ms_preguntas WHERE Pregunta='$pregunta'");
while ($otra_ = mysqli_fetch_array($consultar_)) {
    # code...
    $id = $otra_['Id_Pregunta'];
}

$consultar__ = mysqli_query($conexion, "SELECT Nombre_Estado FROM tbl_ms_usuarios u inner join tbl_ms_estado e on u.estado = e.id_estado WHERE Id_Usuario='$filas'");
while ($otra__ = mysqli_fetch_array($consultar__)) {
    # code...
    $estado = $otra__['Nombre_Estado'];
}

/*
//id bitacora
$consulta_bita="SELECT * FROM tbl_bitacora";
$resultado_bita= mysqli_query( $conexion , $consulta_bita );
$filas_bi = mysqli_num_rows( $resultado_bita );
$filas_bbitacora=$filas_bi+1;
*/
//id usuario
$consulta = "SELECT * FROM tbl_ms_usuarios";
$resultado = mysqli_query($conexion, $consulta);
$filas = mysqli_num_rows($resultado);

session_start();
$user = $_SESSION['usuarioNuevo'];
$consulta = "SELECT id_usuario FROM tbl_ms_usuarios WHERE usuario='$user'";
$resultado = mysqli_query($conexion, $consulta);

// Obtenemos el valor de id_usuario de la primera fila del resultado
$row = mysqli_fetch_assoc($resultado);
$id_Usuario = $row['id_usuario'];
echo "El usuario es: " . $user;
echo "   El id es: " . $id_Usuario;
//consultar valor parametro de preguntas contestadas
$consultar_parametro_contestadas = mysqli_query($conexion, "SELECT VALOR FROM tbl_ms_parametros WHERE ID_PARAMETRO='2'");
while ($otra_parametro_pre = mysqli_fetch_array($consultar_parametro_contestadas)) {
    # code...
    $valor_p_p = $otra_parametro_pre['VALOR'];
}

$fechaC = date('Y-m-d');


$insertar_ = "INSERT INTO tbl_ms_preguntas_usuario VALUES('$id','$id_Usuario','$respuesta','$nombre','$fechaC','$nombre','$fechaC')";
mysqli_query($conexion, $insertar_);

/* $bitacora="INSERT INTO tbl_bitacora VALUES('$filas_bbitacora','$fechaC','$filas','3','AUTOREGISTRO','CONSTESTO PREGUNTA EXITOSAMENTE')";
    mysqli_query( $conexion , $bitacora );*/

$consultar_ = "SELECT * FROM tbl_ms_preguntas_usuario WHERE Creado_Por='$nombre'";
$resultado_ = mysqli_query($conexion, $consultar_);
$filas_ = mysqli_num_rows($resultado_);
$valor_p_p_ = $valor_p_p - 1;


if ($filas_ < $valor_p_p) {
    #Trae preguntas contestadas tabla ms_usuarios
    $preguntascontestadas = "SELECT Preguntas_Contestadas FROM tbl_ms_usuarios where Usuario = '$nombre'";
    $resultado_pregu = mysqli_query($conexion, $preguntascontestadas);

    while ($preguntasco = mysqli_fetch_array($resultado_pregu)) {
        # code...
        $contestadas = intval($preguntasco['Preguntas_Contestadas']);
    }
    $contestadas++;
    #Cambio valor de preguntas contestadas
    $actualizarPre = "UPDATE tbl_ms_usuarios SET Preguntas_Contestadas = '$contestadas' WHERE Usuario = '$nombre'";
    mysqli_query($conexion, $actualizarPre);




    echo '<script>alert("Respuesta Guardada");</script>';
    include("../Login/preguntasPrimeraVez.php");
} elseif ($filas_  == $valor_p_p) {
    #Trae preguntas contestadas tabla ms_usuarios
    $preguntascontestadas = "SELECT Preguntas_Contestadas FROM tbl_ms_usuarios where Usuario = '$nombre'";
    $resultado_pregu = mysqli_query($conexion, $preguntascontestadas);

    while ($preguntasco = mysqli_fetch_array($resultado_pregu)) {
        # code...
        $contestadas = intval($preguntasco['Preguntas_Contestadas']);
    }
    $contestadas++;
    #Cambio valor de preguntas contestadas
    $actualizarPre = "UPDATE tbl_ms_usuarios SET Preguntas_Contestadas = '$contestadas' WHERE Usuario = '$nombre'";
    mysqli_query($conexion, $actualizarPre);

    if ($estado == "NUEVO") {
        $ALTER = "UPDATE tbl_ms_usuarios SET estado='2' WHERE  Usuario = '$nombre'";  //obeservar
        mysqli_query($conexion, $ALTER);

        mysqli_close($conexion);
    } else {
        $ALTER = "UPDATE tbl_ms_usuarios SET estado='3' WHERE  Usuario = '$nombre'";  //obeservar
        mysqli_query($conexion, $ALTER);
        mysqli_close($conexion);
    }

?>
    <script>
        alert("Pregunta Contestadas Correctamente");
        location.href = "../../login";
    </SCRipt><?php
            } elseif ($estado = 'RESETEO' and $filas_ > 1) {
                include('../Login/cambiar_contrasena.php');
            }


            /*

    if($estado = 'NUEVO' and $filas_<=$valor_p_p_){
        
        #Trae preguntas contestadas tabla ms_usuarios
        $preguntascontestadas="SELECT Preguntas_Contestadas FROM tbl_ms_usuarios where Usuario = '$nombre'";
        $resultado_pregu=mysqli_query( $conexion , $preguntascontestadas );
        
        while ($preguntasco=mysqli_fetch_array( $resultado_pregu )) {
            # code...
            $contestadas=intval($preguntasco['Preguntas_Contestadas']);
            
        }
        $contestadas++;
        $actualizarPre = "UPDATE tbl_ms_usuarios SET Preguntas_Contestadas = '$contestadas' WHERE Usuario = '$nombre'";
        mysqli_query( $conexion , $actualizarPre);

        if($filas_ < $valor_p_p){
            echo '<script>alert("Respuesta Guardada");</script>';
            include ("../Login/preguntasPrimeraVez.php");
        }elseif($estado = 'NUEVO' and $filas_ >=$valor_p_p){
            $ALTER = "UPDATE tbl_ms_usuarios SET Estado_Usuario='ACTIVO'";  //obeservar
            mysqli_query($conexion, $ALTER);
            mysqli_close($conexion);?>
            <script> 
               alert("Pregunta Contestadas Correctamente");
               location.href= "../Login/index.php";
            </SCRipt>
            <?php
    }elseif($estado = 'RESETEO' and $filas_>1){
        include('../Login/cambiar_contrasena.php'); 
    }

    }*/

            /*    echo ($estado);    
    if ($estado = 'RESETEO' and $filas_>1){
        include('../Login/cambiar_contrasena.php');        
    }elseif($estado = 'NUEVO'){
        $ALTER = "UPDATE tbl_ms_usuarios SET Estado_Usuario='ACTIVO'";
        mysqli_query($conexion, $ALTER);
        mysqli_close($conexion);
        include('../Login/index.php');
    }else{
        include ("../Login/preguntasPrimeraVez.php");
    }*/

                ?>