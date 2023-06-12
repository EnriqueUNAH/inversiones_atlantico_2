<?php
session_start();

?>
<?php include "../Views/Template/header_admin2.php"; ?>

<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" href="../css/option.css"> -->
  <title></title>
</head>


<body >

  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
        <center> <div class="col-sm-6"></center>

<h1>BACKUPS & RESTAURACION DE BASE DE DATOS</h1>
         
</div>

<center> <div class="card">
  
  <div class="card-body">
  <center><h3> Punto de Backup</h3></center>
   
    <p class="card-text">Hacer click en el boton respaldo para hacer una copia de seguridad de la base de datos</p>

    
    <center> <a href="../php/Backup.php" class="btn btn-info" onclick="return ConfirmarRespaldo()">
          
           Respaldo       
          </a> </center>    

  </div>
</div></center> 



<div class="card">
				<div class="card-body">
				<center><h3>Punto de Restauracion </h3></center>
					<br>
					<?php

					include '../php/Connet.php';

					?>
					<form action="../php/Restore.php" method="POST">
					<center><label>Selecciona un punto de restauración</label><br></center>
		<center>	<select class="form-control select2" style="width: 50%;" name="restorePoint">
			<option value="" disabled="" selected="">Selecciona un punto de restauración</option>
			<?php
				$ruta=BACKUP_PATH;
				if(is_dir($ruta)){
				    if($aux=opendir($ruta)){
				        while(($archivo = readdir($aux)) !== false){
				            if($archivo!="."&&$archivo!=".."){
				                $nombrearchivo=str_replace(".sql", "", $archivo);
				                $nombrearchivo=str_replace("-", ":", $nombrearchivo);
				                $ruta_completa=$ruta.$archivo;
				                if(is_dir($ruta_completa)){
				                }else{
				                    echo '<option value="'.$ruta_completa.'">'.$nombrearchivo.'</option>';
				                }
				            }
				        }
				        closedir($aux);
				    }
				}else{
				    echo $ruta." No es ruta válida";
				}
			?>
		</select></center>
		<br>
		<center><button type="submit" class="btn btn-warning" onclick="return ConfirmarRestore()">Restaurar</button></center>
	</form>
				</div>
			</div>
		</div>
	</div>
</div>





<script type="text/javascript">
function ConfirmarRespaldo()
{
    var respuesta = confirm("Esta seguro de hacer un respaldo de la base de datos");
    if(respuesta == true)
{
    return true;
}
else
{
     return false;
}
}

</script>


<script type="text/javascript">
function ConfirmarRestore()
{
    var respuesta = confirm("Esta seguro de realizar la restauracion de la base de datos");
    if(respuesta == true)
{
    return true;
}
else
{
     return false;
}
}

</script>

<?php include "../Views/Template/footer_admin2.php"; ?>
