<?php


class bitacora {
    public static function evento_bitacora($idUsuario,$id_objeto,$accion,$descripcion)
    {
           require ('../Views/promociones/conexion.php');
           
                   $sql = "INSERT INTO tbl_ms_bitacora(fecha,id_usuario,id_objeto,accion,descripcion) 
                   VALUES (now(),'$idUsuario','$id_objeto','$accion','$descripcion')";
    
    $resultado = mysqli_query($conection,$sql);
    }
    
}
    ?>