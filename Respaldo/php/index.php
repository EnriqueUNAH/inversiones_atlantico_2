
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<title>Script php backup and restore</title>	

</head>
<body>
<main id="main" class="main">
<center> <div class="card">
  
  <div class="card-body">
  <center><h3> Punto de Backup</h3></center>
   
    <p class="card-text">Hacer click en el boton respaldo para hacer una copia de seguridad de la base de datos</p>

    
    <center> <a href="./Backup.php" class="btn btn-primary" onclick="return ConfirmarRespaldo()">
          
           Respaldo       
          </a> </center>    

  </div>
</div></center> 


<center> <div class="card">
  
  <div class="card-body">
  <center><h3> Punto de Restauracion</h3></center>

	<form action="./Restore.php" method="POST">
		<div class="col-5"><br><label>Selecciona un punto de restauración</label><br></di>
		
		<select name="restorePoint" class="form-select form-select-lg mb-3">
			<option value="" disabled="" selected="">Selecciona un punto de restauración</option>
			<?php
				include_once './Connet.php';
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
		</select>
		<button type="submit" class="btn btn-warning">Restaurar</button>
	</form>
</div></center> 



   </main>
</body>
</html>

