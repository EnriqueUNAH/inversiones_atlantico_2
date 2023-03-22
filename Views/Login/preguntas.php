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
///////////////////////////////////////////////////////////////////////////////////////////////
$consultar__ = mysqli_query($conexion, "SELECT estado FROM tbl_ms_usuarios WHERE id_usuario='$filas'");
while ($otra__ = mysqli_fetch_array($consultar__)) {
    # code...
    $estado = $otra__['estado'];
}
///////////////////////////////////////////////////////////////////////////////////////////////
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
//echo "El usuario es: " . $user; /////////////////////////////////////////////////////
//echo "   El id es: " . $id_Usuario; /////////////////////////////////////////////////////
//consultar valor parametro de preguntas contestadas
$consultar_parametro_contestadas = mysqli_query($conexion, "SELECT valor FROM tbl_ms_parametros WHERE id_parametro='2'");
while ($otra_parametro_pre = mysqli_fetch_array($consultar_parametro_contestadas)) {
    # code...
    $valor_p_p = $otra_parametro_pre['valor'];
}
//consultar cuantas preguntas ha contestado
$consultar_contestadas = mysqli_query($conexion, "SELECT preguntas_contestadas FROM tbl_ms_usuarios WHERE id_usuario = '$id_Usuario'");
while ($otra_pre = mysqli_fetch_array($consultar_contestadas)) {
    # code...
    $valor_contestadas = $otra_pre['preguntas_contestadas'];
}
$fechaC = date('Y-m-d');
echo "   Ha contestado: " . $valor_contestadas; /////////////////////////////////////////////////////

$insertar_ = "INSERT INTO tbl_ms_preguntas_usuario VALUES('$id','$id_Usuario','$respuesta')";
mysqli_query($conexion, $insertar_);

$bitacora="INSERT INTO tbl_ms_bitacora(fecha,id_usuario,id_objeto,accion,descripcion) VALUES(now(),'$id_Usuario','2','PREGUNTAS','CONTESTO PREGUNTA CORRECTAMENTE') ";
mysqli_query( $conexion , $bitacora );

/* $bitacora="INSERT INTO tbl_bitacora VALUES('$filas_bbitacora','$fechaC','$filas','3','AUTOREGISTRO','CONSTESTO PREGUNTA EXITOSAMENTE')";
    mysqli_query( $conexion , $bitacora );*/

// $consultar_ = "SELECT * FROM tbl_ms_preguntas_usuario WHERE Creado_Por='$nombre'";
// $resultado_ = mysqli_query($conexion, $consultar_);
// $filas_ = mysqli_num_rows($resultado_);
// $valor_p_p_ = $valor_p_p - 1;
echo "   El valor parametro es: " . $valor_p_p + 1; /////////////////////////////////////////////////////

if ($valor_contestadas < $valor_p_p - 1) { ////////////////////////////////////CAMBIADO
    #Trae preguntas contestadas tabla ms_usuarios
    // $preguntascontestadas = "SELECT preguntas_contestadas FROM tbl_ms_usuarios where id_usuario = '$id_Usuario'";
    // $resultado_pregu = mysqli_query($conexion, $preguntascontestadas);

    // while ($preguntasco = mysqli_fetch_array($resultado_pregu)) {
    //     # code...
    //     $contestadas = intval($preguntasco['Preguntas_Contestadas']);
    // }
    $contestadas = $valor_contestadas + 1;
    #Cambio valor de preguntas contestadas
    $actualizarPre = "UPDATE tbl_ms_usuarios SET preguntas_contestadas = '$contestadas' where id_usuario = '$id_Usuario'";
    mysqli_query($conexion, $actualizarPre);




    echo '<script>alert("Respuesta Guardada");</script>';
    include("../Login/preguntasPrimeraVez.php");
} else {
    #Trae preguntas contestadas tabla ms_usuarios
    // $preguntascontestadas = "SELECT Preguntas_Contestadas FROM tbl_ms_usuarios where Usuario = '$nombre'";
    // $resultado_pregu = mysqli_query($conexion, $preguntascontestadas);

    // while ($preguntasco = mysqli_fetch_array($resultado_pregu)) {
    //     # code...
    //     $contestadas = intval($preguntasco['Preguntas_Contestadas']);
    // }
    // $contestadas++;
    // #Cambio valor de preguntas contestadas
    // $actualizarPre = "UPDATE tbl_ms_usuarios SET Preguntas_Contestadas = '$contestadas' WHERE Usuario = '$nombre'";
    // mysqli_query($conexion, $actualizarPre);
    ///////////////////////////////////////////////////////////////////////////////////////////////
    $contestadas = $valor_contestadas + 1;
    #Cambio valor de preguntas contestadas
    $actualizarPre = "UPDATE tbl_ms_usuarios SET preguntas_contestadas = '$contestadas' where id_usuario = '$id_Usuario'";
    mysqli_query($conexion, $actualizarPre);

    $ALTER = "UPDATE tbl_ms_usuarios SET estado='1' where id_usuario = '$id_Usuario'";  //obeservar
    mysqli_query($conexion, $ALTER);

    mysqli_close($conexion);

    ///////////////////////////////////////////////////////////////////////////////////////////////
?>
    <script>
        alert("Preguntas Contestadas Correctamente");
        location.href = "../../login";
    </SCRipt><?php
            }
            // } elseif ($estado = 'RESETEO' and $filas_ > 1) {
            //             include('../Login/cambiar_contrasena.php');
            //         }


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